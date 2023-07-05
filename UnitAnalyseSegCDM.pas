unit UnitAnalyseSegCDM;
// importation des données de CDM
// Affichage de la page du réseau CDM
// les Tjs ne sont pas traitées, de même que les bretelles double jonction
//
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnitPrinc, ExtCtrls, StdCtrls, ComCtrls, UnitDebug, UnitConfig , StrUtils,
  math, Printers ;

const
   max_db = 20;  // 20 détecteurs maxi entre 2 aiguillages
   pisur180=pi/180 ;
   _180surpi=180/pi;

   // décalages d'affichages
   yCrOffset=-5;
   yCrOffset2=-14;
   yTurnoutOffset=-16;
   Zmini=50;
   Zmaxi=100;
   fond_cdm=$303000;
   precision_clic=4; // précision du clic sur un élément

type
  TFormAnalyseCDM = class(TForm)
    ScrollBox1: TScrollBox;
    ImageCDM: TImage;
    GroupBox1: TGroupBox;
    CheckConnexions: TCheckBox;
    CheckAdresses: TCheckBox;
    CheckSegments: TCheckBox;
    TrackBar1: TTrackBar;
    CheckPorts: TCheckBox;
    Label1: TLabel;
    EditPort: TEdit;
    ButtonAffPort: TButton;
    GroupBoxSegment: TGroupBox;
    Label2: TLabel;
    EditSegment: TEdit;
    LabelAdresse: TLabel;
    Memo1: TMemo;
    LabelPorts: TLabel;
    EditAdresse: TEdit;
    Label3: TLabel;
    EditDetecteur: TEdit;
    ButtonAffDet: TButton;
    CheckColorationDiff: TCheckBox;
    ButtonAllumeTs: TButton;
    Label4: TLabel;
    ButtonImprime: TButton;
    PrintDialog1: TPrintDialog;
    ButtonAnime: TButton;
    ImageLoco: TImage;
    procedure FormResize(Sender: TObject);
    procedure CheckSegmentsClick(Sender: TObject);
    procedure CheckConnexionsClick(Sender: TObject);
    procedure CheckAdressesClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ButtonAffPortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckPortsClick(Sender: TObject);
    procedure EditAdresseChange(Sender: TObject);
    procedure ImageCDMClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ButtonAffDetClick(Sender: TObject);
    procedure CheckColorationDiffClick(Sender: TObject);
    procedure ButtonAllumeTsClick(Sender: TObject);
    procedure ButtonImprimeClick(Sender: TObject);
    procedure ImageCDMMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ButtonAnimeClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

  TdetSeg= array[1..10] of record
            index,periph : integer;
            end;

  Trec_cdm = record adresse : integer;
                  distance : integer;  // distance au port d'entrée
             end;
  tDetect_cdm= array[1..max_db] of Trec_cdm;

  TAig_CDM = record
     adresse,adrtriple,temps : integer;
     modele : TEquipement ;
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

     Adevie2 : integer;
     Adevie2B : char ;
     // états d'une TJD (2 ou 4, 4 par défaut)
     EtatTJD : integer;

    end;

     // structure segment, port et periph de CDM
     TInter =
     record
       x,y,z : integer;
       typ   : string[20];
       MirrorZ : integer;
       MirrorParent : integer;
     end;

     Tport =
     record
       numero : integer;  // numéro du port
       typ    : string[20];
       x,y,z,angle : integer;
       local : integer;    // numéro de port local
       connecte : boolean;
       ConnecteAuPort : integer; // connecté au port
       ConnecteAuSeg  : integer; // connecté au segment
     end;

     TPeriph =
     record
       numero : integer;  // numéro du port
       typ    : string[20];
       pere   : integer;
       x,y,z,angle : integer;
       bright,bdown : integer;// sens et position par rapport à la voie
       location : integer; // ?? en %
       adresse : integer;
       status : integer;
     end;

     Tsegment =
     record
       numero : integer;
       typ    : string[20]; // arc aiguillage,...
       nport,nperiph,nInter : integer;  // nombre de ports et de peripheriques et d'intersections
       port    : array of TPort;
       periph  : array of TPeriph;
       inter   : array of TInter;
       XMin,Ymin,XMax,Ymax,StartAngle,ArcAngle,Rayon,radius0,angle0,angle,lengthdev,deltadev0 : integer;
       lXc,lYc : integer;
       // turnout
       longueur,longueurDev,DeltaDev,Curveoffset : integer;
       // turnout curve
       xc0,yc0,DeltaDev2,xc,yc : integer;
       // pour signaux complexes
       adresse,adresse2,duree : integer;
     end;


var Segment : array of Tsegment;
    nInter,nPeriph,nSeg,nPort,nligne,XminiCDM,XmaxiCDM,YminiCDM,YmaxiCDM,NAig_CDM,Ndet_CDM,
    DernAdrAig,SeqAdrCroisement,nb_det,IndexClic,xAig,yAig,cadre,largeur_voie,
    largeurTrain,HauteurTrain : integer;
    lignes : TStrings;
    reducX,reducY,ArcTanHautLargTrain : double;
    FormAnalyseCDM: TFormAnalyseCDM;
    sBranche,NomModuleCDM : string;
    debugBranche,debugAnalyse,clic,premaff : boolean;
    Aig_CDM : array[0..NbreMaxiAiguillages] of TAig_CDM;
    Det_CDM : array[1..500] of integer;
    FWICImage : tBitmap;

procedure Compilation;
procedure lit_fichier_segments_cdm;
procedure affichage(imprime : boolean);
procedure Aff_train(adr: integer;train:string;x1,y1,x2,y2 :integer);

implementation

uses Importation;


{$R *.dfm}

// cherche, isole et restreint la chaine s qui contient "chercher"
function isole_valeur(var s : string; chercher : string) : string;
var i : integer;
    serr : string;
begin
  i:=pos(chercher,s);
  if i=0 then begin
    serr:='Erreur : pas de chaine '+chercher+' dans "'+s+'" Segment '+intToSTR(segment[nSeg-1].numero);
    Affiche(serr,clred);
    AfficheDebug(serr,clred);
    isole_valeur:='';
    exit;
  end;
  delete(s,1,i+length(chercher)-1);

  repeat
    if s[1]=' ' then delete(s,1,1);
  until (s[1]<>' ') or (length(s)=0);

  i:=pos(' ',s);
  if i<>0 then isole_valeur:=copy(s,1,i-1) else isole_valeur:=s;
end;

procedure compile_periph;
var i,j,erreur : integer;
    s,s2: string;
    trouve : boolean;
begin
  //------------------------Lecture periph----------------------------
  inc(nPeriph);
  segment[nSeg-1].nPeriph:=nPeriph;
  setlength(segment[nSeg-1].Periph,nPeriph);

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'periph #');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].numero:=i;
  if debugAnalyse then AfficheDebug('Compile periph '+intToSTR(i),clYellow);

  s2:=isole_valeur(s,'obj type');
  Segment[nSeg-1].periph[nperiph-1].typ:=s2;
  inc(nLigne);

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'father #');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].pere:=i;
  inc(nLigne);

  s:=AnsiLowerCase(lignes[nligne]);
  inc(nLigne);
  s2:=isole_valeur(s,'x=');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].x:=i;

  s2:=isole_valeur(s,'y=');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].y:=i;

  s2:=isole_valeur(s,'z=');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].z:=i;

  s2:=isole_valeur(s,'angle=');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].angle:=i;

  s:=AnsiLowerCase(lignes[nligne]);
  inc(nLigne);
  s2:=isole_valeur(s,'bright =');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].bRight:=i;

  s2:=isole_valeur(s,'bdown =');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].bDown:=i;

  s2:=isole_valeur(s,'location =');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].location:=i;

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'address');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].Adresse:=i;
  if (Segment[nSeg-1].periph[nperiph-1].typ='detector') and (i<>0) then
  begin
    // remplit le tableau des détecteurs cdm
    trouve:=false;
    for j:=1 to nDet_cdm do
    begin
      trouve:=Det_cdm[j]=i;  // si déja stocké
    end;
    if not(trouve) then
    begin
      inc(nDet_cdm);
      Det_CDM[nDet_cdm]:=i;
    end;
  end;

  s2:=isole_valeur(s,'status');
  val(s2,i,erreur);
  Segment[nSeg-1].periph[nperiph-1].status:=i;
end;

procedure compile_inter;
var i,erreur : integer;
    s,s2: string;
begin
   //------------------------Lecture inter----------------------------
  if debugAnalyse then AfficheDebug('Compile inter',clWhite);
  inc(nInter);
  segment[nSeg-1].ninter:=nInter;
  setlength(segment[nSeg-1].inter,ninter);

  s:=AnsiLowerCase(lignes[nligne]);
  inc(nLigne);
  s2:=isole_valeur(s,'x=');
  val(s2,i,erreur);
  Segment[nSeg-1].inter[nInter-1].x:=i;

  s2:=isole_valeur(s,'y=');
  val(s2,i,erreur);
  Segment[nSeg-1].inter[nInter-1].y:=i;

  s2:=isole_valeur(s,'z=');
  val(s2,i,erreur);
  Segment[nSeg-1].inter[nInter-1].z:=i;

  s2:=isole_valeur(s,'type:');
  Segment[nSeg-1].inter[nInter-1].typ:=s2;

  s:=AnsiLowerCase(lignes[nligne]);
  inc(nLigne);
  s2:=isole_valeur(s,'z=');
  val(s2,i,erreur);
  Segment[nSeg-1].inter[nInter-1].MirrorZ:=i;
end;

procedure compile_port;
var i,erreur : integer;
    s,s2: string;
begin
   //------------------------Lecture port----------------------------
  inc(nport);
  segment[nSeg-1].nport:=nport;
  setlength(segment[nSeg-1].port,nport);

  s:=AnsiLowerCase(lignes[nligne]);
  i:=pos('#',s);
  if i=0 then begin Affiche('Erreur structure n°12',clOrange);exit;end;
  delete(s,1,i);
  val(s,i,erreur);
  Segment[nSeg-1].port[nPort-1].numero:=i;
  if debugAnalyse then AfficheDebug('Compile port '+intToSTR(i),clLime);

  s2:=isole_valeur(s,'obj type');
  Segment[nSeg-1].port[nPort-1].typ:=s2; // port  dummy_port

  s2:=isole_valeur(s,'local #');
  if s2='' then begin Affiche('Erreur structure n°14',clOrange);exit;end;
  val(s,i,erreur);
  Segment[nSeg-1].port[nPort-1].local:=i;
  inc(nligne,2);


  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'x=');
  val(s2,i,erreur);
  Segment[nSeg-1].port[nPort-1].x:=i;

  s2:=isole_valeur(s,'y=');
  val(s2,i,erreur);
  Segment[nSeg-1].port[nPort-1].y:=i;

  s2:=isole_valeur(s,'z=');
  val(s2,i,erreur);
  Segment[nSeg-1].port[nPort-1].z:=i;

  s2:=isole_valeur(s,'angle=');
  val(s2,i,erreur);
  Segment[nSeg-1].port[nPort-1].angle:=i;

  inc(nligne);
  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'connect status:');
  Segment[nSeg-1].port[nPort-1].connecte:=s2='connected';

  if Segment[nSeg-1].port[nPort-1].typ='dummy_port' then
    exit;

  inc(nligne);
  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'connected to port #');
  val(s2,i,erreur);
  Segment[nSeg-1].port[nPort-1].ConnecteAuPort:=i;

  s2:=isole_valeur(s,'segment #');
  val(s2,i,erreur);
  Segment[nSeg-1].port[nPort-1].ConnecteAuSeg:=i;
end;

procedure compile_segment;
var i,erreur : integer;
    s,s2,segType,serr: string;
begin
  //------------------------Lecture segment----------------------------
  nport:=0;
  nperiph:=0;
  nInter:=0;
  inc(nSeg);
  setlength(segment,nSeg);

  Segment[nSeg-1].nport:=0;
  Segment[nSeg-1].nperiph:=0;
  Segment[nSeg-1].nInter:=0;
  s:=AnsiLowerCase(lignes[nligne]);
  i:=pos('#',s);
  if i=0 then 
  begin 
    serr:='Erreur structure n°2';
    Affiche(serr,clOrange);
    AfficheDebug(serr,clOrange);
    exit;
  end;
  delete(s,1,i);
  val(s,i,erreur);
  segment[nSeg-1].numero:=i;

  if debugAnalyse then AfficheDebug('Compile segment '+intToSTR(i),claqua);

  delete(s,1,erreur);

  s2:=isole_valeur(s,'obj type: ');
  if s2<>'segment' then begin Affiche('Erreur structure n°3',clOrange);exit;end;
  s2:=isole_valeur(s,'seg type: ');
  if s2='' then begin Affiche('Erreur structure n°4',clOrange);exit;end;
  segType:=s2;
  segment[nSeg-1].typ:=s2;     // ARC TURNOUT(champ suppl)
  inc(nligne);

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'module :');
  inc(nligne);

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'nb ports:');
  val(s2,i,erreur);
  segment[nSeg-1].nport:=i;

  s:=lignes[nligne];
  s2:=isole_valeur(s,'nb periphs:');
  val(s2,i,erreur);
  segment[nSeg-1].nperiph:=i;
  inc(nligne);

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'zone[0]:');
  s2:=isole_valeur(s,'zone[1]:');
  inc(nligne,2);

  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'xmin =');
  val(s2,i,erreur);
  segment[nSeg-1].XMin:=i;
  if i<xminiCDM then XminiCDM:=i;

  s2:=isole_valeur(s,'ymin =');
  val(s2,i,erreur);
  segment[nSeg-1].YMin:=i;
  if i<yminiCDM then YminiCDM:=i;

  s2:=isole_valeur(s,'xmax =');
  val(s2,i,erreur);
  segment[nSeg-1].XMax:=i;
  if i>xMaxiCDM then xMaxiCDM:=i;

  s2:=isole_valeur(s,'ymax =');
  val(s2,i,erreur);
  segment[nSeg-1].Ymax:=i;
  if i>yMaxiCDM then yMaxiCDM:=i;

  if segType='turntable' then
  begin
    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'start angle:');
    val(s2,i,erreur);
    segment[nSeg-1].startangle:=i;
    s2:=isole_valeur(s,'length:');
    val(s2,i,erreur);
    segment[nSeg-1].longueur:=i;
    s2:=isole_valeur(s,'lengthdev');
    val(s2,i,erreur);
    segment[nSeg-1].lengthdev:=i;

    inc(nligne,2);    // 1 ligne vide
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'xc0:');
    val(s2,i,erreur);
    segment[nSeg-1].xc0:=i;
    s2:=isole_valeur(s,'yc0:');
    val(s2,i,erreur);
    segment[nSeg-1].yc0:=i;
    s2:=isole_valeur(s,'xc:');
    val(s2,i,erreur);
    segment[nSeg-1].xc:=i;
    s2:=isole_valeur(s,'yc:');
    val(s2,i,erreur);
    segment[nSeg-1].yc:=i;
    exit;
  end;

  // modif pour signaux complexes
  if (segType='turnout') or (segType='turnout_3way') or (segType='dbl_slip_switch') then
  begin
    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'adresse =');
    val(s2,i,erreur);
    segment[nSeg-1].adresse:=i;
    if i=0 then
    begin
      Affiche('Aiguillage segment '+intToSTR(segment[nSeg-1].numero)+' adresse nulle',clred);
      AfficheDebug('Aiguillage segment '+intToSTR(segment[nSeg-1].numero)+' adresse nulle',clred);
    end;
    if i>DernAdrAig then DernAdrAig:=i;

    if (segType='dbl_slip_switch') or (segType='turnout_3way') then
    begin
      s:=AnsiLowerCase(lignes[nligne]);
      s2:=isole_valeur(s,'adresse2 =');
      val(s2,i,erreur);
      segment[nSeg-1].adresse2:=i;
      if i>DernAdrAig then DernAdrAig:=i;
    end;

    s2:=isole_valeur(s,'duree =');
    val(s2,i,erreur);
    segment[nSeg-1].duree:=i;
    exit;
  end;

  if segType='straight' then exit;
  if segType='pre_curve' then exit;
  if segType='bumper_stop' then exit;

  // les autres aiguillages  (TURNOUT_SYM...)
  inc(nligne);
  s:=AnsiLowerCase(lignes[nligne]);
  s2:=isole_valeur(s,'start angle:');
  val(s2,i,erreur);
  segment[nSeg-1].StartAngle:=i;

  s2:=isole_valeur(s,'arc angle:');
  val(s2,i,erreur);
  segment[nSeg-1].ArcAngle:=i;

  if segType='crossing' then
  begin
    s2:=isole_valeur(s,'radius:');
    val(s2,i,erreur);
    segment[nSeg-1].Rayon:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'length:');
    val(s2,i,erreur);
    segment[nSeg-1].longueur:=i;

    s2:=isole_valeur(s,'lengthdev:');
    val(s2,i,erreur);
    segment[nSeg-1].longueurDev:=i;

    s2:=isole_valeur(s,'deltadev:');
    val(s2,i,erreur);
    segment[nSeg-1].deltadev:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'curve offset:');
    val(s2,i,erreur);
    segment[nSeg-1].curveoffset:=i;
    exit;
  end;

  //turnout_3way
  if segType='turnout_sym' then
  begin
    s2:=isole_valeur(s,'radius:');
    val(s2,i,erreur);
    segment[nSeg-1].Rayon:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'lengthdev:');
    val(s2,i,erreur);
    segment[nSeg-1].longueur:=i;
    s2:=isole_valeur(s,'deltadev:');
    val(s2,i,erreur);
    segment[nSeg-1].DeltaDev:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'curve offset:');
    val(s2,i,erreur);
    segment[nSeg-1].Curveoffset:=i;

    // signaux complexes
    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);

    s2:=isole_valeur(s,'adresse =');
    val(s2,i,erreur);
    segment[nSeg-1].adresse:=i;
    if i>DernAdrAig then DernAdrAig:=i;

    s2:=isole_valeur(s,'duree =');
    val(s2,i,erreur);
    segment[nSeg-1].duree:=i;
    exit;
  end;

  if segType='turnout_curved_2r' then
  begin
    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'radius0:');
    val(s2,i,erreur);
    segment[nSeg-1].radius0:=i;
    s2:=isole_valeur(s,'radius:');
    val(s2,i,erreur);
    segment[nSeg-1].rayon:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'angle0:');
    val(s2,i,erreur);
    segment[nSeg-1].angle0:=i;
    s2:=isole_valeur(s,'angle:');
    val(s2,i,erreur);
    segment[nSeg-1].angle:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'length:');
    val(s2,i,erreur);
    segment[nSeg-1].longueur:=i;
    s2:=isole_valeur(s,'deltadev0:');
    val(s2,i,erreur);
    segment[nSeg-1].deltadev0:=i;
    s2:=isole_valeur(s,'xc0:');
    val(s2,i,erreur);
    segment[nSeg-1].xc0:=i;
    s2:=isole_valeur(s,'yc0:');
    val(s2,i,erreur);
    segment[nSeg-1].yc0:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'lengthdev:');
    val(s2,i,erreur);
    segment[nSeg-1].lengthdev:=i;
    s2:=isole_valeur(s,'deltadev:');
    val(s2,i,erreur);
    segment[nSeg-1].deltadev:=i;
     s2:=isole_valeur(s,'xc:');
    val(s2,i,erreur);
    segment[nSeg-1].xc:=i;
    s2:=isole_valeur(s,'yc:');
    val(s2,i,erreur);
    segment[nSeg-1].yc:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);

    s2:=isole_valeur(s,'adresse =');
    val(s2,i,erreur);
    if i>DernAdrAig then DernAdrAig:=i;

    segment[nSeg-1].adresse:=i;
    s2:=isole_valeur(s,'duree =');
    val(s2,i,erreur);
    segment[nSeg-1].duree:=i;
    exit;
  end;

  if segType='dbl_cross_over' then
  begin
    Affiche('Bretelle double jonction non gérée',clred);
    AfficheDebug('Bretelle double jonction non gérée',clred);
  end;


  if segType='turnout_curved' then
  begin
    s2:=isole_valeur(s,'radius:');
    val(s2,i,erreur);
    segment[nSeg-1].Rayon:=i;
    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);

    s2:=isole_valeur(s,'length:');
    val(s2,i,erreur);
    segment[nSeg-1].longueur:=i;

    s2:=isole_valeur(s,'deltadev:');
    val(s2,i,erreur);
    segment[nSeg-1].DeltaDev:=i;

    s2:=isole_valeur(s,'xc0:');
    val(s2,i,erreur);
    segment[nSeg-1].xc0:=i;

    s2:=isole_valeur(s,'yc0:');
    val(s2,i,erreur);
    segment[nSeg-1].yc0:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);

    s2:=isole_valeur(s,'lengthdev:');
    val(s2,i,erreur);
    segment[nSeg-1].longueurDev:=i;

    s2:=isole_valeur(s,'deltadev:');
    val(s2,i,erreur);
    segment[nSeg-1].DeltaDev2:=i;

    s2:=isole_valeur(s,'xc:');
    val(s2,i,erreur);
    segment[nSeg-1].xc:=i;

    s2:=isole_valeur(s,'yc:');
    val(s2,i,erreur);
    segment[nSeg-1].yc:=i;

    // signaux complexes
    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);

    s2:=isole_valeur(s,'adresse =');
    val(s2,i,erreur);
    segment[nSeg-1].adresse:=i;
    if i>DernAdrAig then DernAdrAig:=i;

    s2:=isole_valeur(s,'duree =');
    val(s2,i,erreur);
    segment[nSeg-1].duree:=i;
    exit;
  end;

  s2:=isole_valeur(s,'radius:');
  val(s2,i,erreur);
  segment[nSeg-1].Rayon:=i;
  inc(nligne);
  s:=AnsiLowerCase(lignes[nligne]);

  if segment[nseg-1].typ='turnout' then
  begin
    s2:=isole_valeur(s,'length:');
    val(s2,i,erreur);
    segment[nSeg-1].longueur:=i;

    s2:=isole_valeur(s,'lengthdev:');
    val(s2,i,erreur);
    segment[nSeg-1].longueurDev:=i;

    s2:=isole_valeur(s,'deltadev:');
    val(s2,i,erreur);
    segment[nSeg-1].DeltaDev:=i;

    inc(nligne);
    s:=AnsiLowerCase(lignes[nligne]);
    s2:=isole_valeur(s,'curve offset:');
    val(s2,i,erreur);
    segment[nSeg-1].CurveOffset:=i;
  end;

  if (SegType='arc') or (Segtype='curve') then
  begin
    s2:=isole_valeur(s,'lxc:');
    val(s2,i,erreur);
    segment[nSeg-1].lXc:=i;

    s2:=isole_valeur(s,'lyc:');
    val(s2,i,erreur);
    segment[nSeg-1].lYc:=i;
  end;
