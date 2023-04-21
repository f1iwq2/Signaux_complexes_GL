unit UnitAnalyseSegCDM;
// attention manque aiguillage triple
// les Tjs ne sont pas traitées, de même que les bretelles double jonction, ni les tables tournantes.
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnitPrinc, ExtCtrls, StdCtrls, ComCtrls, UnitDebug, UnitConfig;

const
   cadre=30;

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
    procedure FormResize(Sender: TObject);
    procedure CheckSegmentsClick(Sender: TObject);
    procedure CheckConnexionsClick(Sender: TObject);
    procedure CheckAdressesClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ButtonAffPortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

  TAig_CDM = record
    adresse,temps : integer;
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
    nInter,nPeriph,nSeg,nPort,nligne,XminiCDM,XmaxiCDM,YminiCDM,YmaxiCDM,NAig_CDM : integer;
    lignes : TStrings;
    reducX,reducY : double;
    FormAnalyseCDM: TFormAnalyseCDM;
    NomModule : string;

    Aig_CDM : array[0..NbreMaxiAiguillages] of TAig_CDM;

procedure Analyse_seg;

implementation

{$R *.dfm}

function isole_valeur(var s : string; chercher : string) : string;
var i : integer;
begin
    i:=pos(chercher,s);
    if i=0 then begin Affiche('Erreur : pas de chaine '+chercher+' dans '+s,clred);exit;end;
    delete(s,1,i+length(chercher)-1);

    repeat
      if s[1]=' ' then delete(s,1,1);
    until (s[1]<>' ') or (length(s)=0);

    i:=pos(' ',s);
    if i<>0 then isole_valeur:=copy(s,1,i-1) else isole_valeur:=s;
end;

procedure compile_periph;
var i,erreur : integer;
    s,s2: string;
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
    s,s2,segType: string;
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
  if i=0 then begin Affiche('Erreur structure n°2',clOrange);exit;end;
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
    s2:=isole_valeur(s,'lengthdev:');
    val(s2,i,erreur);
    segment[nSeg-1].lengthdev:=i;

    inc(nligne);
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

    if (segType='dbl_slip_switch') then
    begin
      s:=AnsiLowerCase(lignes[nligne]);
      s2:=isole_valeur(s,'adresse2 =');
      val(s2,i,erreur);
      segment[nSeg-1].adresse2:=i;
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
    exit;
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

  if segment[nseg-1].typ='arc' then
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
                Radius: Integer; StartDegrees, StopDegrees: Double);
 //Get it in http://delphidabbler.com/tips/148
const
  Offset = 90;
var
  X1, X2, X3, X4: Integer;
  Y1, Y2, Y3, Y4: Integer;
begin
  X1 := CenterX - Radius;
  Y1 := CenterY - Radius;
  X2 := CenterX + Radius;
  Y2 := CenterY + Radius;
  X4 := CenterX + Round(Radius * Cos(DegToRad(Offset + StartDegrees)));
  Y4 := Centery - Round(Radius * Sin(DegToRad(Offset + StartDegrees)));
  X3 := CenterX + Round(Radius * Cos(DegToRad(Offset + StopDegrees)));
  Y3 := Centery - Round(Radius * Sin(DegToRad(Offset + StopDegrees)));
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

