unit UnitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , verif_version, jpeg, ComCtrls ,StrUtils ;

type
  TFormConfig = class(TForm)
    ButtonAppliquerEtFermer: TButton;
    LabelInfo: TLabel;
    Image1: TImage;
    PageControl: TPageControl;
    TabSheetCDM: TTabSheet;
    TabSheetAutonome: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditAdrIPCDM: TEdit;
    EditPortCDM: TEdit;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    CheckVerifVersion: TCheckBox;
    CheckInfoVersion: TCheckBox;
    CheckLanceCDM: TCheckBox;
    CheckAvecTCO: TCheckBox;
    EditNomLay: TEdit;
    GroupBox6: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    GroupBox7: TGroupBox;
    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    RadioButton16: TRadioButton;
    RadioButton17: TRadioButton;
    RadioButton18: TRadioButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditcomUSB: TEdit;
    EditTempoOctetUSB: TEdit;
    EditTempoReponse: TEdit;
    GroupBox4: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditIPLenz: TEdit;
    EditportLenz: TEdit;
    GroupBox8: TGroupBox;
    CheckBoxServAig: TCheckBox;
    CheckBoxServDet: TCheckBox;
    CheckBoxServAct: TCheckBox;
    CheckServPosTrains: TCheckBox;
    Label6: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    TabSheetAig: TTabSheet;
    Label12: TLabel;
    TabSheetBranches: TTabSheet;
    Label14: TLabel;
    TabSheetSig: TTabSheet;
    Label15: TLabel;
    TabSheetAct: TTabSheet;
    Label16: TLabel;
    CheckBoxSrvSig: TCheckBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    GroupBox9: TGroupBox;
    CheckBoxRazSignaux: TCheckBox;
    GroupBox11: TGroupBox;
    LabelAdresse: TLabel;
    GroupBox10: TGroupBox;
    RadioButtonsans: TRadioButton;
    RadioButton30kmh: TRadioButton;
    RadioButton60kmh: TRadioButton;
    ImageAig: TImage;
    ImageTJD: TImage;
    ImageTri: TImage;
    GroupBox12: TGroupBox;
    ImageSignal: TImage;
    LabelAdrSig: TLabel;
    GroupBox13: TGroupBox;
    LabelDec: TLabel;
    LabelDetAss: TLabel;
    LabelElSuiv: TLabel;
    Label19: TLabel;
    GroupBoxRadio: TGroupBox;
    RadioButtonLoc: TRadioButton;
    GroupBoxAct: TGroupBox;
    GroupBoxPN: TGroupBox;
    Label21: TLabel;
    EditAdrFerme: TEdit;
    Label22: TLabel;
    EditAdrOuvre: TEdit;
    EditCmdFerme: TEdit;
    EditCdeOuvre: TEdit;
    Label23: TLabel;
    LabelV2: TLabel;
    LabelV3: TLabel;
    EditV1F: TEdit;
    Shape1: TShape;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    EditV2F: TEdit;
    EditV3F: TEdit;
    EditV1O: TEdit;
    EditV2O: TEdit;
    EditV3O: TEdit;
    Label10: TLabel;
    Label17: TLabel;
    MemoCarre: TMemo;
    RichAig: TRichEdit;
    ComboBoxDec: TComboBox;
    RichSig: TRichEdit;
    EditDet1: TEdit;
    EditSuiv1: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    EditDet2: TEdit;
    EditSuiv2: TEdit;
    Label26: TLabel;
    EditDet3: TEdit;
    EditSuiv3: TEdit;
    Label27: TLabel;
    EditDet4: TEdit;
    EditSuiv4: TEdit;
    CheckVerrouCarre: TCheckBox;
    Image2: TImage;
    Label28: TLabel;
    CheckInverse: TCheckBox;
    RadioButtonAccess: TRadioButton;
    Label29: TLabel;
    CheckFenEt: TCheckBox;
    GroupBox15: TGroupBox;
    EditNbDetDist: TEdit;
    Label31: TLabel;
    CheckBoxInitAig: TCheckBox;
    EditAdrSig: TEdit;
    Label32: TLabel;
    EditTempoAig: TEdit;
    EditAdrAig: TEdit;
    ComboBoxAig: TComboBox;
    GroupBox16: TGroupBox;
    LabelHG: TLabel;
    Edit_HG: TEdit;
    LabelBG: TLabel;
    EditPointe_BG: TEdit;
    ImageAffiche: TImage;
    EditP1: TEdit;
    EditP2: TEdit;
    EditP3: TEdit;
    EditP4: TEdit;
    LabelHD: TLabel;
    EditDevie_HD: TEdit;
    LabelBD: TLabel;
    EditDroit_BD: TEdit;
    Label18: TLabel;
    EditDevieS2: TEdit;
    LabelTJD1: TLabel;
    LabelTJD2: TLabel;
    Label33: TLabel;
    ComboBoxAsp: TComboBox;
    EditSpecUni: TEdit;
    LabelUni: TLabel;
    Buttonrestaure: TButton;
    GroupBox14: TGroupBox;
    ButtonNouvAcc: TButton;
    ButtonSupAcc: TButton;
    RichAct: TRichEdit;
    GroupBox17: TGroupBox;
    ButtonNouvPN: TButton;
    ButtonSupPN: TButton;
    RichPN: TRichEdit;
    ButtonNouvFeu: TButton;
    ButtonSupFeu: TButton;
    ButtonInsFeu: TButton;
    GroupBox18: TGroupBox;
    EditAct: TEdit;
    LabelActionneur: TLabel;
    EditEtatActionneur: TEdit;
    Label30: TLabel;
    LabelTrain: TLabel;
    EditTrain: TEdit;
    GroupBox19: TGroupBox;
    LabelTempo: TLabel;
    EditTempo: TEdit;
    CheckRAZ: TCheckBox;
    LabelFonction: TLabel;
    EditFonctionAccess: TEdit;
    Labela: TLabel;
    EditEtatFoncSortie: TEdit;
    ButtonNouvAig: TButton;
    BoutSupAig: TButton;
    ButtonAjSup: TButton;
    ButtonRestaureAig: TButton;
    GroupBox20: TGroupBox;
    ButtonValLigne: TButton;
    RichBranche: TRichEdit;
    ButtonVerifConfig: TButton;
    LabelResult: TLabel;
    Label34: TLabel;
    EditAigTriple: TEdit;
    GroupBox21: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    EditTempo10: TEdit;
    CheckInvInit: TCheckBox;
    Label39: TLabel;
    EditV4F: TEdit;
    EditV4O: TEdit;
    Label40: TLabel;
    Label41: TLabel;
    EditFonte: TEdit;
    ComboBoxDD: TComboBox;
    LabelL: TLabel;
    EditL: TEdit;
    CheckBoxFB: TCheckBox;
    procedure ButtonAppliquerEtFermerClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RichAigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButtonsansClick(Sender: TObject);
    procedure RadioButton30kmhClick(Sender: TObject);
    procedure RadioButton60kmhClick(Sender: TObject);
    procedure ComboBoxDecChange(Sender: TObject);
    procedure RichSigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckVerrouCarreClick(Sender: TObject);
    procedure EditActChange(Sender: TObject);
    procedure RichActMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditEtatActionneurChange(Sender: TObject);
    procedure EditTrainChange(Sender: TObject);
    procedure EditFonctionAccessChange(Sender: TObject);
    procedure EditEtatFoncSortieChange(Sender: TObject);
    procedure EditTempoChange(Sender: TObject);
    procedure CheckRAZClick(Sender: TObject);
    procedure CheckInverseClick(Sender: TObject);
    procedure ComboBoxAspChange(Sender: TObject);
    procedure ButtonrestaureClick(Sender: TObject);
    procedure RadioButtonLocClick(Sender: TObject);
    procedure RadioButtonAccessClick(Sender: TObject);
    procedure RichPNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditAdrFermeChange(Sender: TObject);
    procedure EditCmdFermeChange(Sender: TObject);
    procedure EditAdrOuvreChange(Sender: TObject);
    procedure EditCdeOuvreChange(Sender: TObject);
    procedure EditV1FChange(Sender: TObject);
    procedure EditV1OChange(Sender: TObject);
    procedure EditV2FChange(Sender: TObject);
    procedure EditV2OChange(Sender: TObject);
    procedure EditV3FChange(Sender: TObject);
    procedure EditV3OChange(Sender: TObject);
    procedure ButtonNouvAccClick(Sender: TObject);
    procedure ButtonNouvPNClick(Sender: TObject);
    procedure ButtonSupAccClick(Sender: TObject);
    procedure ButtonSupPNClick(Sender: TObject);
    procedure ButtonNouvFeuClick(Sender: TObject);
    procedure ButtonSupFeuClick(Sender: TObject);
    procedure ButtonInsFeuClick(Sender: TObject);
    procedure ButtonNouvAigClick(Sender: TObject);
    procedure BoutSupAigClick(Sender: TObject);
    procedure ButtonAjSupClick(Sender: TObject);
    procedure ButtonRestaureAigClick(Sender: TObject);
    procedure ComboBoxAigChange(Sender: TObject);
    procedure ButtonValLigneClick(Sender: TObject);
    procedure RichBrancheMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonVerifConfigClick(Sender: TObject);
    procedure MemoCarreChange(Sender: TObject);
    procedure CheckInvInitClick(Sender: TObject);
    procedure EditV4FChange(Sender: TObject);
    procedure EditV4OChange(Sender: TObject);
    procedure ComboBoxDDChange(Sender: TObject);
    procedure EditLChange(Sender: TObject);
    procedure CheckBoxFBClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditAdrAigKeyPress(Sender: TObject; var Key: Char);
    procedure EditAdrSigKeyPress(Sender: TObject; var Key: Char);
    procedure EditP3KeyPress(Sender: TObject; var Key: Char);
    procedure EditP4KeyPress(Sender: TObject; var Key: Char);
    procedure EditAigTripleKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_HGKeyPress(Sender: TObject; var Key: Char);
    procedure EditPointe_BGKeyPress(Sender: TObject; var Key: Char);
    procedure EditP1KeyPress(Sender: TObject; var Key: Char);
    procedure EditP2KeyPress(Sender: TObject; var Key: Char);
    procedure EditDevie_HDKeyPress(Sender: TObject; var Key: Char);
    procedure EditDroit_BDKeyPress(Sender: TObject; var Key: Char);
    procedure EditDevieS2KeyPress(Sender: TObject; var Key: Char);
    procedure EditTempo10KeyPress(Sender: TObject; var Key: Char);
    procedure EditDet1KeyPress(Sender: TObject; var Key: Char);
    procedure EditSuiv1KeyPress(Sender: TObject; var Key: Char);
    procedure EditDet2KeyPress(Sender: TObject; var Key: Char);
    procedure EditSuiv2KeyPress(Sender: TObject; var Key: Char);
    procedure EditDet3KeyPress(Sender: TObject; var Key: Char);
    procedure EditSuiv3KeyPress(Sender: TObject; var Key: Char);
    procedure EditDet4KeyPress(Sender: TObject; var Key: Char);
    procedure EditSuiv4KeyPress(Sender: TObject; var Key: Char);
    procedure EditSpecUniKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
// variables du fichier de configuration "config-gl.cfg"
section_init='[section_init]';
nb_det_dist_ch='nb_det_dist';
IpV4_PC_ch='IpV4_PC';
retro_ch='retro';
Init_aig_ch='Init_Aig';
LAY_ch='Lay';
IPV4_INTERFACE_ch='IPV4_INTERFACE';
PROTOCOLE_SERIE_ch='PROTOCOLE_SERIE';
INTER_CAR_ch='INTER_CAR';
Tempo_maxi_ch='Tempo_maxi';
Entete_ch='Entete';
TCO_ch='TCO';
CDM_ch='CDM';
Serveur_interface_ch='Serveur_interface';
fenetre_ch='Fenetre';
Tempo_aig_ch='Tempo_Aig';
NOTIF_VERSION_ch='NOTIF_VERSION';
verif_version_ch='verif_version';
Fonte_ch='Fonte';

// variables de config.cfg
section_aig_ch='[section_aig]';
section_sig_ch='[section_sig]';
section_act_ch='[section_act]';
section_branches_ch='[section_branches]';
Raz_signaux_ch='RazSignaux';

var
  FormConfig: TFormConfig;
  AdresseIPCDM,AdresseIP,PortCom,recuCDM,residuCDM : string;
  portCDM,TempoOctet,TimoutMaxInterface,Valeur_entete,Port,protocole,NumPort,
  LigneCliqueePN,AncLigneCliqueePN,clicMemo,
  ligneclicAig,AncLigneClicAig,ligneClicSig,AncligneClicSig,
  ligneClicBr,AncligneClicBr,ligneClicAct,AncLigneClicAct : integer;
  ack_cdm,clicliste,entreeTCO,affevt,config_modifie : boolean;

function config_com(s : string) : boolean;
function envoi_CDM(s : string) : boolean;
procedure connecte_CDM;
function place_id(s : string) : string;
procedure decodeAig(s : string;var adr : integer;var B : char);
function sauve_config : boolean;
Procedure aff_champs_sig_feux(index : integer);
procedure decode_ligne_feux(chaine_signal : string;i : integer);
function verif_coherence : boolean;
function compile_branche(s : string;i : integer) : boolean;
  
implementation

uses UnitDebug,UnitPrinc, UnitTCO;

{$R *.dfm}

// envoi d'une chaîne à CDM par socket, puis attend l'ack ou le nack
function envoi_CDM(s : string) : boolean;
var temps : integer;
begin
  if SocketCDM_connecte=false then begin envoi_CDM:=false;exit;end;
  //Affiche('Envoi à CDM rail',clRed);Affiche(s,ClGreen);
  if traceTrames then afficheDebug(s,clLime);
  Formprinc.ClientSocketCDM.Socket.SendText(s);
  // attend l'ack
  ackCDM:=false;nackCDM:=false;
  temps:=0;
  repeat
    inc(temps);Sleep(100);
    Application.processMessages;
  until ferme or ackCDM or nackCDM or (temps>30); // CDM répond < 1s

  if not(ackCDM) or nack then
  begin
    Affiche('Pas de réponse de CDM Rail',clRed);
  end;

  envoi_CDM:=ackCDM;
end;

// insère l'id pour le serveur CDM dans une chaîne
function place_id(s : string) : string;
begin
  delete(s,5,2);
  insert(id_cdm,s,5);
  place_id:=s;
end;

procedure Maj_Hint_feu(i : integer);
var s : string;
begin   
  s:='@='+inttostr(feux[i].Adresse)+' Decodeur='+intToSTR(feux[i].Decodeur)+' Adresse détecteur associé='+intToSTR(feux[i].Adr_det1)+
       ' Adresse élement suivant='+intToSTR(feux[i].Adr_el_suiv1);
  if feux[i].Btype_suiv1=2 then s:=s+' (aig)';  
  feux[i].Img.Hint:=s;
end;  

// demande les services Com-IP à CDM
function services_CDM : boolean;
var s,ss : string;
    i : integer;
begin
  //s:=place_id('C-C-00-0002-RQSERV-RTSIM|030|03|SRV=ATNT;SRV=ADET;SRV=AACT;');
  s:=place_id('C-C-00-0002-RQSERV-RTSIM|xxx|xx|');
  i:=0;
  if Srvc_Aig then begin s:=s+'SRV=ATNT;';inc(i);end;
  if Srvc_Act then begin s:=s+'SRV=AACT;';inc(i);end;
  if Srvc_Det then begin s:=s+'SRV=ADET;';inc(i);end;
  if Srvc_PosTrain then  begin s:=s+'SRV=TSXY;';inc(i);end ;
  if Srvc_Sig then begin s:=s+'SRV=ASIG;';inc(i);end;

  // insère le nombre de paramètres
  ss:=format('%.*d',[2,i]) ;
  delete(s,30,2);
  insert(ss,s,30);
  // insère la longueur des paramètres
  i:=length(s)-29;
  ss:=format('%.*d',[3,i]) ;
  delete(s,26,3);
  insert(ss,s,26);

  envoi_CDM(s);
  sleep(100);

  if ack_cdm then
  begin
    s:='Services acceptés: ';
    if Srvc_Aig then s:=s+'- aiguillages ';
    if Srvc_Act then s:=s+'- actionneurs ';
    if Srvc_Det then s:=s+'- détecteurs ';
    if Srvc_PosTrain then s:=s+'- position des trains ';
    if Srvc_sig then s:=s+'- état des signaux ';
    Affiche(s,clYellow);
  end;
  services_CDM:=ack_cdm;
  ack_cdm:=false;
end;

procedure connecte_CDM;
var s : string;
    i : integer;
begin
  // déconnexion de l'ancienne liaison éventuelle
  Formprinc.ClientSocketCDM.Close;
 
  if AdresseIPCDM<>'0' then
  begin
    // ouverture du socket CDM
    with Formprinc do
    begin
      ClientSocketCDM.port:=portCDM;
      ClientSocketCDM.Address:=AdresseIPCDM;
      ClientSocketCDM.Open;
    end;
    i:=0;
    repeat
      Sleep(50);
      inc(i);
      Application.processMessages;
    until (i>10) or SocketCDM_connecte  ;
    //if i>10 then affiche('Timeout',clred);
    if not(SocketCDM_connecte) then begin Affiche('Socket CDM non connecté',clOrange);exit;end;

    // connexion à CDM rail
    recuCDM:='';
    s:='C-C-00-0001-CMDGEN-_CNCT|000|';
    envoi_cdm(s);
    if ack_cdm then
    begin
      ack_cdm:=false;
      Id_CDM:=copy(recuCDM,5,2);   // récupère l'ID reçu de CDM, à utiliser dans toutes les futures trames
      recucdm:='';
      s:='Connecté au serveur CDM rail avec l''ID='+Id_CDM;

      Affiche(s,clYellow);
      AfficheDebug(s,clyellow);
      CDM_connecte:=true;

      // demande des services
      services_CDM;

      // demande les trains
      s:=place_id('C-C-01-0002-DSCTRN-DLOAD|000|');
      envoi_CDM(s);
    end;
  end
  else
  begin
    Affiche('La connexion à CDM n''est pas demandée car l''adresse IP est nulle dans config.cfg',cyan);
  end;
end;

// teste si une adresse IP V4 est ok
function Ipok(s : string) : boolean;
var i,k,octet,erreur : integer;
begin
  for k:=1 to 3 do
  begin
    i:=pos('.',s);
    if i=0 then begin IpOK:=false;exit;end;
    val(copy(s,1,i-1),octet,erreur);if (erreur<>0) or (octet>255) then begin IpOK:=false;exit;end;
    delete(s,1,i);
  end;
  val(s,octet,erreur);if (erreur<>0) or (octet>255) then begin IpOK:=false;exit;end;
  ipOK:=true;
end;

// vérifie si la config de la com série/usb est ok
function config_com(s : string) : boolean;
var sa : string;
    i,erreur : integer;
begin
  sa:=s;
  protocole:=-1;
  // supprimer la dernier paramètre
  i:=pos(',',s);
  if i<>0 then
  begin
    delete(s,1,i);
    i:=pos(',',s);
    if i<>0 then
    begin
      delete(s,1,i);
      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,1,i);
        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,1,i);
          Val(s,protocole,erreur);
        end;
      end;
    end;
  end;

  i:=pos(':',sa);
  val(copy(sa,4,i-1),Numport,erreur);
  config_com:=not( (copy(sa,1,3)<>'COM') or (NumPort>9) or (protocole=-1) or (protocole>4) or (i=0) );
end;

// transforme l'aiguillage du tableau init aiguillage en texte 
function encode_init_aig(index : integer) : string;
var s : string;
begin
  if index=0 then exit;
  s:=IntToSTR(aiguillage[index].Adresse)+','; 
  s:=s+IntToSTR(aiguillage[index].posInit)+',';
  s:=s+IntToSTR(aiguillage[index].temps)+',';
  s:=s+intToSTR(aiguillage[index].inversion);
  encode_init_aig:=s;
end;