end;

// coordonnées image en CDM
procedure inv_coords(var x,y : integer);
begin
  x:=x-(cadre div 2);
  x:=(round(x*1000/reducX))+xMiniCDM;

  y:=y-(cadre div 2);
  y:=ymaxiCDM-(round(y*1000/reducY));
end;

// coordonnées CDM en image
procedure Coords(var x,y : integer);
begin
  x:=(round( (x - xMiniCDM) * reducX/1000 )) + (cadre div 2);
  y:=(round( (yMaxiCDM-y)   * reducY/1000 )) + (cadre div 2);
end;

function degtoRad(angle : double) : double;
begin
  degtoRad:=angle*pi/180;
end;

procedure D_Arc(Canvas: TCanvas; CenterX,CenterY: integer;
                rayon: Integer; StartDegres, StopDegres: Double);
var
  sinA,cosA   : extended;
  x1,x2,x3,x4: Integer;
  y1,y2,y3,y4: Integer;
begin
  if StopDegres<0 then setArcDirection(Canvas.Handle,AD_COUNTERCLOCKWISE)
    else setArcDirection(Canvas.Handle,AD_CLOCKWISE);

  StartDegres:=startDegres*pisur180;
  stopDegres:=StartDegres+stopDegres*pisur180;
  x1:=CenterX - rayon;
  y1:=CenterY - rayon;
  x2:=CenterX + rayon;
  y2:=CenterY + rayon;
  SinCos(StartDegres,SinA,CosA);
  x4:=CenterX + Round(rayon*CosA);
  y4:=Centery - Round(rayon*SinA);
  SinCos(StopDegres,SinA,CosA);
  x3:=CenterX + Round(rayon*CosA);
  y3:=Centery - Round(rayon*SinA);
  Canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
end;


// trouve si le point (x,y) est sur le segment x1,y1 x2,y2
// s*l = distance du point au segment
function point_Sur_Segment(x,y,x1,y1,x2,y2 : integer): Boolean;
var l,r,s : Double;
begin
  Result:=False;
  l:=sqrt(((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)));
  if l<>0 then
  begin
    r:=((y1-y)*(y1-y2)-(x1-x)*(x2-x1))/(l*l);
    s:=((y1-y)*(x2-x1)-(x1-x)*(y2-y1))/(l*l);
    if (r>0) and (r<1) then
        if Abs(s*l)<=precision_clic then Result:=True;  //s*l=distance
  end;
end;

// trouve si le point x,y est sur l'arc de centre CentreX,Y de rayon ..
function point_sur_arc(x,y,CentreX,centreY,rayon : integer;StartDegres,StopDegres :double;deb : boolean) : boolean;
var a : double;
   cosA,SinA : extended;
   xArc,yArc : integer;
   trouve,inverse : boolean;
   canvas : Tcanvas;
begin
  canvas:=FormAnalyseCDM.ImageCDM.Canvas;

  //canvas.MoveTo(x,y);Canvas.LineTo(X+1,y+1);

  //Affiche(floatToSTR(startDegres)+' '+FloatToSTR(stopdegres),clyellow);
  inverse:=false;
  if stopDegres<0 then
  begin
    StartDegres:= StartDegres+StopDegres;
    StopDegres:=-StopDegres;
  end;

  StartDegres:=StartDegres*pisur180; //+3*pi/4;
  StopDegres:=StartDegres+StopDegres*pisur180;
  a:=startDegres;
  repeat
    SinCos(a,SinA,CosA);
    xArc:=CentreX+round(rayon*cosA);
    if inverse then yArc:=CentreY+round(rayon*sinA) else
      yArc:=CentreY-round(rayon*sinA);

    trouve:=(abs(x-xArc)<precision_clic) and (abs(y-yArc)<precision_clic);
     if deb then
     begin
       Affiche(intToSTR(x-xArc)+' / '+intToSTR(y-yARc),clyellow);
       canvas.Pen.Color:=clred;
       canvas.MoveTo(xArc,yArc);Canvas.LineTo(Xarc+3,yArc+3);
     end;
    a:=a+0.02;
  until (trouve) or (a>StopDegres);
  result:=trouve;
end;

procedure affiche_port(indexSeg,IndexPort: integer);
var x,y : integer;
    s : string;
begin
  x:=segment[indexSeg].port[indexport].x;
  y:=segment[indexSeg].port[IndexPort].y;
  s:=intToSTR(segment[indexSeg].port[IndexPort].numero);
  coords(x,y);
  with FormAnalyseCdm.ImageCDM.canvas do
  begin
    pen.Width:=1;
    pen.color:=Cyan;
    TextOut(x,y,s);
    Moveto(0,0);
    LineTo(x,y);
  end;
end;

procedure affiche_segment(indexSeg: integer);
var x,y,x1,y1,x2,y2 : integer;
    s : string;
begin
  x1:=segment[indexSeg].port[0].x;
  y1:=segment[indexSeg].port[0].y;
  x2:=segment[indexSeg].port[1].x;
  y2:=segment[indexSeg].port[1].y;
  x:=(x1+x2) div 2;
  y:=(y1+y2) div 2;

  s:=intToSTR(segment[indexSeg].numero);
  coords(x,y);
  with FormAnalyseCdm.ImageCDM.canvas do
  begin
    pen.Width:=1;
    pen.color:=clyellow;
    TextOut(x,y,s);
    Moveto(0,0);
    LineTo(x,y);
  end;
end;

// trace un arc selon les coordonnées CDM
procedure angle_cdm(canvas : Tcanvas;centreX,centreY:integer;debut,fin : double ;rayon : integer);
begin
  coords(centreX,centreY);
  rayon:=round(rayon*reducX) div 1000;
  D_arc(Canvas,centreX,centreY,rayon,debut,fin);
end;

// affiche le libellé de l'aiguillage du segment i
procedure coords_aff_aig(canvas : Tcanvas;i : integer);
var segType,s: string;
    a,x,y,x3,y3 : integer;
begin
  with segment[i] do
  begin
    SegType:=typ;
    if (segtype='crossing') or (segType='dbl_slip_switch') then
    begin
      x:=(port[0].x+port[2].x) div 2;
      y:=(port[0].y+port[2].y) div 2;
      coords(x,y);
      y:=y-10;
    end;
    if (segtype='turnout') or (segtype='turnout_sym')  then
    begin
      x:=(port[0].x+port[1].x) div 2;
      y:=(port[0].y+port[1].y) div 2;
      x3:=port[2].x;
      y3:=port[2].y;
      coords(x,y);
      coords(x3,y3);
      y:=y-10;
      if y3<y then x:=x-20;
    end;
    if (segtype='turnout_curved') or (segtype='turnout_curved_2r') then
    begin
      x:=(port[0].x+port[1].x) div 2;
      y:=(port[0].y+port[1].y) div 2;
      coords(x,y);
      y:=y-5;
    end;
    if (segtype='turnout_3way') then
    begin
      x:=(port[0].x+port[1].x) div 2;
      y:=(port[0].y+port[1].y) div 2;
      coords(x,y);
      y:=y-5;
    end;

    s:='A'+intToSTR(adresse)+'  ';
    canvas.Font.Color:=clLime;
    canvas.TextOut(x,y+YcrOffset,s);

    a:=adresse2;
    if a<>0 then
    begin
      s:='A'+intToSTR(adresse2)+'  ';
      Canvas.Textout(x,y+20,s);
    end;
  end;
end;

procedure ligneCDM(canvas: Tcanvas;x1,y1,x2,y2 : integer);
begin
  coords(x1,y1);
  coords(x2,y2);
  with canvas do
  begin
    MoveTo(x1,y1);
    LineTo(x2,y2);
  end;
end;

// dessine un arc orienté de xa,ya à xb,yb dans le canvas image (pas imprimante)
// coordonnées CDM
procedure arc_xy(centreX,centreY,rayon,xa,ya,xb,yb : integer);
var x1,y1,x2,y2: integer  ;
    arcXa,arcYa,arcxb,arcYb,angleA,angleB,
    cosA,SinA,CosB,SinB,vectoriel,AngleAB: double;
    canvas : Tcanvas;
    inverse,maxA,maxB,deb : boolean;
begin
  deb:=false;
  if rayon=0 then exit;
  if deb then Affiche('Xa='+intToSTr(xa)+' Ya='+intToSTr(ya)+' Xb='+intToSTr(xb)+' Yb='+intToSTr(yb),clyellow);
  coords(centreX,centreY);
  coords(xa,ya);
  coords(xb,yb);
  rayon:=round(rayon*reducX) div 1000;
  canvas:=FormAnalyseCDM.ImageCDM.Canvas;

  X1:=centreX - rayon;
  Y1:=centreY - rayon;
  X2:=centreX + rayon;
  Y2:=centreY + rayon;

  // angles du point A et du point B
  // attention arcCos renvoie un angle entre 0 et pi (180°)
  // arcsin renvoie un angle entre -pi/2 et + pi/2 (-90° +90°)
  CosA:=(Xa-centreX)/rayon;
  if CosA>1 then CosA:=1;
  if CosA<-1 then CosA:=-1;
  arcXa:=arccos(CosA)*_180surpi;

  SinA:=(centreY-Ya)/rayon;
  if SinA>1 then SinA:=1;
  if SinA<-1 then SinA:=-1;
  arcYa:=arcsin(SinA)*_180surpi;

  CosB:=(Xb-centreX)/rayon;
  if CosB>1 then CosB:=1;
  if CosB<-1 then CosB:=-1;
  arcXb:=arccos(CosB)*_180surpi;

  SinB:=(centreY-Yb)/rayon;
  if SinB>1 then SinB:=1;
  if SinB<-1 then SinB:=-1;
  arcYb:=arcsin(SinB)*_180surpi;

  // quadrant des angles
  {
  quadrantA:=0;QuadrantB:=0;
  if (cosA>=0) and (sinA>=0) then quadrantA:=1;
  if (cosA<=0) and (sinA>=0) then quadrantA:=2;
  if (cosA<=0) and (sinA<=0) then quadrantA:=3;
  if (cosA>=0) and (sinA<=0) then quadrantA:=4;

  if (cosB>=0) and (sinB>=0) then quadrantB:=1;
  if (cosB<=0) and (sinB>=0) then quadrantB:=2;
  if (cosB<=0) and (sinB<=0) then quadrantB:=3;
  if (cosB>=0) and (sinB<=0) then quadrantB:=4;

  if deb then
  begin
    Affiche('QuadrantA='+intToSTR(QuadrantA),clyellow);
    Affiche('QuadrantB='+intToSTR(QuadrantB),clyellow);
  end;
  }

  vectoriel:=((rayon*rayon*cosA*cosB)+(rayon*rayon*sinA*sinB)) / (rayon*rayon);
  if vectoriel>1 then vectoriel:=1;
  if vectoriel<-1 then vectoriel:=-1;
  AngleAB:=arccos(vectoriel)*_180surpi;
  if deb then Affiche('ProdVect='+FloatToSTR(vectoriel*_180surpi)+' AngleAB='+FloatToStr(AngleAB),clYellow);


  //arcXb:=0;arcYb:=0;

  // en déduire l'angle A et B
  if arcYa<0 then angleA:=180-ArcXa+180 else angleA:=ArcXa;
  if arcYb<0 then angleB:=180-ArcXb+180 else angleB:=ArcXb;
  if angleA>=360 then angleA:=360-angleA;

  if abs(angleA-angleB)>180 then
  begin
    // ramener sur 0°
    maxA:=AngleA>angleB;
    maxB:=AngleB>angleB;
    if maxA then
    begin
      AngleB:=AngleB+360-AngleA;
      AngleA:=0;
    end;
    if maxB then
    begin
      AngleA:=AngleA+360-AngleB;
      AngleB:=0;
    end;
  end;


  inverse:=angleB>angleA;
  //inverse:=AngleAB>0;

  if deb then
  begin
    affiche('AngleXa='+intToSTR(round(ArcXa))+' AngleYa='+intToSTR(round(ArcYa)),clred);
    affiche('AngleXb='+intToSTR(round(ArcXb))+' AngleYb='+intToSTR(round(ArcYb)),clred);
  end;
  if angleA<>angleB then
  with Canvas do
  begin
    setArcDirection(Canvas.Handle,AD_COUNTERCLOCKWISE);
    if inverse then canvas.Arc(X1,Y1,X2,Y2,xa,ya,xb,yb)
    else canvas.Arc(X1,Y1,X2,Y2,xb,yb,xa,ya);
  end;
end;

// dessine un aiguillage courbe - pas encore au point
procedure dessine_aig_courbe(canvas : Tcanvas;i : integer);
var numseg,milieuX,milieuY,centreX,centreY,x0,y0,x1,y1,x2,y2,rayon : integer;
    b,pente,rayonD,alpha : double;
    coul : Tcolor;
begin
  numseg:=segment[i].numero;
  //Affiche('----'+intToSTR(numseg)+' aig '+intToSTR(segment[i].adresse),clorange);
  coul:=canvas.Pen.Color;
  x0:=segment[i].port[0].x;
  y0:=segment[i].port[0].y;
  x1:=segment[i].port[1].x;
  y1:=segment[i].port[1].y;
  x2:=segment[i].port[2].x;
  y2:=segment[i].port[2].y;

  // milieu des ports 0 et 1 ----------------
  milieuX:=(x0+x1) div 2;
  milieuY:=(y0+y1) div 2;

  // pente de la médiatrice des ports 0 et 1
  if y1=y0 then pente:=9999 else
  pente:=-(x1-x0)/(y1-y0);

  // équation : y=ax+b a=pente b=
  // b=y-ax
  b:=milieuY-pente*milieuX;

  //
  // méthode calculée
  alpha:=arctan(pente);
  rayonD:=5500;
  centreX:=round(rayonD*cos(alpha))+MilieuX;
  centreY:=round(pente*centreX+b);
  canvas.pen.Width:=1;
  canvas.pen.color:=clred;
  ligneCDM(canvas,milieuX,milieuY,centreX,centreY);
  //ligneCDM(canvas,x0,y0,x1,y1);
  arc_xy(centreX,centreY,round(rayonD)+250,x1,y1,x0,y0);

  centreX:=round(-rayonD*cos(alpha))+MilieuX;
  centreY:=round(pente*centreX+b);
  canvas.pen.Width:=1;
  canvas.pen.color:=clyellow;
  ligneCDM(canvas,milieuX,milieuY,centreX,centreY);
  //ligneCDM(canvas,x0,y0,x1,y1);
  arc_xy(centreX,centreY,round(rayonD)+250,x1,y1,x0,y0);


  exit;

  // méthode directe
  centreX:=x0+3000;
  centreY:=round(pente*centreX+b);
  rayon:=round(sqrt(sqr(centreX-x0)+sqr(centreY-y0)));
  //arc_xy(centreX,centreY,rayon,x1,y1,x0,y0);

  // point de départ en vert
  //canvas.pen.color:=clLime;
  //ligneCDM(canvas,x1,y1,x1+100,y1+100);

  //milieu des ports 0 et 2 -------------------------
  milieuX:=(x0+x2) div 2;
  milieuY:=(y0+y2) div 2;

  // pente de la médiatrice des ports 0 et 2
  pente:=-(x2-x0)/(y2-y0);

  // équation : y=ax+b a=pente b=
  // b=y-ax
  b:=milieuY-pente*milieuX;

  // centre du cercle sur la médiatrice
  alpha:=arctan(pente);
  rayonD:=3000;
  centreX:=round(rayonD*cos(alpha))+MilieuX;
  centreY:=round(pente*centreX+b);
