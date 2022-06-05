Unit UnitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , verif_version, jpeg, ComCtrls ,StrUtils, Unitprinc,
  MMSystem, Buttons ;

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
    EditTrainDecl: TEdit;
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
    Label20: TLabel;
    ButtonConfigSR: TButton;
    GroupBoxEtatTJD: TGroupBox;
    RadioButtonTJD2: TRadioButton;
    RadioButtonTJD4: TRadioButton;
    RadioButtonSon: TRadioButton;
    EditSon: TEdit;
    LabelNomSon: TLabel;
    SpeedButtonJoue: TSpeedButton;
    CheckBoxRazSignaux: TCheckBox;
    EditTempoFeu: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    ButtonTestAct: TButton;
    RadioGroup1: TRadioGroup;
    RadioButtonActDet: TRadioButton;
    RadioButtonZones: TRadioButton;
    EditAct2: TEdit;
    OpenDialogSon: TOpenDialog;
    SpeedButtonCharger: TSpeedButton;
    LabelNumBranche: TLabel;
    EditTrainDest: TEdit;
    Label42: TLabel;
    Label43: TLabel;
    CheckBandeauTCO: TCheckBox;
    EditNbCantons: TEdit;
    Label44: TLabel;
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
    procedure EditTrainDeclChange(Sender: TObject);
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
    procedure EditP3KeyPress(Sender: TObject; var Key: Char);
    procedure EditP4KeyPress(Sender: TObject; var Key: Char);
    procedure EditP1KeyPress(Sender: TObject; var Key: Char);
    procedure EditP2KeyPress(Sender: TObject; var Key: Char);
    procedure EditDevieS2KeyPress(Sender: TObject; var Key: Char);
    procedure ButtonConfigSRClick(Sender: TObject);
    procedure EditDet1Change(Sender: TObject);
    procedure EditSuiv1Change(Sender: TObject);
    procedure EditAdrSigChange(Sender: TObject);
    procedure EditDet2Change(Sender: TObject);
    procedure EditSuiv2Change(Sender: TObject);
    procedure EditDet3Change(Sender: TObject);
    procedure EditSuiv3Change(Sender: TObject);
    procedure EditDet4Change(Sender: TObject);
    procedure EditSuiv4Change(Sender: TObject);
    procedure EditSpecUniChange(Sender: TObject);
    procedure EditAdrAigChange(Sender: TObject);
    procedure EditAigTripleChange(Sender: TObject);
    procedure EditPointe_BGChange(Sender: TObject);
    procedure EditDroit_BDChange(Sender: TObject);
    procedure EditDevie_HDChange(Sender: TObject);
    procedure EditTempo10Change(Sender: TObject);
    procedure Edit_HGChange(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure RadioButtonTJD2Click(Sender: TObject);
    procedure RadioButtonTJD4Click(Sender: TObject);
    procedure RadioButtonSonClick(Sender: TObject);
    procedure EditSonChange(Sender: TObject);
    procedure SpeedButtonJoueClick(Sender: TObject);
    procedure EditTempoFeuChange(Sender: TObject);
    procedure ButtonTestActClick(Sender: TObject);
    procedure RadioButtonActDetClick(Sender: TObject);
    procedure RadioButtonZonesClick(Sender: TObject);
    procedure EditAct2Change(Sender: TObject);
    procedure SpeedButtonChargerClick(Sender: TObject);
    procedure RichBrancheKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditTrainDestChange(Sender: TObject);
    procedure RichAigKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RichSigKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
// variables du fichier de configuration
NomConfig='ConfigGenerale.cfg';
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
MasqueBandeauTCO_ch='MasqueBandeauTCO';
CDM_ch='CDM';
Serveur_interface_ch='Serveur_interface';
fenetre_ch='Fenetre';
Tempo_aig_ch='Tempo_Aig';
Nb_cantons_Sig_ch='Nb_cantons_Sig';
Tempo_Feu_ch='Tempo_Feu';
Algo_Unisemaf_ch='Alg_Unisemaf';
NOTIF_VERSION_ch='NOTIF_VERSION';
verif_version_ch='verif_version';
Fonte_ch='Fonte';
Raz_signaux_ch='RazSignaux';

// sections de config
section_aig_ch='[section_aig]';
section_sig_ch='[section_sig]';
section_act_ch='[section_act]';
section_branches_ch='[section_branches]';

var
  FormConfig: TFormConfig;
  AdresseIPCDM,AdresseIP,PortCom,recuCDM,residuCDM,trainsauve : string;
  portCDM,TempoOctet,TimoutMaxInterface,Valeur_entete,Port,protocole,NumPort,
  LigneCliqueePN,AncLigneCliqueePN,clicMemo,Nb_cantons_Sig,
  ligneclicAig,AncLigneClicAig,ligneClicSig,AncligneClicSig,
  ligneClicBr,AncligneClicBr,ligneClicAct,AncLigneClicAct,Adressefeuclic,NumTrameCDM : integer;
  ack_cdm,clicliste,entreeTCO,affevt,config_modifie,clicproprietes,confasauver : boolean;
  fichier : text;

function config_com(s : string) : boolean;
function envoi_CDM(s : string) : boolean;
procedure connecte_CDM;
function place_id(s : string) : string;
procedure decodeAig(s : string;var adr : integer;var B : char);
function sauve_config : boolean;
procedure lit_config;
Procedure aff_champs_sig_feux(index : integer);
procedure decode_ligne_feux(chaine_signal : string;i : integer);
function verif_coherence : boolean;
function compile_branche(s : string;i : integer) : boolean;
function encode_sig_feux(i : integer): string;

implementation

uses UnitDebug,UnitTCO, UnitSR;

{$R *.dfm}

// envoi d'une chaîne à CDM par socket, puis attend l'ack ou le nack
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
  // ne pas supprimer le @ espace et = qui sert de marqueur pour identifier le feu
  s:='@='+inttostr(feux[i].Adresse)+' Decodeur='+intToSTR(feux[i].Decodeur)+' Adresse détecteur associé='+intToSTR(feux[i].Adr_det1)+
       ' Adresse élement suivant='+intToSTR(feux[i].Adr_el_suiv1);
  if feux[i].Btype_suiv1=aig then s:=s+' (aig)';  
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

  if (AdresseIPCDM<>'0') then
  begin
    if(ProcessRunning('CDR')) then
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
      until (i>10) or CDM_connecte  ;
      //if i>10 then affiche('Timeout',clred);
      if not(CDM_connecte) then begin Affiche('Socket CDM non connecté',clOrange);exit;end;

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
        // demande la description des trains
        s:=place_id('C-C-01-0002-DSCTRN-DLOAD|000|');
        ntrains:=0;
        envoi_CDM(s);
        sleep(10);
        Application.ProcessMessages;
        if ntrains<>0 then
        with formprinc do
        begin
          combotrains.ItemIndex:=0;
          editAdrTrain.text:=IntToSTR(trains[1].adresse);
        end;
      end;
    end
    else Affiche('CDM Rail non lancé',clOrange);
  end  
  else
  begin
    if adresseIPCDM='0' then Affiche('La connexion à CDM n''est pas demandée car l''adresse IP est nulle dans '+NomConfig,cyan);
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

// transforme l'aiguillage de la base de données aiguillage en texte
function encode_aig(index : integer): string;
var s : string;
    c : char;
    tjdC,tjsC,triC,croi : boolean;
begin
   if index=0 then exit;
   s:=IntToSTR(aiguillage[index].Adresse);
   tjdC:=aiguillage[index].modele=tjd;
   tjsC:=aiguillage[index].modele=tjs;
   triC:=aiguillage[index].modele=triple;
   croi:=aiguillage[index].modele=crois;
   if tjdC then s:=s+'TJD';
   if tjsC then s:=s+'TJS';
   if croi then s:=s+'CROI';
   if triC then begin s:=s+'TRI,';s:=s+intToSTR(aiguillage[index].AdrTriple);end;
   s:=s+',';
   // aiguillage normal ou triple
   if not(tjdC) and not(tjsC) and not(croi) then
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
     if triC then
     begin
       s:=s+',S2-';
       s:=s+intToSTR(aiguillage[index].Adevie2);
       c:=aiguillage[index].Adevie2B ;
       if (c<>'Z') and (c<>#0) then s:=s+c;
       //if c=#0 then s:=s+'Z';
     end;
   end;

   // tjd 2/4 états ou tjs 
   if (tjdC or tjsC) then
   begin
     s:=s+'D('+intToSTR(aiguillage[index].Adroit);
     c:=aiguillage[index].AdroitB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDroit)+aiguillage[index].DDroitB+'),';
     s:=s+'S('+intToSTR(aiguillage[index].Adevie);
     c:=aiguillage[index].AdevieB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDevie)+aiguillage[index].DDevieB+')';
   end;

   if croi then
   begin      
     s:=s+'D('+intToSTR(aiguillage[index].Adroit);
     c:=aiguillage[index].AdroitB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDroit)+aiguillage[index].DDroitB+'),';
     s:=s+'S('+intToSTR(aiguillage[index].Adevie);
     c:=aiguillage[index].AdevieB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDevie)+aiguillage[index].DDevieB+')';
   end;

   if tjsC then
   begin
     s:=s+',L'+intToSTR(aiguillage[index].Tjsint)+aiguillage[index].TjsintB;
   end;

   // vitesse de franchissement et inversion
   if not(croi) then
   begin
     if aiguillage[index].vitesse=0 then s:=s+',V0';
     if aiguillage[index].vitesse=30 then s:=s+',V30';
     if aiguillage[index].vitesse=60 then s:=s+',V60';
     if aiguillage[index].inversionCDM=1 then s:=s+',I1' else s:=s+',I0';
   end;
   
   // valeur d'initialisation
   if not(croi) then
   begin
     s:=s+',INIT(';
     s:=s+IntToSTR(aiguillage[index].posInit)+',';
     s:=s+IntToSTR(aiguillage[index].temps)+')'; 
   end;
  
   if tjdC then
   begin
     if aiguillage[index].EtatTJD=2 then s:=s+',E2' else s:=s+',E4';
   end;
  
   encode_aig:=s;
end;

// renvoie un A si BT est un aiguillage (aig, tjd, tjs tri)
function TypeEl_to_char(BT : TEquipement) : string;
begin
  case BT of  // 1=détecteur 2=aig ou TJD ou TJS  4=tri
  det : TypeEl_to_char:='';
  aig,tjd,tjs,triple : TypeEl_to_char:='A';
  end;
end;

function TypeElAIg_to_char(adr : integer;c : char) : string;
var s: string;
begin
  if (adr=0) and (c<>'D') and (c<>'S') and (c<>'P')  then s:='Buttoir';

  if adr<>0 then
  begin
    if c='P' then s:='pointe de l''aiguillage '+IntToSTR(adr) else
    if c='S' then s:='position déviée de l''aiguillage '+IntToSTR(adr) else
    if c='D' then s:='position droite de l''aiguillage '+IntToSTR(adr) else
    if (c<>'D') and (c<>'S') and (c<>'P') then s:='détecteur '+IntToSTR(adr) else
    s:='erreur';
  end;
  TypeElAIg_to_char:=s;
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

    //verrouillage au carré
    if feux[i].verrouCarre then s:=s+'1' else s:=s+'0';
    // si unsemaf, paramètre supplémentaire
    if feux[i].decodeur=6 then s:=s+',U'+intToSTR(feux[i].unisemaf);

    // conditions supplémentaires pour le carré
    for nc:=1 to 6 do
    begin
      CondCarre:=Length(feux[i].condcarre[nc]);  // nombre de conditions (nombre de parenthèses ex 3 pour (A21S,A6D)(A30S,A20D)(A1D,A2S,A3D)
      dec(condcarre);
      if condCarre>0 then
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

    // décodeur SR  
    if feux[i].decodeur=7 then
    begin
      s:=s+',SR(';
      for nc:=1 to 8 do
      begin
        s:=s+intToSTR(feux[i].SR[nc].sortie1)+',';
        s:=s+intToSTR(feux[i].SR[nc].sortie0);
        if nc<8 then s:=s+',' else s:=s+')';
      end;
    end;

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
  
  encode_sig_feux:=s;
end;

// décode la ligne de signal et la stocke dans l'index i du tableau feux
procedure decode_ligne_feux(chaine_signal : string;i : integer);
var s,chaine,sa : string;
    j,k,l,t,adresse,adr,erreur ,asp,bd: integer;
    c : char;
    multiple,fini : boolean;
begin
      if i=0 then
      begin
        AfficheDebug('Erreur 670 : index nul',clred);
        exit;
      end;
      s:=chaine_signal;
      j:=pos(',',s);
      if j>1 then
      begin
        // adresse de feu
        val(s,adresse,erreur);
        if adresse=0 then begin affiche('Erreur 671 ligne '+s,clred);exit;end;
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
              Affiche('Erreur 672 ligne '+chaine_signal+' 6 feux maximum pour un panneau directionnel',clred);
              exit;
            end;
            feux[i].aspect:=l+10;Delete(s,1,j);
            // décodeur
            val(s,adr,erreur);
            Feux[i].decodeur:=adr;
            if (adr>NbDecodeur-1) then Affiche('Erreur 673 ligne '+chaine_signal+' : erreur décodeur inconnu',clred);
            j:=pos(',',s);Delete(s,1,j);
            // liste des aiguillages
            k:=1; // numéro de feu directionnel
            repeat
              // boucle de direction
              delete(s,1,1); // supprimer ( ou le ,
              j:=1; // Nombre de descriptions d'aiguillages dans le feu
              repeat
                if s[1]<>'A' then begin Affiche('Erreur 674 ligne '+chaine_signal,clred);exit;end;
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
              Affiche('Erreur 675 ligne '+chaine_signal,clred);
              Affiche('Nombre incorrect de description des aiguillages: '+intToSTR(k)+' pour '+intToSTR(l)+' feux directionnels',clred);
            end;
          end
          else
          // feu de signalisation---------------------------------
          begin
            val(sa,asp,erreur);  //aspect
            feux[i].aspect:=asp;Delete(s,1,j);
            if (asp=0) or (asp=6) or (asp>9) then
            Affiche('Erreur 676 Fichier '+NomConfig+' configuration aspect ('+intToSTR(asp)+') feu incorrecte à la ligne '+chaine_signal,clRed);
            j:=pos(',',s);
            if j>1 then begin Feux[i].FeuBlanc:=(copy(s,1,j-1))='1';delete(s,1,j);end;
            j:=pos(',',s);
            val(s,Feux[i].decodeur,erreur);
            
            if (Feux[i].decodeur>NbDecodeur-1) then Affiche('Erreur 677 Ligne '+chaine_signal+' : erreur décodeur inconnu',clred);
            if j<>0 then delete(s,1,j);
            feux[i].Adr_el_suiv1:=0;feux[i].Adr_el_suiv2:=0;feux[i].Adr_el_suiv3:=0;feux[i].Adr_el_suiv4:=0;
            feux[i].Btype_Suiv1:=rien;feux[i].Btype_Suiv2:=rien;feux[i].Btype_Suiv3:=rien;feux[i].Btype_Suiv4:=rien;
            feux[i].Adr_det1:=0;feux[i].Adr_det2:=0;feux[i].Adr_det3:=0;feux[i].Adr_det4:=0;
            // éléments optionnels des voies supplémentaires
            if j<>0 then
            begin
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
                   if Adr>NbMemZone then
                   begin
                     Affiche('Erreur 677A : ligne '+chaine_signal+' : adresse détecteur trop grand',clred);
                     Adr:=NbMemZone;
                   end;
                 end;
                 inc(j);
                 if (j=1) then feux[i].Adr_det1:=adr;
                 if (j=2) then feux[i].Adr_det2:=adr;
                 if (j=3) then feux[i].Adr_det3:=adr;
                 if (j=4) then feux[i].Adr_det4:=adr;
                 //type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri
                 if s[1]='A' then
                 begin
                   if (j=1) then feux[i].Btype_Suiv1:=aig;
                   if (j=2) then feux[i].Btype_Suiv2:=aig;
                   if (j=3) then feux[i].Btype_Suiv3:=aig;
                   if (j=4) then feux[i].Btype_Suiv4:=aig;
                   delete(s,1,1);
                 end
                 else
                 begin  // détecteur
                   if (j=1) then feux[i].Btype_Suiv1:=det;
                   if (j=2) then feux[i].Btype_Suiv2:=det;
                   if (j=3) then feux[i].Btype_Suiv3:=det;
                   if (j=4) then feux[i].Btype_Suiv4:=det;
                 end;
                 Val(s,adr,erreur);
                 if (j=1) then feux[i].Adr_el_suiv1:=Adr;
                 if (j=2) then feux[i].Adr_el_suiv2:=Adr;
                 if (j=3) then feux[i].Adr_el_suiv3:=Adr;
                 if (j=4) then feux[i].Adr_el_suiv4:=Adr;
                 delete(s,1,erreur-1);
                 if s[1]=',' then delete(s,1,1);
                 fini:=s[1]=')';
               until (fini) or (j>4);
            end;
          end;
          if (j>4) or (not(multiple)) then
          begin
            Affiche('Erreur 678: fichier de configuration ligne erronnée : '+chaine_signal,clred);
            closefile(fichier);
            exit;
          end;

          k:=pos(',',s);
          delete(s,1,k);
          //Affiche('s='+s,clyellow);
          if length(s)=0 then begin Affiche('Erreur 679: fichier de configuration ligne erronnée : '+chaine_signal,clred); closefile(fichier);exit;end;
          feux[i].VerrouCarre:=s[1]='1';
          delete(s,1,1);

          if length(s)>0 then if s[1]=',' then delete(s,1,1);
          if length(s)>0 then if s[1]='U' then delete(s,1,1);

          // si décodeur UniSemaf (6) champ supplémentaire
          if Feux[i].decodeur=6 then
          begin
             if k=0 then begin Affiche('Erreur 680 Ligne '+chaine_signal,clred);Affiche('Manque définition de la cible pour le décodeur UniSemaf',clred);end
             else
             begin
               Val(s,k,erreur);
               Feux[i].UniSemaf:=k;
               erreur:=verif_UniSemaf(adresse,k);
               if erreur=1 then begin Affiche('Erreur 681 Ligne '+chaine_signal,clred);Affiche('Erreur code Unisemaf',clred);end;
               if erreur=2 then
               begin
                 Affiche('Erreur 682 Ligne '+chaine_signal,clred);Affiche('Erreur cohérence aspect signal ('+intToSTR(asp)+') et code Unisemaf ('+intToSTR(k)+')',clred);
               end;

             end;
            end;
          end;

          // voir si conditions supplémentaires de carré
          l:=1;  // nombre de parenthèses
          repeat
            t:=pos('(',s);
            if t=1 then
            begin
              //Affiche('Conditions supplémentaires pour le feu '+IntToSTR(adresse)+' parenthèse '+intToSTR(l),clyellow);
              k:=pos(')',s);
              sa:=copy(s,t+1,k-t-1); // contient l'intérieur des parenthèses sans les parenthèses
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
                  val(chaine,adresse,erreur);
                  feux[i].condCarre[l][bd].Adresse:=adresse;
                  if erreur<>0 then feux[i].condCarre[l][bd].PosAig:=chaine[erreur] else
                  Affiche('Erreur 683 Définition du feu '+IntToSTR(feux[i].adresse)+': Manque D ou S dans les conditions de carré des aiguillages',clred);
                end;

                k:=pos(',',sa);if k<>0 then delete(sa,1,k);
              until k=0;
              inc(l);
            end;
          until t<>1;
          if length(s)>1 then if s[1]=',' then delete(s,1,1);

          // champ SR
          if length(s)>2 then
            if copy(s,1,2)='SR' then
          begin
            delete(s,1,3);
            for l:=1 to 8 do
            begin
              k:=pos(',',s);
              val(s,j,erreur);
              delete(s,1,k);
              feux[i].SR[l].sortie1:=j;

              k:=pos(',',s);
              val(s,j,erreur);
              delete(s,1,k);
              feux[i].SR[l].sortie0:=j;
            end;
          end;

        end;
      end;