procedure affichage;
var r : Trect;
    i,j,x1,x2,y1,y2,largeur,hauteur,cx,cy,rayon : integer;
    startAngle,arcAngle,lxc,lyc : integer;
    SegType,s,s2 : string;
    Zoom : double;
    portsSeg : array[0..10] of record x,y : integer; end;
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
  reducY:=Zoom*(hauteur-2*cadre)/(YmaxiCDM-YminiCDM);

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
      s:='P'+intToSTR(Segment[i].port[j].numero);
      x1:=segment[i].port[j].X; y1:=segment[i].port[j].y;

      with FormAnalyseCDM.ImageCDM.Canvas do
      begin
        //Affiche('I='+intToSTR(i)+' '+intToSTR(x1)+' '+intToSTR(y1),clred);
        coords(x1,y1);
        if formAnalyseCDM.CheckConnexions.checked then Ellipse(x1-5,y1-5,x1+5,y1+5);
        portsSeg[j].x:=x1;
        portsSeg[j].y:=y1;
        if formAnalyseCDM.CheckPorts.checked then Textout(x1,y1,s);
      end;
      //Affiche(s,ClYellow);
    end;
    // relier les ports en vert &&&
    if formAnalyseCDM.CheckPorts.checked then
    with FormAnalyseCDM.ImageCDM.Canvas do
    begin
      moveto(portsSeg[0].x,portsSeg[0].y);
      for j:=1 to nPort-1 do
        LineTo(portsSeg[j].x,portsSeg[j].y);
    {  if segment[i].typ='arc' then
      begin                             //    D_Arc(Canvas: TCanvas; CenterX,CenterY: integer;Radius: Integer; StartDegrees, StopDegrees: Double);
        rayon:=segment[i].Rayon;
        StartAngle:=segment[i].StartAngle;
        ArcAngle:=segment[i].ArcAngle;
        lxc:=segment[i].lXc;lyc:=segment[i].lyc;
        coords(lxc,lyc);
        D_arc(FormAnalyseCDM.ImageCDM.Canvas,lxc,lyc,rayon,startAngle,ArcAngle);
      end;    }
    end;

    // périphériques en jaune --------------------------
    nperiph:=Segment[i].nperiph;
    FormAnalyseCDM.ImageCDM.Canvas.Pen.Color:=clYellow;
    FormAnalyseCDM.ImageCDM.Canvas.Font.Color:=clYellow;
    //nperiph:=0; //&&&

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
        if formAnalyseCDM.CheckAdresses.checked then textout(x1,y1,s2);
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

procedure trouve_IndexSegPort(seg,port : integer;var indexSeg,indexPort : integer);
var i,j,p,np,ns : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    j:=0;
    np:=segment[i].nport;
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
  end
  else
  begin
    indexSeg:=-1;
    indexPort:=-1;
  end
end;

// trouve les index du port
procedure trouve_IndexPort(port : integer;var indexSeg,indexPort : integer);
var i,j,p,np,ns : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    j:=0;
    np:=segment[i].nport;
    ns:=segment[i].numero;
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

function segment_aig(s : string) : boolean;
begin
  segment_aig:=(s='turnout') or (s='dbl_slip_switch') or (s='turnout_sym') or
               (s='turnout_curved') or (s='turnout_curved_2r') or (s='turnout_3way');
end;

// explore le port,segment jusqu'a trouver une adresse d'aiguillage ou de détecteur
function explore_port(seg,port : integer;var c : string) : integer;
var ns,i,IdSeg,IdPort,np,adresse,port1,port2,portSuivant,segSuivant,portLocal,portLocSuiv : integer;
    typeP : string;
    trouve : boolean;
begin
  trouve_IndexSegPort(seg,port,idSeg,IdPort);
  if idseg=-1 then
  begin
    Affiche('Erreur 1 pas trouvé le port '+intToSTR(port),clred);
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
    Affiche('Erreur 2 pas trouvé le port '+intToSTR(port),clred);
    c:='';
    explore_port:=0;
    exit;
  end;


  // remonter au segment pour voir si c'est un aiguillage
  typeP:=segment[idSeg].typ;
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
    portLocal:=segment[idSeg].port[idport].local; // port local
    // port d'en face
    case portLocal of
    0 : portLocSuiv:=2;
    1 : portLocSuiv:=3;
    2 : portLocSuiv:=0;
    3 : portLocSuiv:=1;
    end;
    i:=explore_port(segSuivant,segment[idSeg].port[PortLocSuiv].numero,c);
    explore_port:=i;
    exit;
  end;

  // y a t-il des periph
  np:=segment[idSeg].nperiph;
  if np<>0 then
  begin
    // présence de péripéhiques
    i:=0;
    repeat
      typeP:=segment[idSeg].periph[i].typ;
      adresse:=segment[idSeg].periph[i].adresse;
      trouve:=(typeP='detector') and (adresse<>0);
      inc(i);
    until (i>np-1) or trouve;
    if trouve then
    begin
      c:='';
      explore_port:=adresse;
      exit;
    end;
  end;

  // trouver l'autre port du segment idseg
  // sur 2 ports
  np:=segment[idSeg].nport;
  if np=0 then
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