//  ligneCDM(canvas,milieuX,milieuY,centreX,centreY);


  //ligneCDM(canvas,MilieuX,MilieuY,centreX,centreY);
  //ligneCDM(canvas,x0,y0,x2,y2);

  canvas.Pen.Color:=coul;
  //arc_xy(centreX,centreY,round(rayonD),x2,y2,x0,y0);

  centreX:=x0+5000;
  centreY:=round(pente*centreX+b);
  rayon:=round(sqrt(sqr(centreX-x0)+sqr(centreY-y0)));
  arc_xy(centreX,centreY,rayon,x2,y2,x0,y0);

  // point de départ en vert
  canvas.pen.color:=clLime;
  ligneCDM(canvas,x2,y2,x2+100,y2+100);
end;


// étale un bitmap avec un nombre de pixels
// Exemple ResizeBmp(Image1.Picture.Bitmap ,100,100);
// non utilisé
procedure ResizeBmp(bitmp: TBitmap; wid, hei: Integer);
var
  TmpBmp: TBitmap;
  ARect: TRect;
begin
  TmpBmp := TBitmap.Create;
  TmpBmp.Width  := wid;
  TmpBmp.Height := hei;
  ARect := Rect(0,0, wid, hei);
  TmpBmp.Canvas.StretchDraw(ARect, Bitmp);
  bitmp.Assign(TmpBmp);
  TmpBmp.Free;
end;

// rotation matricielle autour de Centre
function XForm_Rotation(AAngle : Single;Centre : TPoint) : TXForm;
var SinA,CosA: Extended;
begin
  SinCos(AAngle,SinA,CosA);
  Result.eM11:=CosA;
  Result.eM12:=SinA;
  Result.eM21:=-SinA;
  Result.eM22:=CosA;
  Result.eDx:=(Centre.X - (CosA*Centre.X)) + (SinA*Centre.Y);
  Result.eDy:=(Centre.Y - (SinA*Centre.X)) - (CosA*Centre.Y);
end;

// mise à l'échelle autour du centre
function XForm_Echelle(const AZoomX : Single;const AZoomY : Single;const centre: TPoint) : TXForm;
begin
  Result.eM11:=AZoomX;
  Result.eM12:=0.0;
  Result.eM21:=0.0;
  Result.eM22:=AZoomY;
  Result.eDx:=centre.x - AZoomX*centre.x;
  Result.eDy:=centre.y - AZoomY*centre.y;
end;

function XForm_Translation(const ADistX : Integer;const ADistY : Integer) : TXForm;
begin
  Result.eM11:=1.0;
  Result.eM12:=0.0;
  Result.eM21:=0.0;
  Result.eM22:=1.0;
  Result.eDx:=ADistX;
  Result.eDy:=ADistY;
end;

// dessine le train indextrain pour son animation de déplacement
// x,y en coordonnées windows
procedure peindre(Indextrain,x,y : integer;Zoom : single);
var
  XFormScale,XFormRot,XFormXLat,XForm,XFormOld  : TXForm;  //  matrice
  GMode,x0,y0,x1,y1,x2,y2,x3,y3,c1,c2,larg,haut,ax,ay,l2,h2       : Integer;
  d,alpha,angle,z : double;
  sinA,cosA : extended;
  tv : array[0..3] of integer;
  ACanvas     : TCanvas;
  recta : trect;
begin
  ACanvas:=FormAnalyseCDM.ImageCDm.Canvas;
 
  l2:=largeurTrain div 2;
  h2:=hauteurTrain div 2;
  y:=y-1;  // décalage observé

  {with Acanvas do
  begin
    pen.color:=clyellow;
    MoveTo(x,y);
    LineTo(x+1,y+1);
  end; }

  //y:=y-round((hauteur div 2)*zoom);
  {x1:=x;
  y1:=y;
  x2:=x+(largeur);
  y2:=y+(hauteur);
  }
  ax:=trains[indextrain].x;
  ay:=trains[indextrain].y;
  trains[indextrain].ax:=ax;
  trains[indextrain].ay:=ay;
  trains[indextrain].x:=x;
  trains[indextrain].y:=y;

  //calcul de la pente du train en fonction de l'ancienne position (ax,ay) et de la nouvelle (x,y)
  if x<>ax then alpha:=arctan((y-ay)/(x-ax)) else alpha:=pi/2;
  angle:=alpha;
// angle:=angleX;

  GMode:=SetGraphicsMode(ACanvas.Handle, GM_ADVANCED);
  if GetWorldTransform(ACanvas.Handle, XFormOld) then   // renvoie la matrice courante dans XformOld
  begin
    // faire les transformations
    XFormRot:=XForm_Rotation(Angle,Point(l2,h2));    // rotation autour du centre
    //XFormScale:=XForm_Echelle(Zoom,Zoom,Point(0,0));   // Zoom
    XFormScale:=XForm_Echelle(Zoom,Zoom,point(l2,h2));   // Zoom au point central
    XFormXLat:=XForm_Translation(x-l2,y-h2);    // décalage

    // Combiner les 3 transformations
    CombineTransform(XForm,XFormRot,XFormScale);     // Xform<-- f(XformRot,XformScale)
    CombineTransform(XForm,XForm,XFormXLat);         // Xform<-- f(Xform,XformScale)

    // calcule les coordonnées des 4 points de coins de l'icone qui a tourné et zoomé
    // x0,y0               x3,y3
    // x1,y1               x2,y2
    d:=sqrt( sqr(l2)+ sqr(h2));
    //c1:=round(zoom*l2);  // pour faire la rotation à la tete du train
    //c2:=round(zoom*h2);
    z:=zoom*d;

    alpha:=ArcTanHautLargTrain+angle;
    SinCos(Alpha,SinA,CosA);
    x0:=-round(z*cosA)+x;      //c1;
    y0:=-round(z*sinA)+y;      //+c2;
    x2:=round(z*cosA)+X;       //+c1;
    y2:=round(Zoom*d*sinA)+y;  //+c2;

    alpha:=ArcTanHautLargTrain-angle;
    SinCos(Alpha,SinA,CosA);
    x1:=-round(z*cosA)+X;      //+c1;
    y1:=round(z*sinA)+y;       //+c2;
    x3:=round(z*cosA)+X;       //+c1;
    y3:=-round(z*sinA)+y;      //c2;

    // agrandir la zone un peu
    dec(x0);dec(y0);
    dec(x1);inc(y1);
    inc(x2);inc(y2);
    inc(x3);dec(y3);

    // rectangle contenant l'icone
    tv[0]:=x0; tv[1]:=x1; tv[2]:=x2; tv[3]:=x3;
    x0:=minIntValue(tv);
    x1:=maxIntValue(tv);
    tv[0]:=y0; tv[1]:=y1; tv[2]:=y2; tv[3]:=y3;
    y0:=minIntValue(tv);
    y1:=maxIntValue(tv);
    larg:=x1-x0;
    haut:=y1-y0;

    {
    with Acanvas do
    begin
      Pen.color:=clyellow;
      Pen.width:=1;
      rectangle(x0,y0,x1,y1);
    end;}

    // restituer l'ancien affichage
    if not(premaff) then recta:=rect(trains[IndexTrain].x0,trains[IndexTrain].y0,trains[IndexTrain].x1,trains[IndexTrain].y1);
    premaff:=false;
    Acanvas.CopyRect(recta,trains[IndexTrain].SBitmap.canvas,rect(0,0,trains[IndexTrain].x1-trains[IndexTrain].x0,trains[IndexTrain].y1-trains[IndexTrain].y0));   // copie dans Acanvas <-- SbitMap.canvas


    // sauvegarder à la nouvelle position avant d'afficher la nouvelle position
    recta:=rect(x0,y0,x1,y1);
    trains[IndexTrain].sbitmap.canvas.CopyRect(rect(0,0,larg,haut),Acanvas,recta);   // copie dans sbitmap.canvas <-- Acanvas
    //FormAnalyseCDM.Image1.Canvas.CopyRect(rect(0,0,larg,haut),Acanvas,recta );

    trains[IndexTrain].x0:=x0;
    trains[IndexTrain].y0:=y0;
    trains[IndexTrain].x1:=x1;
    trains[IndexTrain].y1:=y1;

    // appliquer les transformations dans le canvas et afficher l'icône du train
    SetWorldTransform(ACanvas.Handle,XForm);         // mettre dans le canvas
    ACanvas.Draw(0,0,FWICImage);                     // afficher le bitmap
    SetWorldTransform(ACanvas.Handle,XFormOld);
  end;
  {with Acanvas do
  begin
    pen.color:=clyellow;
    pen.width:=1;
    MoveTo(0,0);
    LineTo(x,y);
  end;}
end;


procedure Aff_train(adr: integer;train:string;x1,y1,x2,y2 :integer);
var zom : double;
    i : integer;
begin
  zom:=reducX/40;
  coords(x1,y1);
  i:=index_train_adresse(adr);
  if i>0 then peindre(i,x1,y1,zom);
end;


// Affiche le réseau CDM
procedure affichage(imprime : boolean);
const LargeurMaxi=3000;
var r : Trect;
    i,j,x1,x2,y1,y2,largeur,hauteur,rayon,centreX,centreY,Numsegment,largeurCDM,hauteurCDM,
    maxiCDM,offset,ofs,CadreImp : integer;
    SegType,s,s2,ctyp : string;
    Ech,Zoom,startAngle,StopAngle: double;
    portsSeg : array[0..40] of record x,y : integer; end;
    coul : boolean;
    canvas : tCanvas;
    couleur : Tcolor;
begin
  if (xMaxiCDM-xminiCDM=0) or (yMaxiCDM-yminiCDM=0) then exit;

  if imprime then
  begin
    if not(FormAnalyseCDM.printdialog1.Execute) then exit;
    cadre:=100;
    printer.BeginDoc;
    canvas:=printer.canvas;
    canvas.font.size:=8;
    canvas.pen.Mode:=pmCopy;
    canvas.Font.Name:='arial';
    Canvas.Brush.Style:=bsClear;
    Canvas.Brush.Color:=clWhite;

    largeur:=printer.PageWidth; // la largeur est par l'imprimante, la hauteur est calculée

    largeurCDM:=(XmaxiCDM-XminiCDM);
    hauteurCDM:=(YmaxiCDM-YminiCDM);

    maxiCDM:=max(largeurCDM,hauteurCDM);

    reducX:=1000*(largeur-(2*cadre))/maxiCDM;
    reducY:=reducX;
    largeur:=(round(largeurCDM*reducX/1000))-2*cadre;
    Hauteur:=(round(hauteurCDM*reducY/1000))-2*cadre;
  end;

  if not(imprime) then
  begin
    premaff:=true;
    cadre:=30;
    canvas:=formAnalyseCDM.ImageCDM.Canvas;
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Name:='arial';
    with formAnalyseCDM do
    begin
      largeur:=3000;  // la largeur est fixée, la hauteur est calculée

      largeurCDM:=(XmaxiCDM-XminiCDM);// div 20;
      hauteurCDM:=(YmaxiCDM-YminiCDM);// div 20;

      maxiCDM:=max(largeurCDM,hauteurCDM);

      Zoom:=(2*(90-formAnalyseCDM.TrackBar1.Position)/100)+0.4;
      reducX:=1000*Zoom*(largeur)/maxiCDM;
      reducY:=reducX;

      largeur_voie:=round(reducX/8);

      largeur:=(round(largeurCDM*reducX/1000))+2*cadre;
      Hauteur:=(round(hauteurCDM*reducY/1000))+2*cadre;

      ImageCDM.Width:=largeur;
      ImageCDM.Height:=hauteur;
      ImageCDM.Picture.Bitmap.Width:=largeur;
      ImageCDM.Picture.Bitmap.height:=hauteur;

      with scrollBox1 do
      begin
        HorzScrollBar.Range:=largeur;
        HorzScrollBar.Tracking:=true;
        HorzScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si onclique sur la trackbar!!
        VertScrollBar.Range:=hauteur;
        VertScrollBar.Tracking:=true;
        VertScrollBar.Smooth:=false;
      end;
    end;
  end;

  with Canvas do
  begin
    //effacer tout
    Pen.width:=1;
    Brush.Style:=bsSolid;
    //Brush.Color:=clblack;
    Brush.Color:=fond_cdm;
    pen.color:=clyellow;
    if not(imprime) then
    begin
      r:=rect(0,0,FormAnalyseCDM.ImageCDM.width,FormAnalyseCDM.ImageCDM.height);
      FillRect(r);
    end;
    x1:=xminiCDM;y1:=yminiCDM;
    coords(x1,y1);
    x2:=xmaxiCDM;y2:=ymaxiCDM;
    coords(x2,y2);
    Brush.Style:=bsclear;  // permet d'écrire en transparent
  end;

  coul:=false;
  // balayage ...
  for i:=0 to nSeg-1 do
  begin
   // Affiche(intToSTR(i),clyellow);
    SegType:=Segment[i].typ;
    NumSegment:=Segment[i].numero;
    coul:=not(coul);
    if imprime then canvas.pen.color:=clblack else
    begin
      if not(coloration_Diff) then begin canvas.pen.Color:=clWhite;canvas.Font.color:=clWhite;end else
      begin
        if coul then begin canvas.font.color:=clWhite;canvas.pen.Color:=clWhite;end
          else begin canvas.font.color:=clyellow;canvas.pen.color:=ClYellow;end;
      end;
    end;

    s:='S'+intToSTR(Segment[i].numero); //+' '+SegType;
    if (SegType='turnout') or (SegType='dbl_slip_switch') then
    begin
      s2:=intToSTR(Segment[i].adresse);
      s:=s+' @='+s2;
    end;

    begin
      x1:=segment[i].XMin;y1:=segment[i].YMin; coords(x1,y1);
      x2:=segment[i].XMax;y2:=segment[i].Ymax; coords(x2,y2);
      with Canvas do
      begin
        if formAnalyseCDM.CheckSegments.checked then
        begin
          Textout(x1,y1,s);
          pen.Width:=1;
          PolyGon([point(x1,y1),Point(x2,y2)]);
        end;
        {
        if SegType='straight' then
        begin
         // x1:=segment[i].xc0;
         // affiche(intToSTR(x1),clyellow);
        end;}
      end;
    end;
    //Affiche(s,ClAqua);

    // ports en vert --------------------------------------
    nport:=Segment[i].nport;

    if formAnalyseCDM.CheckPorts.checked then
    begin
      if imprime then canvas.Font.Color:=ClBlack
      else
      begin
        if coul then Canvas.font.Color:=clWhite else
          Canvas.font.color:=ClYellow;
      end;
      x1:=(Segment[i].port[0].x+Segment[i].port[1].x) div 2;
      y1:=(Segment[i].port[0].y+Segment[i].port[1].y) div 2;
      coords(x1,y1);
      s:='S'+intToSTR(NumSegment);
      Canvas.Textout(x1,y1,s);
    end;

    for j:=0 to nPort-1 do
    begin
      x1:=segment[i].port[j].X;
      y1:=segment[i].port[j].y;
      begin
        coords(x1,y1);
        if formAnalyseCDM.CheckConnexions.checked then
        begin
          canvas.pen.width:=1;
          canvas.Ellipse(x1-5,y1-5,x1+5,y1+5);
        end;
        if j<40 then
        begin
          portsSeg[j].x:=x1;      // coordonnées du port j en format image.canvas
          portsSeg[j].y:=y1;
        end;
        if formAnalyseCDM.CheckPorts.checked then
        begin
          //port j
          x1:=Segment[i].port[j].x;
          y1:=Segment[i].port[j].y;

          if j=0 then
          begin
            if x1<Segment[i].port[1].x then offset:=+20 else offset:=-20;
          end;
          if j=1 then
          begin
            if x1<Segment[i].port[0].x then offset:=+20 else offset:=-20;
          end;

          coords(x1,y1);
          x1:=x1+offset;
          s:='P'+intToSTR(Segment[i].port[j].numero);
          canvas.textout(x1,y1,s);
        end;
      end;
      //Affiche(s,ClYellow);
    end;

    with Canvas do
    begin
      pen.width:=largeur_voie;
      if (segtype='crossing') or (segType='dbl_slip_switch') then
      begin
        if imprime then pen.Color:=ClBlack else
        begin
          if coloration_diff then pen.color:=clLime else pen.color:=clWhite;
        end;
        moveto(portsSeg[0].x,portsSeg[0].y);
        LineTo(portsSeg[2].x,portsSeg[2].y);
        moveto(portsSeg[1].x,portsSeg[1].y);
        LineTo(portsSeg[3].x,portsSeg[3].y);
        if formAnalyseCDM.CheckAdresses.checked then coords_aff_aig(canvas,i);
      end
      else
      if (segtype='turnout') or (segtype='turnout_sym')  then
      begin
        if imprime then pen.Color:=ClBlack else
        begin
          if coloration_diff then pen.color:=clLime else pen.color:=clWhite;
        end;
        moveto(portsSeg[0].x,portsSeg[0].y);
        LineTo(portsSeg[1].x,portsSeg[1].y);
        moveTo((portsSeg[0].x+portsSeg[1].x) div 2,(portsSeg[0].y+portsSeg[1].y) div 2);
        LineTo(portsSeg[2].x,portsSeg[2].y);
        if formAnalyseCDM.CheckAdresses.checked then coords_aff_aig(canvas,i);
      end
      else
      if (segtype='turnout_3way') then
      begin
        if imprime then pen.Color:=ClBlack else
        begin
          if coloration_diff then pen.color:=clLime else pen.color:=clWhite;
        end;
        moveto(portsSeg[0].x,portsSeg[0].y);LineTo(portsSeg[1].x,portsSeg[1].y);
        moveTo((portsSeg[0].x+portsSeg[1].x) div 2,(portsSeg[0].y+portsSeg[1].y) div 2);
        LineTo(portsSeg[2].x,portsSeg[2].y);
        moveTo((portsSeg[0].x+portsSeg[1].x) div 2,(portsSeg[0].y+portsSeg[1].y) div 2);
        LineTo(portsSeg[3].x,portsSeg[3].y);
        if formAnalyseCDM.CheckAdresses.checked then coords_aff_aig(canvas,i);
      end
      else
      if (segtype='turnout_curved') or (segtype='turnout_curved_2r')
      then
      begin
        if imprime then pen.Color:=ClBlack else
        begin
          if coloration_diff then pen.color:=clLime else pen.color:=clWhite;
        end;

        Moveto(portsSeg[0].x,portsSeg[0].y);
        LineTo(portsSeg[1].x,portsSeg[1].y);

        MoveTo((portsSeg[0].x+portsSeg[1].x)div 2,(portsSeg[0].y+portsSeg[1].y)div 2);
        LineTo(portsSeg[2].x,portsSeg[2].y);

        //dessine_aig_courbe(canvas,i);
        if formAnalyseCDM.CheckAdresses.checked then coords_aff_aig(canvas,i);
      end
      else
      if (segType='arc') or (segType='curve') then
      begin
        rayon:=segment[i].Rayon;
        StartAngle:=(segment[i].StartAngle/100);
        StopAngle:=segment[i].ArcAngle/100;
        centreX:=segment[i].lXc;
        CentreY:=segment[i].lyc;
        angle_cdm(canvas,centreX,CentreY,startangle,stopangle,rayon);
      end
      else
      begin
        if imprime then pen.Color:=ClBlack;
        moveto(portsSeg[0].x,portsSeg[0].y);
        for j:=1 to nPort-1 do
          LineTo(portsSeg[j].x,portsSeg[j].y);
      end;

    end;

    // périphériques en jaune --------------------------
    nperiph:=Segment[i].nperiph;
    Canvas.Pen.Color:=clYellow;
    Canvas.Font.Color:=clYellow;

    for j:=0 to nPeriph-1 do
    begin
      ctyp:=Segment[i].periph[j].typ;
      s:='Periph '+intToSTR(Segment[i].periph[j].numero)+' '+ctyp;
      s2:=intToSTR(Segment[i].periph[j].adresse);
      if Segment[i].periph[j].adresse<>0 then
      begin
        s:=s+' Adresse='+s2;
        x1:=segment[i].periph[j].X; y1:=segment[i].periph[j].y ;
        with Canvas do
        begin
          coords(x1,y1);
          if formAnalyseCDM.CheckAdresses.checked then
          begin
            ofs:=0;
            if ctyp='detector' then begin couleur:=clAqua;ofs:=-15;end;
            if ctyp='actuator' then begin couleur:=clorange;ofs:=5;end;
            if ctyp='signal' then begin couleur:=clWhite;ofs:=5;end;
            font.color:=couleur;
            pen.color:=couleur;

            textout(x1+4,y1+ofs,s2);
            pen.Width:=1;
            Ellipse(x1-5,y1-5,x1+5,y1+5);
          end;
        end;
      end;
      //Affiche(s,clOrange);
    end;

    nInter:=Segment[i].nInter;
    for j:=0 to nInter-1 do
    begin
      s:='Inter '+Segment[i].Inter[j].typ;
      //Affiche(s,ClYellow);
    end;
  end;
  if imprime then printer.EndDoc;
