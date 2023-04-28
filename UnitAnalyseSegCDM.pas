unit UnitAnalyseSegCDM;
// les Tjs ne sont pas traitées, de même que les bretelles double jonction
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnitPrinc, ExtCtrls, StdCtrls, ComCtrls, UnitDebug, UnitConfig , StrUtils;

const
   cadre=30;
   const max_db = 20;  // 20 détecteurs maxi entre 2 aiguillages

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
    GroupBox2: TGroupBox;
    CheckDebugAnalyse: TCheckBox;
    CheckDebugBranches: TCheckBox;
    GroupBox3: TGroupBox;
    ButtonImporter: TButton;
    RadioGroup1: TRadioGroup;
    RadioCroisSuite: TRadioButton;
    RadioCroisBase: TRadioButton;
    EditBaseCrois: TEdit;
    procedure FormResize(Sender: TObject);
    procedure CheckSegmentsClick(Sender: TObject);
    procedure CheckConnexionsClick(Sender: TObject);
    procedure CheckAdressesClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ButtonAffPortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonImporterClick(Sender: TObject);
    procedure CheckDebugAnalyseClick(Sender: TObject);
    procedure CheckDebugBranchesClick(Sender: TObject);
    procedure EditBaseCroisChange(Sender: TObject);
    procedure CheckPortsClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
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
    DernAdrAig,BaseCroisement,SeqAdrCroisement,nb_det : integer;
    lignes : TStrings;
    reducX,reducY : double;
    FormAnalyseCDM: TFormAnalyseCDM;
    NomModule,sBranche : string;
    debugBranche,debugAnalyse : boolean;
    Aig_CDM : array[0..NbreMaxiAiguillages] of TAig_CDM;
    Det_CDM : array[1..500] of integer;

procedure Analyse_seg;

implementation

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

  // les autres aiguillages
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

procedure Coords(var x,y : integer);
begin
  x:=round( ((x - xMiniCDM) )             * reducX )+(cadre div 2);
  y:=round( (((yMaxiCDM-y)  ) - yMiniCDM) * reducY )+(cadre div 2);
  //y:=round((y - yMiniCDM)*reducY);
end;

function degtoRad(angle : double) : double;
begin
  degtoRad:=angle*pi/180;
end;

procedure D_Arc(Canvas: TCanvas; CenterX,CenterY: integer;
                Radius: Integer; StartDegres, StopDegres: Double);
const  pisur180 =pi/180 ;
var
  X1,X2,X3,X4: Integer;
  Y1,Y2,Y3,Y4: Integer;
  ech : double;
begin
  if StopDegres<0 then setArcDirection(Canvas.Handle,AD_COUNTERCLOCKWISE)
   else setArcDirection(Canvas.Handle,AD_CLOCKWISE);

  StartDegres:=startDegres;
  stopDegres:=StartDegres+stopDegres;
  X1:=CenterX - Radius;
  Y1:=CenterY - Radius;
  X2:=CenterX + Radius;
  Y2:=CenterY + Radius;
  X4:=CenterX + Round(Radius * Cos(StartDegres*pisur180));
  Y4:=Centery - Round(Radius * Sin(StartDegres*pisur180));
  X3:=CenterX + Round(Radius * Cos(StopDegres*pisur180));
  Y3:=Centery - Round(Radius * Sin(StopDegres*pisur180));
  Canvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure affiche_port(indexSeg,IndexPort: integer);
var x,y : integer;
    s : string;
begin
  x:=segment[indexSeg].port[indexport].X; y:=segment[indexSeg].port[IndexPort].y;
  s:=intToSTR(segment[indexSeg].port[IndexPort].numero);
  coords(x,y);
  with FormAnalyseCdm.ImageCDM.canvas do
  begin
    pen.Color:=ClLime;
    TextOut(x,y,s);
    Moveto(0,0);
    LineTo(x,y);
  end;
end;

procedure angle_cdm(centreX,centreY:integer;debut,fin : double ;rayon : integer);
var ech : double;
begin
  coords(centreX,centreY);
  rayon:=round(rayon*reducX);
  D_arc(FormAnalyseCDM.ImageCDM.Canvas,centreX,centreY,rayon,debut,fin);
end;

procedure affichage;
var r : Trect;
    i,j,x1,x2,y1,y2,largeur,hauteur,rayon,centreX,centreY,Numsegment : integer;
    SegType,s,s2 : string;
    Ech,Zoom,startAngle,StopAngle,AncienStart : double;
    portsSeg : array[0..40] of record x,y : integer; end;