end;

// transforme l'actionneur type loco ou actionneur ou son du tableau en texte
// paramètre d'entrée : index
function encode_act_loc_son(i : integer): string;
var s : string;
    adresse : integer;
begin
  // adresse
  adresse:=Tablo_Actionneur[i].adresse;
  

  if Tablo_Actionneur[i].typActMemZone=0 then
  begin
    s:=IntToSTR(adresse); if tablo_actionneur[i].det then s:=s+'Z';
  end
  else
  begin
    s:='Mem['+IntToSTR(adresse)+','+IntToSTR(Tablo_Actionneur[i].adresse2)+']';
  end;
  
  

  if Tablo_Actionneur[i].loco then
    s:=s+','+IntToSTR(Tablo_Actionneur[i].Etat)+','+Tablo_Actionneur[i].trainDecl+',F'+
             IntToSTR(Tablo_Actionneur[i].fonction)+','+intToSTR(Tablo_Actionneur[i].tempo)+
             ','+Tablo_Actionneur[i].trainDest;

  if Tablo_Actionneur[i].act then
  begin
    s:=s+','+IntToSTR(Tablo_Actionneur[i].Etat)+','+Tablo_Actionneur[i].trainDecl+
       ',A'+IntToSTR(Tablo_Actionneur[i].accessoire)+','+intToSTR(Tablo_Actionneur[i].sortie)+',';
    if Tablo_Actionneur[i].Raz then s:=s+'Z' else s:=s+'S';
  end;

  if Tablo_Actionneur[i].son then
    s:=s+','+IntToSTR(Tablo_Actionneur[i].Etat)+','+Tablo_Actionneur[i].trainDecl+',"'+Tablo_Actionneur[i].FichierSon+'"';

  encode_act_loc_son:=s;
end;

// encode l'actionneur PN du tableau en texte
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


// modifie le fichier de config en fonction du paramétrage
// recopie les commentaires du fichier "fichier"
procedure genere_config;
var s: string;
    fichierN : text;
    i : integer;
    continue : boolean;

begin
  assign(fichierN,NomConfig);    
  rewrite(fichierN);

  // entête
  // copie_commentaire;
  writeln(fichierN,'/ Fichier de configuration de signaux_complexes_GL');
  // taille de la fonte
  writeln(fichierN,Fonte_ch+'=',TailleFonte);
  FormPrinc.FenRich.Font.Size:=TailleFonte;

  // adresse ip et port de CDM
  writeln(fichierN,IpV4_PC_ch+'=',adresseIPCDM+':'+intToSTR(portCDM));

  // adresse ip interface XpressNet
  writeln(fichierN,IPV4_Interface_ch+'=',adresseIP+':'+intToSTR(port));

  // port com
  writeln(fichierN,Protocole_serie_ch+'=',portcom);

  // temporisation caractère TempoOctet
  writeln(fichierN,Inter_Car_ch+'=',IntToSTR(TempoOctet));

  // temporisation attente maximale interface
  writeln(fichierN,Tempo_maxi_ch+'=',IntToSTR(TimoutMaxInterface));

  // entete Valeur_entete
  writeln(fichierN,Entete_ch+'=',intToSTR(Valeur_entete));

  // avec ou sans initialisation des aiguillages
  if AvecInitAiguillages then s:='1' else s:='0';
  writeln(fichierN,Init_Aig_ch+'='+s);

  // temporisation initialisation des aiguillages
  writeln(fichierN,Tempo_aig_ch+'=',IntToSTR(Tempo_aig));

  // plein écran
  writeln(fichierN,Fenetre_ch+'=',fenetre);

  // Nombre maxi de détecteurs considérés distants
  writeln(fichierN,nb_det_dist_ch+'=',Nb_Det_Dist);

  // Vérification des versions au démarrage
  if verifVersion then s:='1' else s:='0';
  writeln(fichierN,verif_version_ch+'=',s);

  // Notification de nouvelle version
  if notificationVersion then s:='1' else s:='0';
  writeln(fichierN,notif_version_ch+'=',s);

  // Avec TCO
  if AvecTCO then s:='1' else s:='0';
  writeln(fichierN,TCO_ch+'=',s);

  if MasqueBandeauTCO then s:='1' else s:='0';
  writeln(fichierN,MasqueBandeauTCO_ch+'=',s);

  // lancement de CDM
  if LanceCDM then s:='1' else s:='0';
  writeln(fichierN,CDM_ch+'=',s);

  // Nom du LAY
  writeln(fichierN,lay_ch+'=',Lay);

  // Serveur d'interface de CDM
  writeln(fichierN,Serveur_interface_ch+'=',intToSTR(ServeurInterfaceCDM));

  // Serveur de rétrosignalisation Lenz de CDM
  writeln(fichierN,retro_ch+'=',intToSTR(ServeurRetroCDM));

  // entête
  // Raz Signaux
  if Raz_Acc_signaux then s:='1' else s:='0';
  writeln(fichierN,'RazSignaux='+s);

  // temporisation entre 2 commandes décodeurs feu
  writeln(fichierN,Tempo_feu_ch+'=',IntToSTR(Tempo_feu));

  // Nombre de cantons avant signal
  writeln(fichierN,Nb_cantons_Sig_ch+'=',intToSTR(Nb_cantons_Sig));

  // algorithme Unisemaf
  writeln(fichierN,Algo_unisemaf_ch+'=',IntToSTR(algo_Unisemaf));

  // aiguillages
  writeln(fichierN,'/------------');
  writeln(fichierN,section_aig_ch);
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_aig(i);
    aiguillage[i].modifie:=false;       // sauvegarde en cours, on démarque
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_Branches_ch);
  // branches
  for i:=1 to NbreBranches do
  begin
    s:=Branche[i];
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_sig_ch);
  // feux
  for i:=1 to NbreFeux do
  begin
    s:=encode_sig_feux(i);
    // transformer le tableau feux en ligne
    //Affiche(s,clLime);
    if s='' then Affiche('Erreur 700 - Encodage du feu index='+IntToSTR(i),clRed);
    feux[i].modifie:=false;       // sauvegarde en cours, on démarque
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  // Fonctions Fx
  // actionneurs Train ou accessoire
  writeln(fichierN,'/------------');
  writeln(fichierN,section_act_ch);
  for i:=1 to maxTablo_act do
  begin
    s:=encode_act_loc_son(i);
    if s<>'' then writeln(fichierN,s);
  end;

  writeln(fichierN,'/------------');
  // actionneurs PN
  for i:=1 to NbrePN do
  begin
    s:=encode_act_pn(i);
    if s<>'' then if s<>'' then writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  closefile(fichierN);

end;

procedure lit_config;

var s,sa,chaine,SOrigine: string;
    c,paig : char;
    tec,tjdC,tjsC,s2,trouve,triC,debugConfig,multiple,fini,finifeux,trouve_NbDetDist,trouve_ipv4_PC,trouve_retro,
    trouve_sec_init,trouve_init_aig,trouve_lay,trouve_IPV4_INTERFACE,trouve_PROTOCOLE_SERIE,trouve_INTER_CAR,
    trouve_Tempo_maxi,trouve_Entete,trouve_tco,trouve_cdm,trouve_Serveur_interface,trouve_fenetre,trouve_MasqueTCO,
    trouve_NOTIF_VERSION,trouve_verif_version,trouve_fonte,trouve_tempo_aig,trouve_raz,trouve_section_aig,
    pds,trouve_section_branche,trouve_section_sig,trouve_section_act,fichier_trouve,trouve_tempo_feu,
    trouve_algo_uni,croi,trouve_Nb_cantons_Sig   : boolean;
    bd,virgule,i_detect,i,erreur,aig2,detect,offset,index, adresse,j,position,temporisation,invers,indexPointe,indexDevie,indexDroit,
    ComptEl,Compt_IT,Num_Element,k,modele,adr,adr2,erreur2,l,t,Nligne,postriple,itl,
    postjd,postjs,nv,it,Num_Champ,asp,adraig,poscroi : integer;

 function lit_ligne : string ;
    var esp,l1,l2,k : integer;
        guim : boolean;
        sp : string;
    begin
      repeat
        readln(fichier,s);
        sOrigine:=s;
        s:=uppercase(s);
        if length(s)>0 then c:=s[1];
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      // supprime les espaces éventuels sauf entre les guillements
      esp:=0;
      repeat
        l1:=pos('"',s);l2:=posEx('"',s,l1+1);
        esp:=posEx(' ',s,Esp+1);
        if (esp<>0) and (esp<l1) and (esp>l2) then delete(s,esp,1);
      until esp=0;
      lit_ligne:=s;
    end;

procedure compile_signaux;
begin
  Affiche('Définition des signaux',clyellow);
  i:=1;Nligne:=1;
  NbreFeux:=0;
  repeat
    inc(Nligne);
    s:=lit_ligne;
    //affiche(s,clyellow);
    if s<>'0' then
    begin
      inc(NbreFeux);
      decode_ligne_feux(s,i);inc(i);
    end;
  until (s='0') or  eof(fichier);
end;

procedure compile_branches;
begin
  // branches
  NDetecteurs:=0;
  Nligne:=1;
  i_detect:=1;
  i:=1;
  Affiche('Définition des branches',clyellow);

  repeat
    s:=lit_ligne;
    if s<>'0' then
    begin
      branche[i]:=s;
      j:=1;offset:=1;
      inc(Nligne);
      compile_branche(s,i);
      inc(i);
    end;
  until (s='0') or eof(fichier) or (i>=MaxBranches);
  if i>MaxBranches then Affiche('Nombre maximal de branches atteint',clRed);
  NbreBranches:=i-1;
end;

procedure compile_actionneurs;
var i : integer;
begin
  // raz des actionneurs
  for i:=1 to maxTablo_act do
  begin
    Tablo_actionneur[i].trainDecl:='';
    Tablo_actionneur[i].trainDest:='';
    Tablo_actionneur[i].etat:=0;
    Tablo_actionneur[i].adresse:=0;
    Tablo_actionneur[i].adresse2:=0;
    Tablo_Actionneur[i].typActMemZone:=0;
    Tablo_actionneur[i].accessoire:=0;
    Tablo_actionneur[i].sortie:=0;
    Tablo_actionneur[i].fichierSon:='';
    Tablo_actionneur[i].det:=false;
    Tablo_actionneur[i].loco:=false;
    Tablo_actionneur[i].act:=false;
    Tablo_actionneur[i].son:=false;
  end;

  Affiche('Définition des actionneurs/détecteurs',clyellow);
  maxTablo_act:=1;
  NbrePN:=0;Nligne:=1;

  // définition des actionneurs
  repeat
    s:=lit_ligne;
    sa:=s; sOrigine:=s;

    i:=pos('MEM[',sOrigine);
    if i>0 then
    begin
      Tablo_actionneur[maxtablo_act].typActMemZone:=1;  // type mémoire de zone
      Delete(sa,1,4);
      val(sa,j,erreur);
      Tablo_actionneur[maxtablo_act].adresse:=j;
      i:=pos(',',sa);delete(sa,1,i);
      val(sa,j,erreur);
      i:=pos(',',sa);
      Tablo_actionneur[maxtablo_act].adresse2:=j;
      Tablo_actionneur[maxTablo_act].det:=true;
      delete(sa,1,i);
      s:=sa; // mémo s
    end;

    if length(sOrigine)>1 then
    begin
      if (sOrigine[1]<>'(') and (pos('MEM[',sOrigine)=0) then  // si pas détecteur de PN
      begin
        Tablo_actionneur[maxtablo_act].typActMemZone:=0;  // type actionneur
        val(sa,j,erreur);
        Tablo_actionneur[maxtablo_act].adresse:=j;
        Tablo_actionneur[maxTablo_act].det:=sa[erreur]='Z';
        delete(sa,1,erreur);
        s:=sa;
      end;
    end;

    // vérifier si F ou A  ou " au 4eme champ
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';

    inc(Nligne);

    if length(sa)>1 then if (sa[1]='"') then
    // -----------------son
    begin
      Tablo_actionneur[maxtablo_act].act:=false;
      Tablo_actionneur[maxtablo_act].son:=true;
      Tablo_actionneur[maxtablo_act].loco:=false;
      i:=pos(',',s);
      if i<>0 then
      begin
         val(s,j,erreur);
          Tablo_actionneur[maxTablo_act].etat:=j;
          Delete(s,1,erreur);

          i:=pos(',',s);
          Tablo_actionneur[maxTablo_act].trainDecl:=copy(s,1,i-1);
          Delete(s,1,i);

          i:=pos('"',s);
          Delete(s,1,i);
          i:=pos('"',s);
          Tablo_actionneur[maxTablo_act].fichierSon:=copy(s,1,i-1);
          inc(maxTablo_act);
      end;
    end;

    if length(sa)>1 then if (sa[1]='A') then
    // -----------------accessoire
    begin
      Tablo_actionneur[maxtablo_act].act:=true;
      Tablo_actionneur[maxtablo_act].son:=false;
      Tablo_actionneur[maxtablo_act].loco:=false;

      i:=pos(',',s);
      if i<>0 then
      begin
          val(s,j,erreur);
          Tablo_actionneur[maxTablo_act].etat:=j;
          Delete(s,1,erreur);

          i:=pos(',',s);
          Tablo_actionneur[maxTablo_act].trainDecl:=copy(s,1,i-1);
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

    if length(sa)>1 then if (sa[1]='F') then
    // -----------------fonction loco
    begin
      Tablo_actionneur[maxtablo_act].act:=false;
      Tablo_actionneur[maxtablo_act].loco:=true;
      Tablo_actionneur[maxtablo_act].son:=false;

      // 815,1,CC406526,F2,450
      i:=pos(',',s);
      if i<>0 then
      begin
          val(s,j,erreur);
          Tablo_actionneur[maxTablo_act].etat:=j;
          Delete(s,1,erreur);

          i:=pos(',',s);
          Tablo_actionneur[maxTablo_act].trainDecl:=copy(s,1,i-1);
          Delete(s,1,i);

          i:=pos('F',s);
          if i<>0 then
          begin
            Delete(s,1,1);
            val(s,j,erreur);
            Tablo_actionneur[maxTablo_act].Fonction:=j;

            i:=pos(',',s);// champ tempo
            if i<>0 then
            begin
              Delete(S,1,i);
              val(s,j,erreur);
              Tablo_actionneur[maxTablo_act].Tempo:=j;
              i:=pos(',',s); // champ train dest
              if i=0 then tablo_actionneur[maxTablo_act].TrainDest:=tablo_actionneur[maxTablo_act].TrainDecl
              else
              begin
                tablo_actionneur[maxTablo_act].TrainDest:=copy(s,i+1,length(s)-i);
              end;

              inc(maxTablo_act);
            end;
          end;
          s:='';i:=0;
        end;
    end;

    // Passage à niveau
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
      i:=0;
    end;
    if pos('PN',s)<>0 then i:=0;
  until (s='0');
  dec(maxTablo_act);
end;
  