end;


// supprime les espaces de la premiere position de la chaine jusqu'à ce qu'on rencontre un caractère <>' '
function Supprime_espaces(s : string) : string;
var faire : boolean;
begin
  s:=AnsiLowerCase(s);
  faire:=s<>'';
  while faire do
  begin
    if s[1]=' ' then delete(s,1,1);
    if length(s)<>0 then faire:=s[1]=' ' else faire:=false;
  end;
  result:=s;
end;

procedure liste_liens;
var i,j,connecteAuPort,ConnecteAuSeg,numPort: integer;
    segType : string;
begin
  for i:=0 to nSeg-1 do
  begin
    SegType:=Segment[i].typ;
    nport:=Segment[i].nport;
    for j:=0 to nPort-1 do
    begin
      connecteAuPort:=Segment[i].port[j].ConnecteAuPort;
      connecteAuSeg:=Segment[i].port[j].ConnecteAuSeg;
      NumPort:=Segment[i].port[j].numero;
      Affiche('Le port '+intToSTR(NumPort)+' est connecté au port '+intToSTR(connecteAuPort)+' segment '+intToSTR(ConnecteAuSeg),clyellow);
    end;
  end;
end;

// renvoie si le segment est de tye aiguillage
function segment_aig(s : string) : boolean;
begin
  segment_aig:=(s='turnout') or (s='dbl_slip_switch') or (s='turnout_sym') or
               (s='turnout_curved') or (s='turnout_curved_2r') or (s='turnout_3way');
end;

// trouve l'index du port du segment courant connecté au segment dont l'index est Indexconnecte
function index_port_connecte(index,indexConnecte : integer;var Indexport : integer) : boolean;
var i,np1 : integer;
   trouve : boolean;
begin
   i:=0;
   np1:=segment[index].nport;
   repeat
     trouve:=segment[index].port[i].ConnecteAuSeg=segment[indexConnecte].numero;
     if not(trouve) then inc(i);
   until trouve or (i>np1-1);
   result:=trouve;
   if trouve then IndexPort:=i else indexPort:=-1;
end;


// trouve l'index du segment contenant l'aiguillage adresse
function trouve_IdSegment_aig(adresse : integer;var Id: integer) : boolean;
var i,p,p2 : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    p:=segment[i].adresse;
    p2:=segment[i].adresse2;
    //Affiche(intToSTR(p),clwhite);
    trouve:=((p=adresse) or (p2=adresse)) and segment_aig(segment[i].typ);
    inc(i);
  until (i>nSeg-1) or trouve;
  dec(i);
  if trouve then
  begin
    Id:=i;
    trouve_IdSegment_Aig:=true;
  end
  else
  begin
    id:=-1;
    trouve_IdSegment_Aig:=false;
  end
end;


// trouve les indexs Segment et port contenant le détecteur est detecteur
function trouve_IndexSegPortDetecteur(detecteur : integer;var indexSeg,indexPeriph : integer) : boolean;
var i,j,p,np : integer;
    trouve : boolean;
begin
  i:=0;
  trouve:=false;
  repeat
    j:=0;
    np:=segment[i].nperiph; // nombre de périphériques
    repeat
      if np>0 then
      begin
        p:=segment[i].periph[j].adresse;
        //Affiche(intToSTR(p),clwhite);
        trouve:=(p=detecteur);
      end;
      inc(j);
    until (j>np-1) or trouve;
    inc(i);
  until (i>nSeg-1) or trouve;
  dec(i);dec(j);
  if trouve then
  begin
    trouve_IndexSegPortDetecteur:=true;
    indexSeg:=i;
    indexPeriph:=j;
  end
  else
  begin
    trouve_IndexSegPortDetecteur:=false;
    indexSeg:=-1;
    indexPeriph:=-1;
  end
end;

// trouve l'index du segment
function Index_Segment(seg : integer;var indexSeg : integer) : boolean;
var i,s : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    s:=segment[i].numero;
     //Affiche(intToSTR(p),clwhite);
    trouve:=(s=seg);
    inc(i);
  until (i>nSeg-1) or trouve;
  dec(i);
  if trouve then
  begin
    indexSeg:=i;
    Index_Segment:=true;
  end
  else
  begin
    indexSeg:=-1;
    Index_Segment:=false;
  end
end;


// trouve les index du segment,port
function trouve_IndexSegPort(seg,port : integer;var indexSeg,indexPort : integer) : boolean;
var i,j,p,np,ns : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    j:=0;
    np:=segment[i].nport; // nombre de ports
    ns:=segment[i].numero;
    repeat
      p:=segment[i].port[j].numero;
     //Affiche(intToSTR(p),clwhite);
      trouve:=(port=p) and (seg=ns);
      inc(j);
    until (j>np-1) or trouve;
    inc(i);
  until (i>nSeg-1) or trouve;
  dec(i);dec(j);
  if trouve then
  begin
    indexSeg:=i;
    indexPort:=j;
    trouve_IndexSegPort:=true;
  end
  else
  begin
    trouve_IndexSegPort:=false;
    indexSeg:=-1;
    indexPort:=-1;
  end
end;

// trouve l'index d'un port dans un segment
function trouve_IndexPort_Segment(IndexSegment,port : integer) : integer;
var i,np : integer;
    trouve : boolean;
begin
  np:=segment[indexSegment].nport;  // nombre de ports
  i:=0;
  repeat
    trouve:=segment[indexsegment].port[i].numero=port;
    inc(i);
  until (i>np-1) or trouve;
  dec(i);
  result:=i;
end;

// trouve les index du port dans la liste des segments
procedure trouve_IndexPort(port : integer;var indexSeg,indexPort : integer);
var i,j,p,np : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    j:=0;
    np:=segment[i].nport;
    repeat
      p:=segment[i].port[j].numero;
     //Affiche(intToSTR(p),clwhite);
      trouve:=(port=p) ;
      inc(j);
    until (j>np-1) or trouve;
    inc(i);
  until (i>nSeg-1) or trouve;
  dec(i);dec(j);
  if trouve then
  begin
    indexSeg:=i;
    indexPort:=j;
  end
  else
  begin
    indexSeg:=-1;
    indexPort:=-1;
  end
end;

// raz du tableau des détecteurs rencontrés entre 2 aiguillages
procedure raz_detect(var t : tdetect_cdm);
var i : integer;
begin
  nb_det:=0;
  for i:=1 to max_db do
  begin
    t[i].distance:=0;t[i].adresse:=0;
  end;
end;

// trie le tableau t en fonction de la distance
procedure trier(var t :  tdetect_cdm;n :integer);
var i,j : integer;
    temp : trec_cdm;
begin
  for i:=1 to n do
  begin
    for j:=i+1 to n do
    begin
      if t[i].distance>t[j].distance then
      begin
        temp:=t[i];
        t[i]:=t[j];
        t[j]:=temp;
      end;
    end;
  end;
end;


// fonction récursive
// explore le port,segment jusqu'a trouver une adresse d'aiguillage, de croisement, ou de détecteur
// renvoie l'adresse de l'aiguillage ou du détecteur et dans C le port (P D S)
function explore_port(seg,port : integer;var c : string) : integer;
var i,j,IdSeg,IdPort,NombrePeriph,port1,port2,portSuivant,segSuivant,portLocal,
    xp,yp,xd,yd,detect,nb_det : integer;
    typeP,serr : string;
    sdetect : Tdetect_cdm;
begin
  if seg=0 then
  begin
    explore_port:=0;
    exit;  // laisser sinon mauvais transfert de variable dans la pile dans l'itération suivante!!
  end;
  trouve_IndexSegPort(seg,port,idSeg,IdPort);
  if idseg=-1 then
  begin
    serr:='Erreur 1 pas trouvé le port '+intToSTR(port)+' dans la liste des segments';
    Affiche(serr,clred);
    AfficheDebug(serr,clred);
    explore_port:=0;
    c:='';
    exit;
  end;

  // trouver le segment contigu connecté au port de connexion
  segSuivant:=segment[idseg].port[idport].ConnecteAuSeg;
  portSuivant:=segment[idseg].port[idport].ConnecteAuPort;
  trouve_IndexSegPort(segSuivant,portSuivant,idSeg,IdPort);
  //Affiche('segsuiv='+intToSTr(segsuivant),clred);
  if idSeg=-1 then
  begin
    serr:='Erreur 2 pas trouvé le port '+intToSTR(port)+' dans la liste des segments';
    Affiche(serr,clred);
    AfficheDebug(serr,clred);
    c:='';
    explore_port:=0;
    exit;
  end;


  // remonter au segment pour voir si c'est un aiguillage
  typeP:=segment[idSeg].typ;

  if typeP='dbl_slip_switch' then
  begin
    portlocal:=segment[idSeg].port[idport].local;
    case portlocal of
    0 : c:='D';
    1 : c:='S';
    2 : c:='D';
    3 : c:='S';
    end;

    // TJD 2 états
    if segment[idSeg].adresse2=0 then
    begin
      explore_port:=segment[idSeg].adresse;
      exit;
    end;

    // tjd 4 états
    // si on vient du port 0 ou 1, c'est adresse
    // si on vient du port 2 ou 3, c'est adresse2
    if (portlocal=0) or (portlocal=1) then explore_port:=segment[idSeg].adresse;
    if (portlocal=2) or (portlocal=3) then explore_port:=segment[idSeg].adresse2;
    exit;
  end;

  if segment_aig(typeP) then // est-ce un aig
  //------------- aiguillage
  begin
    portlocal:=segment[idSeg].port[idport].local;
    case portlocal of
    0 : c:='P';
    1 : c:='D';
    2 : c:='S';
    end;
    explore_port:=segment[idSeg].adresse;
    exit;
  end;
  // --- croisement
  if typeP='crossing' then
  begin
    portlocal:=segment[idSeg].port[idport].local;
    case portlocal of
    0 : c:='D';
    1 : c:='S';
    2 : c:='D';
    3 : c:='S';
    end;
    explore_port:=segment[idSeg].adresse;
    exit;
  end;

  // trouver le détecteur le plus proche.
  NombrePeriph:=segment[idSeg].nperiph;
  j:=0;detect:=0;nb_det:=0;
  if NombrePeriph<>0 then
  begin
    raz_detect(sDetect);                      // on peut rencontrer des détecteurs non appairés: ex ;  514   522   514   522
    repeat
      if segment[idSeg].periph[j].typ='detector' then
      begin
        detect:=segment[idSeg].periph[j].adresse;
        if detect<>0 then
        begin
          //if NivDebug=3 then Affichedebug('Détecteur '+inttoStr(detect),clyellow);
          // incrémenter le compteur du détecteur rencontré
          inc(nb_det);
          sDetect[nb_det].adresse:=detect ;
          // coordonnées du port
          xp:=segment[idSeg].Port[idPort].x;
          yp:=segment[idSeg].Port[idPort].y;
          // coordonnées du détecteur
          xd:=segment[idSeg].periph[j].x;
          yd:=segment[idSeg].periph[j].y;
          // calculer la distance du détecteur au port
          sDetect[nb_det].distance:=round( sqrt( sqr(xp-xd)+sqr(yp-yd) ));
        end;
      end;
      inc(j);
    until (j>NombrePeriph-1) ;
    // trier les détecteurs du segment dans l'ordre de la distance de la plus
    // courte à la plus grande au port
    if nb_det<>0 then
    begin
      trier(Sdetect,nb_det);

      // on prend le premier!!
      explore_port:=sDetect[1].adresse;
      c:='';
      exit;
    end;
  end;

  // trouver l'autre port du segment idseg
  // sur 2 ports
  NombrePeriph:=segment[idSeg].nport;
  if NombrePeriph=0 then
  begin
    c:='';
    explore_port:=0;
    exit;
  end;
  port1:=segment[idSeg].port[0].numero;
  port2:=segment[idSeg].port[1].numero;
  i:=0;
  if (port1<>portSuivant) and (segment[idSeg].port[0].connecte) then i:=explore_port(SegSuivant,port1,c);
  if (port2<>portSuivant) and (segment[idSeg].port[1].connecte) then i:=explore_port(SegSuivant,port2,c);

  explore_port:=i;
  exit;

  typeP:=segment[idSeg].typ;
  // explorer l'autre port
  if (typeP='straight') or (typeP='arc') or (typeP='curve') or (typeP='pre_curve') then
  begin
    port1:=segment[idSeg].port[0].numero;
    port2:=segment[idSeg].port[1].numero;
    if port1<>portSuivant then i:=explore_port(SegSuivant,port1,c);
    if port2<>portSuivant then i:=explore_port(SegSuivant,port2,c);
    c:='';
    explore_port:=i;
    exit;
  end;

  Affiche('Segment '+typeP+' non trouvé',clred);

  explore_Port:=0;

end;

// stocke les aiguillages et les croisement dans le tableau Aig_CDM
procedure remplit_Aig_cdm;
  var i,j,NumSegment,IndexSegment,IndexPort,
  adresse,adresse2,element,AdrCroisement : integer;
  s,segType,c,serr : string;