begin
  if (xMaxiCDM-xminiCDM=0) or (yMaxiCDM-yminiCDM=0) then exit;
  with formAnalyseCDM do
  begin
    largeur:=3000;hauteur:=1000;
    largeur:=(XmaxiCDM-XminiCDM) div 20;
    hauteur:=(YmaxiCDM-YminiCDM) div 20;
    //largeur:=ScrollBox1.Width;
    //hauteur:=ScrollBox1.Height;

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
    //largeur:=ScrollBox1.Width;
    //hauteur:=ScrollBox1.Height;
  end;

  Zoom:=(270-formAnalyseCDM.TrackBar1.Position)/100;
  reducX:=Zoom*(largeur-2*cadre)/(XmaxiCDM-XminiCDM);
  reducY:=reducX;
  //reducY:=Zoom*(hauteur-2*cadre)/(YmaxiCDM-YminiCDM);

  with FormAnalyseCDM.ImageCDM.Canvas do
  begin
    //effacer tout
    Pen.width:=1;
    Brush.Style:=bsSolid;
    Brush.Color:=clblack;
    pen.color:=clyellow;
    r:=rect(0,0,FormAnalyseCDM.ImageCDM.width,FormAnalyseCDM.ImageCDM.height);
    FillRect(r);
    x1:=xminiCDM;y1:=yminiCDM;
    coords(x1,y1);
    x2:=xmaxiCDM;y2:=ymaxiCDM;
    coords(x2,y2);
  end;

  // balayage ...
  for i:=0 to nSeg-1 do
  begin
    SegType:=Segment[i].typ;
    NumSegment:=Segment[i].numero;
    FormAnalyseCDM.ImageCDM.Canvas.Pen.Color:=claqua;
    FormAnalyseCDM.ImageCDM.Canvas.Font.Color:=claqua;

    s:='S'+intToSTR(Segment[i].numero); //+' '+SegType;
    if (SegType='turnout') or (SegType='dbl_slip_switch') then
    begin
      s2:=intToSTR(Segment[i].adresse);
      s:=s+' @='+s2;
    end;

    begin
      x1:=segment[i].XMin;y1:=segment[i].YMin; coords(x1,y1);
      x2:=segment[i].XMax;y2:=segment[i].Ymax; coords(x2,y2);
      with FormAnalyseCDM.ImageCDM.Canvas do
      begin
        if formAnalyseCDM.CheckSegments.checked then
        begin
          Textout(x1,y1,s);
          PolyGon([point(x1,y1),Point(x2,y2)]);
        end;
        if SegType='straight' then
        begin
         // x1:=segment[i].xc0;
         // affiche(intToSTR(x1),clyellow);
        end;
      end;
    end;
    //Affiche(s,ClAqua);

    // ports en vert --------------------------------------
    nport:=Segment[i].nport;
    FormAnalyseCDM.ImageCDM.Canvas.Pen.Color:=clLime;
    FormAnalyseCDM.ImageCDM.Canvas.Font.Color:=clLime;
    for j:=0 to nPort-1 do
    begin
      //Affiche_port(i,j);

      //s:='Port '+intToSTR(Segment[i].port[j].numero)+' '+Segment[i].port[j].typ;
      s:='S'+intToSTR(NumSegment)+'P'+intToSTR(Segment[i].port[j].numero);
      x1:=segment[i].port[j].X; y1:=segment[i].port[j].y;

      with FormAnalyseCDM.ImageCDM.Canvas do
      begin
        //Affiche('I='+intToSTR(i)+' '+intToSTR(x1)+' '+intToSTR(y1),clred);
        coords(x1,y1);
        if formAnalyseCDM.CheckConnexions.checked then Ellipse(x1-5,y1-5,x1+5,y1+5);
        if j<40 then
        begin
          portsSeg[j].x:=x1;
          portsSeg[j].y:=y1;
        end;
        if formAnalyseCDM.CheckPorts.checked then Textout(x1,y1,s);
      end;
      //Affiche(s,ClYellow);
    end;

    // relier les ports en vert
    //if formAnalyseCDM.CheckPorts.checked then
    with FormAnalyseCDM.ImageCDM.Canvas do
    begin
      pen.width:=2;
      if (segtype='crossing') or (segType='dbl_slip_switch') then
      begin
        moveto(portsSeg[0].x,portsSeg[0].y);
        LineTo(portsSeg[2].x,portsSeg[2].y);
        moveto(portsSeg[1].x,portsSeg[1].y);
        LineTo(portsSeg[3].x,portsSeg[3].y);
        if formAnalyseCDM.CheckAdresses.checked then
        begin
          s:='A'+intToSTR(Segment[i].adresse);
          x1:=(portsSeg[0].x+portsSeg[1].x) div 2;
          y1:=(portsSeg[0].y+portsSeg[1].y) div 2;
          Textout(x1,y1,s);
          x1:=Segment[i].adresse2;
          if x1<>0 then
          begin
            s:='A'+intToSTR(Segment[i].adresse2);
            x1:=(portsSeg[1].x+portsSeg[3].x) div 2;
            y1:=(portsSeg[1].y+portsSeg[3].y) div 2;
            Textout(x1,y1,s);
          end;
        end;
      end
      else
      if segtype='turnout' then
      begin
        moveto(portsSeg[0].x,portsSeg[0].y);
        LineTo(portsSeg[1].x,portsSeg[1].y);
        moveTo((portsSeg[0].x+portsSeg[1].x)div 2,(portsSeg[0].y+portsSeg[1].y)div 2);
        LineTo(portsSeg[2].x,portsSeg[2].y);
        if formAnalyseCDM.CheckAdresses.checked then
        begin
          s:='A'+intToSTR(Segment[i].adresse);
          x1:=(portsSeg[0].x+portsSeg[1].x) div 2;
          y1:=(portsSeg[0].y+portsSeg[1].y) div 2;
          Textout(x1,y1,s);
        end;
      end
      else
      if (segtype='turnout_curved') or (segtype='turnout_curved_2r')
      then
      begin
        moveto(portsSeg[0].x,portsSeg[0].y);
        LineTo(portsSeg[1].x,portsSeg[1].y);
        moveTo((portsSeg[0].x+portsSeg[1].x)div 2,(portsSeg[0].y+portsSeg[1].y)div 2);
        LineTo(portsSeg[2].x,portsSeg[2].y);
        begin
          s:='A'+intToSTR(Segment[i].adresse);
          x1:=(portsSeg[0].x+portsSeg[1].x) div 2;
          y1:=(portsSeg[0].y+portsSeg[1].y) div 2;
          Textout(x1,y1,s);
        end;
      {  rayon:=segment[i].Rayon;
        StartAngle:=(segment[i].StartAngle/100);
        StopAngle:=segment[i].ArcAngle/100;
        centreX:=segment[i].xc0;
        CentreY:=segment[i].yc0;
        angle_cdm(centreX,CentreY,startangle,stopangle,rayon);    }
      end
      else
      if (segType='arc') or (segType='curve') then
      begin
        rayon:=segment[i].Rayon;
        StartAngle:=(segment[i].StartAngle/100);
        StopAngle:=segment[i].ArcAngle/100;
        centreX:=segment[i].lXc;
        CentreY:=segment[i].lyc;
        angle_cdm(centreX,CentreY,startangle,stopangle,rayon);
      end
      else
      begin
        moveto(portsSeg[0].x,portsSeg[0].y);
        for j:=1 to nPort-1 do
          LineTo(portsSeg[j].x,portsSeg[j].y);
        AncienStart:=portsSeg[j].x;
      end;

    end;

    // périphériques en jaune --------------------------
    nperiph:=Segment[i].nperiph;
    FormAnalyseCDM.ImageCDM.Canvas.Pen.Color:=clYellow;
    FormAnalyseCDM.ImageCDM.Canvas.Font.Color:=clYellow;

    for j:=0 to nPeriph-1 do
    begin
      s:='Periph '+intToSTR(Segment[i].periph[j].numero)+' '+Segment[i].periph[j].typ;
      s2:=intToSTR(Segment[i].periph[j].adresse);
      s:=s+' Adresse='+s2;
      x1:=segment[i].periph[j].X; y1:=segment[i].periph[j].y ;
      with FormAnalyseCDM.ImageCDM.Canvas do
      begin
        coords(x1,y1);
        if formAnalyseCDM.CheckConnexions.checked then Ellipse(x1-5,y1-5,x1+5,y1+5);
        if formAnalyseCDM.CheckAdresses.checked then
        begin
          if segment[i].periph[j].typ='detector' then font.Color:=clAqua else font.Color:=clorange;
          textout(x1,y1,s2);
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
    //if i=0 then exit;