procedure cree;
  var i,j,connecteAuPort,ConnecteAuSeg,numPort,NumSegment,IndexSegment,IndexPort,
  nport,adresse,adresse2,element,DernAdrAig : integer;
  s,segType,c : string;
begin
  // 1er segment, 1er port
  IndexSegment:=0;IndexPort:=0;

  {
  for i:=1 to 10 do
  begin
    numSegment:=segment[IndexSegment].numero;
    NumPort:=segment[IndexSegment].port[IndexPort].numero;
    connecteAuPort:=segment[IndexSegment].port[IndexPort].ConnecteAuPort;
    connecteAuSeg:=segment[IndexSegment].port[IndexPort].ConnecteAuSeg;
    Affiche('le segment '+intToSTR(NumSegment)+' port '+intToSTR(NumPort)+' est connecté au S'+intToSTR(connecteAUSeg)+' P'+intToSTR(connecteAuPort),clyellow);
    trouve_IndexSegPort(connecteAuPort,IndexSegment,IndexPort);
  end;
  }

  DernAdrAig:=0;
  // liste les segments avec des aiguillages
  if debugAnalyse then
  begin
    AfficheDebug('Liste des aiguillages',clWhite);
    AfficheDebug('--------------------------------',clWhite);
  end;
  NAig_CDM:=0;
  for i:=0 to nseg-1 do
  begin
    segType:=segment[i].typ;
    if segment_aig(segtype) then
    begin
      numSegment:=segment[i].numero;
      adresse:=segment[i].adresse;
      if DernAdrAig<adresse then DernAdrAig:=adresse;
      s:='Segment '+intToSTR(numSegment)+' type='+segtype+' Adresse='+intToSTR(adresse);
      if segType='dbl_slip_switch' then s:=s+' Adresse2='+intToSTR(segment[i].adresse2);
      if debugAnalyse then AfficheDebug(s,clorange);
      if (adresse=0) then
      begin
        Affiche('   Erreur segment avec adresse nulle',clred);
        Affiche(s,clred);
      end;


      inc(nAig_CDM);
      Aig_CDM[nAig_CDM].adresse:=adresse;
      Aig_CDM[nAig_CDM].temps:=segment[i].duree;

      if (SegType='dbl_slip_switch') then
      begin
        adresse2:=segment[i].adresse2;
        if DernAdrAig<adresse2 then DernAdrAig:=adresse2;
        Aig_CDM[nAig_CDM].modele:=tjd;
        Aig_CDM[nAig_CDM].ddroit:=Adresse2;
        Aig_CDM[nAig_CDM].ddroitB:='D';
        Aig_CDM[nAig_CDM].dDevie:=Adresse2;
        Aig_CDM[nAig_CDM].dDevieB:='S';
        if adresse2=0 then Aig_CDM[nAig_CDM].etatTJD:=2 else Aig_CDM[nAig_CDM].etatTJD:=4;

        if adresse2<>0 then
        begin
          inc(nAig_CDM);   // attention deux adresses!!
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
      if (SegType='turnout_3way') then Aig_CDM[nAig_CDM].modele:=triple;

      for j:=0 to segment[i].nport-1 do
      begin
        s:='  Port '+intToSTR(j)+' ';
        if (SegType<>'dbl_slip_switch') and (Segtype<>'turnout_3way') then
        case j of
        0 : s:=s+'P';
        1 : s:=s+'D';
        2 : s:=s+'S';
        end;

        if (SegType='dbl_slip_switch') then
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
          if j=0 then begin Aig_CDM[nAig_CDM-1].Adroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM-1].AdroitB:=c[1];end;
          if j=1 then begin Aig_CDM[nAig_CDM-1].Adevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM-1].AdevieB:=c[1];end;
          if j=2 then begin Aig_CDM[nAig_CDM].Adroit:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdroitB:=c[1];end;
          if j=3 then begin Aig_CDM[nAig_CDM].Adevie:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].AdevieB:=c[1];end;
        end
        else
        begin
          // autre aiguillage que tjd (3 ou 4 ports pour les tri)
          if j=0 then begin Aig_CDM[nAig_CDM].APointe:=element;if length(c)<>0 then Aig_CDM[nAig_CDM].APointeB:=c[1];end;
          if j=1 then begin Aig_CDM[nAig_CDM].ADroit:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADroitB:=c[1];end;
          if j=2 then begin Aig_CDM[nAig_CDM].ADevie:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADevieB:=c[1];end;
          if j=3 then begin Aig_CDM[nAig_CDM].ADevie:=element; if length(c)<>0 then Aig_CDM[nAig_CDM].ADevieB:=c[1];end;
        end
      end;
     // exit;
    end;
  end;

  if debugAnalyse then
  begin
    AfficheDebug(' ',clwhite);
    AfficheDebug('Liste des croisements',clWhite);
    AfficheDebug('--------------------------------',clWhite);
  end;
  for i:=0 to nseg-1 do
  begin
    segType:=segment[i].typ;
    if segType='crossing' then
    begin
      numSegment:=segment[i].numero;
      adresse:=segment[i].adresse;

      inc(nAig_CDM);
      inc(dernAdrAig);
      Aig_CDM[nAig_CDM].adresse:=DernAdrAig; //&&&&

      Aig_CDM[nAig_CDM].modele:=crois;

      s:='Segment '+intToSTR(numSegment)+' type='+segtype+' Adresse='+intToSTR(DernAdrAig);
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