begin
  // 1er segment, 1er port
  IndexSegment:=0;IndexPort:=0;
  if debugAnalyse then
  begin
    AfficheDebug(' ',clwhite);
    AfficheDebug('Liste des croisements',clWhite);
    AfficheDebug('--------------------------------',clWhite);
  end;
  NAig_CDM:=0;
  SeqAdrCroisement:=0;
  inc(DernAdrAig);
  for i:=0 to nseg-1 do
  begin
    segType:=segment[i].typ;
    if segType='crossing' then
    begin
      numSegment:=segment[i].numero;
      if formImportation.radioCroisSuite.checked then AdrCroisement:=DernAdrAig+SeqAdrCroisement;
      if formImportation.radioCroisBase.checked then AdrCroisement:=BaseCroisement+SeqAdrCroisement;

      segment[i].adresse:=AdrCroisement;
      inc(nAig_CDM);
      Aig_CDM[nAig_CDM].adresse:=AdrCroisement;
      Aig_CDM[nAig_CDM].modele:=crois;

      s:='Segment '+intToSTR(numSegment)+' type='+segtype+' Adresse='+intToSTR(AdrCroisement);
      inc(SeqAdrCroisement);
      if debugAnalyse then AfficheDebug(s,clorange);

      for j:=0 to segment[i].nport-1 do
      begin
        s:='  Port '+intToSTR(j)+' ';
        // explorer les ports de l'aiguillage
        element:=explore_port(numsegment,segment[i].port[j].numero,c);

        case j of
        0 : begin s:=s+'D';Aig_cdm[nAig_cdm].ddroit:=element;if length(c)<>0 then Aig_cdm[nAig_cdm].ddroitB:=c[1];end;
        1 : begin s:=s+'S';Aig_cdm[nAig_cdm].dDevie:=element;if length(c)<>0 then Aig_cdm[nAig_cdm].ddevieB:=c[1];end;
        2 : begin s:=s+'D';Aig_cdm[nAig_cdm].ADroit:=element;if length(c)<>0 then Aig_cdm[nAig_cdm].aDroitB:=c[1];end;
        3 : begin s:=s+'S';Aig_cdm[nAig_cdm].aDevie:=element;if length(c)<>0 then Aig_cdm[nAig_cdm].aDevieB:=c[1];end;
        end;

        s:=s+' Element : '+intToStr(element)+c;
        if debugAnalyse then afficheDebug(s,clorange);

      end;

    end;
  end;

  if debugAnalyse then
  begin
    AfficheDebug('Liste des aiguillages',clWhite);
    AfficheDebug('--------------------------------',clWhite);
  end;
  for i:=0 to nseg-1 do
  begin
    segType:=segment[i].typ;
    if segment_aig(segtype) then
    begin
      numSegment:=segment[i].numero;
      adresse:=segment[i].adresse;
      if adresse<>0 then
      begin
        s:='Segment '+intToSTR(numSegment)+' type='+segtype+' Adresse='+intToSTR(adresse);
        if segType='dbl_slip_switch' then s:=s+' Adresse2='+intToSTR(segment[i].adresse2);
        if debugAnalyse then AfficheDebug(s,clorange);
        if (adresse=0) then
        begin
          serr:='   Erreur segment aiguillage ('+segType+') avec adresse nulle ; segment '+intToSTR(numSegment);
          Affiche(serr,clred);
          afficheDebug(serr,clred);
        end;


        inc(nAig_CDM);
        Aig_CDM[nAig_CDM].adresse:=adresse;
        Aig_CDM[nAig_CDM].temps:=segment[i].duree;

        if (SegType='dbl_slip_switch') then
        begin
          adresse2:=segment[i].adresse2;
          Aig_CDM[nAig_CDM].modele:=tjd;
          Aig_CDM[nAig_CDM].ddroit:=Adresse2;
          Aig_CDM[nAig_CDM].ddroitB:='D';
          Aig_CDM[nAig_CDM].dDevie:=Adresse2;
          Aig_CDM[nAig_CDM].dDevieB:='S';

          if adresse2=0 then
          begin
            Aig_CDM[nAig_CDM].etatTJD:=2;
          end
          else Aig_CDM[nAig_CDM].etatTJD:=4;

          if adresse2<>0 then
          begin
            inc(nAig_CDM);   // attention deux adresses sur TJD 4 états
            // remplissage 2eme adresse
            Aig_CDM[nAig_CDM].adresse:=adresse2;
            Aig_CDM[nAig_CDM].temps:=segment[i].duree;
            Aig_CDM[nAig_CDM].modele:=tjd;
            Aig_CDM[nAig_CDM].ddroit:=Adresse;
            Aig_CDM[nAig_CDM].ddroitB:='D';
            Aig_CDM[nAig_CDM].dDevie:=Adresse;
            Aig_CDM[nAig_CDM].dDevieB:='S';
            Aig_CDM[nAig_CDM].etatTJD:=4;
          end;

        end;

        if (SegType='turnout') or (SegType='turnout_sym') or (SegType='turnout_curved') or (SegType='turnout_curved_2r') then Aig_CDM[nAig_CDM].modele:=aig;
        if (SegType='turnout_3way') then
        begin
          Aig_CDM[nAig_CDM].modele:=triple;
          Aig_CDM[nAig_CDM].adrTriple:=segment[i].adresse2;
        end;

        // remplir les ports de connexion (aig et tjd)
        for j:=0 to segment[i].nport-1 do
        begin
          s:='  Port '+intToSTR(j)+' ';
          if (SegType<>'dbl_slip_switch') and (Segtype<>'turnout_3way') then
          case j of
          0 : s:=s+'P';
          1 : s:=s+'D';
          2 : s:=s+'S';
          end;

         if (SegType='dbl_slip_switch') then //or (SegType='crossing') then
         begin
            case j of
            0 : s:=s+'D';
            1 : s:=s+'S';
            2 : s:=s+'D';
            3 : s:=s+'S';
            end;
          end;

          if (SegType='turnout_3way') then
          case j of
          0 : s:=s+'P';
          1 : s:=s+'D';
          2 : s:=s+'S';
          3 : s:=s+'S2';
          end;

         // explorer les ports de l'aiguillage
          element:=explore_port(numsegment,segment[i].port[j].numero,c);
          s:=s+' Element : '+intToStr(element)+c;
          if debugAnalyse then AfficheDebug(s,clorange);

          if (SegType='dbl_slip_switch') then
          begin
            if adresse2<>0 then
            begin
              // 4 états
              if j=0 then begin Aig_CDM[nAig_CDM-1].Adroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM-1].AdroitB:=c[1];end;
              if j=1 then begin Aig_CDM[nAig_CDM-1].Adevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM-1].AdevieB:=c[1];end;
              if j=2 then begin Aig_CDM[nAig_CDM].Adroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdroitB:=c[1];end;
              if j=3 then begin Aig_CDM[nAig_CDM].Adevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdevieB:=c[1];end;
            end
            else
            begin
              // 2 états
              if j=0 then begin Aig_CDM[nAig_CDM].Adroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdroitB:=c[1];end;
              if j=1 then begin Aig_CDM[nAig_CDM].Adevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdevieB:=c[1];end;
              if j=2 then begin Aig_CDM[nAig_CDM].Ddroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].DdroitB:=c[1];end;
              if j=3 then begin Aig_CDM[nAig_CDM].Ddevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].DdevieB:=c[1];end;
            end;
          end;

          if SegType='turnout_3way' then
          begin
            if j=0 then begin Aig_CDM[nAig_CDM].APointe:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].APointeB:=c[1];end;
            if j=1 then begin Aig_CDM[nAig_CDM].ADroit:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADroitB:=c[1];end;
            if j=2 then begin Aig_CDM[nAig_CDM].ADevie:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADevieB:=c[1];end;
            if j=3 then begin Aig_CDM[nAig_CDM].ADevie2:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADevie2B:=c[1];end;
          end;

          if segType='crossing' then
          begin
            if j=0 then begin Aig_CDM[nAig_CDM].Adroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdroitB:=c[1];end;
            if j=1 then begin Aig_CDM[nAig_CDM].Adevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdevieB:=c[1];end;
            if j=2 then begin Aig_CDM[nAig_CDM].Ddroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].DdroitB:=c[1];end;
            if j=3 then begin Aig_CDM[nAig_CDM].Ddevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].DdevieB:=c[1];end;
          end;

          if (SegTYpe='turnout') or (SegType='turnout_curved') or (SegType='turnout_curved_2r') or (SegType='turnout_sym') then
          begin
            if j=0 then begin Aig_CDM[nAig_CDM].APointe:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].APointeB:=c[1];end;
            if j=1 then begin Aig_CDM[nAig_CDM].ADroit:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADroitB:=c[1];end;
            if j=2 then begin Aig_CDM[nAig_CDM].ADevie:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADevieB:=c[1];end;
          end;
        end;
     end;
    end;
  end;
end;

// trouve le port de destination sur un segment en fonction du port d'origine 'port'
// exemple : (281,81) renvoie 82
function trouve_port_suivant(IndexSeg,port : integer) : integer;
var ctype: string;
    pOrg,pDest,p1,p2 : integer;
    trouve : boolean;
begin
  ctype:=segment[indexSeg].typ;

  if (ctype='crossing') or (ctype='dbl_slip_switch') then
  begin
    // déterminer le numéro du port d'origine
    pOrg:=0;
    repeat
      trouve:=segment[indexSeg].port[pOrg].numero=port;
      if not(trouve) then inc(pOrg);
    until trouve or (pOrg>3);
    if pOrg=0 then pDest:=2;  // port origine, port destination
    if pOrg=1 then pDest:=3;
    if pOrg=2 then pDest:=0;
    if pOrg=3 then pDest:=1;
    trouve_port_suivant:=segment[indexSeg].port[pDest].numero;
    exit;
  end;

  // autre aiguillage
  if segment_aig(ctype) then
  begin
    // déterminer le numéro du port d'origine
    pOrg:=0;
    repeat
      trouve:=segment[indexSeg].port[pOrg].numero=port;
      if not(trouve) then inc(pOrg);
    until trouve or (pOrg>3);
    if pOrg=0 then pDest:=1;  // port origine, port destination  : aiguillage en position droite
    if pOrg=1 then pDest:=0;
    if pOrg=2 then pDest:=0;
    if pOrg=3 then pDest:=0;  // si c'est un triple
    trouve_port_suivant:=segment[indexSeg].port[pDest].numero;
    exit;
  end;

  if ctype='turntable' then
  begin
    // on repart d'où on vient
    trouve_port_suivant:=port;
    exit;
  end;

  // si section simple
  p1:=segment[indexSeg].port[0].numero;
  p2:=segment[indexSeg].port[1].numero;
  if p1=port then
  begin
    trouve_port_suivant:=p2;
  end;
  if p2=port then
  begin
    trouve_port_suivant:=p1;
    exit;
  end;
end;

// trouve le segment suivant du segment index, opposé au port
//     170   seg=169    171  |  173   Seg=172   174   |
// exemple trouve_seg_suivant(169,171) => 172 173 dans IndexSegSuiv,IndexportSuiv
function trouve_seg_suivant(IndexSeg,Indexport : integer;var IndexSegSuiv,IndexportSuiv : integer) : boolean;
var PortSuiv,NumSegment,ips,SegSuiv,np : integer;
    ctype : string;
begin
  numSegment:=segment[indexSeg].numero;
  numport:=segment[indexSeg].port[indexPort].numero;
  if nivDebug=3 then AfficheDebug('trouve le seg suivant au '+intToSTR(numSegment)+' port '+intToSTR(numport),clyellow);
  np:=segment[indexSeg].nport;
  if np<2 then
  begin
    // valable uniquement sur un segment à au moins 2 ports
    AfficheDebug('Erreur 68 : recherche sur un segment '+intToSTR(segment[indexSeg].numero)+' <2 ports',clred);
    trouve_seg_suivant:=false;
    IndexSegSuiv:=-1;
    indexportSuiv:=-1;
    exit;
  end;

  ctype:=segment[indexSeg].typ;

  SegSuiv:=segment[indexSeg].port[Indexport].ConnecteAuSeg;
  PortSuiv:=segment[indexSeg].port[Indexport].ConnecteAuPort;
  //trouver l'index du port du segment
  if segment[indexSeg].port[Indexport].connecte then
  begin
    if trouve_IndexSegPort(segSuiv,portSuiv,indexSeg,ips) then
    begin
      IndexSegSuiv:=indexSeg;
      IndexPortSuiv:=ips;
      //portsuiv:=segment[indexSeg].port[indexport].numero;
      result:=true;
      exit;
    end
    else
    begin
      Affiche('Pas trouvé l''index du segment port: '+intToSTR(SegSuiv)+' '+intToSTR(portSuiv),clred);
      AfficheDebug('Pas trouvé l''index du segment port: '+intToSTR(SegSuiv)+' '+intToSTR(portSuiv),clOrange);
      result:=false;
    end;
  end
  else
  begin
    //afficheDebug('Port non connecté',clOrange);
    result:=false;
  end;
end;


// renvoie le dernier champ d'une chaine séparés par des virgules
// s='aa,bb,ccc,ddd,ee'  : renvoie ee
function dernier_champ(s : string) : string;
var i,l : integer;
begin
  if s='' then
  begin
    result:='';
    exit;
  end;
  l:=length(s);
  i:=l+1;
  repeat
    dec(i);
  until (s[i]=',') or (i=1);
  if s[i]=',' then
  begin
    result:=copy(s,i+1,l-i);
    exit;
  end;
  result:='';
  exit;
end;


// créée la branche depuis un aiguillage dont un des ports est un détecteur
// indexSeg,port : index su segment et port de départ
// AdrAig : adresse de l'aiguillage qui a servi de départ
procedure cree_branche_aig(indexSeg,Indexport,adrAig,NbreMaxiAigRencontres : integer);
var i,j,k,naig,IndexportSuivant,indexSegSuivant,NombrePeriph,
    detecteur,indexElBranche,AdrAigRencontre,numSegment,
    rien,erreur,det2,nb_det,xp,yp,xd,yd,Adr2,AdrDer,idx : integer;
    trouve : boolean;
    s,ss,ctype,derch: string;
    sdetect : Tdetect_cdm;
begin
  if debugBranche then AfficheDebug('Création branche depuis aiguillage '+intToSTR(AdrAig),clyellow);
  raz_detect(sdetect);
  AdrAigRencontre:=0;
  i:=0; Naig:=0;
  repeat
    if nivdebug=3 then
    begin
      numsegment:=segment[indexSeg].numero;
      NumPort:=segment[indexSeg].port[IndexPort].numero;
      AfficheDebug(intToSTR(i)+' Trouve suivant au= '+intToSTR(numSegment)+' '+intToSTR(NumPort),clOrange);
    end;
    trouve:=trouve_Seg_suivant(indexSeg,indexport,IndexSegSuivant,IndexportSuivant);   // indexSeg=48
    if not(trouve) then
    begin
      s:='Pas de segment suivant à '+intToSTR(numSegment)+' '+intToSTR(NumPort);
      affiche(s,clred);
      afficheDebug(s,clred);
    end;

    if trouve then
    begin
      raz_detect(sdetect);
      numsegment:=segment[indexSegSuivant].numero;
      NumPort:=segment[indexSegSuivant].port[IndexPortSuivant].numero;
      //if debugBranche then
      if NivDebug=3 then AfficheDebug(' Suivant= '+intToSTR(numSegment)+' '+intToSTR(NumPort),clOrange);
      ctype:=segment[indexSegSuivant].typ;

      // est-ce un aiguillage
      if segment_aig(ctype) then
      begin
        AdrAigRencontre:=segment[indexSegSuivant].adresse;
        if NivDebug=3 then Affichedebug('aig '+intTostr(adrAigRencontre),clyellow);
        if (ctype='dbl_slip_switch') and (segment[indexSegSuivant].adresse2<>0) then
        begin
          // dernier élément rencontré
          adr2:=segment[indexSegSuivant].adresse2;

          derch:=dernier_champ(sBranche);
          if derch[1]='A' then begin derch:=copy(derch,2,length(derch)-1);end;
          val(derch,AdrDer,erreur);
         // if AdrDer=ADrAigRencontre then

          idx:=index_aig(AdrAigRencontre);
          // trouver de quel côté on va à la TJD
          if (aiguillage[idx].ADroit=AdrDer) or (aiguillage[idx].ADevie=AdrDer) then
              sbranche:=sbranche+',A'+intToSTR(AdrAigRencontre)+',A'+intToSTR(adr2)
          else
          begin
            idx:=index_aig(Adr2);
            if (aiguillage[idx].ADroit=AdrDer) or (aiguillage[idx].ADevie=AdrDer) then
                sbranche:=sbranche+',A'+intToSTR(adr2)+',A'+intToSTR(AdrAigRencontre)
            else
            begin
              Affiche('TJD '+intToSTR(Adr2)+'/'+intToSTR(adrAigRencontre)+'non résolue en branche '+intToSTR(nbreBranches)+'. Une vérification manuelle est nécessaire.',clred);
              sbranche:=sbranche+',A??,A??';
            end;
          end;
          //  sbranche:=sbranche+',A'+intToSTR(adrAigRencontre)+',A'+intToSTR(adr2);
          inc(nAig);
          raz_detect(sdetect);
        end
        else
        begin
          sBranche:=sBranche+',A'+intToSTR(AdrAigRencontre);
          //if debugBranche then AfficheDebug('Aiguillage '+intToSTR(segment[indexSegSuivant].adresse),clorange);
          inc(nAig);  // à la première itération on a un aiguillage
          raz_detect(sdetect);
        end;
      end;

      // est-ce un croisement
      if ctype='crossing' then
      begin
        sBranche:=sBranche+',A'+intToSTR(segment[indexSegSuivant].adresse);
        if NivDebug=3 then Affichedebug('croisement',clyellow);
        //if debugBranche then AfficheDebug('Croisement '+intToSTR(segment[indexSegSuivant].adresse),clorange);
        raz_detect(sdetect);
      end;

      if ctype='bumper_stop' then
      begin
        sBranche:=sBranche+',0';
        if NivDebug=3 then Affichedebug('buttoir',clyellow);
        //if debugBranche then AfficheDebug('Buttoir',clorange);
        trouve:=false;
        raz_detect(sdetect);
      end;

      if ctype='turntable' then
      begin
        sBranche:=sBranche+',0';
        if NivDebug=3 then Affichedebug('table tournante',clyellow);
        //if debugBranche then AfficheDebug('Buttoir',clorange);
        trouve:=false;
        raz_detect(sdetect);
      end;

      //else

      begin
        // y a til un détecteur
        NombrePeriph:=segment[indexSegSuivant].nperiph;

        j:=0;detecteur:=0;
        if NombrePeriph<>0 then     // on peut rencontrer des détecteurs non appairés: ex ;  514   522   514   522
        begin
          nb_det:=0;
          repeat
            if segment[indexSegSuivant].periph[j].typ='detector' then
            begin
              detecteur:=segment[indexSegSuivant].periph[j].adresse;
              if detecteur<>0 then
              begin
                if NivDebug=3 then Affichedebug('Détecteur '+inttoStr(detecteur),clyellow);
                // incrémenter le compteur du détecteur rencontré
                inc(nb_det);
                sDetect[nb_det].adresse:=detecteur ;
                // coordonnées du port
                xp:=segment[indexSegSuivant].Port[IndexPortSuivant].x;
                yp:=segment[indexSegSuivant].Port[IndexPortSuivant].y;
                // coordonnées du détecteur
                xd:=segment[indexSegSuivant].periph[j].x;
                yd:=segment[indexSegSuivant].periph[j].y;
                // calculer la distance du détecteur au port
                sDetect[nb_det].distance:=round( sqrt( sqr(xp-xd)+sqr(yp-yd) ));
              end;
            end;
            inc(j);
          until (j>NombrePeriph-1) ;

          // trier les détecteurs du segment dans l'ordre de la distance de la plus
          // courte à la plus grande au port
          if nb_det<>0 then
          begin
            trier(Sdetect,nb_det);

            for j:=1 to nb_det do
            begin
              detecteur:=sDetect[j].adresse;
              ss:=dernier_champ(sbranche);
              k:=0;
              val(ss,k,erreur);
              if ss<>'' then if not(ss[1] in['0'..'9']) then k:=0;
              // vérifier si le détecteur est déja en fin de branche
              if k<>detecteur then
              begin
                sbranche:=sbranche+','+intToSTR(detecteur);
                if NivDebug=3 then Affichedebug('Détecteur pris en compte : '+intToSTR(detecteur),clyellow);
              end;
              inc(indexElBranche);
            end;
          end;
        end;

        // préparer le suivant , variables : indexSeg et IndexPort
        indexSeg:=indexSegSuivant;

        // trouver le port de l'autre côté du segment
        port:=trouve_port_suivant(IndexSegSuivant,numport);
        trouve_IndexSegPort(Numsegment,port,rien,indexPort);
      end;
    end;
    inc(i);

  until not(trouve) or (nAig=NbreMaxiAigRencontres) or (i>50) or (adrAig=AdrAigRencontre);

  if debugBranche then
  begin
    if not(trouve) then AfficheDebug('Arrêt sur non trouvé suivant ou buttoir ou table',clYellow);
    if (adrAig=AdrAigRencontre) then AfficheDebug('Arret sur bouclage d''aiguillage',clyellow);
    if nAig=NbreMaxiAigRencontres then AfficheDebug('Arret sur aiguillage '+intToSTR(segment[indexSeg].adresse),clYellow);
    if i>50 then AfficheDebug('Arret sur itérations',clyellow);
  end;

  // vérifier si la branche créée est valide ---------------------------------
  // 1: vérifier si le dernier élément est un A ou buttoir
  ss:=dernier_champ(sbranche);
  if ss<>'' then
  begin
    if ss[1]<>'A' then
    begin
      val(ss,i,erreur);
      if i<>0 then
      begin
        if debugBranche then
        begin
          AfficheDebug('La branche '+sbranche,clOrange);
          AfficheDebug('est invalide car le dernier élément n''est ni un aiguillage ni un buttoir',clOrange);
        end;
        exit;  // branche invalide, elle n'est pas prise en compte
      end;
    end;
  end;

  // 2: vérifier si un des détecteurs de la branche existe déja dans les branches précédentes
  trouve:=false;
  if NbreBranches>0 then
  begin
    s:=sbranche;
    repeat
      if s[1]<>'A' then
      begin
        val(s,detecteur,erreur);
        if detecteur<>0 then
        begin
          // balayer les branches
          i:=1;
          repeat
            ss:=branche[i];
            repeat
              if ss[1]<>'A' then
              begin
                val(ss,det2,erreur);
                trouve:=det2=detecteur;
                //if trouve then Affiche('Trouvé detecteur '+IntToSTR(det2)+' en branche '+intToSTR(i),clred);
              end;
              j:=pos(',',ss);
              if j<>0 then delete(ss,1,j);
            until (j=0) or trouve;
            inc(i);
          until (i=NbreBranches+1) or trouve;
        end;
      end;
      k:=pos(',',s);
      if k<>0 then delete(s,1,k);
    until (k=0) or trouve;
  end;
  if trouve then
  begin
    if debugBranche then
    begin
      AfficheDebug('La branche '+sBranche,clorange);
      AfficheDebug('est inutile car un de ses détecteurs '+intToSTR(detecteur)+' existe dans la branche '+intToSTR(i-1),clOrange);
      exit;
    end;
  end;

  // ok
  inc(NbreBranches);
  branche[nbreBranches]:=sBranche;
  if debugBranche then AfficheDebug('Création branche '+sBranche,clwhite);