end;
 //  FormAnalyseCDM.ImageCDM.Canvas.Refresh;

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

function segment_aig(s : string) : boolean;
begin
  segment_aig:=(s='turnout') or (s='dbl_slip_switch') or (s='turnout_sym') or
               (s='turnout_curved') or (s='turnout_curved_2r') or (s='turnout_3way');
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


// trouve les indexs Segment et port  le détecteur est detecteur
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


// trouve les indexs du segment,port
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

// trie le tableau en fonction de la distance
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
  if seg=0 then exit;  // laisser sinon mauvais transfert de variable dans la pile dans l'itération suivante!!
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
    explore_port:=segment[idSeg].adresse;
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
      if formAnalyseCDM.radioCroisSuite.checked then AdrCroisement:=DernAdrAig+SeqAdrCroisement;
      if formAnalyseCDM.radioCroisBase.checked then AdrCroisement:=BaseCroisement+SeqAdrCroisement;

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
// exemple (169,171) => 172 173
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
    Affiche('Erreur recherche sur un segment '+intToSTR(segment[indexSeg].numero)+' <2 ports',clred);
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
    afficheDebug('Port non connecté',clOrange);
    result:=false;
  end;
end;



// renvoie le dernier champ d'une chaine
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
    rien,erreur,det2,nb_det,xp,yp,xd,yd : integer;
    trouve,sort : boolean;
    s,ss,ss2,ctype: string;
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
        sBranche:=sBranche+',A'+intToSTR(AdrAigRencontre);
        //if debugBranche then AfficheDebug('Aiguillage '+intToSTR(segment[indexSegSuivant].adresse),clorange);
        inc(nAig);  // à la première itération on a un aiguillage
        raz_detect(sdetect);
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
  // 1 vérifier si le dernier élément est un A ou buttoir
  i:=0;
  repeat
    j:=i;
    i:=posEx(',',sbranche,j+1);
  until i=0;
  ss:=copy(sbranche,j+1,length(sbranche)-j);   // dernier élément de la branche
  ss2:=copy(ss,2,length(sbranche)-1);
  val(ss2,i,erreur);
  // ok
  if (i<>0) and (ss[1]<>'A') then
  begin
    if debugBranche then
    begin
      AfficheDebug('La branche '+sbranche,clOrange);
      AfficheDebug('est invalide car le dernier élément n''est ni un aiguillage ni un buttoir',clOrange);
    end;
    exit;  // branche invalide, elle n'est pas prise en compte
  end;

  // vérifier si un des détecteurs de la branche existe déja dans les branches précédentes
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
    trouve : boolean;