end;

procedure Analyse_seg;
var s,s2,ch,SegType: string;
    i,nombre,position : integer;

begin
  Lignes:=Formprinc.FenRich.Lines;
  nligne:=0; nSeg:=0;
  xminiCDM:=0;yMiniCDM:=0;xmaxiCDM:=0;yMaxiCDM:=0;
  nombre:=Formprinc.FenRich.Lines.Count;
  NomModule:=Lignes[0];
  formAnalyseCDM.Caption:='Squelette du réseau '+NomModule;

  Affiche('Compilation en cours',clWhite);

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

  formAnalyseCDM.Show;
  formprinc.ButtonAffAnalyseCDM.Visible:=true;
  Affiche('Compilation terminée',clWhite);
  // crée
  cree;

  if MaxAiguillage<>0 then
  begin
    if MessageDlg('Une configuration de réseau existe dans signaux complexes.'+#10+#13+
                  'Si vous importez le réseau CDM, la configuration des aiguillages de signaux complexes sera écrasée.'+#10+#13+
                  'Voulez vous continuer l''importation? (aiguillages)',mtConfirmation,[mbyes,mbNo],0)=mrNo then
      begin
        Affiche('Importation annulée',clOrange);
        exit;
      end;
  end;

  MaxAiguillage:=0;

  Affiche('Importation en cours',clWhite);
  // recopier les aiguillages
  for i:=1 to NAig_CDM do
  begin
    Aiguillage[i].adresse:=Aig_CDM[i].adresse;
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
var i,j,port,numport,erreur : integer;
    trouve : boolean;
begin
  val(editPort.text,numport,erreur);
  trouve_IndexPort(numport,i,j);
  if i=-1 then exit;
  Affiche_port(i,j);

end;

procedure TFormAnalyseCDM.FormCreate(Sender: TObject);
begin
  checkPorts.Checked:=true;
end;



end.