end;

// crée une branche contenant le détecteur detecteur
procedure cree_branche_det(detecteur : integer);
var i,NumSegment,rien,indexSeg,IndexPeriph,indexPort,IndexSegSuivant,portSuivant,IndexportSuivant,adresse : integer;
    ctype,s : string;
    trouve,fg : boolean;
    label essai_port;
begin
  indexPort:=0; // essayer sur port 0 du détecteur
  fg:=false;
  essai_port:
  if debugBranche then
  begin
    AfficheDebug('------------------',clyellow);
    AfficheDebug('Créée branche détecteur '+intToSTR(detecteur)+' sur port '+intToSTR(indexPort),clOrange);
  end;
  trouve:=trouve_IndexSegPortDetecteur(detecteur,indexSeg,indexPeriph);
  numSegment:=Segment[indexSeg].numero;
  if nivdebug=3 then AfficheDebug('Le segment porteur du détecteur est le '+intToSTR(numSegment)+' Periph '+intToSTR(Segment[indexSeg].periph[indexperiph].numero),clyellow);

  // parcourir les segments jusqu'au prochain aiguillage
  i:=0;
  repeat
    //if trouve then Affiche(intToSTR(numSegment)+' '+intToSTR(indexPeriph),clyellow);
    inc(i);
    trouve:=trouve_Seg_suivant(indexSeg,indexport,IndexSegSuivant,IndexportSuivant);
    if not(trouve) then
    begin
      s:='Erreur 678 : Pas trouvé d''aiguillage ou de buttoir après le segment / port '+intToSTR(numSegment)+'/'+intToSTR(Segment[indexSeg].port[indexPort].numero);
      AfficheDebug(s,clred);
      Affiche(s,clred);
      sBranche:='';
      exit;
    end;
    numSegment:=Segment[indexSegSuivant].numero;
    portSuivant:=Segment[indexSegSuivant].port[IndexPortSuivant].numero;
    if nivdebug=3 then AfficheDebug('Suivant= '+intToSTR(numSegment)+' indexport '+intToSTR(IndexportSuivant),clYellow);
    ctype:=segment[IndexSegSuivant].typ;
    if ctype='bumper_stop' then
    begin
      // repartir en sens inverse
      if indexPortSuivant=0 then indexPortSuivant:=1 else indexPortSuivant:=0;
      portSuivant:=Segment[indexSegSuivant].port[IndexPortSuivant].numero;
    end;
    // si on rencontre une table, çà revient dans l'autre sens

    trouve:=segment_aig(ctype);  // est-ce un aiguillage ???

    // prépare suivant
    if not(trouve) then
    begin
      IndexSeg:=IndexSegSuivant;
      port:=trouve_port_suivant(indexSegSuivant,portSuivant);
      trouve_IndexSegPort(Numsegment,port,rien,indexPort);
    end;
  until (i=50) or trouve;

  if not(trouve) then
  begin
    s:='68 : Pas trouvé d''aiguillage à proximité du détecteur '+intToSTR(detecteur);
    AfficheDebug(s,clred);
    Affiche(s,clred);  // et donc essayer sur le port 1 !!
    if fg then
    begin
      S:='Pas trouvé d''aguillage de chaque côté du détecteur '+intToSTR(detecteur);
      AfficheDebug(s,clred);
      Affiche(s,clred);
      exit;
    end;
    indexport:=1;
    fg:=true;
    goto essai_port;
  end;

  //partir de IndexSegSuivant, IndexPort
  adresse:=segment[IndexSegSuivant].adresse;
  sBranche:='A'+intToSTR(Adresse);
  //convertir le port en index
  IndexPort:=trouve_IndexPort_Segment(IndexSegSuivant,portSuivant);

  Cree_branche_aig(IndexSegSuivant,IndexPort,adresse,1);  // 1 aiguillage rencontré maxi
end;

// procédure principale de création des branches
procedure creee_branches;
var i,j,k,adresse,detecteur,indexSeg,det2,erreur : integer;
    trouve : boolean;
    c : char;
    s : string;
begin
  // l'origine d'une branche est la pointe d'un aiguillage connecté à un détecteur ----------
  NbreBranches:=0;

  Affiche('Création des branches',clWhite);
  if debugBranche then AfficheDebug('Etape 3.1 création des branches de pointe d''aiguillage à pointe d''aiguillage',clwhite);
  i:=1;
  repeat
    c:=aiguillage[i].APointeB;
    trouve:=(c<>'S') and (c<>'D') and (c<>'P') and (aiguillage[i].modele<>crois) and (aiguillage[i].modele<>tjd);
    // si la pointe de l'aiguillage est <> de S D P, c'est qu'il est connecté à un détecteur
    if trouve then
    begin
      adresse:=aiguillage[i].Adresse;
      detecteur:=aiguillage[i].APointe;
      if debugBranche then
      begin
        AfficheDebug('-------------------------',clyellow);
        AfficheDebug('Début de branche n°'+intToSTR(NbreBranches+1)+' : aiguillage '+intToSTR(adresse)+' Pointe='+intToSTR(detecteur),clyellow);
      end;

      trouve:=trouve_IdSegment_aig(adresse,indexSeg);
      if not(trouve) then afficheDebug('Erreur 417 : Aig '+intToSTR(adresse)+' non trouvé ',clred);
      //Affiche(IntToSTR(segment[indexSeg].numero),clYellow);

      if trouve then
      begin
        port:=segment[indexSeg].port[0].numero; // on commence par le port 0 (pointe) de l'aiguillage
        sBranche:='A'+intToSTR(adresse);
        cree_branche_aig(indexSeg,0,adresse,100);  // branche dans sBranche
        if nivdebug=3 then AfficheDebug(sbranche,clwhite);
      end;
    end;
    inc(i); // aiguillage suivant
    trouve:=false;
  until trouve or (i>MaxAiguillage);

  // puis créer les branches depuis les positions déviées ---------------------
  if debugBranche then AfficheDebug('Etape 3.2 création des branches de dévié d''aiguillage',clwhite);
  i:=1;
  repeat
    c:=aiguillage[i].AdevieB;
    trouve:=(c<>'S') and (c<>'D') and (c<>'P') and (aiguillage[i].modele<>crois) and (aiguillage[i].modele<>tjd);
    // si la déviée de l'aiguillage est <> de S D P, c'est qu'il est connecté à un détecteur
    if trouve then
    begin
      adresse:=aiguillage[i].Adresse;
      detecteur:=aiguillage[i].Adevie;
      if debugBranche then AfficheDebug('Début de branche n°'+intToSTR(NbreBranches+1)+' : aiguillage '+intToSTR(adresse)+' dévié='+intToSTR(detecteur),clyellow);

      trouve:=trouve_IdSegment_aig(adresse,indexSeg);
      if not(trouve) then afficheDebug('Erreur 418 : Aig '+intToSTR(adresse)+' non trouvé ',clred);
      //Affiche(IntToSTR(segment[indexSeg].numero),clYellow);

      if trouve then
      begin
        port:=segment[indexSeg].port[2].numero; // on commence par le port 2 cdm (pointe) de l'aiguillage
        sBranche:='A'+intToSTR(adresse);
        cree_branche_aig(indexSeg,2,adresse,100);   // port 2
        if nivdebug=3 then AfficheDebug(sbranche,clwhite);
      end;
    end;
    inc(i); // aiguillage suivant
    trouve:=false;
  until trouve or (i>MaxAiguillage);

  if debugBranche then AfficheDebug('Etape 3.3 Liste de détecteurs absents des branches pour constituer les branches manquantes',clwhite);
  // regarder la liste des détecteurs de CDM qui sont absents des branches--------------------
  for i:=1 to Ndet_cdm do
  begin
    detecteur:=det_CDM[i];
    trouve:=false;
    for j:=1 to NbreBranches do
    begin
      s:=branche[j];
      repeat
        if s[1]<>'A' then
        begin
          val(s,det2,erreur);
          trouve:=trouve or (det2=detecteur);
        end;
        k:=pos(',',s);
        if k<>0 then delete(s,1,k);
      until (k=0) or trouve;
    end;
    if not(trouve) then
    begin
      if debugBranche then AfficheDebug('le détecteur '+intToSTR(detecteur)+' est absent des branches ',clOrange);
      cree_branche_det(detecteur);
      //if debugBranche then AfficheDebug(sbranche,clWhite);
    end;
  end;

  // recopier le tampon des branches dans le richedit de l'onglet branches de la config
  with formconfig do
  begin
    RichBranche.clear;
    clicListe:=true;
    for i:=1 to NbreBranches do
    begin
      s:=Branche[i];
      RichBranche.Lines.Add(s);
      RE_ColorLine(RichBranche,RichBranche.lines.count-1,ClAqua);
    end;
    With RichBranche do
    begin
      SelStart:=0;
      Perform(EM_SCROLLCARET,0,0);
    end;
  end;
  clicListe:=false;
end;

procedure sauve_ficher_cdm;
var
    i,j,np,npe,ni : integer;
    s : string;
    f : text;
begin
  i:=pos(' ',NomModuleCDM);
  if i<>0 then NomModuleCDM:=copy(NomModuleCDM,i+1,length(NomModuleCDM)-i);

  try
    assign(f,NomModuleCDM);
    rewrite(f);
  except
    Affiche('Impossible de créer le fichier des segments CDM : '+NomModuleCDM,clred);
    exit;
  end;

  Writeln(f,NomModuleCDM);

  writeln(f,'');

  for i:=0 to nseg-1 do
  begin
    np:=segment[i].nport;
    npe:=segment[i].nperiph;
    ni:=segment[i].ninter;
    s:='Segment='+intToSTR(segment[i].numero)+' '+segment[i].typ;
    writeln(f,s);
    s:='Nport='+IntToSTR(segment[i].nport)+' Nperiph='+IntToSTR(segment[i].nperiph)+' Ninter='+IntToSTR(segment[i].ninter);
    writeln(f,s);
    s:='Xmin='+intToSTR(segment[i].XMin)+' Ymin='+intToSTR(segment[i].YMin)+' Xmax='+intToSTR(segment[i].XMax)+' Ymax='+intToSTR(segment[i].Ymax);
    writeln(f,s);
    s:='StartAngle='+intToSTR(segment[i].StartAngle)+' ArcAngle='+intToSTR(segment[i].ArcAngle)+' Rayon='+intToSTR(segment[i].Rayon)+' Radius0='+intToSTR(segment[i].radius0);
    writeln(f,s);
    s:='Angle0='+intToSTR(segment[i].angle0)+' Angle='+intToSTR(segment[i].angle)+' Lengthdev='+intToSTR(segment[i].lengthdev)+' Deltadev0='+intToSTR(segment[i].deltadev0);
    writeln(f,s);
    s:='lXc='+intToSTR(segment[i].lXc)+' lYc='+intToSTR(segment[i].lYc)+' Longueur='+intToSTR(segment[i].longueur)+' longueurDev='+intToSTR(segment[i].longueurDev);
    writeln(f,s);
    s:='DeltaDev='+intToSTR(segment[i].DeltaDev)+' CurveOffset='+intToSTR(segment[i].CurveOffset)+' xc0='+intToSTR(segment[i].xc0)+' yc0='+intToSTR(segment[i].yc0);
    writeln(f,s);
    s:='DeltaDev2='+intToSTR(segment[i].DeltaDev2)+' xc='+intToSTR(segment[i].xc)+' yc='+intToSTR(segment[i].yc);
    writeln(f,s);
    s:='Adresse='+intToSTR(segment[i].adresse)+' Adresse2='+intToSTR(segment[i].adresse2)+' Duree='+intToSTR(segment[i].duree);
    writeln(f,s);

    // ports
    for j:=0 to np-1 do
    begin
      s:='  Port='+intToSTR(segment[i].port[j].numero)+' '+segment[i].port[j].typ+
         ' x='+intToStr(segment[i].port[j].x)+
         ' y='+intToStr(segment[i].port[j].y)+
         ' z='+intToStr(segment[i].port[j].z);
      writeln(f,s);
      s:='  Angle='+intToSTr(segment[i].port[j].angle)+' Local='+intToSTr(segment[i].port[j].local)+' Connecte=';
         if segment[i].port[j].connecte then s:=s+'1' else s:=s+'0';
      writeln(f,s);
      s:='  ConnecteAuPort='+intToSTR(segment[i].port[j].ConnecteAuPort)+' ConnecteAuSegment='+intToSTR(segment[i].port[j].ConnecteAuSeg);
      writeln(f,s);
    end;

    // périphériques
    for j:=0 to npe-1 do
    begin
      s:='  Periph='+intToSTR(segment[i].periph[j].numero)+' Type='+segment[i].periph[j].typ+
         ' Pere='+intToSTR(segment[i].periph[j].pere)+
         ' x='+intToSTR(segment[i].periph[j].x)+
         ' y='+intToSTR(segment[i].periph[j].y)+
         ' z='+intToSTR(segment[i].periph[j].z);
      writeln(f,s);
      s:='  Angle='+intToSTR(segment[i].periph[j].angle)+'  Bright='+intToSTR(segment[i].periph[j].bright)+'  Bdown='+intToSTR(segment[i].periph[j].bdown);
      writeln(f,s);
      s:='  Location='+intToSTR(segment[i].periph[j].location)+'  Adresse='+intToSTR(segment[i].periph[j].adresse)+'  Status='+intToSTR(segment[i].periph[j].Status);
      writeln(f,s);

    end;

    // inter
    for j:=0 to ni-1 do
    begin
      s:='  x='+intToSTR(segment[i].inter[j].x)+' y='+intToSTR(segment[i].inter[j].y)+' z='+intToSTR(segment[i].inter[j].z);
      writeln(f,s);
      s:='  MirrorZ='+intToSTR(segment[i].inter[j].MirrorZ)+' MirrorParent='+intToSTR(segment[i].inter[j].MirrorParent);
      writeln(f,s);
    end;
    writeln(f,'');
  end;
  closefile(f);
  Affiche('Le fichier de segments CDM : '+NomModuleCDM+' a été créé',clYellow);
  formprinc.Affiche_fenetre_CDM.enabled:=true;
  confasauver:=true;
end;

procedure lit_fichier_segments_cdm;
var
    i,j,k,np,npe,ni : integer;
    s : string;
    f : text;
    fini : boolean;

    function isole(ss : string) : integer;
    var k,erreur : integer;
    begin
      k:=pos(ss,s);
      result:=-1;
      if k<>0 then
      begin
        delete(s,k,length(ss));
        val(s,k,erreur);
        if s[1]='-' then k:=-k;
        delete(s,1,erreur);
        result:=k;
      end;
    end;

    function lire_fichier : string;
    begin
      s:='';
      while not(eof(f)) and not(s<>'') do
      begin
        readln(f,s);
        //Affiche(s,clyellow);
        s:=AnsiLowerCase(s);
      end;
      result:=s;
      fini:=eof(f);
    end;