// transforme l'aiguillage du tableau aiguillage en texte
function encode_aig(index : integer): string;
var s : string;
    c : char;
    tjd,tjs,tri : boolean;
begin
   if index=0 then exit;
   s:=IntToSTR(aiguillage[index].Adresse);
   tjd:=aiguillage[index].modele=2;
   tjs:=aiguillage[index].modele=3;
   tri:=aiguillage[index].modele=4;
   if tjd then s:=s+'TJD';
   if tjs then s:=s+'TJS';
   if tri then begin s:=s+'TRI,';s:=s+intToSTR(aiguillage[index].AdrTriple);end;
   s:=s+',';
   // aiguillage normal ou triple
   if not(tjd) and not(tjs) then
   begin
     // P
     s:=s+'P';s:=s+intToSTR(aiguillage[index].Apointe);
     c:=aiguillage[index].APointeB ;
     if (c<>'Z') and (c<>#0) then s:=s+c;
     //if c=#0 then s:=s+'Z';
     // D
     s:=s+',D';s:=s+intToSTR(aiguillage[index].Adroit);
     c:=aiguillage[index].ADroitB ;
     if (c<>'Z') and (c<>#0) then s:=s+c;
     //if c=#0 then s:=s+'Z';
     // S
     s:=s+',S';s:=s+intToSTR(aiguillage[index].Adevie);
     c:=aiguillage[index].AdevieB ;
     if (c<>'Z') and (c<>#0) then s:=s+c;
     //if c=#0 then s:=s+'Z';
     // S2 aiguillage triple
     if tri then
     begin
       s:=s+',S2-';
       s:=s+intToSTR(aiguillage[index].Adevie2);
       c:=aiguillage[index].Adevie2B ;
       if (c<>'Z') and (c<>#0) then s:=s+c;
       //if c=#0 then s:=s+'Z';
     end;
   end;

   // tjd / s
   if tjd or tjs then
   begin
     s:=s+'D('+intToSTR(aiguillage[index].Adroit);
     c:=aiguillage[index].AdroitB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDroit)+aiguillage[index].DDroitB+'),';
     s:=s+'S('+intToSTR(aiguillage[index].Adevie);
     c:=aiguillage[index].AdevieB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDevie)+aiguillage[index].DDevieB+')';
   end;

   if tjs then
   begin
     s:=s+',L'+intToSTR(aiguillage[index].Tjsint)+aiguillage[index].TjsintB;
   end;

   // vitesse de franchissement et inversion
   if aiguillage[index].vitesse=0 then s:=s+',V0';
   if aiguillage[index].vitesse=30 then s:=s+',V30';
   if aiguillage[index].vitesse=60 then s:=s+',V60';
   if aiguillage[index].inversionCDM=1 then s:=s+',I1' else s:=s+',I0';
   
   // valeur d'initialisation
   s:=s+',INIT(';
   s:=s+IntToSTR(aiguillage[index].posInit)+',';
   s:=s+IntToSTR(aiguillage[index].temps)+',';
   s:=s+intToSTR(aiguillage[index].inversion)+')';
   
   encode_aig:=s;
end;

// transforme l'aiguillage des champs graphiques en texte
function encode_aig_gfx : string;
var s,ss : string;
    c : char;
    tjd,tjs,tri : boolean;
    modele,erreur,i : integer;
begin
   val(formconfig.EditAdrAig.text,i,erreur);
   s:=intToSTR(i);
   modele:=Formconfig.comboBoxAig.ItemIndex;  
   tjd:=modele=1;
   tjs:=modele=2;
   tri:=modele=3;
   
   if tjd then s:=s+'TJD';
   if tjs then s:=s+'TJS';
   if tri then begin s:=s+'TRI,';val(formconfig.editAigTriple.text,i,erreur);s:=s+intToSTR(i);end;

   s:=s+',';
   if not(tjd) then
   with formconfig do
   begin
     // P
     s:=s+'P';
     ss:=EditPointe_BG.Text;
     val(ss,i,erreur);s:=s+intToSTR(i);
     if erreur<>0 then c:=ss[erreur] ;
     if (c<>'Z') and (c<>#0) then s:=s+c;
     // D
     s:=s+',D';
     ss:=EditDroit_BD.Text;
     val(ss,i,erreur);s:=s+intToSTR(i);
     if erreur<>0 then c:=ss[erreur] ;
     if (c<>'Z') and (c<>#0) then s:=s+c;
     // S
     s:=s+',S';
     ss:=EditDevie_HD.Text;
     val(ss,i,erreur);s:=s+intToSTR(i);
     if erreur<>0 then c:=ss[erreur] ;
     if (c<>'Z') and (c<>#0) then s:=s+c;
     
     // S2 aiguillage triple
     if tri then
     begin
       s:=s+',S2-';
       ss:=EditDevieS2.Text;
       val(ss,i,erreur);s:=s+intToSTR(i);
       if erreur<>0 then c:=ss[erreur] ;
       if (c<>'Z') and (c<>#0) then s:=s+c;
     end;

     // vitesse de franchissement
     if radioButtonSans.Checked then s:=s+',V0';
     if radioButton30kmh.Checked then s:=s+',V30';
     if radioButton60kmh.Checked then s:=s+',V60';
     if checkinverse.Checked then s:=s+',I1' else s:=s+',I0';
   end

   else
   // tjd
   begin          
     with formconfig do
     begin
       s:=s+'D(';
       ss:=Edit_HG.Text;
       val(ss,i,erreur);s:=s+intToSTR(i);
       if erreur<>0 then c:=ss[erreur] ;
       if (c<>'Z') and (c<>#0) then s:=s+c;

       s:=s+',';
       ss:=EditP1.Text;
       val(ss,i,erreur);s:=s+intToSTR(i);
       if erreur<>0 then c:=ss[erreur] ;
       if (c<>'Z') and (c<>#0) then s:=s+c;
       s:=s+'),';

       s:=s+',S(';
       ss:=EditPointe_BG.Text;
       val(ss,i,erreur);s:=s+intToSTR(i);
       if erreur<>0 then c:=ss[erreur] ;
       if (c<>'Z') and (c<>#0) then s:=s+c;

       s:=s+',';
       ss:=EditP2.Text;
       val(ss,i,erreur);s:=s+intToSTR(i);
       if erreur<>0 then c:=ss[erreur] ;
       if (c<>'Z') and (c<>#0) then s:=s+c;
       s:=s+'),';
       
       s:=s+'I';
       if checkInverse.Checked then s:=s+'1' else s:=s+'0';
       
     end;  
   end;
   encode_aig_gfx:=s;
end;

function TypeEl_to_char(i : integer) : string;
begin
  case i of  // 1=détecteur 2=aig ou TJD ou TJS  4=tri
  1 : TypeEl_to_char:='';
  2,3,4 : TypeEl_to_char:='A';
  end;
end;

// transforme le signal du tableau feux[] en texte 
function encode_sig_feux(i : integer): string;
var s : string;
    adresse,aspect,j,k,NfeuxDir,CondCarre,nc : integer;
begin
  // adresse
  adresse:=feux[i].adresse;
  if affevt then Affiche('Encode_sig_feux('+IntToSTR(i)+') : adresse='+IntToSTR(adresse),clyellow);
  
  if adresse=0 then begin encode_sig_feux:='';exit;end;

  s:=IntToSTR(adresse)+',';
  // forme - D=directionnel ajouter 10
  aspect:=feux[i].aspect;
  if aspect<10 then s:=s+IntToSTR(aspect)+',' else s:=s+'D'+intToSTR(aspect-10)+',';

  // bouton feu blanc, n'existe pas pour un feu directionnel (aspect>10)
  if aspect<10 then begin if feux[i].feublanc then s:=s+'1,' else s:=s+'0,';end;

  // décodeur
  s:=s+IntToSTR(feux[i].decodeur)+',';

  // detecteur et élement suivant (4 maxi)
  if aspect<10 then
  begin
    s:=s+'('+IntToSTR(feux[i].Adr_det1)+','+TypeEl_To_char(feux[i].Btype_suiv1)+IntToSTR(feux[i].Adr_el_suiv1);
    j:=feux[i].Adr_det2;
    if j<>0 then s:=s+','+IntToSTR(feux[i].Adr_det2)+','+TypeEl_To_char(feux[i].Btype_suiv2)+IntToSTR(feux[i].Adr_el_suiv2);
    j:=feux[i].Adr_det3;
    if j<>0 then s:=s+','+IntToSTR(feux[i].Adr_det3)+','+TypeEl_To_char(feux[i].Btype_suiv3)+IntToSTR(feux[i].Adr_el_suiv3);
    j:=feux[i].Adr_det4;
    if j<>0 then s:=s+','+IntToSTR(feux[i].Adr_det4)+','+TypeEl_To_char(feux[i].Btype_suiv4)+IntToSTR(feux[i].Adr_el_suiv4);
    s:=s+'),';
  end
  else
  // feux directionnels
  begin
    NfeuxDir:=aspect-10;
    for j:=1 to NfeuxDir+1 do
    begin
      s:=s+'(';
      for k:=1 to Length(feux[i].AigDirection[j])-1 do
      begin
        s:=s+'A'+IntToSTR(feux[i].AigDirection[j][k].adresse) + feux[i].AigDirection[j][k].posaig;
        if k<Length(feux[i].AigDirection[j])-1 then s:=s+',';
      end;
      s:=s+')';
    end;
  end;

  //verrouillage au carré
  if aspect<10 then
  begin
    if feux[i].verrouCarre then s:=s+'1' else s:=s+'0';
    // si unsemaf, paramètre supplémentaire
    if feux[i].decodeur=6 then s:=s+','+intToSTR(feux[i].unisemaf);
  end;

  // conditions supplémentaires pour le carré
  if aspect<10 then
  begin                
   for nc:=1 to 6 do
   begin
     CondCarre:=Length(feux[i].condcarre[nc]);  // nombre de conditions (nombre de parenthèses ex 3 pour (A21S,A6D)(A30S,A20D)(A1D,A2S,A3D)
     if condCarre<>0 then dec(condcarre);
     if condCarre<>0 then
     begin
        s:=s+',(';
        for k:=1 to condcarre do
        begin
          s:=s+'A'+IntToSTR(feux[i].condcarre[nc][k].Adresse)+feux[i].condcarre[nc][k].PosAig;
          if k<condcarre then s:=s+',';
        end;
        s:=s+')';
      end;
    end;  
  end;
  encode_sig_feux:=s;
end;

// décode la ligne de signal et la stocke dans l'index du tableau feux
procedure decode_ligne_feux(chaine_signal : string;i : integer);
var s,chaine,sa : string;
    j,k,l,t,adresse,adr,erreur ,asp,bd: integer;
    c : char;
    multiple,fini : boolean;
begin
      s:=chaine_signal;
      j:=pos(',',s);
      if j>1 then
      begin
        // adresse de feu
        val(s,adresse,erreur);
        if adresse=0 then begin affiche('Erreur ligne '+s,clred);exit;end;
        Delete(s,1,j);
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
            val(sa,l,erreur); // nombre de feux du signal directionnel
            if l>6 then
            begin
              Affiche('Ligne '+s+' 6 feux maximum pour un panneau directionnel',clred);
              exit;
            end;
            feux[i].aspect:=l+10;Delete(s,1,j);
            // décodeur
            val(s,adr,erreur);
            Feux[i].decodeur:=adr;
            j:=pos(',',s);Delete(s,1,j);
            // liste des aiguillages
            k:=1; // numéro de feu directionnel
            repeat
              // boucle de direction
              delete(s,1,1); // supprimer ( ou le ,
              j:=1; // Nombre de descriptions d'aiguillages dans le feu
              repeat
                if s[1]<>'A' then begin Affiche('Erreur a la ligne '+s,clred);exit;end;
                delete(s,1,1);
                val(s,adr,erreur);  // adresse
                c:=s[erreur];       // type
                setlength(feux[i].AigDirection[k],j+1);  // augmenter le tableau dynamique
                feux[i].AigDirection[k][j].PosAig:=c;
                feux[i].AigDirection[k][j].Adresse:=adr;

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
              Affiche('Ligne '+chaine_signal,clred);
              Affiche('Nombre incorrect de description des aiguillages: '+intToSTR(k)+' pour '+intToSTR(l)+' feux directionnels',clred);
            end;
          end
          else
          // feu de signalisation---------------------------------
          begin
            val(sa,asp,erreur);  //aspect
            feux[i].aspect:=asp;Delete(s,1,j);
            if (asp=0) or (asp=6) or (asp>9) then
            Affiche('Fichier config.cfg: configuration aspect ('+intToSTR(asp)+') feu incorrecte à la ligne '+chaine_signal,clRed);
            j:=pos(',',s);
            if j>1 then begin Feux[i].FeuBlanc:=(copy(s,1,j-1))='1';delete(s,1,j);end;
            j:=pos(',',s);
            val(s,Feux[i].decodeur,erreur);
            if j<>0 then delete(s,1,j);
            feux[i].Adr_el_suiv1:=0;feux[i].Adr_el_suiv2:=0;feux[i].Adr_el_suiv3:=0;feux[i].Adr_el_suiv4:=0;
            feux[i].Btype_Suiv1:=0;feux[i].Btype_Suiv2:=0;feux[i].Btype_Suiv3:=0;feux[i].Btype_Suiv4:=0;
            feux[i].Adr_det1:=0;feux[i].Adr_det2:=0;feux[i].Adr_det3:=0;feux[i].Adr_det4:=0;
            // éléments optionnels des voies supplémentaires
            if j<>0 then
            begin
              //Affiche('Entrée:s='+s,clyellow);
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
                 //Affiche('S avec premier champ supprimé='+s,clyellow);
                 inc(j);
                 if (j=1) then feux[i].Adr_det1:=adr;
                 if (j=2) then feux[i].Adr_det2:=adr;
                 if (j=3) then feux[i].Adr_det3:=adr;
                 if (j=4) then feux[i].Adr_det4:=adr;
                 //type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri 
                 t:=0;
                 if s[1]='A' then
                 begin
                   t:=2;
                   //Affiche('détecté aiguillage',clyellow);
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
                   //Affiche('détecté aiguillage tri',clyellow);
                   if (j=1) then feux[i].Btype_Suiv1:=4;
                   if (j=2) then feux[i].Btype_Suiv2:=4;
                   if (j=3) then feux[i].Btype_Suiv3:=4;
                   if (j=4) then feux[i].Btype_Suiv4:=4;
                 end;

                 if t=0 then //détecteur
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
          if (j>4) or (not(multiple)) then begin Affiche('Erreur: fichier de configuration ligne erronnée : '+chaine_signal,clred); closefile(fichier);exit;end;

          k:=pos(',',s);
          delete(s,1,k);
          //Affiche('s='+s,clyellow);
          feux[i].VerrouCarre:=s[1]='1';
          delete(s,1,1);
          // si décodeur UniSemaf (6) champ supplémentaire
          if Feux[i].decodeur=6 then
          begin
             k:=pos(',',s);
             if k=0 then begin Affiche('Ligne '+chaine_signal,clred);Affiche('Manque définition de la cible pour le décodeur UniSemaf',clred);end
             else
             begin
               Delete(S,1,k);
               Val(s,k,erreur);
               Feux[i].UniSemaf:=k;
               erreur:=verif_UniSemaf(i,k);
               if erreur=1 then begin Affiche('Ligne '+chaine_signal,clred);Affiche('Erreur code Unisemaf',clred);end;
               if erreur=2 then 
               begin 
                 Affiche('Ligne '+chaine_signal,clred);Affiche('Erreur cohérence aspect signal ('+intToSTR(asp)+') et code Unisemaf ('+intToSTR(k)+')',clred);
               end;
               
             end;
            end;
          end;
          // voir si conditions supplémentaires de carré
          l:=1;  // nombre de parenthèses
          repeat
            t:=pos('(',s);
            if t<>0 then 
            begin
              //Affiche('Conditions supplémentaires pour le feu '+IntToSTR(adresse)+' parenthèse '+intToSTR(l),clyellow);
              k:=pos(')',s);
              sa:=copy(s,t+1,k-t-1); // contient l'intérieur des parenthèses sans les parenthèses
              //Affiche(sa,clLime);
              delete(s,1,k);//Affiche(s,clYellow);
              // boucle dans la parenthèse
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
                  Affiche('Définition du feu '+IntToSTR(feux[i].adresse)+': Manque D ou S dans les conditions de carré des aiguillages',clred);
                end;
                                 
                k:=pos(',',sa);if k<>0 then delete(sa,1,k);
                //Affiche(sa,clyellow); 
              until k=0;
              inc(l);
            end;
          until t=0;  
        end;
      end;
end;

// transforme l'actionneur type loco ou actionneur du tableau en texte
// paramètre d'entrée : index
function encode_act_loc(i : integer): string;
var s : string;
    adresse : integer;
begin
  // adresse
  adresse:=Tablo_Actionneur[i].actionneur;
  if Tablo_Actionneur[i].loco then
    s:=IntToSTR(adresse)+','+IntToSTR(Tablo_Actionneur[i].Etat)+','+Tablo_Actionneur[i].train+',F'+IntToSTR(Tablo_Actionneur[i].fonction)+','+intToSTR(Tablo_Actionneur[i].tempo);
  if Tablo_Actionneur[i].act then
  begin
    s:=IntToSTR(adresse)+','+IntToSTR(Tablo_Actionneur[i].Etat)+','+Tablo_Actionneur[i].train+
       ',A'+IntToSTR(Tablo_Actionneur[i].accessoire)+','+intToSTR(Tablo_Actionneur[i].sortie)+',';
    if Tablo_Actionneur[i].Raz then s:=s+'Z' else s:=s+'S';
  end;     
  encode_act_loc:=s; 
end;

// encode l'actioneur PN du tableau en texte
function encode_act_pn(i : integer) : string;
var s : string;
    voie,NbVoies : integer;
begin
  with formconfig do
  begin
    NbVoies:=Tablo_PN[i].NbVoies;
    s:='';
    for voie:=1 to NbVoies do
    begin                                    
      s:=s+'('+intToSTR(tablo_PN[i].Voie[voie].ActFerme)+','+intToSTR(tablo_PN[i].Voie[voie].ActOuvre)+')';
      if voie<NbVoies then s:=s+',';
    end;
    s:=s+',PN('+IntToSTR(tablo_PN[i].AdresseFerme);
       if tablo_PN[i].commandeFerme=2 then s:=s+'+,' else s:=s+'-,';
    s:=s+IntToSTR(tablo_PN[i].AdresseOuvre);
       if tablo_PN[i].commandeOuvre=2 then s:=s+'+)' else s:=s+'-)';
  end;  
  encode_act_pn:=s;
end;

// modifie les fichiers de config en fonction du paramétrage
procedure genere_config;
var s: string;
    fichier,fichierN : text;
    i : integer;
    continue : boolean;
    
    // lit une ligne du fichier source "fichier", si c'est une ligne de commentaire, copie jusqu'à ne plus rencontrer
    // de ligne commentaire, et retourne la ligne en sortie
    function copie_commentaire : string  ;
    var c : char;
    begin
      repeat
        readln(fichier,s);
        //Affiche(s,clWhite);
        if length(s)>0 then c:=s[1];
        if c='/' then writeln(fichierN,s);  // copie le commentaire
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      copie_commentaire:=s;
    end;
    
begin
  try
    assign(fichier,'client-GL.cfg');
    reset(fichier);
  except
    Affiche('Fichier client-gl.cfg non trouvé',clred);
    exit;
  end;

  assign(fichierN,'client-GL.tmp');
  rewrite(fichierN);

  // entête
  copie_commentaire;
  // taille de la fonte
  writeln(fichierN,Fonte_ch+'=',TailleFonte);
  FormPrinc.FenRich.Font.Size:=TailleFonte;  
  copie_commentaire;

  // adresse ip et port de CDM
  writeln(fichierN,IpV4_PC_ch+'=',adresseIPCDM+':'+intToSTR(portCDM));
  copie_commentaire;

  // adresse ip interface XpressNet
  writeln(fichierN,IPV4_Interface_ch+'=',adresseIP+':'+intToSTR(port));
  copie_commentaire;

  // port com
  writeln(fichierN,Protocole_serie_ch+'=',portcom);
  copie_commentaire;

  // temporisation caractère TempoOctet
  writeln(fichierN,Inter_Car_ch+'=',IntToSTR(TempoOctet));
  copie_commentaire;

  // temporisation attente maximale interface
  writeln(fichierN,Tempo_maxi_ch+'=',IntToSTR(TimoutMaxInterface));
  copie_commentaire;

  // entete Valeur_entete
  writeln(fichierN,Entete_ch+'=',intToSTR(Valeur_entete));
  copie_commentaire;

  // avec ou sans initialisation des aiguillages
  if AvecInitAiguillages then s:='1' else s:='0';
  writeln(fichierN,Init_Aig_ch+'='+s);
  copie_commentaire;

  // temporisation initialisation des aiguillages
  writeln(fichierN,Tempo_aig_ch+'=',IntToSTR(Tempo_aig));
  copie_commentaire;

  // plein écran
  writeln(fichierN,Fenetre_ch+'=',fenetre);
  copie_commentaire;

  // Nombre maxi de détecteurs considérés distants
  writeln(fichierN,nb_det_dist_ch+'=',Nb_Det_Dist);
  copie_commentaire;

  // Vérification des versions au démarrage
  if verifVersion then s:='1' else s:='0';
  writeln(fichierN,verif_version_ch+'=',s);
  copie_commentaire;

  // Notification de nouvelle version
  if notificationVersion then s:='1' else s:='0';
  writeln(fichierN,notif_version_ch+'=',s);
  copie_commentaire;

  // Avec TCO
  if AvecTCO then s:='1' else s:='0';
  writeln(fichierN,TCO_ch+'=',s);
  copie_commentaire;

  // lancement de CDM
  if LanceCDM then s:='1' else s:='0';
  writeln(fichierN,CDM_ch+'=',s);
  copie_commentaire;

  // Nom du LAY
  writeln(fichierN,lay_ch+'=',Lay);
  copie_commentaire;

  // Serveur d'interface de CDM
  writeln(fichierN,Serveur_interface_ch+'=',intToSTR(ServeurInterfaceCDM));
  copie_commentaire;

  // Serveur de rétrosignalisation Lenz de CDM
  writeln(fichierN,retro_ch+'=',intToSTR(ServeurRetroCDM));

  // [section init] est copié ici
  // valeurs des initialisations aiguillages
  // n'est plus géré dans config-gl.cfg
  {writeln(fichierN,section_init);
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_init_aig(i);  
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0,0,0,0');
  }
  closefile(fichierN); // config-gl.tmp
  closefile(fichier);  // config-gl.cfg

  // ----------------config.cfg ----------------------------
  try
    assign(fichier,'config.cfg');
    reset(fichier);
  except
    Affiche('Fichier config.cfg non trouvé',clred);
    exit;
  end;

  assign(fichierN,'config.tmp');
  rewrite(fichierN);

  // entête
  copie_commentaire;
   // Raz Signaux
  if Raz_Acc_signaux then s:='1' else s:='0';
  writeln(fichierN,'RazSignaux='+s);
  //copie_commentaire;

  // aiguillages
  writeln(fichierN,section_aig_ch);
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_aig(i);       
    aiguillage[i].modifie:=false;       // sauvegarde en cours, on démarque 
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,section_Branches_ch);
  // branches
  for i:=1 to NbreBranches do
  begin
    s:=Branche[i];
    writeln(fichierN,s);
  end;  
  writeln(fichierN,'0');
  
  writeln(fichierN,section_sig_ch);
  // et les feux
  for i:=1 to NbreFeux do
  begin
    s:=encode_sig_feux(i);
    // transformer le tableau feux en ligne
    //Affiche(s,clLime);
    if s='' then Affiche('Erreur 700 - Encodage du feu index='+IntToSTR(i),clRed);
    feux[i].modifie:=false;       // sauvegarde en cours, on démarque 
    writeln(fichierN,s);
    // supprime le graphisme des feux
    Feux[i].Img.free;                
    Feux[i].Lbl.free;                
    if feux[i].feublanc then begin Feux[i].Check.free;Feux[i].Check:=nil;end;
    // et le recréer
    cree_image(i);
  end;
  writeln(fichierN,'0');

  //copie_commentaire;
  // Fonctions Fx 
  // actionneurs Train ou accessoire
  writeln(fichierN,section_act_ch);
  for i:=1 to maxTablo_act do
  begin
    s:=encode_act_loc(i);
    if s<>'' then writeln(fichierN,s);
  end;  
  
  // actionneurs PN
  for i:=1 to NbrePN do
  begin
    s:=encode_act_pn(i);
    if s<>'' then if s<>'' then writeln(fichierN,s);
  end;  
  writeln(fichierN,'0');

  closefile(fichier);
  closefile(fichierN);
  
  deletefile('config.cfg');
  deletefile('client-GL.cfg');

  renameFile('config.tmp','config.cfg');
  renameFile('client-GL.tmp','client-GL.cfg');
end;

// sauvegarder la config dans les fichiers cfg
function Sauve_config : boolean;
var i,erreur : integer;
    s : string;
    ChangeCDM,changeInterface,changeUSB,change_srv : boolean;
begin
  // Vérification de la configuration-------------------------------------------
  // contrôle adresse IP CDM
  with FormConfig do
  begin
    s:=EditAdrIPCDM.text;
    if not(IpOk(s)) then begin labelInfo.Caption:='Adresse IP CDM rail incorrecte';sauve_config:=false;exit;end;
    ChangeCDM:=s<>AdresseIPCDM;
    adresseIPCDM:=s;

    // contrôle port CDM
    val(EditPortCDM.Text,i,erreur);
    if i>65535 then begin labelInfo.Caption:='Port CDM rail incorrect';sauve_config:=false;exit;end;
    changeCDM:=(portCDM<>i) or ChangeCDM;
    portCDM:=i;

    // taille fonte
    val(EditFonte.text,i,erreur);
    if (i<8) or (i>25) then i:=10;
    TailleFonte:=i;
    
    // contrôle adresse IP interface
    s:=EditIPLenz.text;
    if not(IpOk(s)) and (s<>'0') then begin labelInfo.Caption:='Adresse IP Lenz incorrecte';sauve_config:=false;exit;end;
    changeInterface:=s<>AdresseIP;
    AdresseIP:=s;

    // contrôle port interface
    val(EditPortLenz.Text,i,erreur);
    if i>65535 then begin labelInfo.Caption:='Port Interface incorrect';sauve_config:=false;exit;end;
    changeInterface:=changeInterface or (i<>port);
    port:=i;

    Val(editTempoAig.Text,i,erreur);
    if i>3000 then begin labelInfo.Caption:='Temporisation de séquencement incorrecte ';sauve_config:=false;exit;end;
    Tempo_Aig:=i;
  
    // contrôle protocole interface  COM3:57600,N,8,1,2
    s:=EditComUSB.Text;
    if not(config_com(s)) then begin labelInfo.Caption:='Protocole série USB Interface incorrect';sauve_config:=false;exit;end;
    changeUSB:=portcom<>s;
    portcom:=s;
  
    val(EditTempoOctetUSB.text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation octet incorrecte';sauve_config:=false;exit;end; 
    TempoOctet:=i;
  
    val(EditTempoReponse.text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation de réponse interface';sauve_config:=false;exit;end; 
    TimoutMaxInterface:=i;

    val(EditNbDetDist.text,i,erreur);
    if (erreur<>0) or (i<3) then begin labelInfo.Caption:='Valeur nombre de détecteurs trop distants incorrecte';sauve_config:=false;exit;end; 
    Nb_Det_Dist:=i;

    if RadioButton1.checked then Valeur_entete:=0;
    if RadioButton2.checked then Valeur_entete:=1;
    if RadioButton3.checked then Valeur_entete:=2;
    case Valeur_entete of
     0 : begin entete:='';suffixe:='';end;
     1 : begin entete:=#$FF+#$FE;suffixe:='';end;
     2 : begin entete:=#228;suffixe:=#13+#13+#10;end;
    end;

    if changeCDM then connecte_CDM;
    if changeInterface then 
    begin
      if AdresseIP<>'0' then
      begin
        Affiche('demande connexion à la centrale Lenz par Ethernet',clyellow);
        With Formprinc do
        begin
          ClientSocketLenz.port:=port;
          ClientSocketLenz.Address:=AdresseIP;
          ClientSocketLenz.Open;
        end;  
      end
    end;

    if changeUSB then 
    begin
      deconnecte_USB;
      connecte_USB;
    end;

    verifVersion:=CheckVerifVersion.Checked;
    notificationVersion:=CheckInfoVersion.Checked;

    LanceCDM:=CheckLanceCDM.Checked;
    if CheckFenEt.checked then fenetre:=1 else fenetre:=0;
    
    AvecTCO:=CheckAvecTCO.checked;
    Lay:=EditNomLay.Text;
    if RadioButton4.Checked then ServeurInterfaceCDM:=0;
    if RadioButton5.Checked then ServeurInterfaceCDM:=1;
    if RadioButton6.Checked then ServeurInterfaceCDM:=2;
    if RadioButton7.Checked then ServeurInterfaceCDM:=3;
    if RadioButton8.Checked then ServeurInterfaceCDM:=4;
    if RadioButton9.Checked then ServeurInterfaceCDM:=5;
    if RadioButton10.Checked then ServeurInterfaceCDM:=6;
    if RadioButton11.Checked then ServeurInterfaceCDM:=7;
    if RadioButton12.Checked then ServeurInterfaceCDM:=8;
    if RadioButton12.Checked then ServeurInterfaceCDM:=13;
    if RadioButton13.Checked then ServeurRetroCDM:=1;
    if RadioButton14.Checked then ServeurRetroCDM:=2;
    if RadioButton15.Checked then ServeurRetroCDM:=3;
    if RadioButton16.Checked then ServeurRetroCDM:=4;
    if RadioButton17.Checked then ServeurRetroCDM:=5;
    if RadioButton18.Checked then ServeurRetroCDM:=6;

    // changement sur les services CDM 
    change_srv:=Srvc_Aig<>CheckBoxServAig.checked;
    change_srv:=Srvc_Det<>CheckBoxServDet.checked or change_srv;
    change_srv:=Srvc_Act<>CheckBoxServAct.checked or change_srv;
    change_srv:=Srvc_PosTrain<>CheckServPosTrains.checked or change_srv;
    change_srv:=Srvc_Sig<>CheckBoxSrvSig.checked or change_srv;
  
    Srvc_Aig:=CheckBoxServAig.checked;
    Srvc_Det:=CheckBoxServDet.checked;
    Srvc_Act:=CheckBoxServAct.checked;
    Srvc_PosTrain:=CheckServPosTrains.checked;
    Srvc_Sig:=CheckBoxSrvSig.checked;
    Raz_Acc_signaux:=CheckBoxRazSignaux.checked;
    AvecInitAiguillages:=CheckBoxInitAig.Checked;
  end;
  if change_srv then services_CDM;

  // générer le fichiers config.cfg et clieng-GL.cfg
  genere_config;
  Affiche('Configuration sauvegardée dans les fichiers',clLime);
  config_modifie:=false;
  sauve_config:=true;
end;

procedure TFormConfig.ButtonAppliquerEtFermerClick(Sender: TObject);
begin
  if sauve_config then formConfig.close;  // si la config est ok, on ferme la fenetre
  // TCO
  if avectco and not(entreeTCO) then
  begin
    //créée la fenêtre TCO non modale
    FormTCO:=TformTCO.Create(nil);
    FormTCO.show;
    FormPrinc.ButtonAffTCO.Visible:=true;
  end;
end;

procedure TFormConfig.FormActivate(Sender: TObject);
var i :integer;
    s : string;
begin
  if affevt then affiche('FormConfig activate',clLime);
  Aig_supprime.Adresse:=0;
  Feu_Supprime.Adresse:=0;
  Feu_sauve.adresse:=0;
  
  clicListe:=false;
  Edit_HG.Visible:=false;
  labelHG.Visible:=false;
  EditP1.Visible:=false;
  EditP2.Visible:=false;
  EditP3.Visible:=false;
  EditP4.Visible:=false;
  LabelTJD1.Visible:=false;
  LabelTJD2.Visible:=false;
  EditDevieS2.Visible:=false;
  Label18.Visible:=false;
  GroupBoxPN.Visible:=false;
  GroupBoxAct.Visible:=false;
  GroupBoxRadio.Visible:=false;

  EditP1.ReadOnly:=false;
  EditP2.ReadOnly:=false;
  EditP3.ReadOnly:=false;
  EditP4.ReadOnly:=false;
  EditPointe_BG.ReadOnly:=false;
  EditDevie_HD.ReadOnly:=false;
  EditDroit_BD.ReadOnly:=false;
  Edit_HG.ReadOnly:=false;
  
  EditNbDetDist.text:=IntToSTR(Nb_Det_dist);
  EditAdrIPCDM.text:=adresseIPCDM;
  EditPortCDM.Text:=IntToSTR(portCDM);
  EditIPLenz.text:=AdresseIP;
  EditportLenz.text:=IntToSTR(Port);
  EditTempoAig.Text:=IntToSTR(Tempo_Aig);
  EditComUSB.Text:=PortCom;
  EditFonte.text:=IntToSTR(TailleFonte);
  EditTempoOctetUSB.text:=IntToSTR(TempoOctet);
  EditTempoReponse.Text:=IntToSTR(TimoutMaxInterface);
  RadioButton1.checked:=false;
  RadioButton2.checked:=false;
  RadioButton3.checked:=false;
  if Valeur_entete=0 then RadioButton1.checked:=true;
  if Valeur_entete=1 then RadioButton2.checked:=true;
  if Valeur_entete=2 then RadioButton3.checked:=true;
  LabelInfo.Width:=253;LabelInfo.Height:=25;
  LabelResult.width:=137;LabelResult.Height:=25;

  CheckVerifVersion.Checked:=verifVersion;
  CheckFenEt.Checked:=Fenetre=1;
  CheckInfoVersion.Checked:=notificationVersion;
  CheckLanceCDM.Checked:=LanceCDM;
  CheckAvecTCO.checked:=avecTCO;
  entreeTCO:=avecTCO;
  EditNomLay.Text:=Lay;
  RadioButton4.Checked:=ServeurInterfaceCDM=0;
  RadioButton5.Checked:=ServeurInterfaceCDM=1;
  RadioButton6.Checked:=ServeurInterfaceCDM=2;
  RadioButton7.Checked:=ServeurInterfaceCDM=3;
  RadioButton8.Checked:=ServeurInterfaceCDM=4;
  RadioButton9.Checked:=ServeurInterfaceCDM=5;
  RadioButton10.Checked:=ServeurInterfaceCDM=6;
  RadioButton11.Checked:=ServeurInterfaceCDM=7;
  RadioButton12.Checked:=ServeurInterfaceCDM=8;
  RadioButton12.Checked:=ServeurInterfaceCDM=13;
  RadioButton13.Checked:=ServeurRetroCDM=1;
  RadioButton14.Checked:=ServeurRetroCDM=2;
  RadioButton15.Checked:=ServeurRetroCDM=3;
  RadioButton16.Checked:=ServeurRetroCDM=4;
  RadioButton17.Checked:=ServeurRetroCDM=5;
  RadioButton18.Checked:=ServeurRetroCDM=6;

  CheckBoxServAig.checked:=Srvc_Aig;
  CheckBoxServDet.checked:=Srvc_Det;
  CheckBoxServAct.checked:=Srvc_Act;
  CheckServPosTrains.checked:=Srvc_PosTrain;
  CheckBoxRazSignaux.checked:=Raz_Acc_signaux;
  CheckBoxInitAig.checked:=AvecInitAiguillages;

  clicListe:=true;  // empeche le traitement de l'evt text
  EditDroit_BD.Text:='';
  EditPointe_BG.Text:='';
  EditDevie_HD.Text:='';   

  ligneclicSig:=-1;
  AncLigneClicSig:=-1;
  ligneclicAct:=-1;
  AncLigneClicAct:=-1;
  ligneclicAig:=-1;
  AncLigneClicAig:=-1;
  lignecliqueePN:=-1;
  AncLigneCliqueePN:=-1;
         
  // remplit les 4 fenêtres de config des aiguillages branches signaux, actionneurs

  // aiguillages
  RichAig.Clear;
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_aig(i);
    RichAig.Lines.Add(s);
    RE_ColorLine(RichAig,RichAig.lines.count-1,ClAqua);
    Aiguillage[i].modifie:=false;
  end;
  With RichAig do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;  

  // branches 
  clicListe:=true;
  RichBranche.clear;
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

  // signaux
  RichSig.clear;
  for i:=1 to NbDecodeur do
  begin
    ComboBoxDec.items.add(decodeur[i-1]);
  end;
  
  for i:=1 to NbreFeux do
  begin
    s:=encode_sig_feux(i);  // encode la ligne depuis le tableau feux
    //Affiche(s,clwhite);
    if s<>'' then
    begin
      RichSig.Lines.Add(s);
      RE_ColorLine(RichSig,RichSig.lines.count-1,ClAqua);
      Feux[i].modifie:=false;
    end;
  end;
  With RichSig do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;

  // actionneurs Train ou accessoire
  RichAct.Clear;
  for i:=1 to maxTablo_act do
  begin
    s:=encode_act_loc(i);
    if s<>'' then
    begin
      RichAct.Lines.Add(s);
      RE_ColorLine(RichAct,RichAct.lines.count-1,ClAqua);
    end;
  end;
  With RichAct do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;

  // actionneurs PN
  RichPN.Clear;
  for i:=1 to NbrePN do
  begin
    s:=encode_act_pn(i);
    if s<>'' then
    begin
      RichPN.Lines.Add(s);
      RE_ColorLine(RichPN,RichPN.lines.count-1,ClAqua);
    end;
  end;
  With RichPN do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;

  //l'onglet affiché est sélectionné à l'appel de la fiche dans l'unité UnitPrinc
  clicListe:=false;
end;


procedure TFormConfig.FormCreate(Sender: TObject);
begin
  affevt:=false; // pour debug
  clicListe:=true;
  if affevt then affiche('FormConfig create',clLime);
  clicListe:=false;
end;


// décode un morceau d'une chaine d'aiguillage ('P5S')
// si erreur, B='?'
procedure decodeAig(s : string;var adr : integer;var B : char);
var erreur,i : integer;
begin
  if s='' then begin B:='?';adr:=0;exit;end;
  if (s[1]='P') or (s[1]='S') or (s[1]='D') then delete(s,1,1);
  if s='' then 
  begin
    adr:=0;
    B:='Z';
    exit;
  end;
  // supprimer le champ suivant éventuel
  i:=pos(',',s);
  if i<>0 then delete(s,i,length(s)-i+1);
  val(s,adr,erreur);
  if adr<0 then begin B:='?';adr:=0;exit;end;
  if erreur<>0 then
  begin
    if s[erreur]='S' then begin B:='S';exit;end;
    if s[erreur]='P' then begin B:='P';exit;end;
    if s[erreur]='D' then begin B:='D';exit;end;
  end;
  B:='Z';
end;

// affiche le graphisme de l'aiguillage en fonction du tablo en index
procedure Aff_champs_aig_tablo(index : integer);
var Adresse,Adr2,ind,id2,erreur,position : integer;
    tjd,tri,tjs : boolean;
    s,ss : string;
    i : integer;
    B : char;
begin
  s:=Uppercase(formConfig.RichAig.Lines[index-1]);
  //Affiche(s,clLime);
  if s='' then exit;

  Val(s,Adresse,erreur);  // Récupérer l'adresse de l'aiguillage
  if adresse=0 then exit;

  ind:=Index_aig(adresse);
  clicliste:=true;

  ss:=InttoSTr(Adresse);
  formconfig.EditAdrAig.text:= ss;

  tjd:=pos('TJD',s)<>0 ;
  tri:=pos('TRI',s)<>0 ;
  tjs:=pos('TJS',s)<>0 ;
  with formconfig do
  begin
    EditAdrAig.Color:=clWindow;
    ImageAffiche.Picture.Bitmap.TransparentMode:=tmAuto;
    ImageAffiche.Picture.Bitmap.TransparentColor:=clblue;
    ImageAffiche.Transparent:=true;
    // tjd
    if tjd or tjs then
    begin
      if tjd then 
      begin
        ComboBoxAig.ItemIndex:=1;
        EditL.Visible:=false;
        LabelL.Visible:=false;
      end;  
      if tjs then 
      begin
        ComboBoxAig.ItemIndex:=2;
        EditL.Visible:=true;
        LabelL.Visible:=true;
        LabelL.Caption:='L'+IntToSTR(aiguillage[ind].tjsint);
        EditL.Text:=aiguillage[ind].tjsintB;
      end;  
      ImageAffiche.Picture.BitMap:=Imagetjd.Picture.Bitmap;
      labelBG.Caption:='S';
      Edit_HG.Visible:=true;
      labelTJD1.Visible:=true;
      LabelTJD2.Visible:=true;
      EditAigTriple.Visible:=false;
     
      Edit_HG.ReadOnly:=false;        
      EditPointe_BG.ReadOnly:=false;  
      EditDevie_HD.ReadOnly:=false;
      EditDroit_BD.ReadOnly:=false;
      tjd:=true;
      labelHG.Visible:=true;
      EditP1.Visible:=true;
      EditP2.Visible:=true;
      EditP3.Visible:=true;
      EditP4.Visible:=true;
      CheckInverse.Visible:=true;
      EditDevieS2.Visible:=false;
      Label18.Visible:=false;
      adr2:=aiguillage[Index_Aig(adresse)].DDevie;
      id2:=Index_Aig(adr2);
      
      // champ en haut à gauche
      b:=aiguillage[Index_Aig(adresse)].ADroitB;         
      if b='Z' then b:=#0;
      Edit_HG.Text:=intToSTR(aiguillage[index].ADroit)+b;  

      // champ en bas à gauche
      b:=aiguillage[Index].ADevieB;
      if b='Z' then b:=#0;
      EditPointe_BG.Text:=intToSTR(aiguillage[index].ADevie)+b;

      // milieu haut gauche
      EditP1.Text:=intToSTR(adresse)+aiguillage[Index].DDroitB; 
      // milieu bas gauche
      EditP2.Text:=intToSTR(adresse)+aiguillage[Index].DDevieB;   
    
      // milieu haut droit
      EditP3.Text:=intToSTR(aiguillage[index].Ddevie)+aiguillage[index].DDevieB; 
      // milieu bas droit
      EditP4.Text:=intToSTR(aiguillage[index].Ddroit)+aiguillage[index].DdroitB; 

      // droit haut
      EditDevie_HD.Text:=intToSTR(aiguillage[id2].Adevie)+aiguillage[id2].AdevieB; 
      LabelTJD1.Caption:=IntToSTR(adresse);
      
      // droit bas
      EditDroit_BD.Text:=intToSTR(aiguillage[id2].Adroit)+aiguillage[Id2].AdroitB; 
      LabelTJD2.Caption:=IntToSTR(adr2);

      CheckInverse.checked:=aiguillage[Index_Aig(adresse)].inversionCDM=1;
      
      if aiguillage[Index_Aig(adresse)].vitesse=0 then begin RadioButtonSans.checked:=true;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=false;end;
      if aiguillage[Index_Aig(adresse)].vitesse=30 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=true;RadioButton60kmh.checked:=false;end;
      if aiguillage[Index_Aig(adresse)].vitesse=60 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=true;end;
    end;

    // aiguillage normal ou tri
    if not(tjd) and not(tjs) or tri then
    begin
      EditL.Visible:=false;
      LabelL.Visible:=false;
      ComboBoxAig.ItemIndex:=0;
      if not(tri) then 
      begin
        ImageAffiche.Picture.BitMap:=Imageaig.Picture.Bitmap;
        EditDevieS2.Visible:=false;
        EditAigTriple.Visible:=false;
      end;  
      labelBG.Caption:='P';
      EditPointe_BG.ReadOnly:=false;
      Edit_HG.Visible:=false;
      labelHG.Visible:=false;
      EditP1.Visible:=false;
      EditP2.Visible:=false;
      EditP3.Visible:=false;
      EditP4.Visible:=false;
      labelTJD1.Visible:=false;
      LabelTJD2.Visible:=false;
      
      Label18.Visible:=false;
      CheckInverse.checked:=aiguillage[Index_Aig(adresse)].inversionCDM=1;
      if aiguillage[Index].vitesse=0 then begin RadioButtonSans.checked:=true;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=false;end;
      if aiguillage[Index].vitesse=30 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=true;RadioButton60kmh.checked:=false;end;
      if aiguillage[Index].vitesse=60 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=true;end;

      EditPointe_BG.Text:=intToSTR(aiguillage[index].Apointe)+aiguillage[index].ApointeB;
      EditDevie_HD.Text:=intToSTR(aiguillage[index].Adevie)+aiguillage[index].AdevieB;
      EditDroit_BD.Text:=intToSTR(aiguillage[index].Adroit)+aiguillage[index].AdroitB;
      if tri then 
      begin
        ComboBoxAig.ItemIndex:=3; //  0=n'existe pas  1=aiguillage 2=TJD 3=TJS 4=aiguillage triple
        EditAigTriple.Visible:=true;
        labelTJD1.Visible:=false;
        LabelTJD2.Visible:=false;
        EditPointe_BG.ReadOnly:=false;
        labelBG.Caption:='P';
        ImageAffiche.Picture.BitMap:=ImageTri.Picture.Bitmap;
        EditDevieS2.Visible:=true;
        Label18.Visible:=true;
        adr2:=aiguillage[index].AdrTriple;
        EditDevieS2.text:=intToSTR(aiguillage[index].Adevie2)+aiguillage[index].Adevie2B;
        i:=aiguillage[index].Adrtriple;
        EditAigTriple.Text:=intToSTR(i);
        if i=0 then EditAigTriple.Color:=clred else EditAigTriple.Color:=clWindow;
      end;  
    end;
  end;

  position:=aiguillage[index].posinit;
  if position=const_inconnu then formconfig.ComboBoxDD.ItemIndex:=2;
  if position=const_droit then formconfig.ComboBoxDD.ItemIndex:=1;
  if position=const_devie then formconfig.ComboBoxDD.ItemIndex:=0;
  formconfig.EditTempo10.text:=InttoSTr(aiguillage[index].temps);
  formconfig.EditTempo10.text:=InttoSTr(aiguillage[index].temps);
  formconfig.CheckInvInit.Checked:=aiguillage[index].inversion=1;
  
  clicListe:=false;
end;

procedure champs_type_pn;
begin
  with formconfig do
  begin
    GroupBoxRadio.Visible:=false;
    GroupBoxAct.Visible:=false;
    GroupBoxPN.Top:=24;
    GroupBoxPN.Left:=16;
    GroupBoxPN.Visible:=true;
    Visible:=true;
    RadioButtonLoc.Checked:=false;
    RadioButtonAccess.Checked:=false;
  end;
end;

procedure champs_type_loco;
begin
  with formconfig do
  begin
    GroupBoxRadio.Visible:=true;
    GroupBoxRadio.top:=20;        
    GroupBoxRadio.Left:=16;
    GroupBoxAct.Top:=104;    
    GroupBoxAct.Left:=16;
    CheckRaz.Visible:=false;
    GroupBoxAct.Caption:='Actionneur de fonction F de locomotive';
    LabelTempo.Visible:=true; EditTempo.visible:=true; editEtatFoncSortie.visible:=false;LabelA.Visible:=false;
    LabelFonction.caption:='Action : Fonction';
    RadioButtonLoc.Checked:=true;
    RadioButtonAccess.Checked:=false;
    GroupBoxAct.Visible:=true;
    GroupBoxPN.Visible:=false;
  end;
end;

procedure champs_type_act;
begin
  with formconfig do
  begin
    GroupBoxRadio.Visible:=true;
    GroupBoxRadio.top:=20;        
    GroupBoxRadio.Left:=16;
    GroupBoxAct.Top:=104;
    GroupBoxAct.Left:=16;
    GroupBoxAct.Caption:='Actionneur d''accessoire';
    CheckRaz.Visible:=true;
    LabelTempo.Visible:=false; EditTempo.visible:=false;editEtatFoncSortie.visible:=true;LabelA.Visible:=true;
    LabelFonction.caption:='Action : Accessoire';
    RadioButtonLoc.Checked:=false;
    RadioButtonAccess.Checked:=true;
    GroupBoxAct.Visible:=true;
    GroupBoxPN.Visible:=false;
  end;
end;

// mise à jour des champs du signal d'après le tableau feux
Procedure aff_champs_sig_feux(index : integer);
var i,j,l,d,k,nc,condCarre : integer;
    s : string;
begin
  if Affevt then affiche('Aff_champs_sig_feux('+intToSTR(index)+')',clyellow);
  i:=index;
  FormConfig.EditAdrSig.text:=InttoSTr(feux[i].adresse);

  with formconfig.ImageSignal do
  begin
    Picture.Bitmap.TransparentMode:=tmAuto;
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;
    picture.Bitmap:=Select_dessin_feu(feux[i].aspect);
  end;

  with formconfig do
  begin
    MemoCarre.Lines.Clear;
    EditDet2.Text:=''; EditSuiv2.Text:='';
    EditDet3.Text:=''; EditSuiv3.Text:='';
    EditDet4.Text:=''; EditSuiv4.Text:='';
    ComboBoxDec.ItemIndex:=feux[i].decodeur;
    if feux[i].decodeur=6 then 
    begin 
      EditSpecUni.Visible:=true;LabelUni.Visible:=true;
      EditSpecUni.Text:=IntToSTR(feux[i].Unisemaf);
    end
      else begin EditSpecUni.Visible:=false;LabelUni.Visible:=false;end;
    d:=feux[i].aspect;
    case d of
    2 : ComboBoxAsp.ItemIndex:=0;
    3 : ComboBoxAsp.ItemIndex:=1;
    4 : ComboBoxAsp.ItemIndex:=2;
    5 : ComboBoxAsp.ItemIndex:=3;
    7 : ComboBoxAsp.ItemIndex:=4;
    9 : ComboBoxAsp.ItemIndex:=5;
    else
        ComboBoxAsp.ItemIndex:=d-10+4;
    end; 
    
    if ((d=2) or (d>=5)) and (d<10) then checkBoxFB.Visible:=true else checkBoxFB.Visible:=false;
    // signal normal
    if d<10 then
    begin     
      Label17.Caption:='Conditions supplémentaires d''affichage du carré par les aiguillages :';
      Label17.Width:=228;
      LabelDetAss.visible:=true;
      LabelElSuiv.visible:=true;
      
      EditDet1.Visible:=true;EditDet2.Visible:=true;EditDet3.Visible:=true;EditDet4.Visible:=true;
      EditSuiv1.Visible:=true;EditSuiv2.Visible:=true;EditSuiv3.Visible:=true;EditSuiv4.Visible:=true;
      Label24.Visible:=true; Label25.Visible:=true;Label26.Visible:=true;Label27.Visible:=true;
      CheckVerrouCarre.Visible:=true;
      EditDet1.Text:=IntToSTR(feux[i].Adr_det1);
      EditSuiv1.Text:=TypeEl_To_char(feux[i].Btype_suiv1)+IntToSTR(feux[i].Adr_el_suiv1);
      j:=feux[i].Adr_det2;
      if j<>0 then 
      begin
        Editdet2.Text:=IntToSTR(j);EditSuiv2.Text:=TypeEl_To_char(feux[i].Btype_suiv2)+IntToSTR(feux[i].Adr_el_suiv2);
      end else begin EditDet2.Text:='';EditSuiv2.Text:='';end;  
      j:=feux[i].Adr_det3;
      if j<>0 then 
      begin
        EditDet3.Text:=IntToSTR(j);EditSuiv3.Text:=TypeEl_To_char(feux[i].Btype_suiv3)+IntToSTR(feux[i].Adr_el_suiv3);
      end 
      else begin EditDet3.Text:='';EditSuiv3.Text:='';end;
      j:=feux[i].Adr_det4;
      if j<>0 then 
      begin
        EditDet4.Text:=IntToSTR(j);EditSuiv4.Text:=TypeEl_To_char(feux[i].Btype_suiv4)+IntToSTR(feux[i].Adr_el_suiv4);
      end
      else begin EditDet4.Text:='';EditSuiv4.Text:='';end;  

      checkVerrouCarre.Checked:=feux[i].VerrouCarre;
      checkBoxFB.Checked:=feux[i].FeuBlanc;
      
      // conditions supplémentaires du carré par aiguillages
      l:=1;
      repeat
        nc:=Length(feux[i].condcarre[l])-1 ;
        s:='';
        for k:=1 to nc do
        begin
          s:=s+'A'+IntToSTR(feux[i].condcarre[l][k].Adresse)+feux[i].condcarre[l][k].PosAig;
          if k<nc then s:=s+',';
        end;
        MemoCarre.Lines.Add(s);
        inc(l);
      until (nc<=0) or (l>6);
      // scrolle le MemoCarre sur la première ligne
      MemoCarre.SelStart:=0;
      MemoCarre.Perform(EM_SCROLLCARET,0,0);
    end
    else
    begin // directionnel
      Label17.Caption:='Conditions d''affichage du feu directionnel :';
      LabelDetAss.visible:=false;
      LabelElSuiv.visible:=false;
      EditDet1.Visible:=false;EditDet2.Visible:=false;EditDet3.Visible:=false;EditDet4.Visible:=false;
      EditSuiv1.Visible:=false;EditSuiv2.Visible:=false;EditSuiv3.Visible:=false;EditSuiv4.Visible:=false;
      CheckVerrouCarre.Visible:=false;
      Label24.Visible:=false; Label25.Visible:=false;Label26.Visible:=false;Label27.Visible:=false;

      // conditions d'affichage du signal directionnel
      L:=feux[i].aspect-10; //nombre de feux du signal directionnel
      for j:=1 to L+1 do
      begin
        s:='';
        nc:=Length(feux[i].AigDirection[j])-1;
        for k:=1 to nc do
        begin
          s:=s+'A'+IntToSTR(feux[i].AigDirection[j][k].adresse) + feux[i].AigDirection[j][k].posaig;
          if k<nc then s:=s+',';
        end;
        MemoCarre.Lines.Add(s);
      end;
      // scrolle le MemoCarre sur la première ligne
      MemoCarre.SelStart:=0;
      MemoCarre.Perform(EM_SCROLLCARET,0,0);
    end;
  end;
end;


// mise à jour des champs graphiques des actionneurs d'après l'index du richAct
Procedure aff_champs_act(i : integer);
var etatact, adresse,sortie,fonction,tempo,access : integer;
    s,s2 : string;
begin
  if affevt then affiche('Aff_champs_act('+intToSTR(i)+')',clyellow);
  s:=Uppercase(FormConfig.RichAct.Lines[i]);
  if s='' then exit; 
  inc(i); // passer en index tablo

  fonction:=Tablo_actionneur[i].fonction;
  Access:=Tablo_actionneur[i].accessoire;

  // Actionneur fonction F loco
  if Tablo_actionneur[i].loco then 
  begin
    Formconfig.radioButtonLoc.Checked:=true;
    Formconfig.radioButtonAccess.Checked:=false; 
    etatAct:=Tablo_actionneur[i].etat ;
    //etatFonc:=Tablo_actionneur[i].
    Adresse:=Tablo_actionneur[i].actionneur;
    s2:=Tablo_actionneur[i].train;
    tempo:=tablo_actionneur[i].Tempo;
    with formconfig do
    begin
      champs_type_loco;
      EditAct.text:=IntToSTR(Adresse);
      editEtatActionneur.Text:=IntToSTR(etatAct);
      EditTrain.Text:=s2;
      editFonctionAccess.Text:=intToSTR(fonction);
      editTempo.Text:=intToSTR(tempo);
    end;
  end;  

  // Actionneur accessoire
  if Tablo_actionneur[i].act then 
  begin
    champs_type_act;
    Formconfig.radioButtonLoc.Checked:=false;
    Formconfig.radioButtonAccess.Checked:=true;
    etatAct:=Tablo_actionneur[i].etat ;
    Adresse:=Tablo_actionneur[i].actionneur;
    sortie:=Tablo_actionneur[i].sortie;
    s2:=Tablo_actionneur[i].train;
    tempo:=tablo_actionneur[i].Tempo;
    with formconfig do
    begin
      EditAct.text:=IntToSTR(Adresse);
      CheckRaz.Checked:=Tablo_actionneur[i].Raz;
      EditTrain.Text:=s2;
      EditEtatActionneur.Text:=IntToSTR(etatAct);
      editFonctionAccess.Text:=intToSTR(Access);
      editEtatFoncSortie.Text:=intToSTR(sortie);
      editTempo.Text:=intToSTR(tempo);
    end;
  end;  
end;  

// affiche les champs de l'actionneur PN en fonction du tableau en fonction de l'index du richedit
procedure aff_champs_PN(i : integer);
var adresse,erreur,v : integer;
    trouve : boolean;
    s : string;
begin
  if affevt then affiche('Aff_champs_PN('+intToSTR(i)+')',clyellow);
  s:=Uppercase(FormConfig.RichPN.Lines[i]);
  if s='' then exit;

  // actionneur passage à niveau
  if s[1]='(' then
  begin
    champs_type_pn;
    // trouver l'index dans le tableau
    i:=pos('PN(',s);
    delete(s,1,i+2);
    val(s,adresse,erreur);
    i:=0;
    repeat
      inc(i);
      trouve:=(Tablo_PN[i].AdresseFerme=adresse);
    until trouve or (i>NbrePN);
    if not(trouve) then exit;

    with formConfig do
    begin
      EditAdrFerme.text:=IntToSTR(Tablo_PN[i].AdresseFerme);
      EditAdrOuvre.text:=IntToSTR(Tablo_PN[i].AdresseOuvre);
      if Tablo_PN[i].CommandeFerme=2 then s:='+' else s:='-';
      EditCmdFerme.text:=s;
      if Tablo_PN[i].CommandeOuvre=2 then s:='+' else s:='-';
      EditCdeOuvre.text:=s;
      EditV1F.text:=intToSTR(Tablo_PN[i].voie[1].ActFerme);
      EditV1O.text:=intToSTR(Tablo_PN[i].voie[1].ActOuvre);
      v:=Tablo_PN[i].nbvoies;
      if v>=2 then
      begin
        EditV2F.text:=intToSTR(Tablo_PN[i].voie[2].ActFerme);
        EditV2O.text:=intToSTR(Tablo_PN[i].voie[2].ActOuvre);
      end;
      if v>=3 then
      begin
        EditV3F.text:=intToSTR(Tablo_PN[i].voie[3].ActFerme);
        EditV3O.text:=intToSTR(Tablo_PN[i].voie[3].ActOuvre);
      end;
      if v>=4 then
      begin
        EditV4F.text:=intToSTR(Tablo_PN[i].voie[4].ActFerme);
        EditV4O.text:=intToSTR(Tablo_PN[i].voie[4].ActOuvre);
      end;
    end;
  end
end;
  
procedure raz_champs_act;
begin
  with formConfig do
  begin
    editAct.Text:='';
    EditEtatActionneur.Text:='';
    EditTrain.Text:='';
    EditFonctionAccess.Text:='';
    EditEtatFoncSortie.Text:='';
    EditTempo.Text:='';
    CheckRaz.Checked:=false;
  end;
end;
  
procedure raz_champs_aig;
begin
  with formConfig do
  begin
    LabelInfo.caption:='';
    EditAdrAig.Text:='';EditAigTriple.Text:='';
    Edit_HG.text:='';
    editDevie_HD.Text:='';
    editDroit_BD.Text:='';
    editPointe_BG.Text:='';
    EditTempo10.text:='';
  end;  
end;

procedure raz_champs_sig;
begin
  with formconfig do
  begin
    LabelInfo.caption:='';
    EditDet1.Text:='';EditSuiv1.Text:='';
    EditDet2.Text:='';EditSuiv2.Text:='';
    EditDet3.Text:='';EditSuiv3.Text:='';
    EditDet4.Text:='';EditSuiv4.Text:='';
    EditAdrSig.Text:='';
    MemoCarre.Clear;
    ComboBoxAsp.ItemIndex:=-1;
    ComboBoxDec.ItemIndex:=-1;
    ImageSignal.Picture:=Nil;
    checkVerrouCarre.Checked:=false;
    checkBoxFB.Checked:=false;
  end;
end;

// cliqué sur liste aiguillages
procedure TFormConfig.RichAigMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,lc,adresse,erreur : integer;
    s : string;
begin
  clicliste:=true;
  raz_champs_aig;
  ComboBoxAig.ItemIndex:=-1;
  formconfig.ComboBoxDD.ItemIndex:=-1;
   
  with Formconfig.RichAig do
  begin
    lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    //Affiche('numéro de la ligne cliquée '+intToStr(lc),clyellow);
    s:=Uppercase(Lines[lc]);   // ligne cliquée
    if s='' then 
    begin
      RE_ColorLine(Formconfig.RichAig,ligneclicAig,ClAqua);
      ligneclicAig:=-1;
      exit;
    end;  

    Aig_sauve:=Aiguillage[lc+1];  // sauvegarde
    AncligneclicAig:=ligneclicAig;
    ligneclicAig:=lc;

    if AncligneclicAig<>-1 then
    begin
      if aiguillage[ligneclicAig+1].modifie then RE_ColorLine(Formconfig.RichAig,AncligneclicAig,ClWhite) else
      RE_ColorLine(Formconfig.RichAig,AncligneclicAig,ClAqua);
    end;
  end;

  Val(s,Adresse,erreur);  // Adresse de l'aguillage
  if adresse=0 then exit;

  RE_ColorLine(Formconfig.RichAig,ligneclicAig,Clyellow);
  i:=index_aig(Adresse);

  aff_champs_Aig_tablo(i);
  clicliste:=false;
end;

// on change la valeur de la description du champ HG pour les TJD
procedure TFormConfig.Edit_HGKeyPress(Sender: TObject; var Key: Char);
var s : string;
    adr,adraig,erreur,index : integer;
    b : char;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change HG',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneclicAig];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe
    s:=Edit_HG.text;
    decodeAig(s,adr,B);
    if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
    begin
      RE_ColorLine(RichAig,ligneclicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      Aiguillage[index].Adroit:=adr;
      Aiguillage[index].AdroitB:=B;

      // réencoder la ligne
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneclicAig]:=s;
    end
      else
        LabelInfo.caption:='Erreur pointe aiguillage '+intToSTR(AdrAig);
    end;
end;

// on change la valeur de la description de la déviation de l'aiguillage
procedure TFormConfig.EditDevie_HDKeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,adr2,erreur,index,modele : integer;
    b : char;
    s : string;
begin
  // cliqué sur le edit dévié aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change dévié',clyellow);
    
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneclicAig];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=EditDevie_HD.text;
    decodeAig(s,adr,B);
    index:=index_aig(adrAig);
    if index=0 then exit;
    modele:=aiguillage[index].modele;
   
    if (modele=1) or (modele=4) then
    begin
      if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then 
      begin
        // aiguillage normal ou triple
        RE_ColorLine(RichAig,ligneclicAig,ClWhite);
        Aiguillage[index].modifie:=true;
        LabelInfo.caption:='';
        // modifier la base de données de l'aiguillage
        if b=#0 then b:='Z';
        Aiguillage[Index].ADevie:=adr;
        Aiguillage[Index].ADevieB:=B;
        // réencoder la ligne
        s:=encode_aig(Index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end
      else
      begin
        LabelInfo.caption:='Erreur déviation aiguillage '+intToSTR(AdrAig);
      end;
    end;

    if (modele=2) or (modele=3) then
    begin
      // TJD/TJS
      adr2:=aiguillage[index].DDroit;  // adresse homologue
      index:=Index_aig(adr2);
      if index=0 then exit;
      aiguillage[index].Adevie:=adr;
      aiguillage[index].AdevieB:=B;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
      RE_ColorLine(Formconfig.RichAig,index-1,ClWhite);
      LabelInfo.caption:='Modification de la TJD homologe ('+IntToSTR(adr2)+')';
    end;
  end;  
end;

// on change la valeur de la description du droit de l'aiguillage
procedure TFormConfig.EditDroit_BDKeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,erreur,index,modele,adr2 : integer;
    b : char;
    s : string;
begin
  // cliqué sur le edit droit aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change droit',clyellow);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneclicAig];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=EditDroit_BD.text;
    decodeAig(s,adr,B);
    Index:=Index_Aig(AdrAig);
    if index=0 then exit;
    modele:=aiguillage[index].modele;
    if (modele=1) or (modele=4) then
    begin
      if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
      begin
        RE_ColorLine(RichAig,ligneclicAig,ClWhite);
        Aiguillage[Index].modifie:=true;
        LabelInfo.caption:='';
        // modifier la base de données de l'aiguillage
        if b=#0 then b:='Z';
        Aiguillage[index].ADroit:=adr;
        Aiguillage[index].ADroitB:=B;
        // réencoder la ligne
        s:=encode_aig(Index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end
      else
      begin
        LabelInfo.caption:='Erreur droit aiguillage '+intToSTR(AdrAig);
      end;
    end;
    if (modele=2) or (modele=3) then
    begin
      // TJD/TJS
      adr2:=aiguillage[index].DDroit;  // adresse homologue
      index:=Index_aig(adr2);
      if index=0 then exit;
      aiguillage[index].Adroit:=adr;
      aiguillage[index].AdroitB:=B;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
      RE_ColorLine(Formconfig.RichAig,index-1,ClWhite);
      LabelInfo.caption:='Modification de la TJD homologe ('+IntToSTR(adr2)+')';
    end;
  end;  
end;

procedure TFormConfig.EditPointe_BGKeyPress(Sender: TObject;
  var Key: Char);
var AdrAig,adr,erreur,index : integer;
    b : char;
    normal,tjd,tjs,tri : boolean;
    s : string;
begin
  // cliqué sur le edit pointe aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change pointe',clyellow);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneclicAig];
    Val(s,adrAig,erreur);
      
    //vérifier la syntaxe de P
    s:=Editpointe_BG.text;
    decodeAig(s,adr,B);
    if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then 
    begin
      RE_ColorLine(RichAig,ligneclicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
      normal:=aiguillage[index].modele=1;
      tjd:=aiguillage[index].modele=2;
      tjs:=aiguillage[index].modele=3;
      tri:=aiguillage[index].modele=4;
      
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      if normal or tri then
      begin
        Aiguillage[index].APointe:=adr;
        Aiguillage[index].APointeB:=B;
        // réencoder la ligne
        s:=encode_aig(index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end;
      if tjd or tjs then
      begin
        Aiguillage[index].ADevie:=adr;
        Aiguillage[index].ADevieB:=B;
        s:=encode_aig(index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end;
    end
      else
        LabelInfo.caption:='Erreur pointe aiguillage '+intToSTR(AdrAig);
    end;  
end;
 
procedure TFormConfig.EditDevieS2KeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,erreur,index : integer;
    b : char;
    s : string;
begin
  // cliqué sur le edit droit aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change S2',clyellow);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneclicAig];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=EditDevieS2.text;
    decodeAig(s,adr,B);

    if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then 
    begin
      RE_ColorLine(RichAig,ligneclicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';
      Aiguillage[index].ADevie2:=adr;
      Aiguillage[index].ADevie2B:=B;
      // réencoder la ligne
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneclicAig]:=s;
    end
    else
    begin
      LabelInfo.caption:='Erreur S2 aiguillage '+intToSTR(AdrAig);
    end;
  end;  
end;


procedure TFormConfig.CheckInverseClick(Sender: TObject);
var s : string;
    adrAig,erreur : integer;
begin
  // récupérer l'adresse de l'aiguillage cliqué
  if clicliste then exit;
  if affevt then affiche('Evt change pointe',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if checkInverse.Checked then aiguillage[Index_Aig(adraig)].InversionCDM:=1 else aiguillage[Index_Aig(adraig)].InversionCDM:=0;
  // réencoder la ligne
  s:=encode_aig(Index_Aig(AdrAig));
  formconfig.RichAig.Lines[ligneclicAig]:=s;
end;

procedure TFormConfig.RadioButtonsansClick(Sender: TObject);
var AdrAig,erreur,index : integer;
    s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt RadioBouton sans vitesse',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  aiguillage[index].vitesse:=0;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[ligneclicAig]:=s;
end;

procedure TFormConfig.RadioButton30kmhClick(Sender: TObject);
var AdrAig,erreur,index : integer;
    s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt RadioBouton vitesse 30',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  aiguillage[index].vitesse:=30;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[ligneclicAig]:=s;
end;

procedure TFormConfig.RadioButton60kmhClick(Sender: TObject);
var AdrAig,erreur,index : integer;
    s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt RadioBouton vitesse 60',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  aiguillage[Index].vitesse:=60;
  aiguillage[Index].modifie:=true;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[ligneclicAig]:=s;
end;

procedure TFormConfig.ComboBoxDecChange(Sender: TObject);
var s: string;
    i : integer;
begin
//  Affiche(IntToStr(ComboBoxDec.ItemIndex),clyellow);
  if clicListe then exit;
  
  if NbreFeux<ligneclicSig+1 then exit;
  i:=ligneclicSig+1;
  feux[i].decodeur:=ComboBoxDec.ItemIndex;
  Maj_Hint_feu(i);

  s:=encode_sig_feux(i);
  formconfig.RichSig.Lines[ligneclicSig]:=s;
  aff_champs_sig_feux(i);
  if affevt then Affiche('Evt ComboBox Decodeur',clOrange);
end;

// cliqué sur liste feux
procedure TFormConfig.RichSigMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var lc,AncAdresse,adresse,erreur : integer;
    s : string;
begin
  clicliste:=true;
  raz_champs_sig;
  
  with Formconfig.RichSig do
  begin
    lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    //Affiche('numéro de la ligne cliquée '+intToStr(lc),clyellow);
    s:=Uppercase(Lines[lc]);   // ligne cliquée
    if s='' then 
    begin
      RE_ColorLine(Formconfig.RichSig,ligneclicSig,ClAqua);
      ligneclicSig:=-1;
      exit;
    end;  
    
    Feu_Sauve:=feux[lc+1];  // sauvegarde

    AncLigneClicSig:=ligneclicSig;
    ligneClicSig:=lc;

    // Mettre en rouge le signal modifié quand on clique sur un autre signal
    if AncligneclicSig<>-1 then
    begin
      val(FormConfig.RichSig.Lines[AncLigneClicSig],AncAdresse,erreur);
      if feux[ligneClicSig+1].modifie then RE_ColorLine(Formconfig.RichSig,AncLigneClicSig,ClWhite) else
      RE_ColorLine(Formconfig.RichSig,AncLigneClicSig,ClAqua);
    end;
  end;

  Val(s,Adresse,erreur);  // Adresse du signal
  if adresse=0 then exit;

  EditAdrSig.Color:=clWindow;
  RE_ColorLine(Formconfig.RichSig,ligneClicSig,Clyellow);

  aff_champs_sig_feux(lc+1);
  clicliste:=false;
end;

procedure TFormConfig.EditDet1KeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;
  s:=RichSig.Lines[ligneClicSig];
  if affevt then Affiche('Evt Détecteur 1',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet1.Text;
    Val(s,i,erreur);
    if erreur<>0 then begin LabelInfo.caption:='Erreur détecteur1 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det1:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditSuiv1KeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;
  if affevt then Affiche('Evt suivant1',clOrange);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv1.Text;
    if s='' then begin LabelInfo.caption:='Erreur élément suivant 1';exit;end;
    Val(s,i,erreur);
    if erreur<>0 then
    begin
      if (s[erreur]='A') and (erreur=1) then
      begin
        feux[ligneClicSig+1].Btype_suiv1:=2;  // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri
        delete(s,erreur,1);
        Val(s,i,erreur);
      end
      else begin LabelInfo.caption:='Erreur élément suivant 1';exit;end;
    end
    else feux[ligneClicSig+1].Btype_suiv1:=1;

    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv1:=i;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    maj_hint_feu(ligneClicSig+1);
  end;
end;

procedure TFormConfig.EditDet2KeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;
  if affevt then Affiche('Evt detecteur 2',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet2.Text;
    if s='' then exit;
    Val(s,i,erreur);
    if erreur<>0 then begin LabelInfo.caption:='Erreur détecteur2 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det2:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.CheckVerrouCarreClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Verrou carré',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    feux[ligneClicSig+1].VerrouCarre:=checkVerrouCarre.Checked;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;        

procedure TFormConfig.CheckBoxFBClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt FB',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    feux[ligneClicSig+1].FeuBlanc:=checkBoxFB.Checked;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditSuiv2KeyPress(Sender: TObject; var Key: Char);
var s : string;
    erreur,i: integer;
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;
  if affevt then Affiche('Evt Element suivant2',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv2.Text;
    if s='' then begin LabelInfo.caption:='Erreur élément suivant 2';exit;end;
    Val(s,i,erreur);
    if erreur<>0 then
    begin
      if (s[erreur]='A') and (erreur=1) then
      begin
        feux[ligneClicSig+1].Btype_suiv2:=2;  // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri
        delete(s,erreur,1);
        Val(s,i,erreur);
      end
      else begin LabelInfo.caption:='Erreur élément suivant 2';exit;end;
    end
    else feux[ligneClicSig+1].Btype_suiv2:=1;

    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv2:=i;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;


procedure TFormConfig.EditDet3KeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;
  if affevt then Affiche('Evt Detecteur 3',clOrange);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet3.Text;
    if s='' then exit;
    Val(s,i,erreur);if erreur<>0 then begin LabelInfo.caption:='Erreur détecteur3 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det3:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditSuiv3KeyPress(Sender: TObject; var Key: Char);
var s : string;
    erreur,i : integer;
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv3.Text;
    if s='' then begin LabelInfo.caption:='Erreur élément suivant 3';exit;end;
    Val(s,i,erreur);
    if erreur<>0 then
    begin
      if (s[erreur]='A') and (erreur=1) then
      begin
        feux[ligneClicSig+1].Btype_suiv3:=2;  // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri
        delete(s,erreur,1);
        Val(s,i,erreur);
      end
      else begin LabelInfo.caption:='Erreur élément suivant 3';exit;end;
    end
    else feux[ligneClicSig+1].Btype_suiv3:=1;

    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv3:=i;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;

procedure TFormConfig.EditDet4KeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet4.Text;
    if s='' then exit;
    Val(s,i,erreur);if erreur<>0 then begin LabelInfo.caption:='Erreur détecteur4 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det4:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditSuiv4KeyPress(Sender: TObject; var Key: Char);
var s : string;
    erreur,i : integer;
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv4.Text;
    if s='' then begin LabelInfo.caption:='Erreur élément suivant 4';exit;end;
    Val(s,i,erreur);
    if erreur<>0 then
    begin
      if (s[erreur]='A') and (erreur=1) then
      begin
        feux[ligneClicSig+1].Btype_suiv4:=2;  // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri
        delete(s,erreur,1);
        Val(s,i,erreur);
      end
      else begin LabelInfo.caption:='Erreur élément suivant 4';exit;end;
    end
    else feux[ligneClicSig+1].Btype_suiv1:=1;

    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv4:=i;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;

procedure TFormConfig.EditActChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit act Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditAct.Text;
    if radioButtonLoc.Checked or RadioButtonAccess.Checked then
    begin
      Val(s,act,erreur);
      if erreur<>0 then
      begin
        LabelInfo.caption:='Erreur adresse actionneur';exit
      end else LabelInfo.caption:=' ';
      
      tablo_actionneur[ligneClicAct+1].actionneur:=act;
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.RichActMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ligne : integer;
begin
  clicliste:=true;
  LabelInfo.caption:='';
  raz_champs_act;
  with RichAct do
  begin
    ligne:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    if ligne<maxTablo_act then 
    begin
      if AncligneClicAct<>-1 then RE_ColorLine(RichAct,AncligneClicAct,ClAqua);    
      AncligneClicAct:=Ligne;
      ligneClicAct:=ligne;
      RE_ColorLine(Formconfig.RichAct,ligneClicAct,ClYellow);
      Aff_champs_Act(ligneClicAct);
    end
    else
    begin
      RE_ColorLine(Formconfig.RichAct,ligneclicAct,ClAqua);
      ligneclicAct:=-1;
      exit;
    end;  
  end;
  clicliste:=false;
end;

procedure TFormConfig.EditEtatActionneurChange(Sender: TObject);
var s : string;
    etat,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditActionneur Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditEtatActionneur.Text;
    if radioButtonLoc.Checked or RadioButtonAccess.Checked then
    begin
      Val(s,etat,erreur);
      if (erreur<>0) or (etat<0) or (etat>1) then
      begin
        LabelInfo.caption:='Erreur état actionneur';exit
      end else LabelInfo.caption:=' ';
      
      tablo_actionneur[ligneClicAct+1].etat:=etat;
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;
  
procedure TFormConfig.EditTrainChange(Sender: TObject);
var s,train : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit Train Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    if radioButtonLoc.Checked or RadioButtonAccess.Checked then
    begin
      train:=editTrain.Text;
      if train='' then
      begin
        LabelInfo.caption:='Erreur train';exit
      end else LabelInfo.caption:=' ';
      
      tablo_actionneur[ligneClicAct+1].train:=train;
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.EditFonctionAccessChange(Sender: TObject);
var s : string;
    fonction,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit fonctionAccess Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin
    s:=EditFonctionAccess.Text;
    if radioButtonLoc.Checked or RadioButtonAccess.Checked then
    begin
      Val(s,fonction,erreur);
      if erreur<>0 then
      begin
        LabelInfo.caption:='Erreur fonction actionneur';exit
      end else LabelInfo.caption:=' ';
      
      if radioButtonLoc.Checked then tablo_actionneur[ligneClicAct+1].fonction:=fonction;
      if RadioButtonAccess.Checked then Tablo_Actionneur[ligneClicAct+1].accessoire:=fonction;
      
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.EditEtatFoncSortieChange(Sender: TObject);
var s : string;
    Etat,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit FoncSortie Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditEtatFoncSortie.Text;
    if radioButtonAccess.Checked then
    begin
      Val(s,etat,erreur);
      if (erreur<>0) or (etat<0) or (etat>2) then
      begin
        LabelInfo.caption:='Erreur Etat actionneur';exit
      end else LabelInfo.caption:=' ';

      tablo_actionneur[ligneClicAct+1].sortie:=etat;
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.EditTempoChange(Sender: TObject);
var s : string;
    tempo,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt TempoChange',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditTempo.Text;
    if radioButtonLoc.Checked then
    begin
      Val(s,tempo,erreur);
      if erreur<>0 then
      begin
        LabelInfo.caption:='Erreur Tempo actionneur';exit
      end else LabelInfo.caption:=' ';
      
      tablo_actionneur[ligneClicAct+1].tempo:=tempo;
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.CheckRAZClick(Sender: TObject);
 var s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt CheckRaz Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    if radioButtonAccess.Checked then
    begin
      tablo_actionneur[ligneClicAct+1].raz:=CheckRAZ.checked;
      s:=encode_act_loc(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.EditAdrSigKeyPress(Sender: TObject; var Key: Char);
var s : string;
    i, erreur : integer;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then Affiche('Evt adresse signal',clOrange);
  // attention interférence avec clic droit propriétés sur un signal qui génère un evt sur ce contrôle
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditAdrSig.Text;
    Val(s,i,erreur);
    if (erreur<>0) or (i<=0) or (i>MaxAcc) then 
    begin 
      EditAdrSig.Color:=clred;
      LabelInfo.caption:='Erreur adresse signal ';exit;
    end;
    if (index_feu(i)<>0) then
    begin
      EditAdrSig.Color:=clred;
      LabelInfo.caption:='Signal '+intToSTR(i)+' existe, il ne sera pas écrasé';exit;
    end;
    
    EditAdrSig.Color:=clWindow;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].adresse:=i;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s; 
    Feux[ligneClicSig+1].Lbl.caption:='@'+IntToSTR(i);
   end; 
end;

procedure TFormConfig.EditAdrAigKeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,vide,erreur,index,adr2,modele : integer;
    c : char;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditAdrAig.Text;
    Val(s,i,erreur);
    if (erreur<>0) or (i<=0) or (i>MaxAcc) then 
    begin 
      EditAdrAig.Color:=clred;
      LabelInfo.caption:='Erreur adresse Aiguillage ';exit;
    end;
        
    index:=ligneclicAig+1;
    if index=0 then exit;

    modele:=aiguillage[index].modele;
    // si normal ou triple
    if (modele=1) or (modele=4) then
    begin
      if (erreur<>0) or (i>MaxAcc) then begin LabelInfo.caption:='Erreur adresse aiguillage ';exit;end;
      //  vérifier si l'adresse de l'aiguillage existe déja
      if (aiguillage[Index_Aig(i)].modele<>0) then 
      begin
        EditAdrAig.Color:=clred;
        LabelInfo.caption:='aiguillage '+IntToSTR(i)+' existe déja - ne sera pas écrasé' ;
        exit;
      end;
      EditAdrAig.Color:=clWindow;
      LabelInfo.caption:=' ';
      s:=encode_aig_gfx;
    
      aiguillage[index].adresse:=i;
      aiguillage[index].modifie:=true;
      formconfig.RichAig.Lines[ligneclicAig]:=s;
    end;
    if (modele=2) or (modele=3) then  
    begin
      clicListe:=true;
      // modifier les champs P1 et P2 avec la nouvelle adresse
      val(editP1.Text,vide,erreur);
      if erreur<>0 then c:=editP1.text[erreur] else c:='D';
      editP1.Text:=IntToSTR(i)+c;
      val(editP2.Text,vide,erreur);
      if erreur<>0 then c:=editP2.text[erreur] else c:='D';
      editP2.Text:=IntToSTR(i)+c;
      
      clicListe:=false;
      aiguillage[index].adresse:=i;
      aiguillage[index].modifie:=true;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
      
      // modif homologue
      adr2:=aiguillage[index].Ddroit;
      index:=index_aig(adr2);
      aiguillage[index].dDroit:=i;
      aiguillage[index].dDevie:=i;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end;
  end;
end;

procedure TFormConfig.ComboBoxAspChange(Sender: TObject);
var i,index,aspect : integer;
    s : string;
begin
  if clicListe then exit;
  if affevt then Affiche('Evt aspect',clOrange);
  i:=ComboBoxAsp.ItemIndex;
  //Affiche(IntToSTR(i),clyellow);
  case i of
  0 : aspect:=2;
  1 : aspect:=3;
  2 : aspect:=4;
  3 : aspect:=5;
  4 : aspect:=7;
  5 : aspect:=9;
  else aspect:=i+6;
  end;  
  index:=ligneClicSig+1;  // index du feu
  if NbreFeux<index then exit;
  //Affiche('Ligne cliquée='+IntToSTR(index),clyellow);
  if ((aspect=2) or (aspect>=5)) and (aspect<10) then 
    checkBoxFB.Visible:=true else 
    begin
      checkBoxFB.Visible:=false;
      checkBoxFB.Checked:=false;
    end;  
  feux[index].aspect:=aspect;
  s:=encode_sig_feux(index);  
  RichSig.Lines[ligneClicSig]:=s;
  aff_champs_sig_feux(index); // redessine les champs et le feu
  
  // change l'image du feu dans la feuille graphique principale
  Feux[index].Img.picture.Bitmap:=Select_dessin_feu(feux[index].aspect);
  dessine_feu_mx(Feux[index].Img.Canvas,0,0,1,1,feux[index].adresse,1);  // dessine les feux du signal
end;

procedure TFormConfig.EditSpecUniKeyPress(Sender: TObject; var Key: Char);
var erreur,i,Adr : integer ;
    s : string ;
begin
  if clicliste or (ligneClicSig<0) or (ord(Key)<>VK_RETURN) then exit;
  if affevt then Affiche('Evt Unisemaf',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSpecUni.Text;
    Val(s,i,erreur); // code unisemaf
    s:=EditAdrSig.Text;
    Val(s,Adr,erreur); // Adresse signal
    // vérification code unisemaf
    erreur:=verif_unisemaf(Adr,i);
    if erreur=1 then begin LabelInfo.caption:='Erreur code Unisemaf';exit;end;
    if erreur=2 then begin LabelInfo.caption:='Erreur cohérence aspect signal';exit;end;
    
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Unisemaf:=i;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;  
  end;  
end;

procedure TFormConfig.ButtonrestaureClick(Sender: TObject);
var index : integer;
begin
  if (Feu_sauve.adresse<>0) and (ligneClicSig>=0) then
  begin
    clicListe:=true;
    index:=ligneClicSig+1;    
    feux[index]:=Feu_sauve;
    RichSig.Lines[ligneClicSig]:=encode_sig_feux(index);
    aff_champs_sig_feux(index);  // réaffiche les champs 
    Maj_Hint_feu(index);  
    // change l'image du feu dans la feuille graphique principale
    Feux[index].Img.picture.Bitmap:=Select_dessin_feu(feux[index].aspect);
    dessine_feu_mx(Feux[index].Img.Canvas,0,0,1,1,feux[index].adresse,1);  // dessine les feux du signal
    clicListe:=false;
  end;  
end;

procedure TFormConfig.RadioButtonLocClick(Sender: TObject);
var  champ,i,erreur : integer;
    s : string;
begin
  // rendre visible le groupbox Actionneur fonction F loco
  if clicListe then exit;
  i:=ligneClicAct+1;
  if AffEvt then Affiche('RadioLoc '+IntToSTR(i),clyellow);

  Tablo_Actionneur[i].loco:=true;
  Tablo_Actionneur[i].Act:=false;
  champs_type_loco; 
  
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].actionneur:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  Tablo_actionneur[i].train:=editTrain.Text;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc(i);
  RichAct.Lines[ligneClicAct]:=s;
end;

procedure TFormConfig.RadioButtonAccessClick(Sender: TObject);
var  champ,i,erreur : integer;
    s : string;
begin
  // rendre visible le groupbox Actionneur fonction F loco
  if clicListe then exit;
  i:=ligneClicAct+1;
  if AffEvt then Affiche('RadioAccessoire '+IntToSTR(i),clyellow);

  Tablo_Actionneur[i].loco:=false;
  Tablo_Actionneur[i].Act:=true;
  champs_type_act;  
  
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].actionneur:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  Tablo_actionneur[i].train:=editTrain.Text;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc(i);
  RichAct.Lines[ligneClicAct]:=s;
end;

procedure TFormConfig.RichPNMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  ligne : integer;
begin
  clicliste:=true;
  LabelInfo.caption:='';
  editV1F.Text:='';editV1O.Text:='';
  editV2F.Text:='';editV2O.Text:='';
  editV3F.Text:='';editV3O.Text:='';
  editV4F.Text:='';editV4O.Text:='';
  editAdrFerme.Text:='';EditCmdFerme.text:='';
  editAdrOuvre.Text:='';EditCdeOuvre.text:='';
  with RichPN do
  begin
    ligne:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    if ligne<nbrePN then
    begin
      if AncLigneCliqueePN<>-1 then RE_ColorLine(RichPN,AncligneCliqueePN,ClAqua);    
      AncLigneCliqueePN:=Ligne;
      ligneCliqueePN:=ligne;
      RE_ColorLine(RichPN,LigneCliqueePN,ClYellow);
      Aff_champs_PN(lignecliqueePN);
    end
    else
    begin
      RE_ColorLine(Formconfig.RichPN,lignecliqueePN,ClAqua);
      lignecliqueePN:=-1;
      exit;
    end;  
  end;  
  clicliste:=false; 
end;

procedure TFormConfig.EditAdrFermeChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditAdrFerme Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditAdrFerme.Text;
    Val(s,act,erreur);
    if erreur<>0 then
    begin
      LabelInfo.caption:='Erreur adresse actionneur ferme';exit
    end else LabelInfo.caption:=' ';
    tablo_PN[lignecliqueePN+1].AdresseFerme:=act;
    s:=encode_act_PN(lignecliqueePN+1);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditCmdFermeChange(Sender: TObject);
var s : string;
    act : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditCmdFerme Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditCmdFerme.Text;
    if (s='+') or (s='-') then
    begin
      if s='-' then act:=1 else act:=2;
      LabelInfo.caption:=' ';
      tablo_PN[lignecliqueePN+1].CommandeFerme:=act;
      s:=encode_act_PN(lignecliqueePN+1);
      RichPN.Lines[lignecliqueePN]:=s;
    end
    else 
     LabelInfo.caption:='Erreur Commande ferme actionneur';exit
  end;
end;

procedure TFormConfig.EditAdrOuvreChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditAdrOuvre Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditAdrOuvre.Text;
    Val(s,act,erreur);
    if erreur<>0 then
    begin
      LabelInfo.caption:='Erreur adresse actionneur ouvre';exit
    end else LabelInfo.caption:=' ';
    tablo_PN[lignecliqueePN+1].AdresseOuvre:=act;
    s:=encode_act_PN(lignecliqueePN+1);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditCdeOuvreChange(Sender: TObject);
var s : string;
    act : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditCmdOuvre Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditCdeOuvre.Text;
    if (s='+') or (s='-') then
    begin
      if s='-' then act:=1 else act:=2;
      LabelInfo.caption:=' ';
      tablo_PN[lignecliqueePN+1].CommandeOuvre:=act;
      s:=encode_act_PN(lignecliqueePN+1);
      RichPN.Lines[lignecliqueePN]:=s;
    end
    else 
     LabelInfo.caption:='Erreur Commande ouvre actionneur';exit
  end;
end;

procedure TFormConfig.EditV1FChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV1F Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV1F.Text;
    Val(s,act,erreur);
    if (erreur<>0) then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 1 ferme';exit
    end else LabelInfo.caption:=' ';
    tablo_PN[lignecliqueePN+1].voie[1].ActFerme:=act;
    s:=encode_act_PN(lignecliqueePN+1);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;


procedure TFormConfig.EditV1OChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV1O Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV1O.Text;
    Val(s,act,erreur);
    if erreur<>0 then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 1 ouvre';exit
    end else LabelInfo.caption:=' ';
    tablo_PN[lignecliqueePN+1].voie[1].ActOuvre:=act;
    s:=encode_act_PN(lignecliqueePN+1);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditV2FChange(Sender: TObject);
var s : string;
    act,erreur,NbVoies,i : integer;
    V2valide : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV2F Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV2F.Text;
    Val(s,act,erreur);
    if (erreur<>0) and (s<>'') then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 2 ferme';exit
    end else LabelInfo.caption:=' ';
    i:=lignecliqueePN+1;
    tablo_PN[i].voie[2].ActFerme:=act;
    V2valide:=(EditV2O.text<>'') and (EditV2F.text<>'');
    NbVoies:=tablo_PN[i].NbVoies;
    if V2Valide and (NbVoies=1) then tablo_PN[i].NbVoies:=2;
    if not(V2Valide) then tablo_PN[i].NbVoies:=1;
    s:=encode_act_PN(i);
    RichPN.Lines[lignecliqueePN]:=s;
  end;

end;

procedure TFormConfig.EditV2OChange(Sender: TObject);
var s : string;
    act,erreur,NbVoies,i : integer;
    V2valide : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV2O Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV2O.Text;
    Val(s,act,erreur);
    if (erreur<>0) and (s<>'') then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 2 ouvre';exit
    end else LabelInfo.caption:=' ';
    i:=lignecliqueePN;
    tablo_PN[i].voie[2].ActOuvre:=act;
    V2valide:=(EditV2O.text<>'') and (EditV2F.text<>'');
    NbVoies:=tablo_PN[i].NbVoies;
    if V2Valide and (NbVoies=1) then tablo_PN[i].NbVoies:=2;
    if not(V2Valide) then tablo_PN[i].NbVoies:=1;
    s:=encode_act_PN(i);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditV3FChange(Sender: TObject);
var s : string;
    act,erreur,NbVoies,i : integer;
    V3valide : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV3F Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV3F.Text;
    Val(s,act,erreur);
    if (erreur<>0) and (s<>'') then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 3 ferme';exit
    end else LabelInfo.caption:=' ';
    i:=lignecliqueePN+1;
    tablo_PN[i].voie[3].ActFerme:=act;
    V3valide:=(EditV3O.text<>'') and (EditV3F.text<>'');
    NbVoies:=tablo_PN[i].NbVoies;
    if V3Valide and (NbVoies=2) then tablo_PN[i].NbVoies:=3;
    if not(V3Valide) then tablo_PN[i].NbVoies:=2;
    s:=encode_act_PN(i);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditV3OChange(Sender: TObject);
var s : string;
    i,act,erreur,NbVoies : integer;
    V3valide : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV3O Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV3O.Text;
    Val(s,act,erreur);
    if (erreur<>0) and (s<>'') then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 3 ouvre';exit
    end else LabelInfo.caption:=' ';
    i:=lignecliqueePN+1;
    tablo_PN[i].voie[3].ActOuvre:=act;
    V3valide:=(EditV3O.text<>'') and (EditV3F.text<>'');
    NbVoies:=tablo_PN[i].NbVoies;
    if V3Valide and (NbVoies=2) then tablo_PN[i].NbVoies:=3;
    if not(V3Valide) then tablo_PN[i].NbVoies:=2;
    s:=encode_act_PN(i);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.ButtonNouvAccClick(Sender: TObject);
var s: string;
    i : integer;
begin
  if affevt then affiche('Evt bouton nouveau acc',clyellow);
  clicliste:=true;
  inc(maxTablo_act);
  i:=MaxTablo_act;

  radioButtonLoc.Checked:=true;
  Tablo_actionneur[maxtablo_act].act:=false;
  Tablo_actionneur[maxtablo_act].loco:=true;

  s:=encode_act_loc(i); 
  if ligneClicAct<>-1 then RE_ColorLine(RichAct,ligneClicAct,ClAqua);

  // ajouter et scroller en fin
  with richAct do
  begin
    Lines.add(s);
    SetFocus;
    Selstart:=RichAct.GetTextLen-1;
    Perform(EM_SCROLLCARET,0,0);
  end;
 
  GroupBoxRadio.Visible:=true;
  LabelInfo.caption:='';
  LigneClicAct:=i-1;
  AncligneClicAct:=ligneClicAct;
  Aff_champs_Act(maxTablo_act-1);
  clicliste:=false;  
  config_modifie:=true;
end;


procedure TFormConfig.ButtonNouvPNClick(Sender: TObject);
var s: string;
    i : integer;
begin
  if affevt then affiche('Evt bouton nouveau PN',clyellow);
  clicliste:=true;
  inc(nbrePN);
  i:=nbrePN;

  Tablo_PN[i].NbVoies:=1;
  
  s:=encode_act_pn(i); 
  if LigneCliqueePN<>-1 then RE_ColorLine(RichPN,ligneCliqueePN,ClAqua);

  // ajouter et scroller en fin
  with richPN do
  begin
    Lines.add(s);
    SetFocus;
    Selstart:=RichPN.GetTextLen-1;
    Perform(EM_SCROLLCARET,0,0);
  end;
 
  GroupBoxRadio.Visible:=false;
  LabelInfo.caption:='';
  LigneCliqueePN:=i-1;
  AncLigneCliqueePN:=LigneCliqueePN;
  Aff_champs_PN(nbrePN-1);
  clicliste:=false;  
  config_modifie:=true;
end;

procedure TFormConfig.ButtonSupAccClick(Sender: TObject);
var i,index,adr : integer;
    s: string;
begin
  if affevt then affiche('Evt bouton Sup acc',clyellow);

  i:=ligneClicAct;
  if (i=-1) then exit;
  index:=i+1; // passe en index tableau
  
  adr:=tablo_actionneur[index].actionneur;
  s:='Voulez-vous supprimer l''actionneur '+IntToSTR(adr)+'?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  Affiche('Suppression de l''actionneur index='+IntToSTR(index)+' adresse='+IntToSTR(adr),clOrange);
  
  clicliste:=true;
  
  // supprime l'actionneur du tableau
  dec(maxTablo_act);
  for i:=index to maxTablo_act do
  begin
    tablo_actionneur[i]:=tablo_actionneur[i+1];
  end;
  
  clicliste:=false;  
  config_modifie:=true;

  RichAct.Clear;
  for i:=1 to maxTablo_act do
  begin
    s:=encode_act_loc(i);
    if s<>'' then
    begin
      RichAct.Lines.Add(s);
      RE_ColorLine(RichAct,RichAct.lines.count-1,ClAqua);
    end;   
  end;  
  AncligneClicAct:=-1;
  ligneClicAct:=-1;
end;

procedure TFormConfig.ButtonSupPNClick(Sender: TObject);
var i,index,adr : integer;
    s: string;
begin
  if affevt then affiche('Evt bouton Sup PN',clyellow);
  i:=lignecliqueePN;
  if (i=-1) then exit;
  index:=i+1; // passe en index tableau

  adr:=tablo_PN[index].voie[1].ActFerme;
  s:='Voulez-vous supprimer l''actionneur '+IntToSTR(adr)+'?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  Affiche('Suppression de l''actionneur index='+IntToSTR(index)+' adresse='+IntToSTR(adr),clOrange);
  
  clicliste:=true;
  
  // supprime l'actionneur du tableau
  dec(nbrePN);
  for i:=index to nbrePN do
  begin
    tablo_PN[i]:=tablo_PN[i+1];
  end;
  
  clicliste:=false;  
  config_modifie:=true;

  RichPN.Clear;
  for i:=1 to NbrePN do
  begin
    s:=encode_act_PN(i);
    if s<>'' then
    begin
      RichPN.Lines.Add(s);
      RE_ColorLine(RichPN,RichPN.lines.count-1,ClAqua);
    end;   
  end;  
  lignecliqueePN:=-1;
  AncLigneCliqueePN:=-1;
end;

procedure TFormConfig.ButtonNouvFeuClick(Sender: TObject);
var i : integer;
    s : string;
begin
  clicliste:=true;
  inc(NbreFeux);
  i:=NbreFeux;
  feux[i].Adresse:=999;
  feux[i].Aspect:=3;
  feux[i].decodeur:=0;
  feux[i].verrouCarre:=false;
  
  cree_image(i);
  //Affiche('Feu 999 créé',clyellow);
  s:=encode_sig_feux(i); 
  if ligneClicSig<>-1 then RE_ColorLine(RichSig,ligneClicSig,ClAqua);

  // ajouter et scroller en fin
  with richSig do
  begin
    Lines.add(s);
    SetFocus;
    Selstart:=RichSig.GetTextLen-1;
    Perform(EM_SCROLLCARET,0,0);
  end;
  
  LabelInfo.caption:='';
  ligneClicSig:=i-1;
  AncligneClicSig:=ligneClicSig;
  Aff_champs_Sig_feux(i);
  clicliste:=false;
  Feu_sauve.Adresse:=0;
  config_modifie:=true;
end;

procedure TFormConfig.ButtonSupFeuClick(Sender: TObject);
var i,index : integer;
    s : string;
begin
  if affevt then affiche('Evt bouton Sup Feu',clyellow);
  i:=ligneClicSig;
  if (i=-1) then exit;
  index:=i+1; // passe en index tableau

  s:='Voulez-vous supprimer le feu '+IntToSTR(feux[index].adresse)+'?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  Affiche('Suppression du feu ='+IntToSTR(feux[index].adresse),clOrange);
  
  clicliste:=true;
  Feu_supprime:=feux[index];  // sauvegarde le feu supprimé
  Feu_sauve.adresse:=0; // dévalider sa définition
  // supprime le feu du tableau
  dec(NbreFeux);
  ButtonInsFeu.Caption:='Ajouter le feu '+intToSTR(feux[index].adresse)+' supprimé';

  feux[index].Img.free;  // supprime l'image, ce qui efface le feu du tableau graphique
  Feux[index].Lbl.Free;  // supprime le label, ...
  if Feux[index].check<>nil then begin Feux[index].check.Free;Feux[index].Check:=nil;end;  // supprime le check du feu blanc s'il existait
  // décale le tableau de feux et recalcule les positions des images
  for i:=index to NbreFeux do
  begin
    feux[i]:=feux[i+1];
    with feux[i].Img do
    begin
      Top:=(HtImg+espY+20)*((i-1) div NbreImagePLigne);   // détermine les points d'origine
      Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
    end;  
    with feux[i].Lbl do
    begin
      Top:=HtImg+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
    end;
    if Feux[i].check<>nil then
    with Feux[i].Check do
    begin
      Hint:=intToSTR(i);  
      Top:=HtImg+15+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
    end;   
  end;
     
  EditAdrSig.Text:='';
  EditDet1.Text:='';EditDet2.Text:='';EditDet3.Text:='';EditDet4.Text:='';
  EditSuiv1.Text:='';EditSuiv2.Text:='';EditSuiv3.Text:='';EditSuiv4.Text:='';
    
  config_modifie:=true;

  RichSig.Clear;

  // réafficher le richsig
  for i:=1 to NbreFeux do
  begin
    s:=encode_Sig_Feux(i);
    if s<>'' then
    begin
      RichSig.Lines.Add(s);
      RE_ColorLine(RichSig,RichSig.lines.count-1,ClAqua);
    end;   
  end;  
  ligneClicSig:=-1;                    
  AncligneClicSig:=-1;
  raz_champs_sig;
  clicliste:=false;
end;

procedure TFormConfig.ButtonInsFeuClick(Sender: TObject);
var s : string;
begin
  if feu_supprime.adresse<>0 then
  begin
    clicliste:=true;
    inc(NbreFeux);
    feux[NbreFeux]:=Feu_supprime;
    Feu_Supprime.adresse:=0;  // dévalider le feu sauvegardé
    cree_image(nbrefeux);
    config_modifie:=true;
    // réafficher le rechedit
    s:=encode_Sig_Feux(NbreFeux);
    if s<>'' then
    begin
      with RichSig do
      begin
        ButtonInsFeu.Caption:='Ajouter le feu supprimé';
        Lines.Add(s);
        RE_ColorLine(RichSig,RichSig.lines.count-1,ClYellow);
        ligneClicSig:=NbreFeux-1;
        AncligneClicSig:=-1;
        SetFocus;
        Selstart:=RichSig.GetTextLen-1;
        Perform(EM_SCROLLCARET,0,0);
      end;
      Aff_champs_sig_feux(NbreFeux);
    end; 
    clicListe:=false;
  end;
end;


function verif_coherence : boolean;
var i,j,k,l,aig,adr,adr2,detect,modele,condcarre,nc : integer;
    ok : boolean;
begin
  // vérification de la cohérence1
  // parcoure les branches jusqu'à trouver un aiguillage pour voir s'il a été décrit
  ok:=true;
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;
      modele:=BrancheN[i][j].BType;  // 1= détecteur  2= aiguillage  4=Buttoir
      if (modele=2) then
      begin
        //affiche('trouvé aig '+intToSTR(detect),clyellow);
        modele:=aiguillage[Index_Aig(detect)].modele;
        if (modele=0) then
          begin
            Affiche('Erreur 1: Aiguillage '+intToStr(detect)+' non décrit mais présent en branche '+intToStr(i)+' pos. '+intToSTR(j),clred);
            ok:=false;
          end;
      end;
      j:=j+1;
    until((modele=0) and (detect=0));
  end;

  // vérification de la cohérence2
  // parcoure les aiguillages pour voir si les détecteurs sont en branches des détecteurs
  // et les tjd pour voir si pb de cohérence
  for aig:=1 to maxaiguillage do
  begin
    // tjd ou tjs
    if (aiguillage[aig].modele=2) or (aiguillage[aig].modele=3) then
    begin
      if aiguillage[aig].Ddroit<>aiguillage[aig].Ddevie then
      begin
        Affiche('Erreur 7: la TJD/S '+IntToStr(aig)+' a des adresses de destination différentes ('+intToSTR(aiguillage[aig].Ddroit)+' et '+intToSTR(aiguillage[aig].Ddevie)+')',clred);
        ok:=false;
      end;  
      // vérifier si son homologue est une tjd
      adr2:=aiguillage[aig].Ddroit;
      if (aiguillage[Index_Aig(adr2)].modele<>2) and (aiguillage[Index_Aig(adr2)].modele<>3) then 
      begin
        Affiche('Erreur 8: l''aiguillage '+intToStr(Adr2)+' n''est pas une TJD/S ou n''existe pas, mais apparait dans la TJD/S '+IntToSTR(aiguillage[aig].Adresse),clred);
        ok:=false;
      end;
    end;
    // vérifier si l'aiguillage est dans les branches
    if aiguillage[aig].modele<>0 then
    begin
      trouve_aiguillage(aiguillage[aig].adresse); // passe l'adresse de l'aiguillage à trouver
      if (IndexBranche_trouve=0) then
      begin
        Affiche('Avertissement 6: aiguillage '+intToSTR(aiguillage[aig].adresse)+' décrit dans les aiguillages ; absent dans la description des branches',clOrange);
        ok:=false;
      end;
    end;
    adr:=aiguillage[aig].Adroit;
    if (aiguillage[aig].AdroitB='Z') then
    begin           
      trouve_detecteur(adr);
      if IndexBranche_trouve=0 then
      begin
        Affiche('Erreur 2: détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[aig].adresse)+' mais absent dans la description des branches',clred);
        ok:=false;
      end;
    end;
    adr:=aiguillage[aig].Adevie;
    if (aiguillage[aig].AdevieB='Z') then
    begin
      trouve_detecteur(adr);
      if IndexBranche_trouve=0 then
      begin
        Affiche('Erreur 3: détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[aig].adresse)+' mais absent dans la description des branches',clRed);
        ok:=false;
      end;  
    end;
    adr:=aiguillage[aig].Apointe;
    if ((aiguillage[aig].ApointeB='Z') and (aiguillage[aig].modele=1)) then
    begin
      trouve_detecteur(adr);
      if IndexBranche_trouve=0 then
      begin
        Affiche('Erreur 4 : détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[aig].adresse)+' mais absent dans la description des branches',clRed);
        ok:=false;
      end;
    end;
    if (aiguillage[aig].modele=4) then // aiguillage triple
    begin
      if (aiguillage[aig].Adevie2B='Z') then
      begin
        adr:=aiguillage[aig].Adevie2;
        trouve_detecteur(adr);
        if IndexBranche_trouve=0 then
        begin
          Affiche('Erreur 5 : détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[aig].adresse)+' mais absent dans la description des branches',clRed);
          ok:=false;
        end;
      end;
    end;
  end;

  // cohérence 3 : vérifie si aiguillage triple ok et si doublon aiguillage
  for aig:=1 to maxaiguillage do
  begin
    adr:=aiguillage[aig].Adresse;
    if aiguillage[aig].modele=4 then 
    begin
      if aiguillage[aig].AdrTriple=0 then 
      begin
        Affiche('Erreur 6.1 : 2ème adresse de l''aiguillage triple '+intToSTR(adr)+' non définie',clred);
        ok:=false;
      end;
    end;
    for i:=aig+1 to maxaiguillage do
    begin
      if adr=aiguillage[i].Adresse then 
      begin
        affiche('Erreur 6.2 : aiguillage '+intToSTR(adr)+' défini deux fois',clred);
        ok:=false;
      end;
    end;     
  end; 

  // cohérence 4 : vérifie si doublon signal
  for j:=1 to NbreFeux do
  begin
    adr:=feux[j].Adresse;
    for i:=j+1 to NbreFeux do
    begin
      if adr=feux[i].Adresse then 
      begin
        affiche('Erreur 7 : signal '+intToSTR(adr)+' défini deux fois',clred);
        ok:=false;  
      end;
    end;     
  end; 
  
  // cohérence 5 ; vérifie si aiguillages définis en condition supplémentaires de carré existent
  for j:=1 to NbreFeux do
  begin
    l:=1;
    repeat
      nc:=Length(feux[j].condcarre[l])-1 ;
      for k:=1 to nc do
      begin
        adr:=feux[j].condcarre[l][k].Adresse; // adresse de l'aiguillage
        if index_aig(adr)=0 then
        begin
          Affiche('Avertissement : Aig '+intToSTR(adr)+' défini dans les cond de carré du signal '+intToSTR(feux[j].adresse)+' mais non existant',clOrange);
          ok:=false;
        end;
      end;
      inc(l);
    until (nc<=0) or (l>6);
  end;

  // cohérence 6 : vérifier si les détecteurs et les aiguillages associés aux signaux existent
  for j:=1 to NbreFeux do
  begin
    i:=feux[j].Adr_det1;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;
    
    i:=feux[j].Adr_det2;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;
    
    i:=feux[j].Adr_det3;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;
    
    i:=feux[j].Adr_det4;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;

    // élement suivant 1
    i:=feux[j].Adr_el_suiv1;
    k:=feux[j].Btype_suiv1;
    if i<>0 then
    begin
      if k=1 then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if (k>=2) then
      begin
        // aiguillage
        if index_aig(i)=0 then 
        begin
          ok:=false;
          Affiche('Erreur : aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;

    // élement suivant 2
    i:=feux[j].Adr_el_suiv2;
    k:=feux[j].Btype_suiv2;
    if i<>0 then
    begin
      if k=1 then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if (k>=2) then
      begin
        // aiguillage
        if index_aig(i)=0 then 
        begin
          ok:=false;
          Affiche('Erreur : aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;

    // élement suivant 3
    i:=feux[j].Adr_el_suiv3;
    k:=feux[j].Btype_suiv3;
    if i<>0 then
    begin
      if k=1 then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if (k>=2) then
      begin
        // aiguillage
        if index_aig(i)=0 then 
        begin
          ok:=false;
          Affiche('Erreur : aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;
    
    // élement suivant 4
    i:=feux[j].Adr_el_suiv4;
    k:=feux[j].Btype_suiv4;
    if i<>0 then
    begin
      if k=1 then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur : Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if (k>=2) then
      begin
        // aiguillage
        if index_aig(i)=0 then 
        begin
          ok:=false;
          Affiche('Erreur : aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;
  end;
  verif_coherence:=ok;
end;

procedure TFormConfig.ButtonNouvAigClick(Sender: TObject);
var i : integer;
    s : string;
begin
  clicliste:=true;
  inc(MaxAiguillage);
  i:=MaxAiguillage;
  aiguillage[i].Adresse:=999;
  aiguillage[i].modele:=1;
  aiguillage[i].modele:=1;
  aiguillage[i].AdroitB:='Z'; aiguillage[i].AdevieB:='Z';
  aiguillage[i].DdroitB:='D'; aiguillage[i].DdevieB:='S'; // préparation pour TJD/S
  aiguillage[i].ApointeB:='Z';
  aiguillage[i].Adevie2B:='Z';   
  aiguillage[i].tjsintB:='D';   
  
  aiguillage[i].posInit:=const_inconnu;
  aiguillage[i].Temps:=5;
  
  s:=encode_Aig(i); 
  if ligneClicAig<>-1 then RE_ColorLine(RichAig,ligneClicAig,ClAqua);
  // scroller à la fin
  with richAig do
  begin
    Lines.add(s);
    SetFocus;
    Selstart:=RichAig.GetTextLen-1;
    Perform(EM_SCROLLCARET,0,0);
  end;    

  LabelInfo.caption:='Aiguillage '+intToSTR(aiguillage[i].Adresse)+' créé';
  ligneClicAig:=i-1;
  AncligneClicAig:=ligneClicAig;
  Aff_champs_aig_tablo(i);
  clicliste:=false;  
  config_modifie:=true;
  Aig_sauve.Adresse:=0;
end;

procedure TFormConfig.BoutSupAigClick(Sender: TObject);
var i,index,index2 : integer;
    s : string;
begin
  i:=ligneClicAig;
  if (i<0) then exit;
  index:=i+1; // passe en index tableau

  s:='Voulez-vous supprimer l''aiguillage '+IntToSTR(aiguillage[index].adresse)+'?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  Affiche('Suppression de l''aiguillage='+IntToSTR(aiguillage[index].adresse),clOrange);
  ButtonAjSup.Caption:='Ajouter l''aig '+intToSTR(aiguillage[index].adresse)+' supprimé';
  clicliste:=true;
  raz_champs_aig;
  Aig_supprime:=aiguillage[index];  // sauvegarde le supprimé
  Aig_sauve.adresse:=0;             // dévalider sa définition

  // efface les attributs de l'aiguillage supprimé
  aiguillage[index].Adresse:=0;
  aiguillage[index].Modele:=0;
  aiguillage[index].Adroit:=0;
  aiguillage[index].Adevie:=0;
  aiguillage[index].Ddroit:=0;
  aiguillage[index].Ddevie:=0;
  aiguillage[index].APointe:=0;
  aiguillage[index].modifie:=false;
  
  // supprime l'aiguillage du tableau
  dec(MaxAiguillage);
  for i:=index to MaxAiguillage do
  begin
    Aiguillage[i]:=Aiguillage[i+1];
  end;
  
  config_modifie:=true;
  RichAig.Clear;

  // réafficher le richsig
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_Aig(i);
    if s<>'' then
    begin
      RichAig.Lines.Add(s);
      RE_ColorLine(RichAig,RichAig.lines.count-1,ClAqua);
    end;  
  end;  
  ligneClicAig:=-1;
  AncligneClicAig:=-1;
  clicliste:=false;
end;

procedure TFormConfig.EditP1KeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,adr2,erreur,index,id2 : integer;
    b,c : char;
    s : string;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change P1',clyellow);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneClicAig];
    Val(s,adrAig,erreur);
      
    //vérifier la syntaxe de P
    s:=EditP1.text;
    if RightStr(s,1)<>'D' then
    begin
      clicListe:=true;
      s:=s+'D';
      editP1.text:=s;
      clicListe:=false;
    end;
    
    decodeAig(s,adr,B);
    if (B='D') and (adr<>0) then 
    begin
      LabelInfo.caption:='';
      RE_ColorLine(RichAig,ligneClicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
          
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      adr2:=aiguillage[index].DDevie;  // ancien aiguillage associé à la tjd
      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP2.Text:=IntToSTR(adr)+c;
      clicliste:=false;
      LabelInfo.caption:='Changement de l''adresse de la TJD de '+IntToSTR(adr2)+' à '+intToSTR(adr) ;

      id2:=Index_Aig(Adr);
      if (aiguillage[id2].modele<>0) then 
      begin
        LabelInfo.caption:='aiguillage '+IntToSTR(adr)+' existe déja - ne sera pas écrasé' ;
        exit;
      end ;
      aiguillage[index].Adresse:=adr;
      clicliste:=true;
      editAdrAig.Text:=IntToSTR(adr);
      clicListe:=false;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneClicAig]:=s;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneClicAig]:=s;
      // changer l'homologue
      adr2:=aiguillage[index].Ddroit;
      index:=index_aig(Adr2);
      aiguillage[index].Ddroit:=adr;
      aiguillage[index].Ddevie:=adr;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end
      else
        LabelInfo.caption:='Erreur P1 TJD '+intToSTR(AdrAig);
    end;  
end;

procedure TFormConfig.EditP2KeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,adr2,erreur,index,id2 : integer;
    b,c : char;
    s : string;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change P2',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneClicAig];
    Val(s,adrAig,erreur);
      
    //vérifier la syntaxe
    s:=EditP2.text;
    if RightStr(s,1)<>'S' then
    begin
      clicListe:=true;
      s:=s+'S';
      editP2.text:=s;
      clicListe:=false;
    end;
    
    decodeAig(s,adr,B);
    if (B='S') and (adr<>0) then 
    begin
      LabelInfo.caption:='';
      RE_ColorLine(RichAig,ligneClicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
          
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      adr2:=aiguillage[index].DDevie;  // ancien aiguillage associé à la tjd
      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP1.Text:=IntToSTR(adr)+c;
      clicliste:=false;

      LabelInfo.caption:='Changement de l''adresse de la TJD de '+IntToSTR(adr2)+' à '+intToSTR(adr) ;

      id2:=Index_Aig(Adr);
      if (aiguillage[id2].modele<>0) then 
      begin
        LabelInfo.caption:='aiguillage '+IntToSTR(adr)+' existe déja - ne sera pas écrasé' ;
        exit;
      end ;
      aiguillage[index].Adresse:=adr;
      clicliste:=true;
      editAdrAig.Text:=IntToSTR(adr);
      clicListe:=false;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneClicAig]:=s;
      // changer l'homologue
      adr2:=aiguillage[index].Ddroit;
      index:=index_aig(Adr2);
      aiguillage[index].Ddroit:=adr;
      aiguillage[index].Ddevie:=adr;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end
      else
        LabelInfo.caption:='Erreur P2 TJD '+intToSTR(AdrAig);
    end;  
end;

procedure TFormConfig.EditP3KeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,adr2,erreur,index,modele : integer;
    b,c : char;
    s : string;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change P3',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneClicAig];
    Val(s,adrAig,erreur);           // adrAig est l'adresse de l'aiguillage modifié
      
    //vérifier la syntaxe
    s:=EditP3.text;
    if RightStr(s,1)<>'S' then
    begin
      clicListe:=true;
      s:=s+'S';
      editP3.text:=s;
      clicListe:=false;
    end;
    
    decodeAig(s,adr,B);            // adr est le contenu du champ P3
    if (B='S') and (adr<>0) then 
    begin
      LabelInfo.caption:='';
      RE_ColorLine(RichAig,ligneClicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
      modele:=aiguillage[Index].modele;

      if modele=3 then // TJS
      begin
        LabelL.caption:=IntToSTR(adr);
        aiguillage[index].tjsint:=adr;
      end;

      
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      adr2:=aiguillage[index].DDevie;  // ancien aiguillage associé à la tjd
      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP4.Text:=IntToSTR(adr)+c;
      clicliste:=false;
      LabelInfo.caption:='Changement de la TJD homologue de '+IntToSTR(adr2)+' à '+intToSTR(adr) ;

      adr2:=aiguillage[index].Ddroit;  // 'ancienne' adresse homologue avant écrasement
      aiguillage[index].Ddroit:=adr;
      //aiguillage[index].DdroitB:=B;
      aiguillage[index].Ddevie:=adr;
      aiguillage[index].DdevieB:=B;
      
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneClicAig]:=s;

      // changer l'homologue
      index:=index_aig(Adr);
      if index=0 then    // si elle n'existe pas la créer
      begin
        // créer homologue
        if modele=2 then labelInfo.Caption:='Création de la TJD homologue '+IntToSTR(adr);
        if modele=3 then labelInfo.Caption:='Création de la TJS homologue '+IntToSTR(adr);
        
        inc(MaxAiguillage);
        index:=MaxAiguillage;
        aiguillage[index].Adresse:=Adr;
        aiguillage[Index].modele:=modele;
        aiguillage[Index].Adroit:=0;
        aiguillage[Index].AdroitB:='D';
        aiguillage[Index].Adevie:=0;
        aiguillage[Index].AdevieB:='D';
        aiguillage[Index].Ddroit:=adrAig;
        aiguillage[Index].DdroitB:='D';
        aiguillage[Index].Ddevie:=adrAig;
        aiguillage[Index].DdevieB:='S';
        aiguillage[Index].APointeB:='Z';
        aiguillage[Index].tjsINTB:='S';
        
        s:=encode_aig(index);
        formconfig.RichAig.Lines[index-1]:=s;
        // scroller à la fin
        with richAig do
        begin
          SetFocus;
          Selstart:=RichAig.GetTextLen-1;
          Perform(EM_SCROLLCARET,0,0);
          RE_ColorLine(RichAig,index-1,ClAqua);
          HideCaret(richAig.Handle); // éteint curseur
        end;
      end  // fin de la création
      else 
      begin
        // existe, vérifier si c'est bien une TJD/S
        modele:=aiguillage[Index].modele;
        if (modele=2) or (modele=3) then
        begin
          aiguillage[index].adresse:=adr;
          s:=encode_aig(index);
          formconfig.RichAig.Lines[index-1]:=s;
        end
        else 
          labelInfo.caption:='L''aiguillage '+IntToSTR(adr)+' existe, il ne sera pas écrasé';
      end;    
    end
      else
        LabelInfo.caption:='Erreur P3 TJD '+intToSTR(AdrAig);
    end;  
end;


procedure TFormConfig.EditP4KeyPress(Sender: TObject; var Key: Char);
var AdrAig,adr,adr2,erreur,index : integer;
    b,c : char;
    s : string;
begin
  if clicliste or (ord(Key)<>VK_RETURN) then exit;
  if affevt then affiche('Evt change P4',clyellow);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[ligneClicAig];
    Val(s,adrAig,erreur);
      
    //vérifier la syntaxe
    s:=EditP4.text;
    if RightStr(s,1)<>'D' then
    begin
      clicListe:=true;
      s:=s+'D';
      editP4.text:=s;
      clicListe:=false;
    end;
    
    decodeAig(s,adr,B);
    if (B='D') and (adr<>0) then 
    begin
      LabelInfo.caption:='';
      RE_ColorLine(RichAig,ligneClicAig,ClWhite);
      Index:=Index_Aig(AdrAig);
          
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      adr2:=aiguillage[index].DDevie;  // ancien aiguillage associé à la tjd
      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP3.Text:=IntToSTR(adr)+c;
      clicliste:=false;
      LabelInfo.caption:='Changement de la TJD homologue de '+IntToSTR(adr2)+' à '+intToSTR(adr) ;

      adr2:=aiguillage[index].Ddroit;  // 'ancienne' adresse homologue avant écrasement
      aiguillage[index].Ddroit:=adr;
      //aiguillage[index].DdroitB:=B;
      aiguillage[index].Ddevie:=adr;
      aiguillage[index].DdevieB:=B;
      
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneClicAig]:=s;

      // changer l'homologue
      index:=index_aig(Adr2);
      aiguillage[index].adresse:=adr;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end
      else
        LabelInfo.caption:='Erreur P4 TJD '+intToSTR(AdrAig);
    end;  
end;

procedure TFormConfig.ButtonAjSupClick(Sender: TObject);
var s : string;
begin
  if Aig_supprime.adresse<>0 then
  begin
    inc(MaxAiguillage);
    aiguillage[MaxAiguillage]:=Aig_supprime;
    Aig_Supprime.adresse:=0;  // dévalider l'aiguillage sauvegardé
    Aig_Supprime.modele:=0;  
    clicListe:=true;
    config_modifie:=true;

    // réafficher les rechedit et scroller à la fin
    s:=encode_Aig(MaxAiguillage);  // ligne de l'aiguillage
    if s<>'' then
    with RichAig do
    begin
      ButtonAjSup.Caption:='Ajouter l''aig supprimé';
      ligneClicAig:=MaxAiguillage-1;
      AncligneClicAig:=-1;
      RichAig.Lines.Add(s);
      RE_ColorLine(RichAig,RichAig.lines.count-1,clYellow);
      SetFocus;
      Selstart:=RichAig.GetTextLen-1;
      Perform(EM_SCROLLCARET,0,0);
    end; 
    Aff_champs_aig_tablo(MaxAiguillage);
  end;  
  clicListe:=false;
end;

procedure TFormConfig.ButtonRestaureAigClick(Sender: TObject);
var index : integer;
begin
  if (Aig_sauve.adresse<>0) and (ligneclicAig>=0) then
  begin
    clicListe:=true;
    index:=ligneclicAig+1;    
    Aiguillage[index]:=Aig_sauve;
    RichAig.Lines[ligneclicAig]:=encode_Aig(index);
    aff_champs_Aig_tablo(index);  // réaffiche les champs 
    clicListe:=false;
  end;  
end;

procedure TFormConfig.ComboBoxAigChange(Sender: TObject);
var s: string;
    i : integer;
begin
  if clicListe then exit;
  if MaxAiguillage<ligneclicAig+1 then exit;
  if affevt then Affiche('Evt ComboBox Aiguillage',clOrange);
  i:=ligneclicAig+1;
  aiguillage[i].modele:=ComboBoxAig.ItemIndex+1;
  s:=encode_aig(i);
  formconfig.RichAig.Lines[ligneclicAig]:=s;
  clicliste:=true;
  Aff_champs_aig_tablo(i);
  clicliste:=false;
end;  

procedure TFormConfig.ButtonValLigneClick(Sender: TObject);
var s: string;
    ligne,esp : integer;
    ok : boolean;
begin
  ligne:=1;
  ok:=true;
  repeat 
    s:=RichBranche.Lines[ligne-1];
    if s<>'' then
    begin
      // supprime les espaces éventuels
      repeat
        esp:=pos(' ',s);
        if esp<>0 then delete(s,esp,1);
      until esp=0;
      if s<>'' then 
      begin
        RichBranche.Lines[ligne-1]:=s;
        branche[ligne]:=s;  // stocker la ligne dans la branche pour la compiler
        if compile_branche(s,ligne) then 
        begin
          RE_ColorLine(RichBranche,Ligne-1,ClLime);
        end
        else 
        begin
          RE_ColorLine(RichBranche,Ligne-1,ClRed);
          labelResult.Caption:='Erreur de syntaxe';
          ok:=false;
        end; 
        inc(ligne); 
      end
    else RichBranche.Lines.Delete(ligne-1);
  end
  else RichBranche.Lines.Delete(ligne-1);
    
  until ligne>RichBranche.Lines.count;
  NbreBranches:=ligne-1;
  if ok then labelResult.Caption:='Syntaxe correcte';
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

// trouve l'enregistrement suivant après l'offset dans une branche
// en sortie : trouve_enregistrement= nouvel offset, enregistrement
// si 0 en sortie: fin de ligne
function trouve_enregistrement_suiv(num_branche : integer;offset : integer) : integer;
var j : integer;
    ss : string;
begin
  j:=virgule_suiv(branche[Num_Branche],offset);    // pointe sur la virgule suivante
  if j<>0 then ss:=copy(branche[Num_Branche],offset,j-offset) // champ suivant
        else ss:=copy(branche[Num_Branche],offset,length(branche[Num_Branche])-offset+1); // si j=0 c'est la fin de la chaîne
  enregistrement:=ss;
  if j=0 then result:=0 else result:=j+1;
end;

// compile une branche de réseau sous forme de texte, et la stocke dans le tableau des branches
// i = index de la branche à stocker
function compile_branche(s : string;i : integer) : boolean;
var offset,j,bd,detect,erreur,adresse,erreur2 : integer;
    c : char;
    trouve,code : boolean;
    se : string;
begin
   j:=1;offset:=1;
   code:=true;
   // la boucle repeat parcoure la ligne s
   repeat
     BrancheN[i,j].adresse:=0; // préparer le suivant à 0
     offset:=trouve_enregistrement_suiv(i,offset) ;
     if enregistrement='' then
     begin
       Affiche('Erreur ligne '+s,clred);
       compile_branche:=false;
       exit;
     end;
     se:=enregistrement;
     // décoder l'enregistrement
     // si c'est un détecteur, fini trouvé
     Val(enregistrement,detect,erreur);      // détermine si le champ est numérique ou pas  (cad si aiguillage)
     // il y a un aiguillage   ou un espace après le champ....en fin de ligne
     if erreur<>0 then
     begin
       c:=enregistrement[1];
       delete(enregistrement,1,1);
       if c='A' then
       begin
         Val(enregistrement,adresse,erreur2);
         if (adresse=0) or (erreur2<>0) then
         begin
           Affiche('Erreur 17 champ '+se+' ligne '+s,clred);
           code:=false;
         end;
         BrancheN[i,j].adresse:=adresse;
         BrancheN[i,j].btype:=2; // ident aiguillage
       end
       else 
       begin
         Affiche('Erreur 18 champ '+se+' ligne '+s,clred);
         code:=false;
         erreur:=0; // forcer erreur à 0 pour obliger à passer sur un détecteur
       end;  
     end;
     // détecteur
     if erreur=0 then
     begin
       BrancheN[i,j].adresse:=detect;          // adresse
       BrancheN[i,j].btype:=1;// ident détecteur
       if detect=0 then begin BrancheN[i,j].btype:=4;end; // buttoir
       // vérifier si le détecteur est déja stocké
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
     BrancheN[i,j].adresse:=0; // préparer le suivant à 0
     BrancheN[i,j].BType:=0;
     //Affiche('branche '+intToSTR(i)+' index='+intToStr(j),clGreen);
   until (offset=0);
   compile_branche:=code;
end;

procedure TFormConfig.RichBrancheMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var curseur,lc : integer;   
begin
  if clicListe then exit;
  clicListe:=true;
  if affevt then affiche('Evt RichBranche clic',clyellow);
  with Formconfig.RichBranche do
  begin
    lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    AncligneClicBr:=ligneClicBr;
    ligneClicBr:=lc;
    curseur:=SelStart;  // position initiale du curseur
    if AncligneClicBr<>ligneClicBr then 
    begin
      if AncligneClicBr<>-1 then 
      begin
        RE_ColorLine(RichBranche,AncligneClicBr,ClAqua);
      end;
      RE_ColorLine(RichBranche,ligneClicBr,ClYellow);
      selStart:=curseur;  // remettre le curseur en position initiale
    end;  
  end;  
  clicListe:=false;
end;

procedure TFormConfig.ButtonVerifConfigClick(Sender: TObject);
var s : string;
begin
  if verif_coherence then
  begin
    s:='La configuration est ok';  
    labelResult.Caption:=s;
    Affiche(s,clLime);
  end
  else
    labelResult.Caption:='Erreur de cohérence';
end;

procedure TFormConfig.MemoCarreChange(Sender: TObject);
var s,sO: string;
    j,erreur,adr,ligne,aspect : integer;
    c : char;
    dir : boolean;
begin
  if (ligneClicSig<0) or clicListe then exit;
  
  if affevt then affiche('Evt MemoCarre change',clyellow);
  clicMemo:=MemoCarre.Perform(EM_LINEFROMCHAR,-1,0);     // numéro de la ligne du curseur
  aspect:=feux[ligneClicSig+1].aspect;
  dir:=aspect>10;

  if dir and (clicMemo>aspect-10) then 
  begin
    clicListe:=true;
    LabelInfo.Caption:='Erreur '+intToSTR(aspect-9)+' conditions maxi pour un feu à '+intToSTR(aspect-10)+' directions';
    MemoCarre.Lines.Delete(clicMemo);
    clicListe:=false;
    exit;
  end;

  if not(dir) and (clicMemo>5) then 
  begin
    clicListe:=true;
    LabelInfo.Caption:='Erreur 6 conditions maxi';
    MemoCarre.Lines.Delete(clicMemo);
    clicListe:=false;
    exit;
  end;
  
  // feu directionnel
  if dir then
  begin
    // boucle de ligne
    for ligne:=1 to 6 do
    begin
      s:=MemoCarre.Lines[ligne-1];
      sO:=s;
      // boucle de chaine
      j:=1;
      if s<>'' then 
      repeat
        if s[1]<>'A' then begin LabelInfo.Caption:='Erreur manque A : '+sO;exit;end;
        delete(s,1,1);
        val(s,adr,erreur);  // adresse
        if adr=0 then exit;
        c:=s[erreur];       // S ou D
        if (c<>'D') and (c<>'S') then begin LabelInfo.Caption:='Erreur manque D ou S : '+sO;exit;end;
        setlength(feux[ligneClicSig+1].AigDirection[ligne],j+1);  // augmenter le tableau dynamique
        feux[ligneClicSig+1].AigDirection[ligne][j].PosAig:=c;
        feux[ligneClicSig+1].AigDirection[ligne][j].Adresse:=adr;
        delete(s,1,erreur);   // supprime jusque D
        if length(s)<>0 then if s[1]=',' then delete(s,1,1);
        inc(j);
      until s=''
      else
        setlength(feux[ligneClicSig+1].AigDirection[ligne],0);
    end;  
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end
  
  else
  // feu normal
  begin
    // boucle de ligne
    for ligne:=1 to 6 do
    begin
      s:=MemoCarre.Lines[ligne-1];
      sO:=s;
      j:=1;
      if s<>'' then 
      repeat
        if s[1]<>'A' then begin LabelInfo.Caption:='Erreur manque A : '+sO;exit;end;
        delete(s,1,1);
        val(s,adr,erreur);  // adresse
        if adr=0 then exit;
        c:=s[erreur];       // S ou D
        if (c<>'D') and (c<>'S') then begin LabelInfo.Caption:='Erreur manque D ou S : '+sO;exit;end;
        setlength(feux[ligneClicSig+1].condCarre[ligne],j+1);  
        feux[ligneClicSig+1].condCarre[ligne][j].PosAig:=c;
        feux[ligneClicSig+1].condCarre[ligne][j].Adresse:=adr;
        delete(s,1,erreur);   // supprime jusque D
        if length(s)<>0 then if s[1]=',' then delete(s,1,1);
        inc(j);
      until s=''
      else
        setlength(feux[ligneClicSig+1].condCarre[ligne],0);
    end;    
  end;

   s:=encode_sig_feux(ligneClicSig+1);
   RichSig.Lines[ligneClicSig]:=s;
   LabelInfo.Caption:=''; 
end;  

procedure TFormConfig.EditAigTripleKeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,modele,erreur,index : integer;
begin
  if clicliste then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditAigTriple.Text;
    Val(s,i,erreur);
    index:=ligneclicAig+1;
    if index=0 then exit;

    modele:=aiguillage[index].modele;
    if (modele=4) then
    begin
      if (erreur<>0) then begin LabelInfo.caption:='Erreur adresse aiguillage ';exit;end;
      //  vérifier si l'adresse de l'aiguillage existe déja
      if (aiguillage[Index_Aig(i)].modele<>0) then 
      begin
        LabelInfo.caption:='aiguillage '+IntToSTR(i)+' existe déja - ne sera pas écrasé' ;
        EditAigTriple.Color:=clred;
        exit;
      end ;
      if i=0 then EditAigTriple.Color:=clred else EditAigTriple.Color:=clWindow;
      LabelInfo.caption:='';
      s:=encode_aig_gfx; 
      aiguillage[index].AdrTriple:=i;
      aiguillage[index].modifie:=true;              
      formconfig.RichAig.Lines[ligneclicAig]:=s;
    end;
  end;  
end;

procedure TFormConfig.ComboBoxDDChange(Sender: TObject);
var s: string;
    i,pos: integer;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=encode_aig_gfx;   
    i:=ComboBoxDD.ItemIndex;
    case i of
    0 :  pos:=const_devie;
    1 :  pos:=const_droit;
    2 :  pos:=const_inconnu;
    end;
    
    aiguillage[ligneclicAig+1].PosInit:=pos;
    aiguillage[ligneclicAig+1].modifie:=true;
    formconfig.RichAig.Lines[ligneclicAig]:=s;
    s:=encode_aig(ligneclicAig+1);
    RichAig.lines[ligneclicAig]:=s;
  end;
end;

procedure TFormConfig.EditTempo10KeyPress(Sender: TObject; var Key: Char);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ord(Key)<>VK_RETURN) or (ligneclicAig<0) then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditTempo10.Text;
    Val(s,i,erreur);
    if (i>0) and (i<50) then
    begin
      LabelInfo.caption:='';
      s:=encode_aig_gfx;
      aiguillage[ligneclicAig+1].temps:=i;
      aiguillage[ligneclicAig+1].modifie:=true;
      formconfig.RichAig.Lines[ligneclicAig]:=s;
      s:=encode_aig(ligneclicAig+1);
      RichAig.lines[ligneclicAig]:=s;
    end ;
  end;  
end;

procedure TFormConfig.CheckInvInitClick(Sender: TObject);
var adrAig,erreur : integer;
    s : string;
begin
  // récupérer l'adresse de l'aiguillage cliqué
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt change InvInit',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if checkInvInit.Checked then aiguillage[Index_Aig(adraig)].Inversion:=1 else aiguillage[Index_Aig(adraig)].Inversion:=0;
  // réencoder la ligne
  s:=encode_aig(Index_Aig(AdrAig));
  formconfig.RichAig.Lines[ligneclicAig]:=s;
end;

procedure TFormConfig.EditV4FChange(Sender: TObject);
var s : string;
    act,erreur,NbVoies,i : integer;
    V4valide : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt EditV4F Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV4F.Text;
    Val(s,act,erreur);
    if (erreur<>0) and (s<>'') then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 4 ferme';exit
    end else LabelInfo.caption:=' ';
    i:=lignecliqueePN+1;
    tablo_PN[i].voie[4].ActFerme:=act;
    V4valide:=(EditV4O.text<>'') and (EditV4F.text<>'');
    NbVoies:=tablo_PN[i].NbVoies;
    if V4Valide and (NbVoies<=3) then tablo_PN[i].NbVoies:=4;
    if not(V4Valide) then tablo_PN[i].NbVoies:=3;
    s:=encode_act_PN(i);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditV4OChange(Sender: TObject);
var s : string;
    i,act,erreur,NbVoies : integer;
    V4valide : boolean;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt EditV4O Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    s:=EditV4O.Text;
    Val(s,act,erreur);
    if (erreur<>0) and (s<>'') then
    begin
      LabelInfo.caption:='Erreur adresse actionneur voie 4 ouvre';exit
    end else LabelInfo.caption:=' ';
    i:=lignecliqueePN+1;
    tablo_PN[i].voie[4].ActOuvre:=act;
    V4valide:=(EditV4O.text<>'') and (EditV4F.text<>'');
    NbVoies:=tablo_PN[i].NbVoies;
    if V4Valide and (NbVoies<=3) then tablo_PN[i].NbVoies:=4;
    if not(V4Valide) then tablo_PN[i].NbVoies:=3;
    s:=encode_act_PN(i);
    RichPN.Lines[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.EditLChange(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt EditL Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  begin
    s:=EditL.Text;
    if s='' then exit;
    if (s[1]<>'S') and (s[1]<>'D') then 
    begin
      LabelInfo.caption:='Erreur Champ L : D ou S';exit;
    end;
    aiguillage[ligneclicAig+1].tjsintb:=s[1];
    s:=encode_aig(ligneclicAig+1);
    RichAig.Lines[ligneclicAig]:=s;
  end;  
end;

procedure TFormConfig.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormConfig.FormClose(Sender: TObject; var Action: TCloseAction);
var index : integer;
begin
  for index:=1 to NbreFeux do
  begin
    // créer les nouveau checkBox de feux blancs si de nouveaux ont été cochés
    if feux[index].FeuBlanc and (feux[index].check=nil) then
    begin
      feux[index].Check:=TCheckBox.create(Formprinc.ScrollBox1);  // crée le handle
      with Feux[index].Check do
      begin
        onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la procédure de traitement quand on clique dessus
        Hint:=intToSTR(index);
        caption:='dem FB';
        Parent:=Formprinc.ScrollBox1;
        width:=100;height:=15;
        Top:=HtImg+15+((HtImg+EspY+20)*((index-1) div NbreImagePLigne));
        Left:=10+ (LargImg+5)*((index-1) mod (NbreImagePLigne));
        BringToFront;
      end;  
    end;
    // supprimer les checkBox de feux blancs si ils ont été décochés
    if not(feux[index].FeuBlanc) and (feux[index].check<>nil) then 
    begin
      Feux[index].Check.free;
      Feux[index].Check:=nil;
    end;
  end;
end;

begin


begin

end;

end.