begin
  if debugBranche then
  begin
    AfficheDebug('------------------',clyellow);
    AfficheDebug('Créée branche détecteur '+intToSTR(detecteur),clOrange);
  end;
  trouve:=trouve_IndexSegPortDetecteur(detecteur,indexSeg,indexPeriph);
  numSegment:=Segment[indexSeg].numero;
  if nivdebug=3 then AfficheDebug('Le segment porteur du détecteur est le '+intToSTR(numSegment)+' Periph '+intToSTR(Segment[indexSeg].periph[indexperiph].numero),clyellow);
  indexport:=0 ; // essayer depuis le port 0    //***************************************ZZZZZZZZZZZZZZZ

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
    Affiche(s,clred);
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
      if not(trouve) then affiche('Erreur 417 : Aig '+intToSTR(adresse)+' non trouvé ',clred);
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
      if not(trouve) then affiche('Erreur 418 : Aig '+intToSTR(adresse)+' non trouvé ',clred);
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


procedure Compilation;
var s : string;
    i,nombre,position : integer;
                        
begin
  ndet_cdm:=0;
  debugAnalyse:=true;
  debugBranche:=true;
  Lignes:=Formprinc.FenRich.Lines;
  nligne:=0; nSeg:=0;
  DernAdrAig:=0;
  xminiCDM:=0;yMiniCDM:=0;xmaxiCDM:=0;yMaxiCDM:=0;
  nombre:=Formprinc.FenRich.Lines.Count;
  NomModule:=Lignes[0];
  formAnalyseCDM.Caption:='Squelette du réseau '+NomModule;

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

  Affichage;
  Affiche('nombre de détecteurs: '+intToSTR(NDet_cdm),clyellow);

  formAnalyseCDM.Show;
  formprinc.ButtonAffAnalyseCDM.Visible:=true;
  Affiche('Compilation terminée. Nombre de segments='+intToSTR(nSeg),clWhite);

  remplit_Aig_cdm;
  Affiche('nombre de d''aiguillages: '+intToSTR(Naig_cdm),clyellow);

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

  Affiche('Importation des aiguillages',clWhite);
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


  // créer les branches pour version 6.1
  creee_branches;
  
  Affiche('Validation des branches',ClLime);
  valide_branches;
  for i:=1 to NbreBranches do
    compile_branche(Branche[i],i);

  Affiche('Importation terminée',clWhite);
  Affiche('Vérification de la cohérence :',clWhite);
  if verif_coherence then Affiche('Configuration cohérente',clLime);