begin
  xminiCDM:=900000;
  yminiCDM:=900000;
  xmaxiCDM:=-900000;
  ymaxiCDM:=-900000;

  try
    assign(f,NomModuleCDM);
    reset(f);
  except
    Affiche('Impossible d''ouvrir le fichier de segments CDM : '+NomModuleCDM,clred);
    exit;
  end;

  //TformAnalyseCDM.Create(nil);

  i:=0;
  s:=lire_fichier;
  NomModuleCDM:=s;

  while not(eof(f)) do
  begin
    s:=lire_fichier;
    if fini then break;

    setlength(segment,i+1);

    segment[i].numero:=isole('segment=');
    segment[i].typ:=s;

    s:=lire_fichier;
    if fini then break;
    np:=isole('nport=');
    npe:=isole('nperiph=');
    ni:=isole('ninter=');

    segment[i].nport:=np;
    segment[i].nperiph:=npe;
    segment[i].ninter:=ninter;

    s:=lire_fichier;
    if fini then break;
    segment[i].XMin:=isole('xmin=');
    segment[i].YMin:=isole('ymin=');
    segment[i].XMax:=isole('xmax=');
    segment[i].YMax:=isole('ymax=');

    if segment[i].XMin<xminiCDM then xminiCDM:=segment[i].xMin;
    if segment[i].YMin<yminiCDM then yminiCDM:=segment[i].yMin;
    if segment[i].XMax>xmaxiCDM then xmaxiCDM:=segment[i].xMax;
    if segment[i].YMax>ymaxiCDM then ymaxiCDM:=segment[i].yMax;

    s:=lire_fichier;
    if fini then break;
    segment[i].startangle:=isole('startangle=');
    segment[i].arcangle:=isole('arcangle=');
    segment[i].rayon:=isole('rayon=');
    segment[i].radius0:=isole('radius0=');

    s:=lire_fichier;
    if fini then break;
    segment[i].Angle0:=isole('angle0=');
    segment[i].angle:=isole('angle=');
    segment[i].LengthDev:=isole('lengthdev=');
    segment[i].deltaDev0:=isole('deltadev0=');

    s:=lire_fichier;
    if fini then break;
    segment[i].lxc:=isole('lxc=');
    segment[i].lyc:=isole('lyc=');
    segment[i].longueur:=isole('longueur=');
    segment[i].longueurdev:=isole('longueurdev=');

    s:=lire_fichier;
    if fini then break;
    segment[i].deltadev:=isole('deltadev=');
    segment[i].CurveOffset:=isole('CurveOffset=');
    segment[i].xc0:=isole('xc0=');
    segment[i].yc0:=isole('xc0=');

    s:=lire_fichier;
    if fini then break;
    segment[i].deltadev2:=isole('deltadev2=');
    segment[i].xc:=isole('xc=');
    segment[i].yc:=isole('xc=');

    s:=lire_fichier;
    if fini then break;
    segment[i].Adresse:=isole('adresse=');
    segment[i].Adresse2:=isole('adresse2=');
    segment[i].duree:=isole('duree=');

    // port
    if np<>0 then
    begin
      setlength(segment[i].port,np);
      for j:=0 to np-1 do
      begin
        s:=lire_fichier;
        if fini then break;
        segment[i].Port[j].numero:=isole('port=');
        k:=pos(' ',s);
        segment[i].port[j].typ:=copy(s,1,k-1);
        delete(s,1,k);
        segment[i].port[j].x:=isole('x=');
        segment[i].port[j].y:=isole('y=');
        segment[i].port[j].z:=isole('z=');

        s:=lire_fichier;
        if fini then break;
        segment[i].Port[j].angle:=isole('angle=');
        segment[i].port[j].local:=isole('local=');
        segment[i].port[j].connecte:=isole('connecte=')=1;

        s:=lire_fichier;
        if fini then break;
        segment[i].port[j].ConnecteAuPort:=isole('connecteauport=');
        segment[i].port[j].ConnecteAuSeg:=isole('connecteausegment=');
      end;
    end;

    // periphériques
    if npe<>0 then
    begin
      setlength(segment[i].periph,npe);
      for j:=0 to npe-1 do
      begin
        s:=lire_fichier;
        if fini then break;
        segment[i].periph[j].numero:=isole('periph=');
        k:=isole('type');
        k:=pos(' ',s);
        segment[i].periph[j].typ:=copy(s,1,k-1);
        delete(s,1,k);
        segment[i].periph[j].pere:=isole('pere=');
        segment[i].periph[j].x:=isole('x=');
        segment[i].periph[j].y:=isole('y=');
        segment[i].periph[j].z:=isole('z=');
        s:=lire_fichier;
        if fini then break;
        segment[i].periph[j].angle:=isole('angle=');
        segment[i].periph[j].bright:=isole('bright=');
        segment[i].periph[j].bdown:=isole('bdown=');
        s:=lire_fichier;
        segment[i].periph[j].location:=isole('location=');
        segment[i].periph[j].adresse:=isole('adresse=');
        segment[i].periph[j].status:=isole('status=');
      end;
    end;

    if ni<>0 then
    begin
      setlength(segment[i].inter,ni);
      for j:=0 to ni-1 do
      begin
        s:=lire_fichier;
        if fini then break;
        segment[i].inter[j].x:=isole('x=');
        segment[i].inter[j].y:=isole('y=');
        segment[i].inter[j].z:=isole('z=');
        s:=lire_fichier;
        if fini then break;
        segment[i].inter[j].mirrorz:=isole('mirrorz=');
        segment[i].inter[j].mirrorparent:=isole('mirrorparent=');
      end;
    end;
    inc(i);
  end;

  closefile(f);
  nseg:=i;
  formprinc.ButtonAffAnalyseCDM.Visible:=true;
  formprinc.Affiche_fenetre_CDM.enabled:=true;
end;


// importe la base de données CDM dans la base de données Signaux complexes
// et crée les branches
procedure Importation;
var i : integer;
begin
  if MaxAiguillage<>0 then
  begin
    if MessageDlg('Une configuration de réseau existe dans signaux complexes.'+#10+#13+
                  'Si vous importez le réseau CDM, la configuration des aiguillages et des branches '+#10+#13+
                  'de Signaux_complexes sera écrasée.'+#10+#13+
                  'Voulez vous continuer l''importation? (aiguillages & branches)',mtConfirmation,[mbyes,mbNo],0)=mrNo then
      begin
        Affiche('Importation annulée',clOrange);
        exit;
      end;
  end;

  MaxAiguillage:=0;

  Affiche('Importation des aiguillages et des branches',clWhite);

  // recopier les aiguillages
  for i:=1 to NAig_CDM do
  begin
    Aiguillage[i].adresse:=Aig_CDM[i].adresse;
    Aiguillage[i].adrtriple:=Aig_CDM[i].adrtriple;
    Aiguillage[i].modele:=Aig_Cdm[i].modele;
    Aiguillage[i].temps:=Aig_cdm[i].temps;
    Aiguillage[i].ADroit:=Aig_Cdm[i].ADroit;
    Aiguillage[i].ADroitB:=Aig_Cdm[i].ADroitB;
    Aiguillage[i].ADevie:=Aig_Cdm[i].ADevie;
    Aiguillage[i].ADevieB:=Aig_Cdm[i].ADevieB;
    Aiguillage[i].APointe:=Aig_Cdm[i].Apointe;
    Aiguillage[i].APointeB:=Aig_Cdm[i].ApointeB;
    Aiguillage[i].DDroit:=Aig_Cdm[i].DDroit;
    Aiguillage[i].DDroitB:=Aig_Cdm[i].DDroitB;
    Aiguillage[i].DDevie:=Aig_CDM[i].DDevie;
    Aiguillage[i].DDevieB:=Aig_CDM[i].DDevieB;
    Aiguillage[i].EtatTJD:=Aig_CDM[i].EtatTJD;

    Aiguillage[i].posInit:=9;
    aiguillage[i].InversionCDM:=0;
    aiguillage[i].vitesse:=0;
  end;
  MaxAiguillage:=NAig_CDM;
  trier_aig;

  // créer les branches
  creee_branches;

  Affiche('Validation des branches',ClLime);
  valide_branches;
  for i:=1 to NbreBranches do
    compile_branche(Branche[i],i);

  Affiche('Importation terminée',clWhite);
  Affiche('Vérification de la cohérence :',clWhite);
  if verif_coherence then Affiche('Configuration cohérente',clLime);
end;

// compile le fichier Texte de CDM et l'importe
procedure Compilation;
var s : string;
    nombre,position : integer;
    resultat : integer;
begin
  s:=lowercase(Formprinc.fenRich.Lines[0]);
  if pos('module',s)=0 then
  begin
    Affiche('Pas de module détecté',clred);
    exit;
  end;

  formImportation.showmodal;
  if not(faireImport) then exit;

  ndet_cdm:=0;
  //debugAnalyse:=true;
  //debugBranche:=true;
  Lignes:=Formprinc.FenRich.Lines;
  nligne:=0; nSeg:=0;
  DernAdrAig:=0;
  xminiCDM:=0;yMiniCDM:=0;xmaxiCDM:=0;yMaxiCDM:=0;
  nombre:=Formprinc.FenRich.Lines.Count;
  NomModuleCDM:=AnsiLowerCase(Lignes[0]+'.cdm');
  formAnalyseCDM.Caption:='Squelette du réseau '+NomModuleCDM;
  formAnalyseCDM.Show;

  Affiche('Compilation en cours',clWhite);
  if DebugBranche then AfficheDebug('Compilation des segments, ports, inter et périphériques de CDM rail',ClWhite);
  repeat
    s:=supprime_espaces(lignes[nligne]);
    position:=pos('segment #',s) ; if position=1 then
    begin
      //affiche(s,clred);
      compile_segment;
    end;
    position:=pos('port #',s) ; if position=1 then
    begin
      //affiche(s,clred);
      compile_port;
    end;
    position:=pos('inter:',s) ; if position=1 then
    begin
      //affiche(s,clred);
      compile_inter;
    end;
    position:=pos('periph #',s) ; if position=1 then
    begin
      //affiche(s,clred);
      compile_periph;
    end;
    inc(nligne);
  until (nligne>nombre); // or (nligne=1311) ;
  //Affiche('fin de la compilation',cllime);

  Affichage(false);
  Affiche('nombre de détecteurs: '+intToSTR(NDet_cdm),clyellow);

  formAnalyseCDM.Show;
  formprinc.ButtonAffAnalyseCDM.Visible:=true;
  Affiche('Compilation terminée. Nombre de segments='+intToSTR(nSeg),clWhite);

  remplit_Aig_cdm;
  Affiche('nombre de d''aiguillages: '+intToSTR(Naig_cdm),clyellow);

  // sauvegarde
  sauve_ficher_cdm;

  Importation;
end;


procedure TFormAnalyseCDM.FormResize(Sender: TObject);
begin
  affichage(false);
end;

procedure TFormAnalyseCDM.CheckSegmentsClick(Sender: TObject);
begin
  affichage(false);
end;

procedure TFormAnalyseCDM.CheckConnexionsClick(Sender: TObject);
begin
  Affichage(false);
end;

procedure TFormAnalyseCDM.CheckAdressesClick(Sender: TObject);
begin
  Affichage(false);
end;

procedure TFormAnalyseCDM.TrackBar1Change(Sender: TObject);
begin
  Affichage(false);
end;

procedure TFormAnalyseCDM.ButtonAffPortClick(Sender: TObject);
var i,j,numport,erreur : integer;
begin
  val(editPort.text,numport,erreur);
  trouve_IndexPort(numport,i,j);
  if i<>-1 then
  begin
    Affiche_port(i,j);
    exit;
  end;
  if Index_Segment(numport,i) then
  begin
    Affiche_segment(i);
  end;
end;

procedure TFormAnalyseCDM.FormCreate(Sender: TObject);
begin
  if debug=1 then Affiche('Création fenêtre CDM',clLime);
  IndexClic:=0;
  checkPorts.Checked:=false;
  CheckAdresses.checked:=true;
  LabelPorts.Width:=120;
  LabelPorts.Height:=23;

  ImageCDM.Top:=0;
  ImageCDM.Left:=0;
  formAnalyseCDM.Caption:=NomModuleCDM;

  largeur_voie:=4;

  ImageLoco.Width:=49;
  ImageLoco.Height:=15;

  ImageLoco.Transparent:=true;
  FWICImage:=tbitmap.Create;
  FWICImage.Assign(ImageLoco.Picture.graphic);
  FWICImage.TransparentColor:=clwhite;

  premaff:=true;
  buttonAnime.Visible:=not(diffusion);

  with FwicImage do
  begin
    largeurTrain:=Width;   // largeur de l'icone du train
    hauteurTrain:=Height;
  end;
  ArcTanHautLargTrain:=ArcTan(HauteurTrain/LargeurTrain);
  if debug=1 then Affiche('Fin création fenetre CDM',clLime);
end;



procedure TFormAnalyseCDM.CheckPortsClick(Sender: TObject);
begin
  Affichage(false);
end;

procedure clic_image;
var pt : Tpoint;
   xSouris,ySouris,x1,y1,x2,y2,i,centreX,centrey,rayon,numero: integer;
   StartAngle,StopAngle : double;
   trouve : boolean;
   debug : boolean;
   ctype,s : string;
   canvas : Tcanvas;
begin
  clic:=true;
  pt:= formAnalyseCDM.ImageCDM.ScreenToClient(Mouse.CursorPos);  // coordonnées par rapport à l'image
  xSouris:=pt.x;
  ySouris:=pt.y;

  canvas:=FormAnalyseCDM.ImageCDM.Canvas;

  //index_segment(6713,i);
  i:=0;
  repeat
    numero:=segment[i].numero;
    debug:=false;
    // debug:=(numero=6989) or (numero=6980);
    if debug then Affiche('Segment'+inttoSTR(segment[i].numero),clYellow);
    //Affiche(intToSTR(x1)+' '+intToSTR(y1)+' / '+intToSTR(x2)+' '+intToSTR(y2),clYellow);

    ctype:=Segment[i].typ;

    if segment_aig(ctype) and (ctype<>'dbl_slip_switch') then
    begin
      x1:=segment[i].port[0].x;
      y1:=segment[i].port[0].y;
      x2:=segment[i].port[1].x;
      y2:=segment[i].port[1].y;
      coords(x1,y1);
      coords(x2,y2);
      trouve:=point_Sur_Segment(Xsouris,Ysouris,x1,y1,x2,y2);
      if trouve then
      begin
        Canvas.Pen.Width:=largeur_voie;
        Canvas.pen.Color:=clred;
        canvas.MoveTo(x1,y1);
        canvas.LineTo(x2,y2);

        x1:=(x1+x2) div 2;
        y1:=(y1+y2) div 2;
        x2:=segment[i].port[2].x;
        y2:=segment[i].port[2].y;
        coords(x2,y2);
        canvas.MoveTo(x1,y1);
        canvas.LineTo(x2,y2);

        if ctype='turnout_3way' then
        begin
          canvas.moveTo(x1,y1);
          x2:=segment[i].port[3].x;
          y2:=segment[i].port[3].y;
          coords(x2,y2);
          canvas.LineTo(x2,y2);
        end;

        xAig:=x1;yAig:=y1-5;

        s:=intToSTR(Segment[i].adresse);
        if Segment[i].adresse2<>0 then s:=s+'/'+intToSTR(Segment[i].adresse2);
        formAnalyseCDM.EditAdresse.text:=s;

        s:='Ports 0/1/2 = '+IntToSTR(Segment[i].port[0].numero)+'/'+IntToSTR(Segment[i].port[1].numero)+'/'+
                          IntToSTR(Segment[i].port[2].numero);
        formAnalyseCDM.LabelPorts.Caption:=s;

      end;
    end;

    if (ctype='crossing') or (ctype='dbl_slip_switch') then
    begin
      x1:=segment[i].port[0].x;
      y1:=segment[i].port[0].y;
      x2:=segment[i].port[2].x;
      y2:=segment[i].port[2].y;
      coords(x1,y1);
      coords(x2,y2);
      trouve:=point_Sur_Segment(Xsouris,Ysouris,x1,y1,x2,y2);
      if trouve then
      begin

        s:=intToSTR(Segment[i].adresse);
        if Segment[i].adresse2<>0 then s:=s+'/'+intToSTR(Segment[i].adresse2);
        formAnalyseCDM.EditAdresse.Text:=s;
        s:='Ports 0/1/2/3 = '+IntToSTR(Segment[i].port[0].numero)+'/'+IntToSTR(Segment[i].port[1].numero)+'/'+
                              IntToSTR(Segment[i].port[2].numero)+'/'+IntToSTR(Segment[i].port[3].numero);
        formAnalyseCDM.LabelPorts.Caption:=s;

        Canvas.Pen.Width:=largeur_voie;
        Canvas.pen.Color:=clred;

        x1:=segment[i].port[1].x;
        y1:=segment[i].port[1].y;
        x2:=segment[i].port[3].x;
        y2:=segment[i].port[3].y;
        coords(x1,y1);
        coords(x2,y2);
        canvas.MoveTo(x1,y1);
        canvas.LineTo(x2,y2);

        x1:=segment[i].port[0].x;
        y1:=segment[i].port[0].y;
        x2:=segment[i].port[2].x;
        y2:=segment[i].port[2].y;
        coords(x1,y1);
        coords(x2,y2);
        canvas.MoveTo(x1,y1);
        canvas.LineTo(x2,y2);

        xAig:=x1;yAig:=y1-5;
      end;
    end;

    // le précurve est un type droit!!
    if (ctype='straight') or (ctype='pre_curve') or (ctype='bumper_stop') then
    begin
      x1:=segment[i].port[0].x;
      y1:=segment[i].port[0].y;
      x2:=segment[i].port[1].x;
      y2:=segment[i].port[1].y;
      coords(x1,y1);
      coords(x2,y2);
      trouve:=point_Sur_Segment(Xsouris,Ysouris,x1,y1,x2,y2);
      if trouve then
      begin
        formAnalyseCDM.EditAdresse.text:='';
        s:='Ports 0/1 = '+InttoSTR(Segment[i].port[0].numero)+'/'+IntToSTR(Segment[i].port[1].numero);
        formAnalyseCDM.LabelPorts.Caption:=s;

        Canvas.Pen.Width:=largeur_voie;
        Canvas.pen.Color:=clred;
        canvas.MoveTo(x1,y1);
        canvas.LineTo(x2,y2);
      end;
    end;

    if (ctype='curve')  or (ctype='arc') then
    begin
      StartAngle:=segment[i].StartAngle/100;
      StopAngle:=segment[i].ArcAngle/100;
      centreX:=segment[i].lXc;
      CentreY:=segment[i].lyc;
      coords(centreX,centreY);

      rayon:=round(Segment[i].Rayon*reducX) div 1000;

      //Affiche('Segment index '+intToSTR(i)+' Numéro='+intToSTR(numero),clOrange);
      if stopAngle<0 then
        canvas.Pen.color:=clred
         else canvas.Pen.color:=clOrange;

      trouve:=point_sur_arc(xSouris,ySouris,CentreX,centreY,rayon,StartAngle,StopAngle,debug) ;
      if trouve then
       begin
         FormAnalyseCDM.EditAdresse.text:='';
         s:='Ports 0/1 = '+IntToSTR(Segment[i].port[0].numero)+'/'+IntToSTR(Segment[i].port[1].numero);
         formAnalyseCDM.LabelPorts.Caption:=s;

         if not(debug) then
         begin
           Canvas.Pen.Width:=largeur_voie;
           Canvas.pen.Color:=clred;
           D_arc(formAnalyseCDM.ImageCDM.Canvas,centreX,centreY,rayon,StartAngle,StopAngle);
         end;
       end;
     end;
    {
    with ImageCDM.canvas do
    begin
      pen.width:=1;
      pen.color:=clred;
      moveTo(x1,y1);LineTo(x2,y2);
      //ellipse(x1-20,y1-20,x2+20,y2+20);
    end;
    }

    if not(trouve) then inc(i);
  until (i>=nSeg) or trouve;

  if trouve then
  begin
    with FormAnalyseCDM do
    begin
      GroupBoxSegment.Caption:='Segment : '+ctype;
      EditSegment.Text:=intToSTR(numero);
      s:='Segment '+IntToSTR(Segment[i].numero)+' '+ctype;
      x1:=Segment[i].adresse;
      if x1<>0 then
      begin
        s:=s+#13+'Adr='+intToSTR(x1);
        if Segment[i].adresse2<>0 then s:=s+'/'+intToSTR(Segment[i].adresse2);
      end;
      Hint:=s;
      showHint:=true;
    end;
    IndexClic:=i;
  end
    else FormAnalyseCDM.hint:='';

  clic:=false;