procedure compile_aiguillages;
begin
  Affiche('Définition des aiguillages',clyellow);
  maxaiguillage:=0;
  Nligne:=1;
  repeat
    s:=lit_ligne;
    inc(Nligne);
    //Affiche(s,ClLime);
    //chaine:=s;
    if debugconfig then Affiche(s,ClLime);
    if (s<>'0') then
    begin
      if MaxAiguillage>=MaxAcc then
      begin
        Affiche('Nombre maximal d''aiguillages atteint',clRed);
      end
      else
        inc(maxaiguillage);
      virgule:=pos(',',s);
      enregistrement:=copy(s,1,virgule-1);  // adresse de l'aiguillage [TRI]
      delete(s,1,virgule);
      postriple:=pos('TRI',enregistrement);triC:=postriple<>0;if triC then delete(enregistrement,postriple,3);
      postjd:=pos('TJD',enregistrement);tjdC:=postjd<>0;if tjdC then delete(enregistrement,postjd,3);
      postjs:=pos('TJS',enregistrement);tjsC:=postjs<>0;if tjsC then delete(enregistrement,postjs,3);
      poscroi:=pos('CROI',enregistrement);croi:=poscroi<>0;if croi then delete(enregistrement,poscroi,4);
      
      // adresse de l'aiguillage
      Val(enregistrement,adraig,erreur); // adraig = adresse de l'aiguillage
      if erreur<>0 then Affiche('Erreur aiguillage '+intToSTR(adraig)+' ; caractère '+enregistrement[erreur]+' inconnu',clred);
      if debugConfig then Affiche('Adresse='+IntToSTR(adraig)+' enregistrement='+Enregistrement,clyellow);

      aiguillage[maxaiguillage].adresse:=adraig;
      aiguillage[maxaiguillage].AdroitB:='Z'; aiguillage[maxaiguillage].AdevieB:='Z';
      aiguillage[maxaiguillage].DdroitB:='Z'; aiguillage[maxaiguillage].DdevieB:='Z';

      aiguillage[maxaiguillage].ApointeB:='Z';
      aiguillage[maxaiguillage].Adevie2B:='Z';

      if (triC) then aiguillage[maxaiguillage].modele:=triple;
      if (tjsC) then
      begin
        aiguillage[maxaiguillage].modele:=tjs
      end;
      if (tjdC) then
      begin
        aiguillage[maxaiguillage].modele:=tjd ;
      end;
      if not(tjsC) and not(tjdC) and not(triC) then
      begin
        aiguillage[maxaiguillage].modele:=aig;
      end;
      if croi then aiguillage[maxaiguillage].modele:=crois;    

      if (triC) then
      begin
        Val(s,aig2,erreur); // aig = 2eme adresse de l'aiguillage
        aiguillage[maxaiguillage].AdrTriple:=aig2;
        virgule:=pos(',',s);
        delete(s,1,virgule);
      end;
      ComptEl:=0;Compt_It:=0;Num_element:=Num_element+1;
      // préparer l'enregistrement pour la boucle de ligne

      enregistrement:=s;

      Num_Champ:=1;
      itl:=0;
      repeat  // parcoure la ligne
        if (debugConfig) then Affiche('boucle de ligne: '+s,clYellow);
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='P') then
        begin
          if tjdC then begin affiche('Erreur P interdit dans une TJD : '+sOrigine,clred);exit; end;
          if debugconfig then Affiche('Section P - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          decodeAig(enregistrement,detect,c);
          if c='' then c:='Z';
          aiguillage[maxaiguillage].Apointe:=detect;
          aiguillage[maxaiguillage].ApointeB:=c;

          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(Enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        if (length(enregistrement)<>0) then  // section droite
        if (enregistrement[1]='D') then
        begin
          if debugconfig then Affiche('Section D - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          if tjdC or tjsC or croi then
          begin
            Delete(Enregistrement,1,2);
            decodeAig(Enregistrement,detect,c);
            aiguillage[maxaiguillage].Adroit:=detect;
            aiguillage[maxaiguillage].AdroitB:=c;
            i:=pos(',',Enregistrement);Delete(Enregistrement,1,i);
            decodeAig(Enregistrement,detect,c);
            aiguillage[maxaiguillage].DDroit:=detect;
            aiguillage[maxaiguillage].DdroitB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);exit;end;
            Delete(enregistrement,1,i+1);
          end
          else
          begin
            decodeAig(enregistrement,detect,c);
            if c='' then c:='Z';
            aiguillage[maxaiguillage].Adroit:=detect;
            aiguillage[maxaiguillage].AdroitB:=c;

            virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
            delete(enregistrement,1,virgule);
          end;
        end;

        if (length(enregistrement)<>0) then
        if (enregistrement[1]='S') then
        begin
          if debugconfig then Affiche('Section S - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;

          if tjdC or tjsC or croi then
          begin
            Delete(enregistrement,1,2);
            decodeAig(enregistrement,detect,c);
            aiguillage[maxaiguillage].Adevie:=detect;
            aiguillage[maxaiguillage].AdevieB:=c;
            i:=pos(',',enregistrement);Delete(enregistrement,1,i);
            decodeAig(enregistrement,detect,c);
            aiguillage[maxaiguillage].DDevie:=detect;
            aiguillage[maxaiguillage].DDevieB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);exit;end;
            Delete(enregistrement,1,i+1);

            //Affiche(enregistrement,clBlue);
          end
          else
          begin
            delete(enregistrement,1,1); // supprime le S
            i:=pos(',',enregistrement);
            if i=0 then i:=length(enregistrement)+1;
            s:=copy(enregistrement,1,i-1); // isole la zone S

            erreur:=pos('2-',s);
            S2:=erreur<>0;
            if (S2) then delete(s,erreur,2);

            erreur:=pos('S2',s); // description d'un rattachement à la branche S2 d'un aiguillage triple
            tec:=erreur<>0;  // ne supprimer que le 2
            if (tec) then delete(s,erreur+1,1);

            //val(enregistrement,detect,erreur);  //  extraction de l'adresse
            decodeAig(s,detect,c);
            //if ((detect=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section S: '+s,clred);
            //c:='Z';
            //if (erreur<>0) then begin delete(enregistrement,1,erreur-1);c:=enregistrement[1];end;

            if not(S2) and not(tec) then begin aiguillage[maxaiguillage].Adevie:=detect;aiguillage[maxaiguillage].AdevieB:=c;end;
            if     S2  and not(tec) then begin aiguillage[maxaiguillage].Adevie2:=detect;aiguillage[maxaiguillage].Adevie2B:=c;end;
            if     S2  and     tec  then begin aiguillage[maxaiguillage].Adevie2:=detect;aiguillage[maxaiguillage].Adevie2B:='T';end;

            virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
            delete(enregistrement,1,virgule);;
          end;
        end;

        // inversion aiguillage
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='I')  then
        begin
           inc(Num_Champ);  
           delete(enregistrement,1,1);
           Val(enregistrement,adr,erreur);
           if (adr<0) or (adr>1) then begin Affiche('Erreur Inversion ; ligne '+sOrigine,clred);end;
           //Affiche(intTostr(adr),clblue);
           Aiguillage[maxaiguillage].inversionCDM:=adr;
           virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
           delete(enregistrement,1,virgule);
        end;
          
        // si vitesse définie
        if (length(enregistrement)<>0) then
        if enregistrement[1]='V' then 
        begin
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          //Affiche('section vitesse définie aig='+intToSTR(aig)+'/'+intToSTR(adr),clyellow);
          aiguillage[maxaiguillage].vitesse:=adr;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
          delete(enregistrement,1,virgule);
        end;

        // TJS et L
        if (length(enregistrement)<>0) then
        if enregistrement[1]='L' then 
        begin
          if not(tjsC) then begin Affiche('Erreur paramètre L ligne: '+sOrigine,clred);exit;end;
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          aiguillage[maxaiguillage].tjsInt:=adr;
          c:=enregistrement[erreur];
          if ((c<>'S') and (c<>'D')) then 
          begin
            c:=' ';Affiche('Erreur paramètre L '+sOrigine,clred);
          end;
          aiguillage[maxaiguillage].tjsIntB:=c;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        // Init aiguillage
        i:=pos('INIT(',enregistrement);
        if i=1 then 
        begin
          inc(num_champ);
          delete(enregistrement,i,i+4);
          Val(enregistrement,position,erreur);
          i:=pos(',',enregistrement);
          if i<>0 then delete(enregistrement,1,i);
          Val(enregistrement,j,erreur);
          aiguillage[maxaiguillage].temps:=j;     
          aiguillage[maxaiguillage].posinit:=position;
          i:=pos(')',enregistrement);
          delete(enregistrement,1,i);
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        // nombre d'états de la TJD
        if (length(enregistrement)<>0) then
        if enregistrement[1]='E' then 
        begin
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          aiguillage[maxaiguillage].EtatTJD:=adr;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
          delete(enregistrement,1,virgule);
        end;  
        
        inc(itl);
      until (enregistrement='') or (itl>3);
      if itl>4 then begin Affiche('Erreur 400 ligne '+sOrigine,clred);exit;end;
    end;
  until (sOrigine='0');
end;

procedure lit_flux;
    label ici1,ici2,ici3,ici4 ;
    var i : integer;

// début de la procédure lit_config
begin
  // valeurs par défaut
  Nb_cantons_Sig:=3;
  nv:=0; it:=0;
  // taille de fonte
  repeat
    s:=lit_ligne;
    //affiche(s,cllime);
    sa:=uppercase(Fonte_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_fonte:=true;
      delete(s,i,length(sa));
      val(s,TailleFonte,erreur);
      if (TailleFonte<8) or (tailleFonte>25) then taillefonte:=10;
      FormPrinc.FenRich.Font.Size:=TailleFonte;
    end;

    // adresse ip et port de CDM
    sa:=uppercase(IpV4_PC_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_ipv4_PC:=true;
      delete(s,i,length(sa));
      i:=pos(':',s);
      if i<>0 then
      begin
        adresseIPCDM:=copy(s,1,i-1);Delete(s,1,i);
        val(s,portCDM,erreur);
        if (portCDM=0) or (portCDM>65535) or (erreur<>0) then affiche('Erreur port CDM : '+s,clred);
      end
      else affiche('Erreur adresse ip cdm rail '+s,clred);
    end;

    // adresse ip et port de la centrale
    sa:=uppercase(IPV4_INTERFACE_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_IPV4_INTERFACE:=true;
      delete(s,i,length(sa));
      i:=pos(':',s);
      if i<>0 then
      begin
        adresseIP:=copy(s,1,i-1);Delete(s,1,i);port:=StrToINT(s);
        if (adresseIP<>'0') and (port=0) then affiche('Erreur port nul : '+sOrigine,clRed);
      end
      else begin adresseIP:='0';parSocketLenz:=false;end;
    end;

    // configuration du port com
    sa:=uppercase(PROTOCOLE_SERIE_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_PROTOCOLE_SERIE:=true;
      delete(s,i,length(sa));
      if not(config_com(s)) then Affiche('Erreur port com mal déclaré : '+s,clred);
      portcom:=s;
    end;

    // temporisation entre 2 caractères
    sa:=uppercase(INTER_CAR_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
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
    if i=1 then
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
    if i=1 then
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
      if (erreur<>0) or (valeur_entete>2) then Affiche('Erreur déclaration variable '+entete_ch,clred);
    end;

    // avec ou sans initialisation des aiguillages
    sa:=uppercase(INIT_AIG_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      trouve_init_aig:=true;
      inc(nv);
      delete(s,i,length(sa));
      AvecInitAiguillages:=s='1';
    end;

    // taille de la fenetre
    sa:=uppercase(fenetre_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_fenetre:=true;
      delete(s,i,length(sa));
      val(s,fenetre,erreur);
      if fenetre=1 then Formprinc.windowState:=wsMaximized;
    end;

    // Nombre de cantons avant signal
    sa:=uppercase(Nb_cantons_Sig_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_Nb_cantons_Sig:=true;
      delete(s,i,length(sa));
      val(s,Nb_cantons_Sig,erreur);
      if (Nb_cantons_Sig<3) or (Nb_cantons_Sig>5) then Nb_cantons_Sig:=3;
    end;

    // temporisation aiguillages
    sa:=uppercase(Tempo_Aig_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_Tempo_aig:=true;
      delete(s,i,length(sa));
      val(s,Tempo_Aig,erreur);
    end;

    // temporisation décodeurs de feux
    sa:=uppercase(Tempo_Feu_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_Tempo_feu:=true;
      delete(s,i,length(sa));
      val(s,Tempo_Feu,erreur);
      if tempo_Feu=0 then Tempo_feu:=100;
    end;

    // algo unisemaf
    sa:=uppercase(Algo_unisemaf_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_Algo_Uni:=true;
      delete(s,i,length(sa));
      val(s,algo_Unisemaf,erreur);
      if (algo_Unisemaf<0) or (algo_Unisemaf>2) then algo_Unisemaf:=1;
    end;

    sa:=uppercase(verif_version_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      trouve_verif_version:=true;
      inc(nv);
      delete(s,i,length(sa));
      // vérification de la version au démarrage
      verifVersion:=true;
      val(s,i,erreur);
      if erreur=0 then verifVersion:=i=1;
    end;

    sa:=uppercase(NOTIF_VERSION_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_NOTIF_VERSION:=true;
      // vérification de la version au démarrage
      val(s,i,erreur);
      notificationVersion:=i=1;
    end;

    sa:=uppercase(TCO_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_TCO:=true;
      val(s,i,erreur);
      AvecTCO:=i=1;
    end;

    sa:=uppercase(MasqueBandeauTCO_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_MasqueTCO:=true;
      val(s,i,erreur);
      MasqueBandeauTCO:=i=1;
    end;

    sa:=uppercase(CDM_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_CDM:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      LanceCDM:=i=1;
    end;

    sa:=uppercase(LAY_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_lay:=true;
      delete(s,i,length(sa));
      lay:=s;
    end;

    sa:=uppercase(SERVEUR_INTERFACE_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_serveur_interface:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      ServeurInterfaceCDM:=i;
    end;

    sa:=uppercase(RETRO_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_retro:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      ServeurRetroCDM:=i;
    end;

    sa:=uppercase(nb_det_dist_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_NbDetDist:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      if i<2 then begin i:=2;Affiche('Attention '+nb_det_dist_ch+' ramené à '+IntToSTR(i),clOrange); end;
      Nb_Det_Dist:=i;
    end;
  
    sa:=uppercase(Raz_signaux_ch)+'=';
    i:=pos(sa,s);
    if i=1 then
    begin
      inc(nv);
      trouve_NbDetDist:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      if i>1 then i:=1;
      Raz_Acc_signaux:=i=1;
    end;

    // section aiguillages
    sa:=uppercase(section_aig_ch);
    if pos(sa,s)<>0 then
    begin
      trouve_section_aig:=true;
      compile_aiguillages;
    end;

    // section branche
    sa:=uppercase(section_branches_ch);
    if pos(sa,s)<>0 then
    begin
      trouve_section_branche:=true;
      compile_branches;
    end;

    // section signaux
    sa:=uppercase(section_sig_ch);
    if pos(sa,s)<>0 then
    begin
      trouve_section_sig:=true;
      compile_signaux;
    end;

    // section actionneurs
    sa:=uppercase(section_act_ch);
    if pos(sa,s)<>0 then
    begin
      trouve_section_act:=true;
      compile_actionneurs;
    end;

    inc(it);

  until (eof(fichier));

end;
// procédure lit_config
begin
  debugConfig:=false;
  trouve_NbDetDist:=false;
  trouve_ipv4_PC:=false;
  trouve_retro:=false;
  trouve_sec_init:=false;
  trouve_init_aig:=false;
  trouve_tempo_aig:=false;
  trouve_tempo_feu:=false;
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
  trouve_masqueTCO:=false;
  trouve_fenetre:=false;
  trouve_verif_version:=false;
  trouve_Fonte:=false;
  trouve_Raz:=false;

  Nb_Det_Dist:=3;
  // initialisation des aiguillages avec des valeurs par défaut
  for i:=1 to MaxAcc do
  begin
    Aiguillage[i].modele:=rien  ;  //  sans existence
    Aiguillage[i].adresse:=0;
    Aiguillage[i].position:=const_inconnu;  // position inconnue
    Aiguillage[i].PosInit:=const_inconnu;  // position inconnue
    Aiguillage[i].temps:=5   ;
    Aiguillage[i].inversionCDM:=0;
  end;
  for i:=1 to 1024 do
  begin
     Detecteur[i].etat:=false;
     Detecteur[i].train:='0';
     Ancien_detecteur[i]:=false;
  end;

  Affiche('Lecture du fichier de configuration '+NomConfig,clyellow);
  {$I+}
  try
    assign(fichier,NomConfig);
    reset(fichier);
  except
    Affiche('Fichier '+NomConfig+' non trouvé : création d''un fichier vide par défaut',clred);
    portcom:='COM3:57600,N,8,1,2';
    adresseIPCDM:='127.0.0.1';portCDM:=9999;
    adresseIP:='192.168.1.23';port:=5550;
    verifVersion:=true;
    Valeur_entete:=1;
    TempoOctet:=50;
    TimoutMaxInterface:=7;
    AvecInitAiguillages:=true;
    Tempo_Aig:=100;
    Tempo_feu:=100;
    ServeurInterfaceCDM:=1;
    Nb_cantons_Sig:=3;
    ServeurRetroCDM:=1;
    algo_Unisemaf:=1;
    TailleFonte:=12;
    Nb_Det_Dist:=3;
    genere_config;
    assign(fichier,NomConfig);
    reset(fichier);
  end;
  {$I-}
  lit_flux;
  close(fichier);

  configNulle:=(maxAiguillage=0) and (NbreBranches=0) and (Nbrefeux=0);
  if configNulle then Affiche('Fonctionnement en config nulle',ClYellow);

  s:='';//Affiche(intToSTR(Nv),clred);
  if not(trouve_NbDetDist) then s:=nb_det_dist_ch;
  if not(trouve_ipv4_PC) then s:=IpV4_PC_ch;
  if not(trouve_retro) then s:=retro_ch;
  if not(trouve_init_aig) then s:=INIT_AIG_ch;
  if not(trouve_lay) then s:=LAY_ch;
  if not(trouve_INTER_CAR) then s:=INTER_CAR_ch;
  if not(trouve_Tempo_maxi) then s:=Tempo_maxi_ch;
  if not(trouve_Entete) then s:=Entete_ch;
  if not(trouve_TCO) then s:=TCO_ch;
  if not(trouve_CDM) then s:=CDM_ch;
  if not(trouve_Serveur_interface) then s:=Serveur_interface_ch;
  if not(trouve_fenetre) then s:=fenetre_ch;
  if not(trouve_tempo_aig) then s:=tempo_aig_ch;
  if not(trouve_Algo_Uni) then s:=Algo_unisemaf_ch;
  if not(trouve_Nb_cantons_Sig) then s:=Nb_cantons_Sig_ch;
  if not(trouve_tempo_feu) then
  begin
    s:=tempo_feu_ch;
    tempo_feu:=100;
    s:='';
  end;
  if not(trouve_NOTIF_VERSION) then s:=NOTIF_VERSION_ch;
  if not(trouve_verif_version) then s:=verif_version_ch;
  if not(trouve_fonte) then s:=fonte_ch;

  if s<>'' then
  begin
    affiche('Manque variables dans '+NomConfig+' : '+s,clOrange);
    confasauver:=true;
  end;
  if not(trouve_section_aig) then Affiche('Manque section '+section_aig_ch,clred);
  if not(trouve_section_sig) then Affiche('Manque section '+section_sig_ch,clred);
  if not(trouve_section_branche) then Affiche('Manque section '+section_branches_ch,clred);
  verif_coherence;
  formDebug.buttonCP.Caption:='Etat '+intToSTR(Nb_cantons_Sig)+' cantons précédents signal';
end;


// sauvegarder la config dans le fichier cfg
function Sauve_config : boolean;
begin
  // générer le fichier de config
  genere_config;
  Affiche('Configuration sauvegardée dans le fichier',clLime);
  config_modifie:=false;
  confasauver:=false;
  sauve_config:=true;
  exit;
end;



function verifie_panneau_config : boolean;
var ChangeCDM,changeInterface,changeUSB,change_srv,ok : boolean;
    i,erreur : integer;
    s : string;
begin
  ok:=true;
  // Vérification de la configuration-------------------------------------------
  // contrôle adresse IP CDM
  with FormConfig do
  begin
    s:=EditAdrIPCDM.text;
    if s='' then s:='127.0.0.1';
    if not(IpOk(s)) then begin labelInfo.Caption:='Adresse IP CDM rail incorrecte';ok:=false;end;
    ChangeCDM:=s<>AdresseIPCDM;
    adresseIPCDM:=s;

    // contrôle port CDM
    val(EditPortCDM.Text,i,erreur);
    if i=0 then i:=9999;
    if i>65535 then begin labelInfo.Caption:='Port CDM rail incorrect';ok:=false;end;
    changeCDM:=(portCDM<>i) or ChangeCDM;
    portCDM:=i;

    // taille fonte
    val(EditFonte.text,i,erreur);
    if (i<8) or (i>25) then i:=10;
    TailleFonte:=i;

    // contrôle adresse IP interface
    s:=EditIPLenz.text;
    if s='' then s:='0';
    if not(IpOk(s)) and (s<>'0') then begin labelInfo.Caption:='Adresse IP interface Xpressnet incorrecte';ok:=false;end;
    changeInterface:=s<>AdresseIP;
    AdresseIP:=s;

    // contrôle port interface
    val(EditPortLenz.Text,i,erreur);
    if i=0 then i:=5550;
    if i>65535 then begin labelInfo.Caption:='Port Interface incorrect';ok:=false;end;
    changeInterface:=changeInterface or (i<>port);
    port:=i;

    Val(editTempoAig.Text,i,erreur);
    if i>3000 then begin labelInfo.Caption:='Temporisation de séquencement incorrecte ';ok:=false;end;
    Tempo_Aig:=i;

    // contrôle protocole interface  COM3:57600,N,8,1,2
    s:=EditComUSB.Text;
    if s='' then s:='COM3:57600,N,8,1,2';
    if not(config_com(s)) then begin labelInfo.Caption:='Protocole série USB Interface incorrect';ok:=false;end;
    changeUSB:=portcom<>s;
    portcom:=s;

    val(EditTempoOctetUSB.text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation octet incorrecte';ok:=false;end;
    TempoOctet:=i;

    val(EditTempoReponse.text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation de réponse interface';ok:=false;end;
    TimoutMaxInterface:=i;

    val(EditNbDetDist.text,i,erreur);
    if (erreur<>0) or (i<3) then begin labelInfo.Caption:='Valeur nombre de détecteurs trop distants incorrecte';ok:=false;end;
    Nb_Det_Dist:=i;

    val(EditNbCantons.text,i,erreur);
    if (erreur<>0) or ((i<3) or (i>5)) then begin labelInfo.Caption:='Valeur cantons signaux de 3 à 5';ok:=false;end;
    Nb_cantons_Sig:=i;
    formDebug.buttonCP.Caption:='Etat '+intToSTR(Nb_cantons_Sig)+' cantons précédents signal';

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
    MasqueBandeauTCO:=CheckBandeauTCO.checked;
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
  verifie_panneau_config:=ok;
end;

procedure TFormConfig.ButtonAppliquerEtFermerClick(Sender: TObject);
var  ok : boolean;
begin
  ok:=verifie_panneau_config;
  if ok then
  begin
    Sauve_config;
    formConfig.close;  // si la config est ok, on ferme la fenetre
  end;

  // TCO
  if avectco and not(entreeTCO) then
  begin
    //créée la fenêtre TCO non modale
    FormTCO:=TformTCO.Create(nil);
    FormTCO.show;
    FormPrinc.ButtonAffTCO.Visible:=true;
  end;
end;

// LC=Adresse du feu
procedure clicListeFeu(lc : integer);
var AncAdresse,index,adresse,erreur : integer;
    s : string;
begin
  index:=index_feu(lc)-1;
  s:=Uppercase(FormConfig.RichSig.Lines[index]);   // ligne cliquée
  if s='' then 
  begin
    RE_ColorLine(Formconfig.RichSig,ligneclicSig,ClAqua);
    ligneclicSig:=-1;
    exit;
  end;  
    
  Feu_Sauve:=feux[index+1];  // sauvegarde

  AncLigneClicSig:=ligneclicSig;
  ligneClicSig:=index;

  // Mettre en rouge le signal modifié quand on clique sur un autre signal
  if AncligneclicSig<>-1 then
  begin
    val(FormConfig.RichSig.Lines[AncLigneClicSig],AncAdresse,erreur);
    if feux[ligneClicSig+1].modifie then RE_ColorLine(Formconfig.RichSig,AncLigneClicSig,ClWhite) else
    RE_ColorLine(Formconfig.RichSig,AncLigneClicSig,ClAqua);
  end;

  Val(s,Adresse,erreur);  // Adresse du signal
  if adresse=0 then exit;

  FormConfig.EditAdrSig.Color:=clWindow;
  RE_ColorLine(Formconfig.RichSig,ligneClicSig,Clyellow);

  aff_champs_sig_feux(index+1);   // affiche les champs du feu
  clicliste:=false;
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
  Label20.Visible:=false;
  GroupBoxPN.Visible:=false;
  GroupBoxAct.Visible:=false;
  GroupBoxRadio.Visible:=false;
  GroupBoxEtatTJD.Visible:=false;

  EditP1.ReadOnly:=false;
  EditP2.ReadOnly:=false;
  EditP3.ReadOnly:=false;
  EditP4.ReadOnly:=false;
  EditPointe_BG.ReadOnly:=false;
  EditDevie_HD.ReadOnly:=false;
  EditDroit_BD.ReadOnly:=false;
  Edit_HG.ReadOnly:=false;

  EditNbCantons.text:=intToSTR(Nb_cantons_Sig);
  EditTempoFeu.Text:=IntToSTR(Tempo_feu);
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
  LabelNomSon.top:=16;LabelNomSon.Left:=48;
  SpeedButtonJoue.Top:=60; SpeedButtonCharger.Top:=60;
  EditSon.Top:=38;EditSon.Left:=16;

  CheckVerifVersion.Checked:=verifVersion;
  CheckFenEt.Checked:=Fenetre=1;
  CheckInfoVersion.Checked:=notificationVersion;
  CheckLanceCDM.Checked:=LanceCDM;
  CheckAvecTCO.checked:=avecTCO;
  CheckBandeauTCO.Checked:=MasqueBandeauTCO;
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
  // pour positionner sur la 1ere ligne
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
  ComboBoxDec.items.Clear;
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
    s:=encode_act_loc_son(i);
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

  if clicproprietes then clicListeFeu(Adressefeuclic);
  clicproprietes:=false;
  
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
    tjd,tri,tjs,croi : boolean;
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
  croi:=pos('CROI',s)<>0 ;
  with formconfig do
  begin
    EditAdrAig.Color:=clWindow;
    ImageAffiche.Picture.Bitmap.TransparentMode:=tmAuto;
    ImageAffiche.Picture.Bitmap.TransparentColor:=clblue;
    ImageAffiche.Transparent:=true;
    GroupBoxEtatTJD.Visible:=false;
    GroupBox21.Visible:=true;
    GroupBox10.Visible:=true;
    checkInverse.Visible:=true; 
    
    // tjd
    if tjd or tjs or croi then
    begin
      if not(croi) then Label20.Visible:=true;
      if tjd then 
      begin
        ComboBoxAig.ItemIndex:=1;
        EditL.Visible:=false;
        LabelL.Visible:=false;
        GroupBoxEtatTJD.Visible:=true;
        if aiguillage[ind].EtatTJD=2 then 
        begin 
          RadioButtonTJD2.Checked:=true;RadioButtonTJD4.Checked:=false;
          EditP1.Visible:=false;EditP2.Visible:=false;EditP3.Visible:=false;EditP4.Visible:=false;
          LabelTJD1.Visible:=false;LabelTJD2.Visible:=false;
        end;
        if aiguillage[ind].EtatTJD=4 then 
        begin 
          RadioButtonTJD2.Checked:=false;RadioButtonTJD4.Checked:=true;
          EditP1.Visible:=true;EditP2.Visible:=true;EditP3.Visible:=true;EditP4.Visible:=true;
          LabelTJD1.Visible:=true;LabelTJD2.Visible:=true;
        end;
      end;
      
      if tjs then 
      begin
        ComboBoxAig.ItemIndex:=2;
        EditL.Visible:=true;
        LabelL.Visible:=true;
        LabelL.Caption:='L';
        EditL.Text:=IntToSTR(aiguillage[ind].tjsint)+aiguillage[ind].tjsintB;
      end;  
      ImageAffiche.Picture.BitMap:=Imagetjd.Picture.Bitmap;
      labelBG.Caption:='S';
      Edit_HG.Visible:=true;
      EditAigTriple.Visible:=false;
     
      Edit_HG.ReadOnly:=false;        
      EditPointe_BG.ReadOnly:=false;  
      EditDevie_HD.ReadOnly:=false;
      EditDroit_BD.ReadOnly:=false;
      tjd:=true;
      labelHG.Visible:=true;
     
      CheckInverse.Visible:=true;
      EditDevieS2.Visible:=false;
      Label18.Visible:=false;
      adr2:=aiguillage[Index_Aig(adresse)].DDevie;
      id2:=Index_Aig(adr2);
      
      // champ en haut à gauche
      b:=aiguillage[Index_Aig(adresse)].ADroitB;
      if b='Z' then b:=#0;
      Edit_HG.Text:=intToSTR(aiguillage[index].ADroit)+b;  
      Edit_HG.Hint:=TypeElAIg_to_char(aiguillage[index].Adroit,b);

      // champ en bas à gauche
      b:=aiguillage[Index].ADevieB;
      if b='Z' then b:=#0;
      EditPointe_BG.Text:=intToSTR(aiguillage[index].ADevie)+b;
      EditPointe_BG.Hint:=TypeElAIg_to_char(aiguillage[index].ADevie,b);

      // milieu haut gauche
      EditP1.Text:=intToSTR(adresse)+aiguillage[Index].DDroitB; 
      // milieu bas gauche
      EditP2.Text:=intToSTR(adresse)+aiguillage[Index].DDevieB;   
    
      // milieu haut droit
      EditP3.Text:=intToSTR(aiguillage[index].Ddevie)+aiguillage[index].DDevieB; 
      // milieu bas droit
      EditP4.Text:=intToSTR(aiguillage[index].Ddroit)+aiguillage[index].DdroitB; 

      if (aiguillage[ind].EtatTJD=4) or tjs then
      begin
        // droit haut
        EditDevie_HD.Text:=intToSTR(aiguillage[id2].Adevie)+aiguillage[id2].AdevieB; 
        EditDevie_HD.Hint:=TypeElAIg_to_char(aiguillage[id2].Adevie,aiguillage[id2].AdevieB); 
        LabelTJD1.Caption:=IntToSTR(adresse);
      
        // droit bas
        EditDroit_BD.Text:=intToSTR(aiguillage[id2].Adroit)+aiguillage[Id2].AdroitB;
        EditDroit_BD.Hint:=TypeElAIg_to_char(aiguillage[id2].ADroit,aiguillage[Id2].AdroitB); 
        LabelTJD2.Caption:=IntToSTR(adr2);
      end;

      if ((aiguillage[ind].EtatTJD=2) and tjd) or croi then
      begin
        // droit haut
        EditDevie_HD.Text:=intToSTR(aiguillage[index].Ddevie)+aiguillage[index].DdevieB; 
        EditDevie_HD.Hint:=TypeElAIg_to_char(aiguillage[index].Ddevie,aiguillage[index].DdevieB); 
        LabelTJD1.Caption:=IntToSTR(adresse);
      
        // droit bas
        EditDroit_BD.Text:=intToSTR(aiguillage[index].Ddroit)+aiguillage[index].DdroitB;
        EditDroit_BD.Hint:=TypeElAIg_to_char(aiguillage[index].Ddroit,aiguillage[index].DdroitB); 
        LabelTJD2.Caption:=IntToSTR(adresse);
      end;
  

      CheckInverse.checked:=aiguillage[Index_Aig(adresse)].inversionCDM=1;
      
      if aiguillage[Index_Aig(adresse)].vitesse=0 then begin RadioButtonSans.checked:=true;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=false;end;
      if aiguillage[Index_Aig(adresse)].vitesse=30 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=true;RadioButton60kmh.checked:=false;end;
      if aiguillage[Index_Aig(adresse)].vitesse=60 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=true;end;
    end;

    if croi then 
    begin
      GroupBox21.Visible:=false;
      GroupBox10.Visible:=false;
      checkInverse.Visible:=false;
      editL.Visible:=false;
      labelL.Visible:=false;
      ComboBoxAig.ItemIndex:=4;
      editP1.Visible:=false;
      editP2.Visible:=false;
      editP3.Visible:=false;
      editP4.Visible:=false;
      labelTJD1.Visible:=false;
      labelTJD2.Visible:=false;
    end;
    
    // aiguillage normal ou tri
    if (not(tjd) and not(tjs) and not(croi)) or tri then
    begin
      EditL.Visible:=false;
      Label20.Visible:=false;
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
      EditPointe_BG.Hint:=TypeElAIg_to_char(aiguillage[index].Apointe,aiguillage[index].ApointeB);

      EditDevie_HD.Text:=intToSTR(aiguillage[index].Adevie)+aiguillage[index].AdevieB;
      EditDevie_HD.Hint:=TypeElAIg_to_char(aiguillage[index].Adevie,aiguillage[index].AdevieB); 

      EditDroit_BD.Text:=intToSTR(aiguillage[index].Adroit)+aiguillage[index].AdroitB;
      EditDroit_BD.Hint:=TypeElAIg_to_char(aiguillage[index].Adroit,aiguillage[index].AdroitB); 
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
    RadioButtonSon.Checked:=false;
    EditSon.Visible:=false;
    SpeedButtonJoue.Visible:=false;
    SpeedButtonCharger.Visible:=false;
    
    LabelNomSon.Visible:=false;
  end;
end;

procedure positionne;
begin
  with formconfig do
  begin
    GroupBoxRadio.Visible:=true;
    GroupBoxRadio.top:=16;
    GroupBoxRadio.Left:=16;
    GroupBoxAct.Top:=92;
    GroupBoxAct.Left:=16;
    GroupBoxAct.Height:=292;
    GroupBox18.Top:=16;
    GroupBox18.Height:=136;
    GroupBox19.Top:=160;
    GroupBox19.Height:=96;
  end;
end;

procedure champs_type_loco;
begin
  with formconfig do
  begin
    positionne;

    CheckRaz.Visible:=false;
    GroupBoxAct.Caption:='Actionneur de fonction F de locomotive';
    LabelTempo.Visible:=true; EditTempo.visible:=true; editEtatFoncSortie.visible:=false;LabelA.Visible:=false;
    LabelFonction.visible:=true;
    LabelFonction.caption:='Action : Fonction';
    RadioButtonLoc.Checked:=true;
    RadioButtonAccess.Checked:=false;
    RadioButtonSon.Checked:=false;
    GroupBoxAct.Visible:=true;
    GroupBoxPN.Visible:=false;
    EditSon.Visible:=false;
    SpeedButtonJoue.Visible:=false;
    SpeedButtonCharger.Visible:=false;
    EditFonctionAccess.Visible:=true;
    LabelNomSon.Visible:=false;
    editTrainDest.Visible:=true;
    label42.Visible:=true;
  end;
end;

procedure champs_type_act;
begin
  with formconfig do
  begin
    positionne;

    GroupBoxAct.Caption:='Actionneur d''accessoire';
    CheckRaz.Visible:=true;
    LabelTempo.Visible:=false; EditTempo.visible:=false;editEtatFoncSortie.visible:=true;LabelA.Visible:=true;
    LabelFonction.visible:=true;
    LabelFonction.caption:='Action : Accessoire';
    RadioButtonLoc.Checked:=false;
    RadioButtonSon.checked:=false;
    RadioButtonAccess.Checked:=true;
    GroupBoxAct.Visible:=true;
    GroupBoxPN.Visible:=false;
    EditSon.Visible:=false;
    SpeedButtonJoue.Visible:=false;
    SpeedButtonCharger.Visible:=false;
    EditFonctionAccess.Visible:=true;
    LabelNomSon.Visible:=false;
    editTrainDest.Visible:=false;
    label42.Visible:=false;
  end;
end;

procedure champs_type_son;
begin
  with formconfig do
  begin
    Positionne;
    GroupBoxAct.Caption:='Actionneur d''accessoire';
    CheckRaz.Visible:=true;

    LabelTempo.Visible:=false; EditTempo.visible:=false;

    editEtatFoncSortie.visible:=false;
    LabelA.Visible:=false;
    LabelFonction.visible:=false;
    EditFonctionAccess.Visible:=false;
    CheckRaz.Visible:=false;
    EditSon.Visible:=true;
    SpeedButtonJoue.Visible:=true;
    SpeedButtonCharger.Visible:=true;
    LabelNomSon.Visible:=true;
    
    RadioButtonLoc.Checked:=false;
    RadioButtonAccess.Checked:=false;
    RadioButtonSon.checked:=true;

    GroupBoxAct.Visible:=true;
    GroupBoxPN.Visible:=false;
    editTrainDest.Visible:=false;
    label42.Visible:=false;
  end;
end;

// transforme une chaine "élément" en une chaine affichable pour le hint
// ex chaine_element("A32")=aiguillage 32
function chaine_element(Equip : Tequipement;adr : integer) : string;
var s: string;
begin
  case Equip of
  aig : s:='Aiguillage ';
  tjd : s:='Tjd ';
  tjs : s:='Tjs ';
  triple : s:='Aiguillage triple ';
  det : s:='Détecteur ';
  else s:='Inconnu ';
  end;
  result:=s+intToSTR(adr);
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

    if feux[i].decodeur=7 then 
      ButtonConfigSR.Visible:=true else  ButtonConfigSR.Visible:=false;

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

    if (d>3) and (d<10) then CheckVerrouCarre.Visible:=true else CheckVerrouCarre.Visible:=false;
    
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
      EditDet1.Text:=IntToSTR(feux[i].Adr_det1);
      EditSuiv1.Text:=TypeEl_To_char(feux[i].Btype_suiv1)+IntToSTR(feux[i].Adr_el_suiv1);
    
      EditSuiv1.Hint:=chaine_element(feux[i].Btype_suiv1,feux[i].Adr_el_suiv1);
      j:=feux[i].Adr_det2;
      if j<>0 then 
      begin
        Editdet2.Text:=IntToSTR(j);EditSuiv2.Text:=TypeEl_To_char(feux[i].Btype_suiv2)+IntToSTR(feux[i].Adr_el_suiv2);
        EditSuiv2.Hint:=chaine_element(feux[i].Btype_suiv2,feux[i].Adr_el_suiv2);
      end else begin EditDet2.Text:='';EditSuiv2.Text:='';EditSuiv2.Hint:='';end;  
      j:=feux[i].Adr_det3;
      if j<>0 then 
      begin
        EditDet3.Text:=IntToSTR(j);EditSuiv3.Text:=TypeEl_To_char(feux[i].Btype_suiv3)+IntToSTR(feux[i].Adr_el_suiv3);
        EditSuiv3.Hint:=chaine_element(feux[i].Btype_suiv3,feux[i].Adr_el_suiv3);
      end 
      else begin EditDet3.Text:='';EditSuiv3.Text:='';EditSuiv3.Hint:='';end;
      j:=feux[i].Adr_det4;
      if j<>0 then 
      begin
        EditDet4.Text:=IntToSTR(j);EditSuiv4.Text:=TypeEl_To_char(feux[i].Btype_suiv4)+IntToSTR(feux[i].Adr_el_suiv4);
        EditSuiv4.Hint:=chaine_element(feux[i].Btype_suiv4,feux[i].Adr_el_suiv4);
      end
      else begin EditDet4.Text:='';EditSuiv4.Text:='';EditSuiv4.Hint:='';end;  

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
var etatact, adresse,sortie,fonction,tempo,access,typ : integer;
    s,s2,adr : string;
    det : boolean;
begin
  if affevt then affiche('Aff_champs_act('+intToSTR(i)+')',clyellow);
  s:=Uppercase(FormConfig.RichAct.Lines[i]);
  if s='' then exit;
  inc(i); // passer en index tablo

  fonction:=Tablo_actionneur[i].fonction;
  Access:=Tablo_actionneur[i].accessoire;
  det:=Tablo_actionneur[i].det;
  typ:=Tablo_actionneur[i].typActMemZone;

  with formconfig do
  begin
    if typ=0 then 
    begin
      EditTrainDecl.Visible:=true ;
      LabelTrain.Visible:=true ;
    end  
    else 
    begin
      EditTrainDecl.Visible:=false;
      LabelTrain.Visible:=false;
    end;
  end;    
  
  if det then s2:='Détecteur ' else s2:='Actionneur ';
  s2:=s2+intToSTR(Tablo_actionneur[i].adresse);
  FormConfig.EditAct.Hint:=s2;

  // Actionneur fonction F loco
  if Tablo_actionneur[i].loco then
  begin
    champs_type_loco;
    
    if typ=0 then with formconfig do
    begin
      radioButtonActDet.Checked:=true;
      radioButtonZones.Checked:=false;
      editAct2.Visible:=false;
      LabelActionneur.Caption:='Actionneur DétecteurZ'; 
    end;
    if typ=1 then with formconfig do
    begin
      radioButtonActDet.Checked:=false;
      radioButtonZones.Checked:=true;
      editAct2.Visible:=true;
      LabelActionneur.Caption:='Mémoire de Zone'; 
      editAct2.Text:=IntToSTR(Tablo_actionneur[i].adresse2);
    end;
    
    etatAct:=Tablo_actionneur[i].etat;
    Adresse:=Tablo_actionneur[i].adresse;
    s2:=Tablo_actionneur[i].trainDecl;
    trainsauve:=s2;
    tempo:=tablo_actionneur[i].Tempo;
    with formconfig do
    begin
      champs_type_loco;
      adr:=IntToSTR(Adresse); if det then adr:=adr+'Z';
      EditAct.text:=adr;
      EditAct2.Text:=inttostr(Tablo_actionneur[i].adresse2);
      editEtatActionneur.Text:=IntToSTR(etatAct);
      EditTrainDecl.Text:=s2;
      EditTrainDest.Text:=Tablo_actionneur[i].trainDest;
      editFonctionAccess.Text:=intToSTR(fonction);
      editTempo.Text:=intToSTR(tempo);
    end;
  end;

  // Actionneur accessoire
  if Tablo_actionneur[i].act then
  begin
    champs_type_act;
    if typ=0 then with formconfig do
    begin
      radioButtonActDet.Checked:=true;
      radioButtonZones.Checked:=false;
      editAct2.Visible:=false;
      LabelActionneur.Caption:='Actionneur DétecteurZ'; 
    end;
    if typ=1 then with formconfig do
    begin
      radioButtonActDet.Checked:=false;
      radioButtonZones.Checked:=true;
      editAct2.Visible:=true;
      LabelActionneur.Caption:='Mémoire de Zone'; 
    end;
    
    etatAct:=Tablo_actionneur[i].etat ;
    Adresse:=Tablo_actionneur[i].adresse;
    sortie:=Tablo_actionneur[i].sortie;
    s2:=Tablo_actionneur[i].trainDecl;
    trainsauve:=s2;
    tempo:=tablo_actionneur[i].Tempo;
    with formconfig do
    begin
      adr:=IntToSTR(Adresse); if det then adr:=adr+'Z';
      EditAct.text:=adr;
      EditAct2.Text:=inttostr(Tablo_actionneur[i].adresse2);
      CheckRaz.Checked:=Tablo_actionneur[i].Raz;
      EditTrainDecl.Text:=s2;
      EditEtatActionneur.Text:=IntToSTR(etatAct);
      editFonctionAccess.Text:=intToSTR(Access);
      editEtatFoncSortie.Text:=intToSTR(sortie);
      editTempo.Text:=intToSTR(tempo);
    end;
  end;

  // Actionneur son
  if Tablo_actionneur[i].son then
  begin
    champs_type_son;
    if typ=0 then with formconfig do
    begin
      radioButtonActDet.Checked:=true;
      radioButtonZones.Checked:=false;
      editAct2.Visible:=false;
      LabelActionneur.Caption:='Actionneur DétecteurZ'; 
    end;
    if typ=1 then with formconfig do
    begin
      radioButtonActDet.Checked:=false;
      radioButtonZones.Checked:=true;
      editAct2.Visible:=true;
      LabelActionneur.Caption:='Mémoire de Zone';
    end;

    etatAct:=Tablo_actionneur[i].etat ;
    Adresse:=Tablo_actionneur[i].adresse;
    s2:=Tablo_actionneur[i].trainDecl;
    trainsauve:=s2;
    s:=Tablo_actionneur[i].FichierSon;
    with formconfig do
    begin
      adr:=IntToSTR(Adresse); if det then adr:=adr+'Z';
      EditAct.text:=adr;
      EditAct2.Text:=inttostr(Tablo_actionneur[i].adresse2);
      //CheckRaz.Checked:=Tablo_actionneur[i].Raz;
      EditTrainDecl.Text:=s2;
      EditSon.Text:=s;
      EditEtatActionneur.Text:=IntToSTR(etatAct);
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
    EditTrainDecl.Text:='';
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

procedure TFormConfig.Edit_HGChange(Sender: TObject);
var s : string;
    adr,adraig,erreur,index : integer;
    b : char;
begin
  if clicliste then exit;
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
      Edit_HG.Hint:=TypeElAIg_to_char(adr,B);
      
      // réencoder la ligne
      s:=encode_aig(index);
      formconfig.RichAig.Lines[ligneclicAig]:=s;
    end
      else
        LabelInfo.caption:='Erreur pointe aiguillage '+intToSTR(AdrAig);
    end;
end;

// on change la valeur de la description du champ HG pour les TJD
procedure TFormConfig.EditDevie_HDChange(Sender: TObject);
var AdrAig,adr,adr2,erreur,index : integer;
    b : char;
    modele:Tequipement;
    s : string;
begin
  // cliqué sur le edit dévié aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
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

    if (modele=aig) or (modele=triple) then
    begin
      if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
      begin
        // aiguillage normal ou triple
        LabelInfo.caption:='';
        if (B='S') or (b='P') or (b='D') then
        begin
          if adr=AdrAig then LabelInfo.caption:='Un aiguillage ne peut pointer sur lui même ';
        end;

        RE_ColorLine(RichAig,ligneclicAig,ClWhite);
        Aiguillage[index].modifie:=true;
        // modifier la base de données de l'aiguillage
        if b=#0 then b:='Z';
        Aiguillage[Index].ADevie:=adr;
        Aiguillage[Index].ADevieB:=B;
        EditDevie_HD.Hint:=TypeElAIg_to_char(adr,B);
        // réencoder la ligne
        s:=encode_aig(Index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end
      else
      begin
        LabelInfo.caption:='Erreur déviation aiguillage '+intToSTR(AdrAig);
      end;
    end;

    if (modele=tjd) or (modele=tjs) then
    begin
      // TJD4/TJS
      if aiguillage[index].EtatTJD=4 then
      begin
        adr2:=aiguillage[index].DDroit;  // adresse homologue
        index:=Index_aig(adr2);
        if index=0 then exit;
        aiguillage[index].Adevie:=adr;
        aiguillage[index].AdevieB:=B;
        RE_ColorLine(Formconfig.RichAig,index-1,ClWhite);
        LabelInfo.caption:='Modification de la TJD homologe ('+IntToSTR(adr2)+')';
      end;
      if aiguillage[index].EtatTJD=2 then
      begin
        aiguillage[index].Ddevie:=adr;
        aiguillage[index].DdevieB:=B;
      end;
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end;

    if modele=crois then
    begin
      aiguillage[index].Ddevie:=adr;
      aiguillage[index].DdevieB:=B;
      RE_ColorLine(Formconfig.RichAig,index-1,ClWhite);
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end;
    
  end;  
end;

// on change la valeur de la description de la déviation de l'aiguillage
procedure TFormConfig.EditDroit_BDChange(Sender: TObject);
var AdrAig,adr,erreur,index,adr2 : integer;
    b : char;
    modele: TEquipement;
    s : string;
begin
  // cliqué sur le edit droit aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
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

    LabelInfo.caption:='';
    if (B='S') or (b='P') or (b='D') then
    begin
      if adr=AdrAig then LabelInfo.caption:='Un aiguillage ne peut pointer sur lui même ';
    end;

    modele:=aiguillage[index].modele;
    if (modele=aig) or (modele=triple) then
    begin
      if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
      begin
        RE_ColorLine(RichAig,ligneclicAig,ClWhite);
        Aiguillage[Index].modifie:=true;
        // modifier la base de données de l'aiguillage
        if b=#0 then b:='Z';
        Aiguillage[index].ADroit:=adr;
        Aiguillage[index].ADroitB:=B;
          EditDroit_BD.Hint:=TypeElAIg_to_char(adr,B);
        // réencoder la ligne
        s:=encode_aig(Index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end
      else
      begin
        LabelInfo.caption:='Erreur droit aiguillage '+intToSTR(AdrAig);
      end;
    end;

    if (modele=tjd) or (modele=tjs) then
    begin
      // TJD4/TJS
      if aiguillage[index].EtatTJD=4 then
      begin 
        adr2:=aiguillage[index].DDroit;  // adresse homologue
        index:=Index_aig(adr2);
        if index=0 then exit;
        aiguillage[index].Adroit:=adr;
        aiguillage[index].AdroitB:=B;
      end;  
      // TJD2
      if aiguillage[index].EtatTJD=2 then
      begin 
        aiguillage[index].Ddroit:=adr;
        aiguillage[index].DdroitB:=B;
      end;  
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
      RE_ColorLine(Formconfig.RichAig,index-1,ClWhite);
      LabelInfo.caption:='Modification de la TJD homologe ('+IntToSTR(adr2)+')';
    end;

    if modele=crois then
    begin
      aiguillage[index].Ddroit:=adr;
      aiguillage[index].DdroitB:=B;
      RE_ColorLine(Formconfig.RichAig,index-1,ClWhite);
      s:=encode_aig(index);
      formconfig.RichAig.Lines[index-1]:=s;
    end;
    
  end;

end;

procedure TFormConfig.EditPointe_BGChange(Sender: TObject);
var AdrAig,adr,erreur,index : integer;
    b : char;
    normal,tjdC,tjsC,triC,croi : boolean;
    s : string;
begin
  // cliqué sur le edit pointe aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
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
      LabelInfo.caption:='';
      if (B='S') or (b='P') or (b='D') then
      begin
        if adr=AdrAig then LabelInfo.caption:='Un aiguillage ne peut pointer sur lui même ';
      end;

      normal:=aiguillage[index].modele=aig;
      tjdC:=aiguillage[index].modele=tjd;
      tjsC:=aiguillage[index].modele=tjs;
      triC:=aiguillage[index].modele=triple;
      croi:=aiguillage[index].modele=crois;

      Aiguillage[index].modifie:=true;

      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';

      if normal or triC then
      begin
        Aiguillage[index].APointe:=adr;
        Aiguillage[index].APointeB:=B;
        // réencoder la ligne
        s:=encode_aig(index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end;
      if tjdC or tjsC or croi then
      begin
        Aiguillage[index].ADevie:=adr;
        Aiguillage[index].ADevieB:=B;
        s:=encode_aig(index);
        formconfig.RichAig.Lines[ligneclicAig]:=s;
      end;
      EditPointe_BG.Hint:=TypeElAIg_to_char(adr,B);
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

procedure TFormConfig.RadioButtonTJD2Click(Sender: TObject);
var AdrAig,erreur,index,adr2 : integer;
    s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt RadioBouton tjd 2 états',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;

  EditP1.Visible:=false;EditP2.Visible:=false;EditP3.Visible:=false;EditP4.Visible:=false;
  LabelTJD1.Visible:=false;LabelTJD2.Visible:=false;
  
  index:=Index_Aig(AdrAig);
  aiguillage[index].etatTJD:=2;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[ligneclicAig]:=s;
  
  adr2:=aiguillage[index].Ddroit;  // adresse homologue
  index:=Index_Aig(Adr2);
  aiguillage[index].etatTJD:=2;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[index-1]:=s;
end;


procedure TFormConfig.RadioButtonTJD4Click(Sender: TObject);
var AdrAig,erreur,index,adr2 : integer;
    s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt RadioBouton tjd 4 états',clyellow);
  s:=formconfig.RichAig.Lines[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;

  EditP1.Visible:=true;EditP2.Visible:=true;EditP3.Visible:=true;EditP4.Visible:=true;
  LabelTJD1.Visible:=true;LabelTJD2.Visible:=true;
  
  index:=Index_Aig(AdrAig);
  aiguillage[index].etatTJD:=4;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[ligneclicAig]:=s;
  
  adr2:=aiguillage[index].Ddroit;  // adresse homologue
  index:=Index_Aig(Adr2);
  aiguillage[index].etatTJD:=4;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.RichAig.Lines[index-1]:=s;
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
  if i<1 then exit;
  feux[i].decodeur:=ComboBoxDec.ItemIndex;
  Maj_Hint_feu(i);

  s:=encode_sig_feux(i);
  formconfig.RichSig.Lines[ligneclicSig]:=s;
  aff_champs_sig_feux(i);
  if affevt then Affiche('Evt ComboBox Decodeur',clOrange);
end;



// cliqué sur liste feux
procedure TFormConfig.RichSigMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var lc : integer;
begin
  clicliste:=true;
  raz_champs_sig;
  
  with Formconfig.RichSig do
  begin
    lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    //Affiche('numéro de la ligne cliquée '+intToStr(lc),clyellow);
    clicListeFeu(feux[lc+1].adresse);
  end;  

end;

procedure Det1;
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt detecteur 1',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet1.Text;
    Val(s,i,erreur);
    if (s<>'') and (erreur<>0) then begin LabelInfo.caption:='Erreur détecteur1 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det1:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet1Change(Sender: TObject);
begin
  Det1;
end;

procedure TFormConfig.EditTempoFeuChange(Sender: TObject);
var i,erreur : integer;
    s : string;
begin
  s:=editTempoFeu.Text;
  Val(s,i,erreur);
  if (s<>'') and (erreur<>0) then begin LabelInfo.caption:='Erreur temporisation décodeurs ';exit;end;
  LabelInfo.caption:=' ';
  tempo_feu:=i;
end;

procedure Suiv1;
   var s : string;
    i,erreur : integer;
    bt : Tequipement;
begin    
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Element suivant1',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv1.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if erreur<>0 then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
        end
        else begin LabelInfo.caption:='Erreur élément suivant 1';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv1:=i;
    feux[ligneClicSig+1].Btype_suiv1:=bt;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;


procedure TFormConfig.EditSuiv1Change(Sender: TObject);
begin
  Suiv1;
end;


procedure Det2;
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt detecteur 2',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet2.Text;
    Val(s,i,erreur);
    if (s<>'') and (erreur<>0) then begin LabelInfo.caption:='Erreur détecteur2 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det2:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet2Change(Sender: TObject);
begin
  det2;
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

procedure Suiv2;
var s : string;
    erreur,i: integer;
    bt : Tequipement;
begin
  if affevt then Affiche('Evt Element suivant2',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv2.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if erreur<>0 then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
        end
        else begin LabelInfo.caption:='Erreur élément suivant 2';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv2:=i;
    feux[ligneClicSig+1].Btype_suiv2:=bt;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;

procedure TFormConfig.EditSuiv2Change(Sender: TObject);
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) then exit;
  Suiv2;
end;

procedure det3;
var s : string;
    i,erreur : integer;
begin    
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt detecteur 3',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet3.Text;
    Val(s,i,erreur);
    if (s<>'') and (erreur<>0) then begin LabelInfo.caption:='Erreur détecteur3 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det3:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet3Change(Sender: TObject);
begin
  if clicliste or (ligneClicSig<0) then exit;
  det3;
end;


procedure Suiv3;
var s : string;
    erreur,i : integer;
    bt : Tequipement;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Element suivant3',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv3.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if erreur<>0 then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
        end
        else begin LabelInfo.caption:='Erreur élément suivant 3';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv3:=i;
    feux[ligneClicSig+1].Btype_suiv3:=bt;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;  

procedure TFormConfig.EditSuiv3Change(Sender: TObject);
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) then exit;
  suiv3;
end;

procedure det4;
var s : string;
    i,erreur : integer;
begin
  if clicliste then exit;
  if affevt then Affiche('Evt detecteur 4',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet4.Text;
    Val(s,i,erreur);
    if (s<>'') and (erreur<>0) then begin LabelInfo.caption:='Erreur détecteur4 ';exit;end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_det4:=i;
    maj_hint_feu(ligneClicSig+1);
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
    feux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet4Change(Sender: TObject);
begin
  if clicliste or (ligneClicSig<0) then exit;
  det4;
end;

procedure suiv4;
var s : string;
    erreur,i : integer;
    bt : Tequipement;
begin
  if clicliste or (ligneClicSig<0)  then exit;
  if affevt then Affiche('Evt Element suivant4',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv4.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if erreur<>0 then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
        end
        else begin LabelInfo.caption:='Erreur élément suivant 4';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    feux[ligneClicSig+1].Adr_el_suiv4:=i;
    feux[ligneClicSig+1].Btype_suiv4:=bt;
    s:=encode_sig_feux(ligneClicSig+1);
    RichSig.Lines[ligneClicSig]:=s;
  end;
end;

procedure TFormConfig.EditSuiv4Change(Sender: TObject);
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) then exit;
  Suiv4;
end;


procedure TFormConfig.EditActChange(Sender: TObject);
var s,s2 : string;
    act,erreur : integer;
    det : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit act Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin
    s:=EditAct.Text;
    if radioButtonLoc.Checked or RadioButtonAccess.Checked or RadioButtonSon.Checked then
    begin
      Val(s,act,erreur);
      if s='' then exit;
      det:=pos('Z',s)<>0;    // si détecteur
      if det then s2:='Détecteur ' else s2:='Actionneur ';
      s2:=s2+intToSTR(act);
      EditAct.Hint:=s2;
      if det then delete(s,erreur,1);
      Val(s,act,erreur);
      if erreur<>0 then
      begin
        LabelInfo.caption:='Erreur adresse actionneur';exit
      end else LabelInfo.caption:=' ';

      tablo_actionneur[ligneClicAct+1].adresse:=act;
      tablo_actionneur[ligneClicAct+1].det:=det;
      s:=encode_act_loc_son(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;


procedure TFormConfig.EditAct2Change(Sender: TObject);
var s,s2 : string;
    det2,erreur : integer;
    det : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit act2 Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin
    s:=EditAct2.Text;
    if radioButtonLoc.Checked or RadioButtonAccess.Checked or RadioButtonSon.Checked then
    begin
      Val(s,det2,erreur);
      if s='' then exit;
      if erreur<>0 then
      begin
        LabelInfo.caption:='Erreur adresse détecteur';exit
      end else LabelInfo.caption:=' ';

      tablo_actionneur[ligneClicAct+1].adresse2:=det2;
      tablo_actionneur[ligneClicAct+1].det:=det;
      s:=encode_act_loc_son(ligneClicAct+1);
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
      s:=encode_act_loc_son(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;
  
procedure TFormConfig.EditTrainDeclChange(Sender: TObject);
var s,train : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit TrainDecl Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin
    if radioButtonLoc.Checked or RadioButtonAccess.Checked then
    begin
      train:=EditTrainDecl.Text;
      if train='' then
      begin
        LabelInfo.caption:='Erreur train';exit
      end else LabelInfo.caption:=' ';

      tablo_actionneur[ligneClicAct+1].trainDecl:=train;
      s:=encode_act_loc_son(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.EditTrainDestChange(Sender: TObject);
var s,train : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit TrainDest Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin
    if radioButtonLoc.Checked then
    begin
      train:=EditTrainDest.Text;
      if train='' then
      begin
        LabelInfo.caption:='Erreur train';exit
      end else LabelInfo.caption:=' ';

      tablo_actionneur[ligneClicAct+1].trainDest:=train;
      s:=encode_act_loc_son(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;

end;


procedure TFormConfig.EditSonChange(Sender: TObject);
var s,fichier : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt Edit NomFichier Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAct then
  with Formconfig do
  begin 
    if radioButtonLoc.Checked or RadioButtonAccess.Checked or RadioButtonSon.Checked then
    begin
      fichier:=EditSon.Text;
      if fichier='' then
      begin
        LabelInfo.caption:='Nom fichier vide';exit
      end else LabelInfo.caption:=' ';
      
      tablo_actionneur[ligneClicAct+1].fichierSon:=fichier;
      s:=encode_act_loc_son(ligneClicAct+1);
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
      
      s:=encode_act_loc_son(ligneClicAct+1);
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
      s:=encode_act_loc_son(ligneClicAct+1);
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
      s:=encode_act_loc_son(ligneClicAct+1);
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
      s:=encode_act_loc_son(ligneClicAct+1);
      RichAct.Lines[ligneClicAct]:=s;
    end;
  end;
end;

procedure TFormConfig.EditAdrSigChange(Sender: TObject);
var s : string;
    i, erreur : integer;
begin
  if clicliste then exit;
  if affevt then Affiche('Evt adresse signal',clOrange);
  // attention interférence avec clic droit propriétés sur un signal qui génère un evt sur ce contrôle
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditAdrSig.Text;
    if (s='') or (ligneClicSig<0) then exit;
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
    Maj_Hint_feu(ligneClicSig+1); 
   end;
end;             


procedure TFormConfig.EditAdrAigChange(Sender: TObject);
  var s : string;
    i,vide,erreur,index,adr2 : integer;
    modele: TEquipement;
    c : char;
begin
  if clicliste then exit;
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
    if (modele=aig) or (modele=triple) then
    begin
      if (erreur<>0) or (i>MaxAcc) then begin LabelInfo.caption:='Erreur adresse aiguillage ';exit;end;
      //  vérifier si l'adresse de l'aiguillage existe déja
      if (aiguillage[Index_Aig(i)].modele<>rien) then 
      begin
        EditAdrAig.Color:=clred;
        LabelInfo.caption:='aiguillage '+IntToSTR(i)+' existe déja - ne sera pas écrasé' ;
        exit;
      end;
      
      EditAdrAig.Color:=clWindow;
      LabelInfo.caption:=' ';
      aiguillage[index].adresse:=i;
      aiguillage[index].modifie:=true;
      s:=encode_aig(index);  
      formconfig.RichAig.Lines[ligneclicAig]:=s;
    end;
    if (modele=tjd) or (modele=tjs) then  
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
var x,y,i,index,aspect,adresseFeu : integer;
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
  if index<1 then exit;
  if NbreFeux<index then exit;
  //Affiche('Ligne cliquée='+IntToSTR(index),clyellow);
  if ((aspect=2) or (aspect>=5)) and (aspect<10) then
    checkBoxFB.Visible:=true else
    begin
      checkBoxFB.Visible:=false;
      checkBoxFB.Checked:=false;
    end;
  if (aspect>3) and (aspect<10) then CheckVerrouCarre.Visible:=true else CheckVerrouCarre.Visible:=false;

  feux[index].aspect:=aspect;
  s:=encode_sig_feux(index);
  RichSig.Lines[ligneClicSig]:=s;
  aff_champs_sig_feux(index); // redessine les champs et le feu

  // change l'image du feu dans la feuille graphique principale
  Feux[index].Img.picture.Bitmap:=Select_dessin_feu(feux[index].aspect);
  dessine_feu_mx(Feux[index].Img.Canvas,0,0,1,1,feux[index].adresse,1);  // dessine les feux du signal
  // et dans le TCO
  if avecTCO then
  begin
    for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage=30 then
        begin
          AdresseFeu:=feux[index].adresse;
          if tco[x,y].Adresse=AdresseFeu then affiche_tco;
        end;
      end;
  end;
end;


procedure TFormConfig.EditSpecUniChange(Sender: TObject);
var erreur,i,Adr : integer ;
    s : string ;
begin
  if clicliste or (ligneClicSig<0) then exit;
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
  Tablo_Actionneur[i].Son:=false;
  champs_type_loco; 
  
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].adresse:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  Tablo_actionneur[i].trainDecl:=EditTrainDecl.Text;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc_son(i);
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
  Tablo_Actionneur[i].Son:=false;
  champs_type_act;  
  
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].adresse:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  Tablo_actionneur[i].trainDecl:=EditTrainDecl.Text;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc_son(i);
  RichAct.Lines[ligneClicAct]:=s;
end;


procedure TFormConfig.RadioButtonSonClick(Sender: TObject);
var  champ,i,erreur : integer;
    s : string;
begin
  // rendre visible le groupbox Actionneur fonction F loco
  if clicListe then exit;
  i:=ligneClicAct+1;
  if AffEvt then Affiche('RadioSon '+IntToSTR(i),clyellow);

  Tablo_Actionneur[i].loco:=false;
  Tablo_Actionneur[i].Act:=false;
  Tablo_Actionneur[i].Son:=true;
  
  champs_type_son;  
 
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].adresse:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  Tablo_actionneur[i].trainDecl:=EditTrainDecl.Text;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc_son(i);
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
    i:=lignecliqueePN+1;
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

  s:=encode_act_loc_son(i); 
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
  
  adr:=tablo_actionneur[index].adresse;
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
    s:=encode_act_loc_son(i);
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
var i,index,AdrMax : integer;
    s : string;
begin
  clicliste:=true;
  inc(NbreFeux);

  AdrMax:=0;
  for i:=1 to NbreFeux do
  begin
    if AdrMax<feux[i].adresse then AdrMax:=feux[i].adresse;
  end;

  i:=NbreFeux;
  feux[i].Adresse:=AdrMax+20;
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


procedure supprime_sig;
var adresse,i,indexFeu,index,debut,fin,longueur,ltot,lignedeb,lignefin,l : integer;
    s : string;
begin
  if affevt then affiche('Evt bouton Sup Feu',clyellow);
  //trouver ligne de début et de fin sélectionner.
  debut:=FormConfig.RichSig.SelStart;
  longueur:=FormConfig.RichSig.SelLength;
  fin:=debut+longueur;
  //Affiche(inttostr(debut)+' '+inttostr(longueur),clyellow);
  // trouver les lignes sélectionnées
  i:=0;ltot:=0;ligneDeb:=0;LigneFin:=0;
  repeat
    l:=length(FormConfig.RichSig.lines[i])+2;  //+2 car CR LF
    ltot:=ltot+l;
    if (debut<ltot) and (ligneDeb=0) then ligneDeb:=i+1;
    if (ltot>=fin) and (ligneFin=0) and (ligneDeb<>0) then ligneFin:=i+1;
    //if (ltot=fin) and (ligneFin=0) then ligneFin:=i;
    inc(i);
  until (i>=NbreFeux) or (ligneFin>0);
  if lignefin=0 then if fin>ltot then ligneFin:=NbreFeux;
  //Affiche(inttostr(ligneDeb)+' '+inttostr(LigneFin),clyellow);

  i:=ligneClicSig;
  if (i<0) then exit;
  index:=i+1; // passe en index tableau

  if ligneDeb=LigneFin then s:='Voulez-vous supprimer le signal '+IntToSTR(feux[index].adresse)+'?'
  else s:='Voulez-vous supprimer les signaux de '+
           IntToSTR(feux[ligneDeb].adresse)+' à '+IntToSTR(feux[ligneFin].adresse)+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  FormConfig.ButtonInsFeu.Caption:='Ajouter le feu '+intToSTR(feux[index].adresse)+' supprimé';
  clicliste:=true;
  Feu_supprime:=feux[index];  // sauvegarde le supprimé
  feu_sauve.adresse:=0;       // dévalider sa définition

  index:=ligneDeb;

  if ligneDeb=LigneFin then s:='Suppression du signal '+IntToSTR(feux[index].adresse)
  else s:='Suppression des signaux de '+
           IntToSTR(feux[ligneDeb].adresse)+' à '+IntToSTR(feux[ligneFin].adresse);
  Affiche(s,clOrange);

  //Affiche('Boucle de '+intToSTR(ligneDeb)+' N='+intToSTR(NbreFeux-ligneFin),clyellow);

  // d'abord supprimer les images des feux
  for i:=LigneDeb to LigneFin do
  begin
    feux[i].Img.free;  // supprime l'image, ce qui efface le feu du tableau graphique
    Feux[i].Lbl.free;  // supprime le label, ...
    if Feux[i].check<>nil then begin Feux[i].check.Free;Feux[i].Check:=nil;end;  // supprime le check du feu blanc s'il existait
  end;

  for i:=1 to NbreFeux-ligneFin do
  begin
    index:=i+lignefin; //index ddu feu de remplacement
    indexFeu:=lignedeb+i-1;
    //Affiche('Suppresion feu '+intToSTR(feux[i+lignedeb].Adresse),clorange);
    //Affiche('remplacement par index '+intToSTR(index),clorange);

   feux[indexFeu]:=feux[index];
   adresse:=feux[indexFeu].adresse;

    with feux[IndexFeu].Img do
    begin
      Parent:=Formprinc.ScrollBox1;   // dire que l'image est dans la scrollBox1
      Top:=(HtImg+espY+20)*((IndexFeu-1) div NbreImagePLigne);   // détermine les points d'origine
      Left:=10+ (LargImg+5)*((IndexFeu-1) mod (NbreImagePLigne));
      Name:='ImageFeu'+IntToSTR(adresse);
      s:='Index='+IntToSTR(IndexFeu)+' @='+inttostr(feux[IndexFeu].Adresse)+' Décodeur='+intToSTR(feux[IndexFeu].Decodeur)+
       ' Adresse détecteur associé='+intToSTR(feux[IndexFeu].Adr_det1)+
       ' Adresse élement suivant='+intToSTR(feux[IndexFeu].Adr_el_suiv1);
      if feux[IndexFeu].Btype_suiv1=aig then s:=s+' (aig)';
      Hint:=s;
    end;
    with feux[IndexFeu].Lbl do
    begin
      Top:=HtImg+((HtImg+EspY+20)*((IndexFeu-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((IndexFeu-1) mod (NbreImagePLigne));
      caption:='@'+IntToSTR(Feux[IndexFeu].adresse);
    end;
    if Feux[IndexFeu].check<>nil then
    with Feux[IndexFeu].Check do
    begin
      Hint:=intToSTR(IndexFeu);
      Top:=HtImg+15+((HtImg+EspY+20)*((IndexFeu-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((IndexFeu-1) mod (NbreImagePLigne));
    end;
    //Affiche('décale feu '+IntToSTR(i)+'<'+intToSTR(i+1),clorange);

    feux[index].Adresse:=0;
    feux[index].modifie:=false;
  end;
  Nbrefeux:=NbreFeux-(ligneFin-LigneDeb)-1;

  config_modifie:=true;
  FormConfig.RichSig.Clear;

  // réafficher le richsig
  for i:=1 to NbreFeux do
  begin
    s:=encode_Sig_Feux(i);
    if s<>'' then
    begin
      FormConfig.RichSig.Lines.Add(s);
      RE_ColorLine(FormConfig.RichSig,FormConfig.RichSig.lines.count-1,ClAqua);
    end;
  end;
  ligneClicSig:=-1;
  AncligneClicSig:=-1;
  raz_champs_sig;
  clicliste:=false;

  {
  i:=ligneClicSig;
  if (i<0) then exit;
  index:=i+1; // passe en index tableau

  s:='Voulez-vous supprimer le feu '+IntToSTR(feux[index].adresse)+'?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  Affiche('Suppression du feu ='+IntToSTR(feux[index].adresse),clOrange);

  clicliste:=true;  // évite les évènements Edit text
  Feu_supprime:=feux[index];  // sauvegarde le feu supprimé
  Feu_sauve.adresse:=0; // dévalider sa définition
  Feu_sauve.aspect:=0; // dévalider sa définition

  // supprime le feu du tableau

  ButtonInsFeu.Caption:='Ajouter le feu '+intToSTR(feux[index].adresse)+' supprimé';

  feux[index].Img.free;  // supprime l'image, ce qui efface le feu du tableau graphique
  Feux[index].Lbl.free;  // supprime le label, ...
  if Feux[index].check<>nil then begin Feux[index].check.Free;Feux[index].Check:=nil;end;  // supprime le check du feu blanc s'il existait

  // décale le tableau de feux et recalcule les positions des images
  for i:=index to NbreFeux-1 do
  begin
    feux[i]:=feux[i+1];
    with feux[i].Img do
    begin
      Top:=(HtImg+espY+20)*((i-1) div NbreImagePLigne);   // détermine les points d'origine
      Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
      Name:='ImageFeu'+IntToSTR(i);
      s:='Index='+IntToSTR(i)+' @='+inttostr(feux[i].Adresse)+' Décodeur='+intToSTR(feux[i].Decodeur)+
       ' Adresse détecteur associé='+intToSTR(feux[i].Adr_det1)+
       ' Adresse élement suivant='+intToSTR(feux[i].Adr_el_suiv1);
      if feux[i].Btype_suiv1=aig then s:=s+' (aig)';
      Hint:=s;
    end;
    with feux[i].Lbl do
    begin
      Top:=HtImg+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
      caption:='@'+IntToSTR(Feux[i].adresse);
    end;
    if Feux[i].check<>nil then
    with Feux[i].Check do
    begin
      Hint:=intToSTR(i);
      Top:=HtImg+15+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
    end;
    //Affiche('décale feu '+IntToSTR(i)+'<'+intToSTR(i+1),clorange);
  end;

  dec(NbreFeux);

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
  }
end;

procedure TFormConfig.ButtonSupFeuClick(Sender: TObject);
begin
  Supprime_sig;
end;

// Ajouter le feu supprimé
procedure TFormConfig.ButtonInsFeuClick(Sender: TObject);
var s : string;
begin
  if feu_supprime.adresse<>0 then
  begin
    clicliste:=true;
    inc(NbreFeux);
    feux[NbreFeux]:=Feu_supprime;
    Feu_Supprime.adresse:=0;  // dévalider le feu sauvegardé
    Feu_supprime.aspect:=0;
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

// renvoie le numéro de branche en défaut
// si ok, renvoie 0
Function verif_extr_branches : integer;
var i,j,detect,erreur : integer;
    model,AncModel : Tequipement;
begin
  Erreur:=0;
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;
      AncModel:=model;
      model:=BrancheN[i][j].BType;
      if (j=1) and (model<>Aig) and (Model<>Buttoir) then
      begin
        Affiche('Erreur 3.1 branche '+intToSTR(i)+' : le premier élément d''une branche doit être un buttoir ou un aiguillage',clred);
        erreur:=i;
      end;
      inc(j);
      until((model=rien) and (detect=0));
    if (Ancmodel<>Aig) and (AncModel<>Buttoir) then
    begin
      Affiche('Erreur 3.2 branche '+intToSTR(i)+' : le dernier élément d''une branche doit être un buttoir ou un aiguillage',clred);
      erreur:=i;
    end;
  end;

  verif_extr_branches:=Erreur;
end;

function verif_coherence : boolean;
var AncAdr,i,j,k,l,Indexaig,adr,adr2,extr,detect,condcarre,nc,index2,SuivAdr,
    x,y,extr2,adr3,index3 : integer;
    modAig,AncModel,model,km,SuivModel,model2: TEquipement;
    c : char;
    ok,trouveSuiv,TrouvePrec : boolean;
begin
  // vérification de la cohérence1
  // parcoure les branches jusqu'à trouver un aiguillage pour voir s'il a été décrit
  ok:=true;
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;

      if detect>NbMemZone then
      begin
        Affiche('Erreur 1: adresse détecteur trop grand: '+intToSTR(detect),clred);
        ok:=false;
      end;

      AncModel:=model;
      model:=BrancheN[i][j].BType;  // 1= détecteur  2= aiguillage  4=Buttoir

      if (model=aig) then
      begin
        //affiche('trouvé aig '+intToSTR(detect),clyellow);
        modAig:=aiguillage[Index_Aig(detect)].modele;
        if (modAig=rien) then
          begin
            Affiche('Erreur 2: Aiguillage '+intToStr(detect)+' non décrit mais présent en branche '+intToStr(i)+' pos. '+intToSTR(j),clred);
            ok:=false;
          end;
      end;
      j:=j+1;
    until((model=rien) and (detect=0));
    if (Ancmodel<>Aig) and (AncModel<>Buttoir) then
      Affiche('Erreur 3.2 branche '+intToSTR(i)+' : le dernier élément d''une branche doit être un buttoir ou un aiguillage',clred);
  end;

  if verif_extr_branches<>0 then ok:=false;

  // vérification de la cohérence2
  // parcoure les aiguillages pour voir si les détecteurs sont en branches des détecteurs
  // et les tjd pour voir si pb de cohérence
  for Indexaig:=1 to maxaiguillage do
  begin
    // tjd ou tjs
    if ((aiguillage[Indexaig].modele=tjd) and (aiguillage[Indexaig].EtatTJD=4)) or (aiguillage[Indexaig].modele=tjs) then
    begin
      if aiguillage[Indexaig].Ddroit<>aiguillage[Indexaig].Ddevie then
      begin
        Affiche('Erreur 7: la TJD/S '+IntToStr(Indexaig)+' a des adresses de destination différentes ('+intToSTR(aiguillage[Indexaig].Ddroit)+' et '+intToSTR(aiguillage[Indexaig].Ddevie)+')',clred);
        ok:=false;
      end;
      // vérifier si son homologue est une tjd
      adr2:=aiguillage[Indexaig].Ddroit;
      if (aiguillage[Index_Aig(adr2)].modele<>tjd) and (aiguillage[Index_Aig(adr2)].modele<>tjs) then 
      begin
        Affiche('Erreur 8: l''aiguillage '+intToStr(Adr2)+' n''est pas une TJD/S ou n''existe pas, mais apparait dans la TJD/S '+IntToSTR(aiguillage[Indexaig].Adresse),clred);
        ok:=false;
      end;
    end;
    // vérifier si l'aiguillage est dans les branches
    if aiguillage[Indexaig].modele<>rien then
    begin
      trouve_aiguillage(aiguillage[Indexaig].adresse); // passe l'adresse de l'aiguillage à trouver
      if (IndexBranche_trouve=0) then
      begin
        Affiche('Avertissement 6: aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' décrit dans les aiguillages ; absent dans la description des branches',clOrange);
        ok:=false;
      end;
    end;
    adr:=aiguillage[Indexaig].Adroit;
    if (aiguillage[Indexaig].AdroitB='Z') then
    begin           
      trouve_detecteur(adr);
      if IndexBranche_trouve=0 then
      begin
        Affiche('Erreur 21: détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clred);
        ok:=false;
      end;
    end;
    adr:=aiguillage[Indexaig].Adevie;
    if (aiguillage[Indexaig].AdevieB='Z') then
    begin
      trouve_detecteur(adr);
      if IndexBranche_trouve=0 then
      begin
        Affiche('Erreur 31: détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clRed);
        ok:=false;
      end;  
    end;
    adr:=aiguillage[Indexaig].Apointe;
    if ((aiguillage[Indexaig].ApointeB='Z') and (aiguillage[Indexaig].modele=aig)) then
    begin
      trouve_detecteur(adr);
      if IndexBranche_trouve=0 then
      begin
        Affiche('Erreur 4 : détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clRed);
        ok:=false;
      end;
    end;
    if (aiguillage[Indexaig].modele=triple) then // aiguillage triple
    begin
      if (aiguillage[Indexaig].Adevie2B='Z') then
      begin
        adr:=aiguillage[Indexaig].Adevie2;
        trouve_detecteur(adr);
        if IndexBranche_trouve=0 then
        begin
          Affiche('Erreur 5 : détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clRed);
          ok:=false;
        end;
      end;
    end;
  end;

  // cohérence 3 : vérifie si aiguillage triple ok et si doublon aiguillage
  for Indexaig:=1 to maxaiguillage do
  begin
    adr:=aiguillage[Indexaig].Adresse;
    if aiguillage[Indexaig].modele=triple then
    begin
      if aiguillage[Indexaig].AdrTriple=0 then
      begin
        Affiche('Erreur 6.1: 2ème adresse de l''aiguillage triple '+intToSTR(adr)+' non définie',clred);
        ok:=false;
      end;
    end;
    for i:=Indexaig+1 to maxaiguillage do
    begin
      if adr=aiguillage[i].Adresse then 
      begin
        affiche('Erreur 6.2: aiguillage '+intToSTR(adr)+' défini deux fois',clred);
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
        Affiche('Erreur 8.1: Détecteur '+intToSTR(i)+' non existant dans les branches mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end
    else
    begin
      if feux[j].Aspect<10 then
      begin
        ok:=false;
        Affiche('Erreur 8.2: Adresse de détecteur nul sur signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;

    i:=feux[j].Adr_det2;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.3: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;
    
    i:=feux[j].Adr_det3;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.4: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;

    i:=feux[j].Adr_det4;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.5: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
      end;
    end;

    // élement suivant 1
    i:=feux[j].Adr_el_suiv1;
    km:=feux[j].Btype_suiv1;
    if i<>0 then
    begin
      if km=det then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.1: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.2: aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;

    // élement suivant 2
    i:=feux[j].Adr_el_suiv2;
    km:=feux[j].Btype_suiv2;
    if i<>0 then
    begin
      if km=det then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.3: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.4: aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;

    // élement suivant 3
    i:=feux[j].Adr_el_suiv3;
    km:=feux[j].Btype_suiv3;
    if i<>0 then
    begin
      if km=det then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.5: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then 
        begin
          ok:=false;
          Affiche('Erreur 9.6: aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;  
      end;
    end;

    // élement suivant 4
    i:=feux[j].Adr_el_suiv4;
    km:=feux[j].Btype_suiv4;
    if i<>0 then
    begin
      if km=det then   // détecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.7: Détecteur '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.10: aiguillage '+intToSTR(i)+' non existant mais associé au signal '+IntToSTR(feux[j].adresse),clred);
        end;
      end;
    end;
  end;

  // cohérence 7
  // parcoure les aiguillages pour voir si les aiguillages déclarés aux extrémités sont existants
  for Indexaig:=1 to maxaiguillage do
  //indexaig:=index_aig(93);
  begin
    adr:=aiguillage[indexaig].Adresse;
    model:=aiguillage[indexaig].modele;
    
    if adr>NbMemZone then
    begin
      Affiche('Erreur 9.11: adresse aiguillage trop grand: '+intToSTR(adr),clred);
      ok:=false;
    end;

    // on ne vérifie pas les tjd tjs crois
    if (model<>tjd) and (model<>tjd) and (model<>crois) then 
    begin
    
      adr2:=aiguillage[indexaig].ADroit;    // adresse de ce qui est connecté sur la position droite
      c:=aiguillage[indexaig].AdroitB;
      if (c='D') or (c='S') or (c='P') then
      begin
        index2:=Index_aig(adr2);            // adresse de l'aiguillage connecté
        model2:=aiguillage[index2].modele;  // modèle de l'aiguillage connecté
        if index2=0 then
        begin
          ok:=false;
          Affiche('Erreur 10.20: aiguillage '+intToSTR(adr)+': déclaration d''un aiguillage '+IntToSTR(adr2)+' inexistant',clred);
        end
        else
        begin
          // tjs ou tjs à 2 états ou croisement
          if ( ((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=2) ) or (model2=crois) then
          begin
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index2].DDevie) and (adr<>aiguillage[index2].Ddroit) then
            begin
              Affiche('Erreur 10.21: Discordance de déclaration aiguillages '+intToSTR(adr)+': '+intToSTR(adr2),clred); 
              ok:=false;
            end;    
          end;
   
          // tjs ou tjs à 4 états
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=4)) then
          begin
            adr3:=aiguillage[index2].Ddroit;  // 2eme adresse de la TJD
            index3:=index_aig(adr3);
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index3].ADevie) and (adr<>aiguillage[index3].Adroit) then
            begin
              Affiche('Erreur 10.22: Discordance de déclaration aiguillages  '+intToSTR(adr)+': '+intToSTR(adr2),clred); 
              ok:=false;
            end;
          end;
      
          if (model2=aig) or (model2=triple) then
          begin
            if c='D' then 
            begin
              extr:=aiguillage[index2].ADroit;
              if adr<>extr then Affiche('Erreur 10.23: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'D différent de '+intToSTR(extr),clred); 
            end;  
            if c='S' then 
            begin
              extr:=aiguillage[index2].ADevie;
              if adr<>extr then Affiche('Erreur 10.24: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'S différent de '+intToSTR(extr),clred); 
            end;
            if c='P' then 
            begin 
              extr:=aiguillage[index2].APointe;
              if adr<>extr then Affiche('Erreur 10.25: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'P différent de '+intToSTR(extr),clred); 
            end;
          end; 
        end;  
      end;
  
      adr2:=aiguillage[indexaig].Adevie;  // adresse de ce qui est connecté sur la position déviée
      c:=aiguillage[indexaig].AdevieB;
      if (c='D') or (c='S') or (c='P') then
      begin
        index2:=Index_aig(adr2);            // adresse de l'aiguillage connecté
        model2:=aiguillage[index2].modele;  // modèle de l'aiguillage connecté
        if index2=0 then
        begin
          ok:=false;
          Affiche('Erreur 10.30: aiguillage '+intToSTR(adr)+': déclaration d''un aiguillage '+IntToSTR(adr2)+' inexistant',clred);
        end
        else
        begin
          // tjs ou tjs à 2 états ou croisement
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=2)) or (model2=crois) then
          begin
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index2].DDevie) and (adr<>aiguillage[index2].Ddroit) then
            begin
              Affiche('Erreur 10.31: Discordance de déclaration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred); 
              ok:=false;
            end;    
          end;
    
          // tjs ou tjs à 4 états
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=4)) then
          begin
            adr3:=aiguillage[index2].Ddroit;  // 2eme adresse de la TJD
            index3:=index_aig(adr3);
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index3].ADevie) and (adr<>aiguillage[index3].Adroit) then
            begin
              Affiche('Erreur 10.32: Discordance de déclaration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred); 
              ok:=false;
            end;
          end;
       
          if (model2=aig) or (model2=triple) then
          begin
            if c='D' then 
            begin
              extr:=aiguillage[index2].ADroit;
              if adr<>extr then Affiche('Erreur 10.33: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'D différent de '+intToSTR(extr),clred); 
            end;  
            if c='S' then 
            begin
              extr:=aiguillage[index2].ADevie;
              if adr<>extr then Affiche('Erreur 10.34: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'S différent de '+intToSTR(extr),clred); 
            end;
            if c='P' then 
            begin 
              extr:=aiguillage[index2].APointe;
              if adr<>extr then Affiche('Erreur 10.35: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'P différent de '+intToSTR(extr),clred); 
            end;
          end; 
        end;  
      end;
    
      adr2:=aiguillage[indexaig].APointe;  // adresse de ce qui est connecté sur la pointe
      c:=aiguillage[indexaig].ApointeB;
      if (c='D') or (c='S') or (c='P') then
      begin
        index2:=Index_aig(adr2);            // adresse de l'aiguillage connecté
        model2:=aiguillage[index2].modele;  // modèle de l'aiguillage connecté
        if index2=0 then
        begin
          ok:=false;
          Affiche('Erreur 10.40: aiguillage '+intToSTR(adr)+': déclaration d''un aiguillage '+IntToSTR(adr2)+' inexistant',clred);
        end
        else
        begin
          // tjs ou tjs à 2 états ou croisement
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=2)) or (model2=crois) then
          begin
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index2].DDevie) and (adr<>aiguillage[index2].Ddroit) then
            begin
              Affiche('Erreur 10.41: Discordance de déclaration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred); 
              ok:=false;
            end;    
   
            // tjs ou tjs à 4 états
            if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=4)) then
            begin
              adr3:=aiguillage[index2].Ddroit;  // 2eme adresse de la TJD
              index3:=index_aig(adr3);
              if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
                 (adr<>aiguillage[index3].ADevie) and (adr<>aiguillage[index3].Adroit) then
              begin
                Affiche('Erreur 10.42: Discordance de déclaration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred); 
                ok:=false;
              end;
            end;
       
            if (model2=aig) or (model2=triple) then
            begin
              if c='D' then 
              begin
                extr:=aiguillage[index2].ADroit;
                if adr<>extr then Affiche('Erreur 10.43: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'D différent de '+intToSTR(extr),clred); 
              end;
              if c='S' then 
              begin
                extr:=aiguillage[index2].ADevie;
                if adr<>extr then Affiche('Erreur 10.44: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'S différent de '+intToSTR(extr),clred); 
              end;
              if c='P' then 
              begin 
                extr:=aiguillage[index2].APointe;
                if adr<>extr then Affiche('Erreur 10.45: Discordance de déclaration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'P différent de '+intToSTR(extr),clred); 
              end;
            end; 
          end;  
        end;  
      end; 
    end;
  end;
    
  // cohérence 8
  // parcoure les branches pour voir si les aiguillages aux extrémités sont cohérentes avec leurs déclarations
  for i:=1 to NbreBranches do
  begin
    j:=1;  // on vérifie entre j-1 et j+1
    detect:=BrancheN[i][1].Adresse;
    model:=BrancheN[i][1].BType;
    repeat
      AncAdr:=detect;AncModel:=model;
      detect:=BrancheN[i][j].Adresse;
      SuivAdr:=BrancheN[i][j+1].Adresse;
      SuivModel:=BrancheN[i][j+1].Btype;
      model:=BrancheN[i][j].BType;  // 1= détecteur  2= aiguillage  4=Buttoir
      trouvePrec:=false;

      if (model=aig) or (model=Tjd) or (model=Tjs) then
      begin
        k:=index_aig(detect);
        // comparer au précédent
        if j=1 then trouvePrec:=true;
        if (j>1) then
        begin
          if aiguillage[k].modele=Aig then
          begin
            if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
            if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
            if aiguillage[k].APointe=AncAdr then trouvePrec:=true;
          end;
          if (aiguillage[k].modele=Tjd) or (aiguillage[k].modele=TjS) then
          begin
            if aiguillage[k].EtatTJD=2 then
            begin
              if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
              if aiguillage[k].Ddroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].Ddevie=AncAdr then trouvePrec:=true;
            end;
            if aiguillage[k].EtatTJD=4 then
            begin
              l:=index_aig(aiguillage[k].Ddroit); // 2eme adresse de la TJD
              if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
              if aiguillage[k].Ddroit=AncAdr then trouvePrec:=true;
              if aiguillage[l].Adroit=AncAdr then trouvePrec:=true;
              if aiguillage[l].Adevie=AncAdr then trouvePrec:=true;
              if aiguillage[l].Ddevie=AncAdr then trouvePrec:=true;
            end;
          end;
          if aiguillage[k].modele=crois then
          begin
            if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
            if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
            if aiguillage[k].Ddroit=AncAdr then trouvePrec:=true;
            if aiguillage[k].Ddevie=AncAdr then trouvePrec:=true;
          end;
          
          if not(trouvePrec) then
          begin
            Affiche('Erreur 11: La description de l''aiguillage '+intToSTR(detect)+' ne correspond pas à son élément contigu ('+intToStr(AncAdr)+') en branche '+intToSTR(i),clred);
            ok:=false;
          end;
        end;

        TrouveSuiv:=false;
        // comparer au suivant
        if SuivModel<>rien then
        begin
          if aiguillage[k].modele=Aig then
          begin
            if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
            if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
            if aiguillage[k].APointe=SuivAdr then trouveSuiv:=true;
          end;
          if (aiguillage[k].modele=Tjd) or (aiguillage[k].modele=TjS) then
          begin
            if aiguillage[k].EtatTJD=2 then
            begin
              if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].Ddroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].Ddevie=SuivAdr then trouveSuiv:=true;
            end;
            if aiguillage[k].EtatTJD=4 then
            begin
              l:=index_aig(aiguillage[k].Ddroit); // 2eme adresse de la TJD
              if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].Ddroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[l].Adroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[l].Adevie=SuivAdr then trouveSuiv:=true;
              if aiguillage[l].Ddevie=SuivAdr then trouveSuiv:=true;
            end;
          end;
          if aiguillage[k].modele=crois then
          begin
            if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
            if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
            if aiguillage[k].Ddroit=SuivAdr then trouveSuiv:=true;
            if aiguillage[k].Ddevie=SuivAdr then trouveSuiv:=true;
          end;
          
          if not(trouveSuiv) then
          begin
            Affiche('Erreur 12: La description de l''aiguillage '+intToSTR(detect)+' ne correspond pas à son élément contigu ('+intToStr(SuivAdr)+') en branche '+intToSTR(i),clred);
            ok:=false;
          end;
        end;
      end;
      inc(j);
    until((model=rien) and (detect=0)) ;
  end;

  // 9. vérifier la cohérence TCO
  if avecTCO then
  begin
    for y:=1 to NbreCellY do
      for x:=1 to NbreCellX do
        begin
          i:=TCO[x,y].BImage;
          if i=30 then
          begin
            adr:=TCO[x,y].adresse;
            if index_feu(adr)=0 then
            begin
              Affiche('Un feu '+IntToSTR(adr)+' est déclaré dans le TCO['+intToSTR(x)+','+intToSTR(y)+'] mais absent de la configuration',clred);
              ok:=false;
            end;
          end;
          if (i=2) or (i=3) or (i=4) or (i=5) or (i=12) or (i=13) or (i=14) or (i=15) then
          begin
            adr:=TCO[x,y].adresse;
            if index_aig(adr)=0 then
            begin
              Affiche('Un aiguillage '+IntToSTR(adr)+' est déclaré dans le TCO['+intToSTR(x)+','+intToSTR(y)+'] mais absent de la configuration',clred);
              ok:=false;
            end;
          end;
          if (i=1) or (i=6) or (i=7) or (i=8) or (i=9) or (i=16) or (i=17) or (i=18) or (i=19) or (i=20) or (i=10) or (i=11) then
          begin
            adr:=TCO[x,y].adresse;
            if adr<>0 then
            begin
              j:=1;
              repeat
                trouveSuiv:=adr=Adresse_detecteur[j];
                inc(j);
              until (j>NDetecteurs) or trouveSuiv;
             
              if not(trouveSuiv) then
              begin
                Affiche('Un détecteur '+IntToSTR(adr)+' est déclaré dans le TCO['+intToSTR(x)+','+intToSTR(y)+'] mais absent de la configuration',clred);
                ok:=false;
              end;
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
  if MaxAiguillage>=MaxAcc then
  begin
    Affiche('Nombre maximal d''aiguillages atteint',clRed);
    exit;
  end;
  clicliste:=true;
  inc(MaxAiguillage);
  i:=MaxAiguillage;
  aiguillage[i].Adresse:=999;
  aiguillage[i].modele:=aig;
  aiguillage[i].AdroitB:='Z'; aiguillage[i].AdevieB:='Z';
  aiguillage[i].DdroitB:='D'; aiguillage[i].DdevieB:='S'; // préparation pour TJD/S
  aiguillage[i].EtatTJD:=4;
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


// supprime le ou les aiguillages sélectionnés dans le richEdit
procedure supprime_aig;
var ligneDeb,LigneFin,i,index,index2,debut,longueur,fin,l,ltot : integer;
    s : string;
begin
  //trouver ligne de début et de fin sélectionner.
  with formConfig do
  begin
    debut:=RichAig.SelStart;
    longueur:=RichAig.SelLength;
  end;  
  fin:=debut+longueur;
  //Affiche(inttostr(debut)+' '+inttostr(longueur),clyellow);
  // trouver les lignes sélectionnées
  i:=0;ltot:=0;ligneDeb:=0;LigneFin:=0;
  repeat
    l:=length(FormConfig.RichAig.lines[i])+2;  //+2 car CR LF
    ltot:=ltot+l;
    if (debut<ltot) and (ligneDeb=0) then ligneDeb:=i+1;
    if (ltot>=fin) and (ligneFin=0) and (ligneDeb<>0) then ligneFin:=i+1;
    //if (ltot=fin) and (ligneFin=0) then ligneFin:=i;
    inc(i);
  until (i>=MaxAiguillage) or (ligneFin>0);
  if lignefin=0 then if fin>ltot then ligneFin:=MaxAiguillage;
  //Affiche(inttostr(Ltot)+' '+inttostr(Fin),clyellow);
  
  
  i:=ligneClicAig;
  if (i<0) then exit;
  index:=i+1; // passe en index tableau

  if ligneDeb=LigneFin then s:='Voulez-vous supprimer l''aiguillage '+IntToSTR(aiguillage[index].adresse)+'?'
  else s:='Voulez-vous supprimer les aiguillages de '+
           IntToSTR(aiguillage[ligneDeb].adresse)+' à '+IntToSTR(aiguillage[ligneFin].adresse)+' ?';
  
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  
  FormConfig.ButtonAjSup.Caption:='Ajouter l''aig '+intToSTR(aiguillage[index].adresse)+' supprimé';
  clicliste:=true;
  raz_champs_aig;
  Aig_supprime:=aiguillage[index];  // sauvegarde le supprimé
  Aig_sauve.adresse:=0;             // dévalider sa définition

  index:=ligneDeb;

  if ligneDeb=LigneFin then s:='Suppression de l''aiguillage '+IntToSTR(aiguillage[index].adresse)
  else s:='Suppression des aiguillages de '+
           IntToSTR(aiguillage[ligneDeb].adresse)+' à '+IntToSTR(aiguillage[ligneFin].adresse);
  Affiche(s,clOrange);

  //Affiche('Boucle de '+intToSTR(ligneDeb)+' N='+intToSTR(MaxAiguillage-ligneFin),clyellow);

  for i:=1 to MaxAiguillage-ligneFin do
  begin
    index:=i+lignefin; //index de l'aiguillage de remplacement
    //Affiche('Suppresion aiguillage '+intToSTR(aiguillage[i+lignedeb].Adresse),clorange);
    //Affiche('remplacement par index '+intToSTR(index),clorange);

    Aiguillage[lignedeb+i-1]:=Aiguillage[index];
    aiguillage[index].Adresse:=0;
    aiguillage[index].Modele:=rien;
    aiguillage[index].Adroit:=0;
    aiguillage[index].Adevie:=0;
    aiguillage[index].Ddroit:=0;
    aiguillage[index].Ddevie:=0;
    aiguillage[index].APointe:=0;
    aiguillage[index].modifie:=false;
  end;
  MaxAiguillage:=maxAiguillage-(ligneFin-LigneDeb)-1;
    
  config_modifie:=true;
  FormConfig.RichAig.Clear;
                                                   
  // réafficher le richsig
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_Aig(i);
    if s<>'' then
    begin
      FormConfig.RichAig.Lines.Add(s);
      RE_ColorLine(FormConfig.RichAig,FormConfig.RichAig.lines.count-1,ClAqua);
    end;
  end;
  With FormConfig.RichAig do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;  
  ligneClicAig:=-1;
  AncligneClicAig:=-1;
  clicliste:=false;
end;

procedure TFormConfig.BoutSupAigClick(Sender: TObject);
begin
  Supprime_aig;
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
      if (aiguillage[id2].modele<>rien) then 
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
      if (aiguillage[id2].modele<>rien) then 
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
var AdrAig,adr,adr2,erreur,index : integer;
    model: Tequipement;
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
      model:=aiguillage[Index].modele;

      if model=tjs then // TJS
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
        if model=tjd then labelInfo.Caption:='Création de la TJD homologue '+IntToSTR(adr);
        if model=tjs then labelInfo.Caption:='Création de la TJS homologue '+IntToSTR(adr);
        
        inc(MaxAiguillage);
        index:=MaxAiguillage;
        aiguillage[index].Adresse:=Adr;
        aiguillage[Index].modele:=model;
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
        model:=aiguillage[Index].modele;
        if (model=tjd) or (model=tjs) then
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
    Aig_Supprime.modele:=rien;  
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
  case ComboBoxAig.ItemIndex of
  0 : aiguillage[i].modele:=aig;
  1 : aiguillage[i].modele:=tjd;
  2 : aiguillage[i].modele:=tjs;
  3 : aiguillage[i].modele:=triple;
  4 : aiguillage[i].modele:=crois;
  else aiguillage[i].modele:=rien;
  end;

  if (aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs) then
  begin
    if not(radioButtonTJD2.Checked) and not(radioButtonTJD4.Checked) then radioButtonTJD2.Checked:=true;
    if (aiguillage[i].tjsIntB<>'S') and (aiguillage[i].tjsIntB<>'D') then aiguillage[i].tjsIntB:='D';
  end;

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
    s:=AnsiUpperCase(RichBranche.Lines[ligne-1]);
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
          ok:=false;
        end;
        inc(ligne);
      end
    else RichBranche.Lines.Delete(ligne-1);
  end
  else RichBranche.Lines.Delete(ligne-1);

  until (ligne>RichBranche.Lines.count) or (ligne>=MaxBranches);
  NbreBranches:=ligne-1;
  if ligne>=MaxBranches then Affiche('Nombre maximal de branches atteint',clRed);

  ligne:=verif_extr_branches;
  if ligne<>0 then
  begin
    ok:=false;
    RE_ColorLine(RichBranche,Ligne-1,ClRed);
  end; 
  
  if ok then 
  begin 
    labelResult.Caption:='Syntaxe correcte';
    config_modifie:=true;
  end  
    else labelResult.Caption:='Erreur de syntaxe';
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
         if adresse>NbMemZone then
         begin
           Affiche('Erreur 18 ligne '+s+' : adresse aiguillage trop grand: '+intToSTR(adresse),clred);
           adresse:=NbMemZone;
           code:=false;
         end;
         BrancheN[i,j].adresse:=adresse;
         BrancheN[i,j].btype:=aig; // ident aiguillage
       end
       else
       begin
         Affiche('Erreur 19 champ '+se+' ligne '+s,clred);
         code:=false;
         erreur:=0; // forcer erreur à 0 pour obliger à passer sur un détecteur
       end;
     end;
     // détecteur
     if erreur=0 then
     begin
       if detect>NbMemZone then
       begin
         Affiche('Erreur 20 ligne '+s+' : adresse détecteur trop grand: '+intToSTR(detect),clred);
         detect:=NbMemZone;
         code:=false;
       end;
       BrancheN[i,j].adresse:=detect;          // adresse
       BrancheN[i,j].btype:=det;// ident détecteur
       if detect=0 then begin BrancheN[i,j].btype:=buttoir;end; // buttoir
       // vérifier si le détecteur est déja stocké
       bd:=0;
       repeat
         inc(bd);
         if bd>NbMaxDet then
         begin
           Affiche('Nombre maximal de détecteurs dépassé ('+IntToSTR(NbMaxDet)+')',clred);
           code:=false;
         end
         else
           trouve:=Adresse_detecteur[bd]=detect;
       until ((bd=NDetecteurs+1) or trouve) or (bd>NbMaxDet) ;
       if not(trouve) then
       begin
         Adresse_detecteur[bd]:=detect;
         NDetecteurs:=bd;
       end;
     end;
     inc(j);

     BrancheN[i,j].adresse:=0; // préparer le suivant à 0
     BrancheN[i,j].BType:=rien;
     //Affiche('branche '+intToSTR(i)+' index='+intToStr(j),clGreen);
   until (offset=0) or (j>=MaxElBranches);
   if j=2 then
   begin
     Affiche('Branche '+IntToSTR(i)+' : Une branche doit contenir au moins deux éléments',clred);
     code:=false;
   end;
   if (j>=MaxElBranches) then Affiche('Nombre maximal d''élements dans une branche atteint',clred);
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
    if lines[lc]<>'' then LabelNumBranche.Caption:='Branche n°'+intToSTR(lc+1) else LabelNumBranche.Caption:='';
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


procedure TFormConfig.EditAigTripleChange(Sender: TObject);
  var s : string;
    i,erreur,index : integer;
    model: TEquipement;
begin
  if clicliste then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditAigTriple.Text;
    Val(s,i,erreur);
    index:=ligneclicAig+1;
    if index=0 then exit;

    model:=aiguillage[index].modele;
    if (model=triple) then
    begin
      if (erreur<>0) then begin LabelInfo.caption:='Erreur adresse aiguillage ';exit;end;
      //  vérifier si l'adresse de l'aiguillage existe déja
      if (aiguillage[Index_Aig(i)].modele<>rien) then 
      begin
        LabelInfo.caption:='aiguillage '+IntToSTR(i)+' existe déja - ne sera pas écrasé' ;
        EditAigTriple.Color:=clred;
        exit;
      end ;
      if i=0 then EditAigTriple.Color:=clred else EditAigTriple.Color:=clWindow;
      LabelInfo.caption:='';
      
      aiguillage[index].AdrTriple:=i;
      aiguillage[index].modifie:=true;              
      s:=encode_aig(index);
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
  
    i:=ComboBoxDD.ItemIndex;
    case i of
    0 :  pos:=const_devie;
    1 :  pos:=const_droit;
    2 :  pos:=const_inconnu;
    end;
    
    aiguillage[ligneclicAig+1].PosInit:=pos;
    aiguillage[ligneclicAig+1].modifie:=true;
    s:=encode_aig(ligneclicAig+1);
    RichAig.lines[ligneclicAig]:=s;
  end;
end;

procedure TFormConfig.EditTempo10Change(Sender: TObject);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneclicAig<0) then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditTempo10.Text;
    Val(s,i,erreur);
    if (i>0) and (i<50) then
    begin
      LabelInfo.caption:='';
      aiguillage[ligneclicAig+1].temps:=i;
      aiguillage[ligneclicAig+1].modifie:=true;
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
    i, erreur :integer;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt EditL Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  begin
    s:=EditL.Text;
    if s='' then exit;
    val(s,i,erreur);
    if (s[erreur]<>'S') and (s[erreur]<>'D') then
    begin
      LabelInfo.caption:='Erreur Champ L manque D ou S';exit
    end
    else LabelInfo.caption:='';
    aiguillage[ligneclicAig+1].tjsint:=i;
    aiguillage[ligneclicAig+1].tjsintb:=s[erreur];
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
    ok : boolean;
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

  ok:=verifie_panneau_config;

  // TCO
  if avectco and not(entreeTCO) then
  begin
    //créée la fenêtre TCO non modale
    FormTCO:=TformTCO.Create(nil);
    FormTCO.show;
    FormPrinc.ButtonAffTCO.Visible:=true;
  end;

  if not(ok) then action:=tCloseAction(caNone);  // si la config est nok, on ferme pas la fenetre

end;

procedure TFormConfig.ButtonConfigSRClick(Sender: TObject);
begin
  clicListe:=true;
  formSR.showmodal;
  formSR.close;
  clicListe:=false;
end;

procedure TFormConfig.PageControlChange(Sender: TObject);
begin
  Label20.Visible:=false;
end;


procedure TFormConfig.SpeedButtonJoueClick(Sender: TObject);
begin
   if PlaySound(pchar(EditSon.Text),0,SND_ASYNC)=false then
        labelInfo.Caption:='Erreur';

end;


procedure TFormConfig.ButtonTestActClick(Sender: TObject);
Var Adr,adr2,erreur,etat : integer;
begin
  etat:=0;
  val(EditEtatActionneur.Text,Etat,erreur);
  val(EditAct.Text,Adr,erreur);
  val(EditAct2.Text,Adr2,erreur);
  if erreur=0 then
  begin
    Event_act(adr,adr2,etat,'X');
  end;  
end;

procedure TFormConfig.RadioButtonActDetClick(Sender: TObject);
var i,champ,erreur : integer;
    s : string;
begin
  if clicListe then exit;
  i:=ligneClicAct+1;
  if AffEvt then Affiche('RadioBoutonActDet '+IntToSTR(i),clyellow);
  Tablo_Actionneur[i].typActMemZone:=0;
  LabelActionneur.Caption:='Actionneur DétecteurZ';
  editAct2.Visible:=false;
  EditTrainDecl.Visible:=true;
  LabelTrain.Visible:=true;

  Tablo_Actionneur[i].trainDecl:=trainSauve;
  EditTrainDecl.Text:=trainSauve;
  
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].adresse:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  Tablo_actionneur[i].trainDecl:=EditTrainDecl.Text;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc_son(i);
  RichAct.Lines[ligneClicAct]:=s;

end;


procedure TFormConfig.RadioButtonZonesClick(Sender: TObject);
var i,champ,erreur : integer;
    s : string;
begin
  if clicListe then exit;
  i:=ligneClicAct+1;
  if AffEvt then Affiche('RadioBoutonZones '+IntToSTR(i),clyellow);
  Tablo_Actionneur[i].typActMemZone:=1;
  LabelActionneur.Caption:='Mémoire de Zone'; 
  EditTrainDecl.Visible:=false;
  LabelTrain.Visible:=false;
  editAct2.Visible:=true;
  //editact.Text:=intToSTR(Tablo_actionneur[i].adresse2);
  
  Tablo_actionneur[i].trainDecl:='X';
  val(editact.Text,champ,erreur);
  Tablo_actionneur[i].adresse:=champ ;
  val(editEtatActionneur.Text,champ,erreur);
  Tablo_actionneur[i].etat:=champ;
  val(editFonctionAccess.Text,champ,erreur);
  Tablo_actionneur[i].fonction:=champ;
  val(editEtatFoncSortie.Text,champ,erreur);
  Tablo_actionneur[i].sortie:=champ;
  val(editTempo.Text,champ,erreur);
  Tablo_actionneur[i].tempo:=champ;
  tablo_actionneur[i].Raz:=checkRaz.checked;
  s:=encode_act_loc_son(i);
  RichAct.Lines[ligneClicAct]:=s;
end;


procedure TFormConfig.SpeedButtonChargerClick(Sender: TObject);
var s: string;
begin
  s:=GetCurrentDir;
  OpenDialogSon.InitialDir:=s;
  OpenDialogSon.DefaultExt:='wav';
  OpenDialogSon.Title:='Ouvrir un fichier son';
  OpenDialogSon.Filter:='Fichiers wav (*.wav)|*.wav|Tous fichiers (*.*)|*.*';
  if openDialogSon.Execute then
  begin
    s:=openDialogSon.FileName;
    editson.Text:=s;
  end;
end;

procedure TFormConfig.RichBrancheKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var lc,curseur : integer;
begin
  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt RichBranche keydown',clyellow);
    with Formconfig.RichBranche do
    begin
      lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
      if lc>0 then
      begin
        dec(lc);
        if lines[lc]<>'' then LabelNumBranche.Caption:='Branche n°'+intToSTR(lc+1) else LabelNumBranche.Caption:='';
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
   end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt RichBranche keydown',clyellow);
    with Formconfig.RichBranche do
    begin
      lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
      if lc<NbreBranches-1 then
      begin
        inc(lc);
        LabelNumBranche.Caption:='Branche n°'+intToSTR(lc+1);
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
   end;
  end;
  clicListe:=false;
end;


procedure TFormConfig.RichAigKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_delete then supprime_aig;
end;

procedure TFormConfig.RichSigKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_delete then supprime_sig;
end;

begin
end.