end;


procedure TFormAnalyseCDM.FormResize(Sender: TObject);
begin
  affichage;
end;

procedure TFormAnalyseCDM.CheckSegmentsClick(Sender: TObject);
begin
  affichage;
end;

procedure TFormAnalyseCDM.CheckConnexionsClick(Sender: TObject);
begin
  Affichage;
end;

procedure TFormAnalyseCDM.CheckAdressesClick(Sender: TObject);
begin
  Affichage;
end;

procedure TFormAnalyseCDM.TrackBar1Change(Sender: TObject);
begin
  Affichage;
end;

procedure TFormAnalyseCDM.ButtonAffPortClick(Sender: TObject);
var i,j,numport,erreur : integer;
begin
  val(editPort.text,numport,erreur);
  trouve_IndexPort(numport,i,j);
  if i=-1 then exit;
  Affiche_port(i,j);

end;

procedure TFormAnalyseCDM.FormCreate(Sender: TObject);

begin
  checkPorts.Checked:=true;
  radioCroisBase.Checked:=true;
  radioCroisSuite.checked:=false;
  BaseCroisement:=100;
  EditBaseCrois.Text:=IntToSTR(BaseCroisement);

   

end;

procedure Analyse_Seg;
begin
  formAnalyseCDM.Show;
  //compilation;
end;


procedure TFormAnalyseCDM.ButtonImporterClick(Sender: TObject);
var startAngle,stopAngle : double;
    centreX,CentreY,rayon,x1,y1,x2,y2 : integer;
    r : Trect;
begin
  //FormAnalyseCDM.WindowState:=wsMinimized;
   Compilation;
  exit;
   with FormAnalyseCDM.ImageCDM.Canvas do
  begin
    //effacer tout
    Pen.width:=1;
    Brush.Style:=bsSolid;
    Brush.Color:=clblack;
    pen.color:=clyellow;
    r:=rect(0,0,FormAnalyseCDM.ImageCDM.width,FormAnalyseCDM.ImageCDM.height);
    FillRect(r);
    x1:=xminiCDM;y1:=yminiCDM;
    coords(x1,y1);
    x2:=xmaxiCDM;y2:=ymaxiCDM;
    coords(x2,y2);
  end;


    D_arc(FormAnalyseCDM.ImageCDM.Canvas,300,200,100,90,30);
  exit;
  //46
   ImageCDM.canvas.pen.color:=clLime;
   StartAngle:=90; //+AncienStart;  // relatif par rapport au dernier!!!
   StopAngle:=-30;
   centreX:=21850;centreY:=18310;
   rayon:=6500;
   angle_cdm(centreX,CentreY,startangle,stopangle,rayon);
  //55
   ImageCDM.canvas.pen.color:=clred;
   StartAngle:=60; //+AncienStart;  // relatif par rapport au dernier!!!
   StopAngle:=-30;
   centreX:=21850;centreY:=18310;
   rayon:=6500;
   angle_cdm(centreX,CentreY,startangle,stopangle,rayon);

end;

procedure TFormAnalyseCDM.CheckDebugAnalyseClick(Sender: TObject);
begin
  debugAnalyse:=checkDebugAnalyse.checked;
end;

procedure TFormAnalyseCDM.CheckDebugBranchesClick(Sender: TObject);
begin
  debugBranche:=checkDebugBranches.checked;
end;

procedure TFormAnalyseCDM.EditBaseCroisChange(Sender: TObject);
var i,erreur : integer;
begin
  val(editBaseCrois.text,i,erreur);
  if erreur=0 then BaseCroisement:=i;
end;

procedure TFormAnalyseCDM.CheckPortsClick(Sender: TObject);
begin
  Affichage;
end;

end.