end;

procedure TFormAnalyseCDM.EditAdresseChange(Sender: TObject);
var adresse,adresse2,erreur,ofs : integer;
    canvas : Tcanvas;
    ctyp,s : string;
    i : integer;
begin
  if clic then exit;
  s:=editAdresse.Text;
  i:=pos('/',s);
  adresse2:=0;
  if i=0 then val(s,adresse,erreur) else
  begin
    val(s,adresse,erreur);
    delete(s,1,erreur);
    val(s,adresse2,erreur);
    erreur:=0;
  end;

  if erreur=0 then
  begin
    ofs:=0;
    segment[IndexClic].adresse:=adresse;
    if adresse2<>0 then segment[IndexClic].adresse2:=adresse2;
    if (ctyp='crossing') then ofs:=YcrOffset;
    ctyp:=segment[IndexClic].typ;
    if not(segment_aig(ctyp)) and not(ctyp='crossing') then exit;  // si c'est pas un aiguillage ni un croisement
    if (ctyp='crossing') or (ctyp='dbl_slip_switch') then ofs:=YcrOffset;
    if (ctyp='turnout') or (ctyp='turnout_sym') then ofs:=yTurnoutOffset;
    if (ctyp='turnout_curved') or (ctyp='turnout_curved_2r') then ofs:=YcrOffset;

    canvas:=ImageCDM.Canvas;
    with canvas do
    begin
      Pen.Color:=clLime;
      Brush.Style:=bsSolid;
      brush.Color:=fond_cdm;
    end;
    coords_aff_aig(canvas,indexClic);
    canvas.Brush.Style:=bsClear;
  end;
end;

procedure TFormAnalyseCDM.ImageCDMClick(Sender: TObject);
begin
  clic_image;
end;

procedure TFormAnalyseCDM.FormMouseWheel(Sender: TObject;Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;var Handled: Boolean);
var i : integer;
begin
  i:=TrackBar1.Position;

  if WheelDelta>0 then
  begin
    if (i<=Zmini) then
    begin
      TrackBar1.Position:=Zmini;
      exit;
    end;
    dec(i);
  end
  else
  begin
    if (i>=ZMaxi) then
    begin
      TrackBar1.Position:=Zmaxi;
      exit;
    end;
    inc(i);
  end;

  TrackBar1.Position:=i;
  Affichage(false);

  // positionner la trackbar zoom

  {FormTCO.TrackBarZoom.Position:=i;
  calcul_cellules;
  Affiche_TCO;
  SelectionAffichee:=false;}
end;

// trouve les index du segment qui contiennent le détecteur Adresse
// renvoie dans index les index, et dans periph les numéros de périphériques dans lesquels ils se trouvent
function index_segment_det(Adresse : integer;var TabloDetSeg : TdetSeg; nombre : integer) : boolean;
var i,n,ip,itablo : integer;
begin
  //trouver les deux segments du détecteurs
  if adresse=0 then
  begin
    nombre:=0;
    result:=false;
    exit;
  end;
  for i:=1 to 10 do
  begin
    TabloDetSeg[i].index:=-1;
    TabloDetSeg[i].periph:=-1;
  end;

  i:=0;
  itablo:=0;
  repeat
    n:=segment[i].nperiph;
    if n<>0 then
    begin
      for ip:=0 to n-1 do
      begin
        if segment[i].periph[ip].typ='detector' then
        begin
          if segment[i].periph[ip].adresse=adresse then
          begin
            inc(itablo);
            if itablo>10 then
            begin
              AfficheDebug('Erreur 857 : Nbre périphériques>10 Segment '+intToSTR(segment[i].numero),clred);
              exit;
            end;
            TabloDetSeg[itablo].index:=i;
            TabloDetSeg[itablo].periph:=ip;
          end;
        end;
      end;
    end;
    inc(i);
  until (i>nseg-1);
  nombre:=itablo;
  result:=itablo>0;
end;



// allume la zone du détecteur "adresse"
procedure dessine_det(adresse : integer);
var p,centreX,CentreY,rayon,i,index,x,y,x1,y1,x2,y2,x3,y3,x4,y4,np,NindexR,NumPort,IndexportSuiv,NumSeg,indexport,
    xs,ys,nombre,ind1,ind2,per1,per2,IndexSegBumper,PortBumper,port : integer;
    StartAngle,stopangle,startDegres,StopDegres : double;
    trouve,ts,tn,tp : boolean;
    ctyp,s : string;
    canvas : Tcanvas;
    circuit_det : array[1..20] of record
                     index : integer;  // index des segments du circuit des détecteurs
                     port  : integer;  // pour les premiers et derniers index, index du périphérique, sinon du port
                     end;
    tabloDetSeg : TdetSeg;
begin
  if adresse=0 then exit;
  canvas:=FormAnalyseCDM.ImageCDM.canvas;
  Canvas.pen.color:=clred;
  canvas.Pen.width:=largeur_voie;

  // trouve la liste des détecteurs, résultat dans tabloDetSeg, nombre
  index_segment_det(adresse,tabloDetSeg,nombre);
  circuit_det[1].index:=tabloDetSeg[1].index;

   ind1:=tabloDetSeg[1].index;
   ind2:=tabloDetSeg[2].index;
   per1:=tabloDetSeg[1].periph;
   per2:=tabloDetSeg[2].periph;

  //Affiche('Trouvé détecteur sur le segment '+inttoSTR(segment[i1].numero),clYellow);

  // cas ou il y a plus d'un détecteur sur le même segment
  // pour l'instant on ne traite que 2 détecteurs (identiques) par segment maxi
  if ind1=ind2 then
  begin
    circuit_det[1].port:=tabloDetSeg[1].periph; //index du périph1
    circuit_det[1].index:=tabloDetSeg[1].index;
    circuit_det[2].port:=tabloDetSeg[2].periph; //index du périph2
    circuit_det[2].index:=tabloDetSeg[2].index;
    ctyp:=segment[ind1].typ;
    if (ctyp='straight') or (ctyp='pre_curve') or (ctyp='bumper_stop')  then
    begin
      x:=segment[ind1].periph[per1].x;
      y:=segment[ind1].periph[per1].y;
      coords(x,y);
      canvas.moveto(x,y);

      x:=segment[ind1].periph[per2].x;
      y:=segment[ind1].periph[per2].y;
      coords(x,y);
      Canvas.LineTo(x,y);
    end;

    if (ctyp='curve') or (ctyp='arc') then
    begin
      rayon:=segment[ind1].Rayon;
      StartAngle:=segment[ind1].StartAngle/100;
      StopAngle:=segment[ind1].ArcAngle/100;
      centreX:=segment[ind1].lxc;
      CentreY:=segment[ind1].lyc;
      Canvas.pen.color:=clred;
      x1:=segment[ind1].periph[per1].x;
      y1:=segment[ind1].periph[per1].y;
      x2:=segment[ind1].periph[per2].x;
      y2:=segment[ind1].periph[per2].y;
      canvas.pen.Color:=clred;
      arc_xy(centreX,centreY,rayon,x1,y1,x2,y2);

      coords(centreX,centreY);
      {coords(x2,y2);
      canvas.MoveTo(centreY,centreY);
      canvas.LineTo(x2,y2);}
    end;

  end

  else
  begin
    // aller dans un sens pour tenter de trouver le détecteur homologue
    port:=0;
    trouve:=false;
    IndexSegBumper:=-1;
    repeat
      i:=1;
      index:=ind1;
      //Affiche('Sens port '+intToSTR(port),clred);
      //Affiche(IntToSTR(segment[index].numero),clred);
      indexport:=port;
      circuit_det[i].port:=port; //index du port
      circuit_det[i].index:=ind1; //index du segment
      i:=2;

      repeat
        ts:=trouve_seg_suivant(Index,indexport,Suivant,IndexportSuiv);  // si ts=faux, possible sur un buttoir car pas de suivant
        index:=Suivant;
        indexport:=IndexPortSuiv;
        numseg:=segment[index].numero;
        ctyp:=segment[index].typ;
        if (ctyp='bumper_stop') or (ctyp='turntable') then
        begin
          IndexSegBumper:=index;
          PortBumper:=indexport;
        end;
        if ts then
        begin
          //Affiche(intToSTR(numseg),clred);
          circuit_det[i].port:=indexport; //index du port
          circuit_det[i].index:=index;
          indexport:=1-indexport;  // inverser le port
          tn:=indexport>=0;    // si pas tn c'est que c'est un segment à plus de 3 ports
          np:=segment[index].nperiph;
          if np<>0 then
          begin
            p:=0;
            repeat
              if segment[index].periph[p].typ='detector' then trouve:=segment[index].periph[p].adresse=adresse;
              inc(p);
            until (p>np-1) or trouve;
          end;
          inc(i);
        end;
      until trouve or (i>10) or not(tn) or not(ts);  // boucle de segment
      if not(trouve) then
      begin
        inc(port); // tester le port suivant (changement de sens)
        index:=ind2;
      end;
    until (port=2) or trouve; // boucle de port

    if not(trouve) then
    begin
      if IndexSegBumper=-1 then begin AfficheDebug('Msg 187 : pas trouvé de route pour le détecteur '+intToSTR(adresse),clOrange) ; exit; end;
      begin
        // repartir du buttoir vers le détecteur
        IndexPort:=PortBumper;
        per1:=port;
        i:=1;
        index:=IndexSegBumper;
        circuit_det[i].index:=IndexSegBumper;
        circuit_det[i].port:=PortBumper;
        i:=2;
        repeat
          ts:=trouve_seg_suivant(index,Indexport,Suivant,IndexportSuiv);
          if not(ts) then begin AfficheDebug('Erreur 102 - Pas de suivant Segment '+intToSTR(segment[Index].numero),clred);exit;end;
          index:=Suivant;
          indexport:=IndexPortSuiv;
          numseg:=segment[index].numero;
          //Affiche(intToSTR(numseg),clred);
          circuit_det[i].port:=indexport; //index du port
          circuit_det[i].index:=index;
          indexport:=1-indexport;  // inverser le port
          tn:=indexport>=0;
          if not(tn) then begin AfficheDebug('Erreur 103 - Port destination négatif - Segment '+intToSTR(segment[IndexSegBumper].numero),clred);exit;end;

          np:=segment[index].nperiph;
          if np<>0 then
          begin
            p:=0;
            repeat
              if segment[index].periph[p].typ='detector' then trouve:=segment[index].periph[p].adresse=adresse;
              inc(p);
            until (p>np-1) or trouve;
          end;
          inc(i);
        until trouve or (i>10);
        if not(trouve) then begin AfficheDebug('Erreur 104 - Detecteur '+intToSTR(adresse)+' non trouvé car trop distant',clred);exit;end;
        per2:=p-1;
      end;
    end;
    NindexR:=i-1;

    {
    for i:=1 to NindexR do
    begin
      index:=circuit_det[i].index;
      s:=intToSTR(segment[index].numero)+
         ' StartAngle='+IntToSTR(segment[index].StartAngle div 100)+
         ' ArcAngle='+IntToSTR(segment[index].ArcAngle div 100);
      Affiche(s,clWhite);
    end;              }

    // le circuit des segments est trouvé dans le tableau circuit_det
    if trouve then
    begin
      // départ sur détecteur
      index:=circuit_det[1].index;
      ctyp:=segment[index].typ;
      if (ctyp='curve') or (ctyp='arc') then
      begin
        rayon:=segment[index].Rayon;
        StartAngle:=segment[index].StartAngle/100;
        StopAngle:=segment[index].ArcAngle/100;
        centreX:=segment[index].lxc;
        CentreY:=segment[index].lyc;
        x:=segment[index].periph[per1].x;
        y:=segment[index].periph[per1].y;
        // déterminer la destination
        // trouve le port connecté au segment suivant
        tp:=index_port_connecte(index,circuit_det[2].index,indexPort);
        // trouver les coordonnées su x,y sur lequel est connecté le port
        xs:=Segment[index].port[IndexPort].x;
        ys:=Segment[index].port[IndexPort].y;
        // donc tracer un arc de (x,y) détecteur à (xs,ys) port
        arc_xy(centreX,centreY,rayon,x,y,xs,ys);
      end;
      if (ctyp='straight') or (ctyp='pre_curve') or (ctyp='bumper_stop')  then
      begin
        if ctyp='bumper_stop' then
        begin
          // faire le raccordement sur le port non connecté
          if segment[index].port[0].connecte then p:=1 else p:=0;
          x:=segment[index].port[p].x;
          y:=segment[index].port[p].y;
        end
        else
        begin
          x:=segment[index].periph[per1].x;
          y:=segment[index].periph[per1].y;
        end;

        coords(x,y);
        canvas.moveto(x,y);

        x:=segment[index].port[circuit_det[1].port].x;
        y:=segment[index].port[circuit_det[1].port].y;
        coords(x,y);
        Canvas.LineTo(x,y);
      end;

      for i:=2 to NindexR-1 do
      begin
        index:=circuit_det[i].index;
        //Affiche('Route de index Seg='+inttoSTR(segment[index].numero),clYellow);

        ctyp:=segment[index].typ;
        if (ctyp='curve') or (ctyp='arc') then
        begin
          rayon:=segment[index].Rayon;
          StartAngle:=segment[index].StartAngle/100;
          StopAngle:=segment[index].ArcAngle/100;
          centreX:=segment[index].lxc;
          CentreY:=segment[index].lyc;
          angle_cdm(canvas,centreX,CentreY,startangle,stopangle,rayon);
        end;

        if (ctyp='straight') or (ctyp='pre_curve') or (ctyp='bumper_stop')  then
        begin
          x:=segment[index].port[0].x;
          y:=segment[index].port[0].y;
          coords(x,y);
          canvas.moveto(x,y);

          x:=segment[index].port[1].x;
          y:=segment[index].port[1].y;
          coords(x,y);
          Canvas.LineTo(x,y);
        end;
      end;
      // dernier élément
      index:=circuit_det[NindexR].index;
      ctyp:=segment[index].typ;
      if (ctyp='curve') or (ctyp='arc') then
      begin
        rayon:=segment[index].Rayon;
        StartAngle:=segment[index].StartAngle/100;
        StopAngle:=segment[index].ArcAngle/100;
        centreX:=segment[index].lxc;
        CentreY:=segment[index].lyc;
        Canvas.pen.color:=clred;
        x:=segment[index].periph[per2].x;
        y:=segment[index].periph[per2].y;
        // déterminer la destination
        // trouve le port connecté au segment précédent
        tp:=index_port_connecte(index,circuit_det[NindexR-1].index,indexPort);
        // trouver les coordonnées su x,y sur lequel est connecté le port
        xs:=Segment[index].port[IndexPort].x;
        ys:=Segment[index].port[IndexPort].y;
        // donc tracer un arc de (x,y) (détecteur) à (xs,ys) port
        arc_xy(centreX,centreY,rayon,x,y,xs,ys);
      end;
      if (ctyp='straight') or (ctyp='pre_curve') or (ctyp='bumper_stop')  then
      begin
        x:=segment[index].periph[per2].x;
        y:=segment[index].periph[per2].y;
        coords(x,y);
        canvas.moveto(x,y);

        x:=segment[index].port[circuit_det[nindexr].port].x;
        y:=segment[index].port[circuit_det[nindexr].port].y;
        coords(x,y);
        Canvas.LineTo(x,y);
      end;
    end;
  end;
end;

procedure TFormAnalyseCDM.ButtonAffDetClick(Sender: TObject);
var i,erreur : integer;
begin
  val(EditDetecteur.text,i,erreur);
  if erreur=0 then dessine_det(i);
end;

procedure TFormAnalyseCDM.CheckColorationDiffClick(Sender: TObject);
begin
  coloration_diff:=CheckColorationDiff.checked;
  Affichage(false);
end;

procedure TFormAnalyseCDM.ButtonAllumeTsClick(Sender: TObject);
var i,j,p,np : integer;
begin
  for i:=0 to NSeg-1 do
  begin
    np:=segment[i].nperiph; // nombre de périphériques
    for j:=0 to np-1 do
    begin
      if segment[i].periph[j].typ='detector' then
      begin
        p:=segment[i].periph[j].adresse;
        if p<>0 then dessine_det(p);
      end;
    end;
  end;
end;

procedure TFormAnalyseCDM.ButtonImprimeClick(Sender: TObject);
begin
  affichage(true);
  affichage(false); //pour remettre les variables globales de dimensionnement qui sont différentes de l'impression
end;

procedure TFormAnalyseCDM.ImageCDMMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var Xs,Ys,i,xt,yt : integer;
    trouve : boolean;
begin
  xs:=x;ys:=y;
  inv_coords(xs,ys);
  caption:=NomModuleCDM+' '+intToSTR(xs)+' '+intToSTr(ys)+' / '+intToSTR(x)+' '+intToSTR(y);
  i:=1;

  // afficher le hint du train
  repeat
    xt:=trains[i].x;
    yt:=trains[i].y;
    trouve:=(abs(xt-x)<50) and (abs(yt-y)<50);
    if not(trouve) then inc(i);
  until (i>Ntrains) or trouve;
  if trouve then
  begin
    ImageCDM.Hint:=trains[i].nom_train+' @='+intToSTR(trains[i].adresse);
    ImageCDM.showHint:=true;
  end
  else ImageCDM.showhint:=false;
end;

procedure TFormAnalyseCDM.ButtonAnimeClick(Sender: TObject);
var bmp : tbitmap;
    zom,ang : single;
    x,y : integer;
begin
  x:=100;y:=200;
  zom:=1.2;
  ang:=0;

  repeat
    peindre(1,x,y,zom);

    //peindre(2,500-x,y,0,zom);
    //zom:=zom+0.005;
    x:=x+10;
    ang:=ang+0.04;
    sleep(40);
    Application.processMessages;
  until x>800;

  //until x>500;


end;





end.





