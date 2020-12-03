unit UnitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , verif_version, jpeg, ComCtrls ,StrUtils ;

type
  TFormConfig = class(TForm)
    ButtonAppliquerEtFermer: TButton;
    LabelInfo: TLabel;
    Button2: TButton;
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
    MemoBranches: TMemo;
    TabSheetSig: TTabSheet;
    Label15: TLabel;
    TabSheetAct: TTabSheet;
    Label16: TLabel;
    MemoAct: TMemo;
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
    EditDroit_BD: TEdit;
    EditDevie_HD: TEdit;
    EditPointe_BG: TEdit;
    LabelLigne: TLabel;
    LabelBG: TLabel;
    LabelHD: TLabel;
    LabelBD: TLabel;
    ImageAig: TImage;
    ImageAffiche: TImage;
    ImageTJD: TImage;
    Edit_HG: TEdit;
    LabelHG: TLabel;
    EditP1: TEdit;
    EditP2: TEdit;
    ImageTri: TImage;
    Label18: TLabel;
    EditDevieS2: TEdit;
    GroupBox12: TGroupBox;
    ImageSignal: TImage;
    LabelAdrSig: TLabel;
    GroupBox13: TGroupBox;
    LabelDec: TLabel;
    LabelDetAss: TLabel;
    LabelElSuiv: TLabel;
    Label19: TLabel;
    GroupBox14: TGroupBox;
    RadioButtonLoc: TRadioButton;
    RadioButtonPN: TRadioButton;
    Label20: TLabel;
    GroupBoxAct: TGroupBox;
    LabelActionneur: TLabel;
    EditAct: TEdit;
    EditTrain: TEdit;
    LabelTrain: TLabel;
    EditEtatFoncSortie: TEdit;
    Labela: TLabel;
    EditFonctionAccess: TEdit;
    LabelFonction: TLabel;
    EditTempo: TEdit;
    LabelTempo: TLabel;
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
    LabelTJD1: TLabel;
    EditP3: TEdit;
    EditP4: TEdit;
    Label28: TLabel;
    LabelTJD2: TLabel;
    CheckInverse: TCheckBox;
    RadioButtonAccess: TRadioButton;
    Label29: TLabel;
    Label30: TLabel;
    EditEtatActionneur: TEdit;
    CheckRAZ: TCheckBox;
    CheckFenEt: TCheckBox;
    GroupBox15: TGroupBox;
    EditNbDetDist: TEdit;
    Label31: TLabel;
    procedure ButtonAppliquerEtFermerClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoSignauxClick(Sender: TObject);
    procedure MemoActClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure RichAigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditPointe_BGChange(Sender: TObject);
    procedure EditDevie_HDChange(Sender: TObject);
    procedure EditDroit_BDChange(Sender: TObject);
    procedure EditDevieS2Change(Sender: TObject);
    procedure RadioButtonsansClick(Sender: TObject);
    procedure RadioButton30kmhClick(Sender: TObject);
    procedure RadioButton60kmhClick(Sender: TObject);
    procedure ComboBoxDecChange(Sender: TObject);
    procedure RichSigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditDet1Change(Sender: TObject);
    procedure EditSuiv1Change(Sender: TObject);
    procedure CheckVerrouCarreClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   
  end;

const 
TitreAig='Description de l''aiguillage ';
        
var
  FormConfig: TFormConfig;
  AdresseIPCDM,AdresseIP,PortCom,recuCDM : string;
  portCDM,TempoOctet,TimoutMaxInterface,Valeur_entete,Port,protocole,NumPort,
  LigneCliquee,AncLigneCliquee : integer;
  clicliste : boolean;
  
function config_com(s : string) : boolean;
function envoi_CDM(s : string) : boolean;
procedure connecte_CDM;
function place_id(s : string) : string;
procedure decodeAig(s : string;var adr : integer;var B : char);
procedure sauve_config;
  
implementation

uses UnitDebug,UnitPrinc;

{$R *.dfm}

// envoi d'une chaîne à CDM par socket, puis attend l'ack ou le nack
function envoi_CDM(s : string) : boolean;
var temps : integer;
begin
    if SocketCDM_connecte=false then begin envoi_CDM:=false;exit;end;
    //Affiche('Envoi à CDM rail',clRed);Affiche(s,ClGreen);
    if trace then affiche(s,clLime);
    Formprinc.ClientSocketCDM.Socket.SendText(s);
    // attend l'ack
    ackCDM:=false;nackCDM:=false;
    temps:=0;
    repeat
      inc(temps);Sleep(100);
      Application.processMessages;
    until ferme or ackCDM or nackCDM or (temps>30); // CDM répond < 1s
    //Affiche(IntToSTR(temps),clyellow);
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
  //Affiche(s,clyellow);
  envoi_CDM(s);sleep(100);
  if pos('_ACK',recuCDM)<>0 then 
  begin
    s:='Services acceptés: ';
    if Srvc_Aig then s:=s+'- aiguillages ';
    if Srvc_Act then s:=s+'- actionneurs ';
    if Srvc_Det then s:=s+'- détecteurs ';
    if Srvc_PosTrain then s:=s+'- position des trains ';
    if Srvc_sig then s:=s+'- état des signaux ';
    Affiche(s,clYellow);
  end;  
  services_CDM:=pos('_ACK',recuCDM)<>0;
end;
  
procedure connecte_CDM;
var s , ss : string;
    i : integer;
begin
  // déconnexion de l'ancienne liaison éventuelle
  Formprinc.ClientSocketCDM.Close;
  // Initialisation de la comm socket CDM
  //if CDM_connecte then begin Affiche('CDM déja connecté',Cyan);exit;end;
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
    //if i>30 then affiche('Timeout',clred);
    if not(SocketCDM_connecte) then Affiche('Socket CDM non connecté',clOrange);

    // connexion à CDM rail
    recuCDM:='';
    s:='C-C-00-0001-CMDGEN-_CNCT|000|';
    envoi_cdm(s);
    if pos('_ACK',recuCDM)<>0 then
    begin
      Id_CDM:=copy(recuCDM,5,2);   // récupère l'ID reçu de CDM, à utiliser dans toutes les futures trames
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
var i,k,posp,n,octet,erreur : integer;
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
    j,i,erreur : integer;
begin
  sa:=s;
  protocole:=-1;
  // supprimer la dernier paramètre
  i:=pos(',',s);
  if i<>0 then
  begin
    delete(s,1,i);
    j:=i;
    i:=pos(',',s);
    j:=j+i;
    if i<>0 then
    begin
      delete(s,1,i);
      i:=pos(',',s);
      j:=j+i;
      if i<>0 then
      begin
        delete(s,1,i);
        i:=pos(',',s);
        j:=j+i;
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


// transforme l'aiguillage du tableau en texte
function encode_aig(i : integer): string;
var s : string;
    c : char;
    tjd : boolean;
begin
   s:=IntToSTR(i);    
   tjd:=aiguillage[i].modele=2;
   if tjd then s:=s+'TJD';
   if aiguillage[i].modele=3 then s:=s+'TJS';
   if aiguillage[i].modele=4 then begin s:=s+'TRI,';s:=s+intToSTR(aiguillage[i].AdrTriple);end;
   s:=s+',';
   if not(tjd) then
   begin
     // P
     s:=s+'P';s:=s+intToSTR(aiguillage[i].Apointe);
     c:=aiguillage[i].APointeB ;
     if c<>'Z' then s:=s+c;
     // D
     s:=s+',D';s:=s+intToSTR(aiguillage[i].Adroit);
     c:=aiguillage[i].ADroitB ;
     if c<>'Z' then s:=s+c;
     // S
     s:=s+',S';s:=s+intToSTR(aiguillage[i].Adevie);
     c:=aiguillage[i].AdevieB ;
     if c<>'Z' then s:=s+c;
     // S2 aiguillage triple
     if aiguillage[i].modele=4 then
     begin
       s:=s+',S2-';
       s:=s+intToSTR(aiguillage[i].Adevie2);
       c:=aiguillage[i].Adevie2B ;
       if c<>'Z' then s:=s+c;
     end;
     // vitesse de franchissement
     if aiguillage[i].vitesse=30 then s:=s+',30';
     if aiguillage[i].vitesse=60 then s:=s+',60';
   end

   else
   // tjd
   begin
     s:=s+'D('+intToSTR(aiguillage[i].Adroit);
     c:=aiguillage[i].AdroitB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[i].DDroit)+aiguillage[i].DDroitB+'),';
     s:=s+'S('+intToSTR(aiguillage[i].Adevie);
     c:=aiguillage[i].AdevieB;if c<>'Z' then s:=s+c;
     s:=s+','+intToSTR(aiguillage[i].DDevie)+aiguillage[i].DDevieB+'),';
     s:=s+'I'+IntToSTR(aiguillage[i].InversionCDM);
   end;
   
   encode_aig:=s;
end;

function TypeEl_to_char(i : integer) : string;
begin
  case i of  // 1=détecteur 2=aig ou TJD ou TJS  4=tri 
  1 : TypeEl_to_char:='';
  2,3,4 : TypeEl_to_char:='A';
  end;

end;

// transforme le signal du tableau en texte
function encode_sig(i : integer): string;
var s : string;
    c : char;
    adresse,aspect,j,k,NfeuxDir : integer;
begin
  // adresse
  adresse:=feux[i].adresse;
  if adresse=0 then begin encode_sig:='';exit;end;
  
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
  // feux directionels
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
  encode_sig:=s;
end;

// modifie les fichiers de config en fonction du paramétrage
procedure genere_config2;
var s: string;
    fichier,fichierN : text;
    i,j : integer;
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
  writeln(fichierN,'Fonte=',TailleFonte);
  copie_commentaire;

  // adresse ip et port de CDM
  writeln(fichierN,'IpV4_PC=',adresseIPCDM+':'+intToSTR(portCDM));
  copie_commentaire;

  // adresse ip interface XpressNet
  writeln(fichierN,'IPV4_Interface=',adresseIP+':'+intToSTR(port));
  copie_commentaire;

  // port com
  writeln(fichierN,'Protocole_serie=',portcom);
  copie_commentaire;

  // temporisation caractère TempoOctet
  writeln(fichierN,'Inter_Car=',IntToSTR(TempoOctet));
  copie_commentaire;

  // temporisation attente maximale interface
  writeln(fichierN,'Tempo_maxi=',IntToSTR(TimoutMaxInterface));
  copie_commentaire;

  // entete Valeur_entete
  writeln(fichierN,'Entete=',intToSTR(Valeur_entete));
  copie_commentaire;

  // avec ou sans initialisation des aiguillages
  writeln(fichierN,'Init_Aig=',IntToSTR(AvecInitAiguillages));
  copie_commentaire;

  // plein écran
  writeln(fichierN,'Fenetre=',fenetre);
  copie_commentaire;

  // Nombre maxi de détecteurs considérés distants
  writeln(fichierN,'Nb_Det_Dist=',Nb_Det_Dist);
  copie_commentaire;

  
  // Vérification des versions au démarrage
  if verifVersion then s:='1' else s:='0';
  writeln(fichierN,'verif_version=',s);
  copie_commentaire;

  // Notification de nouvelle version
  if notificationVersion then s:='1' else s:='0';
  writeln(fichierN,'notif_version=',s);
  copie_commentaire;
 
  // Avec TCO
  if AvecTCO then s:='1' else s:='0';
  writeln(fichierN,'TCO=',s);
  copie_commentaire; 

  // lancement de CDM
  if LanceCDM then s:='1' else s:='0';
  writeln(fichierN,'CDM=',s);
  copie_commentaire; 

  // Nom du LAY
  writeln(fichierN,'LAY=',Lay);
  copie_commentaire; 

  // Serveur d'interface de CDM
  writeln(fichierN,'Serveur_interface=',intToSTR(ServeurInterfaceCDM));
  copie_commentaire; 

  // Serveur de rétrosignalisation Lenz de CDM
  writeln(fichierN,'retro=',intToSTR(ServeurRetroCDM));
  copie_commentaire; 
  
  // section init est copié ici
  writeln(fichierN,s);
  // valeurs des initialisations
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);
  copie_commentaire;
  
  closefile(fichier);
  closefile(fichierN);

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
  // 2 variables inutilisées
  writeln(fichierN,'Log=0');
  copie_commentaire;
  // fichier log
  writeln(fichierN,'TraceDet=0');
  copie_commentaire;
  // Raz Signaux
  if Raz_Acc_signaux then s:='1' else s:='0';
  writeln(fichierN,'RazSignaux='+s);
  copie_commentaire;

  // modélisation des aiguillages
  for i:=1 to MaxAiguillage do
  begin
    if aiguillage[i].modele<>0 then
    begin
      s:=encode_aig(i);
      aiguillage[i].modifie:=false;       // sauvegarde en cours, on démarque 
      writeln(fichierN,s);
      readln(fichier,s);
      if s[1]='/' then writeln(fichierN,s);
    end;
  end;
  
  if s[1]<>'0' then
  repeat
    readln(fichier,s);
    continue:=s[1]<>'0';
  until not(continue);
  writeln(fichierN,'0');
  
  copie_commentaire;
  
  writeln(fichierN,s);
  // modélisation des branches de réseau
  if s[1]<>'0' then
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);

  // copie tous les commentaires de la branche feux
  repeat
    readln(fichier,s);
    continue:=true;
    if length(s)>0 then 
    begin
      if s[1]='/' then writeln(fichierN,s);
      continue:=s[1]<>'0'; 
    end;
  until not(continue) or eof(fichier);

  for i:=1 to NbreFeux do
  begin
    s:=encode_sig(i);
    feux[i].modifie:=false;       // sauvegarde en cours, on démarque 
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');
  
  // Fonctions Fx généré du fichier d'origine, pas encore fait
  repeat
    continue:=true;
    readln(fichier,s); 
    writeln(fichierN,s);
    if length(s)>0 then continue:=s[1]<>'0';
  until not(continue) or eof(fichier);
  
  closefile(fichier);
  closefile(fichierN);
  
  deletefile('config.cfg');
  deletefile('client-GL.cfg');

  renameFile('config.tmp','config.cfg');
  renameFile('client-GL.tmp','client-GL.cfg');

end;


procedure Sauve_config;
var i,erreur : integer;
    s : string;
    ChangeCDM,changeInterface,changeUSB,change_srv : boolean;
begin
  // Vérification de la configuration-------------------------------------------
  // contrôle adresse IP CDM
  with FormConfig do
  begin
  s:=EditAdrIPCDM.text;
  if not(IpOk(s)) then begin labelInfo.Caption:='Adresse IP CDM rail incorrecte';exit;end; 
  ChangeCDM:=s<>AdresseIPCDM;
  adresseIPCDM:=s;
  
  // contrôle port CDM
  val(EditPortCDM.Text,i,erreur);
  if i>65535 then begin labelInfo.Caption:='Port CDM rail incorrect';exit;end; 
  changeCDM:=(portCDM<>i) or ChangeCDM;
  portCDM:=i;
  
  // contrôle adresse IP interface
  s:=EditIPLenz.text;
  if not(IpOk(s)) and (s<>'0') then begin labelInfo.Caption:='Adresse IP Lenz incorrecte';exit;end; 
  changeInterface:=s<>AdresseIP;
  AdresseIP:=s;
  
  // contrôle port interface
  val(EditPortLenz.Text,i,erreur);
  if i>65535 then begin labelInfo.Caption:='Port Interface incorrect';exit;end;   
  changeInterface:=changeInterface or (i<>port);
  port:=i;
  
  // contrôle protocole interface  COM3:57600,N,8,1,2
  s:=EditComUSB.Text;
  if not(config_com(s)) then begin labelInfo.Caption:='Protocole série USB Interface incorrect';exit;end;
  changeUSB:=portcom<>s;
  portcom:=s;
  
  val(EditTempoOctetUSB.text,i,erreur);
  if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation octet incorrecte';exit;end; 
  TempoOctet:=i;
  
  val(EditTempoReponse.text,i,erreur);
  if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation de réponse interface';exit;end; 
  TimoutMaxInterface:=i;

  val(EditNbDetDist.text,i,erreur);
  if (erreur<>0) or (i<3) then begin labelInfo.Caption:='Valeur nombre de détecteurs trop distants incorrecte';exit;end; 
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

  // changement sur les services CDM ?
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
  end;
  
  if change_srv then services_CDM;

  // générer le fichiers config.cfg et clieng-GL.cfg
  genere_config2;
  
end;

procedure TFormConfig.ButtonAppliquerEtFermerClick(Sender: TObject);
begin
  Sauve_config;
  formConfig.close;
end;

procedure TFormConfig.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormConfig.FormActivate(Sender: TObject);
var i : integer;
begin
  Edit_HG.Visible:=false;
  labelHG.Visible:=false;
  EditP1.Visible:=false;
  EditP2.Visible:=false;
  EditP3.Visible:=false;
  EditP4.Visible:=false;
  CheckInverse.Visible:=false;
  LabelTJD1.Visible:=false;
  LabelTJD2.Visible:=false;
  EditDevieS2.Visible:=false;
  Label18.Visible:=false;
  GroupBoxPN.Visible:=false;
  GroupBoxAct.Visible:=false;
  

  
  EditP1.ReadOnly:=true;
  EditP2.ReadOnly:=true;
  EditP3.ReadOnly:=true;
  EditP4.ReadOnly:=true;
  EditPointe_BG.ReadOnly:=false;
  EditDevie_HD.ReadOnly:=false;
  EditDroit_BD.ReadOnly:=false;
  Edit_HG.ReadOnly:=false;
  

  EditNbDetDist.text:=IntToSTR(Nb_Det_dist);
  EditAdrIPCDM.text:=adresseIPCDM;
  EditPortCDM.Text:=IntToSTR(portCDM);
  EditIPLenz.text:=AdresseIP;
  EditportLenz.text:=IntToSTR(Port);
  EditComUSB.Text:=PortCom;
  EditTempoOctetUSB.text:=IntToSTR(TempoOctet);
  EditTempoReponse.Text:=IntToSTR(TimoutMaxInterface);
  RadioButton1.checked:=false;
  RadioButton2.checked:=false;
  RadioButton3.checked:=false;
  if Valeur_entete=0 then RadioButton1.checked:=true;
  if Valeur_entete=1 then RadioButton2.checked:=true;
  if Valeur_entete=2 then RadioButton3.checked:=true;
  LabelInfo.Width:=253;LabelInfo.Height:=25;

  CheckVerifVersion.Checked:=verifVersion;
  CheckFenEt.Checked:=Fenetre=1;
  CheckInfoVersion.Checked:=notificationVersion;
  CheckLanceCDM.Checked:=LanceCDM;
  CheckAvecTCO.checked:=avecTCO;
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

  EditDroit_BD.Text:='';
  EditPointe_BG.Text:='';
  EditDevie_HD.Text:='';                
end;


procedure TFormConfig.FormCreate(Sender: TObject);
var i : integer;
s : string;
couleur : Tcolor;
begin
  AncLigneCliquee:=-1;
  // remplit les 4 fenêtres de config des aiguillages branches signaux, actionneurs

  // aiguillages
  RichAig.Clear;
  for i:=1 to MaxAiguillage do
  begin
    if aiguillage[i].modele<>0 then
    begin
      s:=encode_aig(i);
     // Affiche(s,couleur);
      RichAig.Lines.Add(s);
      RE_ColorLine(RichAig,RichAig.lines.count-1,ClAqua);
      Aiguillage[i].modifie:=false;
    end;
  end;
  // branches
  for i:=1 to NbreBranches do
    MemoBranches.Lines.Add(mod_Branches[i]);

  // signaux
  RichSig.clear;
  for i:=1 to NbreFeux do
  begin
    s:=encode_sig(i);
    if s<>'' then
    begin
      //Affiche(s,clyellow);
      RichSig.Lines.Add(s);
      RE_ColorLine(RichSig,RichSig.lines.count-1,ClAqua);
      Feux[i].modifie:=false; 
    end;  
  end;

  // actionneurs
  for i:=1 to maxTablo_act do
    MemoAct.Lines.Add(mod_Act[i]);
  PageControl.ActivePage:=TabSheetCDM;  // force le premier onglet sur la page

  for i:=1 to NbDecodeur do
  begin
    ComboBoxDec.items.add(decodeur[i-1]);
  end;
  EditDet1.Text:='';EditDet2.Text:='';EditDet3.Text:='';EditDet4.Text:='';
  EditSuiv1.Text:='';EditSuiv2.Text:='';EditSuiv3.Text:='';EditSuiv4.Text:='';
end;


// décode un morceau d'une chaine d'aiguillage ('P5S')
// si erreur, B='?'
procedure decodeAig(s : string;var adr : integer;var B : char);
var erreur,i : integer;
begin
  if s='' then begin B:='?';adr:=0;exit;end;
  if (s[1]='P') or (s[1]='S') or (s[1]='D') then delete(s,1,1);
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

// procédure appellée quand on clique une ligne aiguillage de RichAig
procedure Aff_champs_aig;
var Adresse,Adr2,traite,erreur,i,j,Nboucle,selpos,AncAdresse,lc : integer;
    bis,tjd,tri : boolean;
    s,ss : string;
    B : char;
begin
  // déterminer la ligne cliquée et mettre en surbrillance
  with Formconfig.RichAig do
  begin
    lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée

    s:=Uppercase(Lines[lc]);   // ligne cliquée
    if s='' then exit;

    AncLigneCliquee:=LigneCliquee;
    ligneCliquee:=lc;
    //Affiche('Ancienne='+IntToSTR(AncLigneCliquee)+' Nouvelle='+IntToSTR(LigneCliquee),clyellow);
    
    // Mettre en rouge l'aiguillage modifié quand on clique sur un autre aiguillage
    if AncLigneCliquee<>-1 then 
    begin
      val(FormConfig.RichAig.Lines[AncLigneCliquee],AncAdresse,erreur);
      
      if aiguillage[AncAdresse].modifie then RE_ColorLine(Formconfig.RichAig,AncligneCliquee,ClWhite) else
      RE_ColorLine(Formconfig.RichAig,AncligneCliquee,ClAqua);
    end;  
    
    {
    SelStart:=Perform(EM_LINEINDEX,ligneCliquee,0);  // début de la sélection
    SelLength:=Length(s) ;  // fin de la sélection
    SetFocus;
    }
    
  end;

  Val(s,Adresse,erreur);  // Adresse de l'aiguillage
  if adresse=0 then exit;

  RE_ColorLine(Formconfig.RichAig,ligneCliquee,Clyellow);

  ss:=TitreAig+InttoSTr(Adresse);
  formconfig.LabelAdresse.Caption:= ss;

  tjd:=pos('TJD',s)<>0 ;
  tri:=pos('TRI',s)<>0 ;
  with formconfig do
  begin
    LabelLigne.caption:=s;
    ImageAffiche.Picture.Bitmap.TransparentMode:=tmAuto;
    ImageAffiche.Picture.Bitmap.TransparentColor:=clblue;
    ImageAffiche.Transparent:=true;
    // tjd
    if tjd then 
    begin
      ImageAffiche.Picture.BitMap:=Imagetjd.Picture.Bitmap;
      labelBG.Caption:='S';
      Edit_HG.Visible:=true;
      labelTJD1.Visible:=true;
      LabelTJD2.Visible:=true;
      Edit_HG.ReadOnly:=true;        // en mode TJD, on ne peut pas modifier
      EditPointe_BG.ReadOnly:=true;  
      EditDevie_HD.ReadOnly:=true;
      EditDroit_BD.ReadOnly:=true;
      tjd:=true;
      labelHG.Visible:=true;
      EditP1.Visible:=true;
      EditP2.Visible:=true;
      EditP3.Visible:=true;
      EditP4.Visible:=true;
      CheckInverse.Visible:=true;
      EditDevieS2.Visible:=false;
      Label18.Visible:=false;

      // champ en bas à gauche
      b:=aiguillage[adresse].ADevieB;
      if b='Z' then b:=#0;
      EditPointe_BG.Text:=intToSTR(aiguillage[adresse].ADevie)+b;

      // champ en haut à gauche
      b:=aiguillage[adresse].ADroitB;
      if b='Z' then b:=#0;
      Edit_HG.Text:=intToSTR(aiguillage[adresse].ADroit)+b;  

      // milieu haut gauche
      EditP1.Text:=intToSTR(aiguillage[adresse].Ddroit)+aiguillage[adresse].DDroitB; 
      // milieu bas gauche
      EditP2.Text:=intToSTR(aiguillage[adresse].DDevie)+aiguillage[adresse].DDevieB;   

      adr2:=aiguillage[adresse].DDevie;
      // milieu haut droit
      EditP3.Text:=intToSTR(aiguillage[adr2].DDevie)+aiguillage[adr2].DDevieB; 
      // milieu bas droit
      EditP4.Text:=intToSTR(aiguillage[adr2].Ddroit)+aiguillage[adr2].DDroitB; 

      // droit haut
      EditDevie_HD.Text:=intToSTR(aiguillage[adr2].Adevie)+aiguillage[adr2].AdevieB; 
      LabelTJD1.Caption:=IntToSTR(adresse);
      
      // droit bas
      EditDroit_BD.Text:=intToSTR(aiguillage[adr2].Ddevie)+aiguillage[adr2].DdevieB; 
      LabelTJD2.Caption:=IntToSTR(adr2);

      CheckInverse.checked:=aiguillage[adresse].inversionCDM=1;
      
      if aiguillage[adresse].vitesse=0 then begin RadioButtonSans.checked:=true;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=false;end;
      if aiguillage[adresse].vitesse=30 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=true;RadioButton60kmh.checked:=false;end;
      if aiguillage[adresse].vitesse=60 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButton60kmh.checked:=true;end;
      exit;
    end
    else
    // aiguillage tri
    if tri then 
    begin
      tri:=true;
      labelTJD1.Visible:=false;
      LabelTJD2.Visible:=false;
      EditPointe_BG.ReadOnly:=false;
      labelBG.Caption:='P';
      i:=pos(',',s);delete(s,1,i);
      ImageAffiche.Picture.BitMap:=ImageTri.Picture.Bitmap;
      EditDevieS2.Visible:=true;
      Label18.Visible:=true;
      Val(s,Adr2,erreur);
      formconfig.LabelAdresse.Caption:=formconfig.LabelAdresse.Caption+','+IntToSTR(Adr2);
    end
    else
    // aiguillage normal
    begin
      ImageAffiche.Picture.BitMap:=Imageaig.Picture.Bitmap;
      labelBG.Caption:='P';
      EditPointe_BG.ReadOnly:=false;
      Edit_HG.Visible:=false;
      labelHG.Visible:=false;
      EditP1.Visible:=false;
      EditP2.Visible:=false;
      EditP3.Visible:=false;
      EditP4.Visible:=false;
      CheckInverse.Visible:=false;
      labelTJD1.Visible:=false;
      LabelTJD2.Visible:=false;
      EditDevieS2.Visible:=false;
      Label18.Visible:=false;
      tjd:=false;
    end;  
  end;
//  affiche(s,clOrange);
       
  i:=pos(',',s);Delete(s,1,i);
  traite:=0;nBoucle:=0;
  if not(tjd) then
  repeat
    if s<>'' then
    if s[1]='P' then
    begin
      decodeAig(s,adresse,B);
      ss:=intToSTR(Adresse);
      formconfig.EditPointe_BG.Text:=ss+B;
      i:=pos(',',s);if i=0 then i:=length(s)+1;
      Delete(s,1,i);
      inc(traite);
    end;
    if s<>'' then 
    if s[1]='S' then
    begin
      decodeAig(s,adresse,B);
      ss:=intToSTR(Adresse);
      formconfig.EditDevie_HD.Text:=ss+B;
      i:=pos(',',s);if i=0 then i:=length(s)+1;
      Delete(s,1,i);
      inc(traite);
    end;
    if s<>'' then
    if s[1]='D' then
    begin
      decodeAig(s,adresse,B);
      ss:=intToSTR(Adresse);
      formconfig.EditDroit_BD.Text:=ss+B;
      i:=pos(',',s);if i=0 then i:=length(s)+1;
      Delete(s,1,i);
      inc(traite);
    end;
    inc(nBoucle);
  until (traite=3) or (nboucle=3);

  // reste S2 pour le tri à traiter
  if tri then
  begin
    i:=pos('S2-',s);
    if i<>0 then
    begin
      delete(s,i,3);
      formconfig.EditDevieS2.text:=s;
    end;
  end;
    
  if s='' then
  with formconfig do
  begin
    RadioButtonsans.Checked:=true;
    RadioButton30kmh.Checked:=false;
    RadioButton60kmh.Checked:=false;
  end;
  if s='30' then
  with formconfig do
  begin
    RadioButtonsans.Checked:=false;
    RadioButton30kmh.Checked:=true;
    RadioButton60kmh.Checked:=false;
  end;
  if s='60' then
  with formconfig do
  begin
    RadioButtonsans.Checked:=false;
    RadioButton30kmh.Checked:=false;
    RadioButton60kmh.Checked:=true;
  end;
end;

// appellée quand on clique sur la liste signaux
Procedure aff_champs_sig;
var i,j,l,d,k, ligne,lc, adresse,erreur,condCarre,AncAdresse : integer;
    s,ss,s2 : string;
begin
// déterminer la ligne cliquée et mettre en surbrillance
  with Formconfig.RichSig do
  begin
    lc:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée

    s:=Uppercase(Lines[lc]);   // ligne cliquée
    if s='' then exit;

    AncLigneCliquee:=LigneCliquee;
    ligneCliquee:=lc;
    //Affiche('Ancienne='+IntToSTR(AncLigneCliquee)+' Nouvelle='+IntToSTR(LigneCliquee),clyellow);
    
    // Mettre en rouge le signal modifié quand on clique sur un autre aiguillage
    if AncLigneCliquee<>-1 then 
    begin
      val(FormConfig.RichSig.Lines[AncLigneCliquee],AncAdresse,erreur);
      if feux[lignecliquee+1].modifie then RE_ColorLine(Formconfig.RichSig,AncligneCliquee,ClWhite) else
      RE_ColorLine(Formconfig.RichSig,AncligneCliquee,ClAqua);
    end;  
  end;

 
  Val(s,Adresse,erreur);  // Adresse du signal
  if adresse=0 then exit;

  RE_ColorLine(Formconfig.RichSig,ligneCliquee,Clyellow);

  ss:='Signal '+InttoSTr(Adresse);
  formconfig.LabelAdrSig.Caption:= ss;
  i:=Index_feu(adresse);
  with formconfig.ImageSignal do
  begin
    Picture.Bitmap.TransparentMode:=tmAuto; 
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;
    Picture.BitMap:=feux[i].Img.Picture.Bitmap;
  end;
  with formconfig do
  begin
    MemoCarre.Lines.Clear;
    EditDet2.Text:=''; EditSuiv2.Text:='';
    EditDet3.Text:=''; EditSuiv3.Text:='';
    EditDet4.Text:=''; EditSuiv4.Text:='';
    ComboBoxDec.ItemIndex:=feux[i].decodeur;
    d:=feux[i].aspect;
    // signal normal
    if d<10 then
    begin
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
      
      // conditions supplémentaires
      CondCarre:=Length(feux[i].condcarre[1]);
      l:=1;
     
      while condCarre<>0 do
      begin
        if condcarre<>0 then dec(condcarre);
         s2:='';
        for k:=1 to condCarre do
        begin
          s2:=s2+'A'+IntToSTR(feux[i].condcarre[l][k].Adresse)+feux[i].condcarre[l][k].PosAig;
          if k<condCarre then s2:=s2+',';
          
        end;
        //s2:=s2+'/';
        MemoCarre.Lines.Add(s2); 
        inc(l);
        CondCarre:=Length(feux[i].condcarre[l]);
      end;
      
    end
    else
    begin // directionnel
      EditDet1.Text:='';EditSuiv1.Text:='';
      EditDet2.Text:='';EditSuiv2.Text:='';
      EditDet3.Text:='';EditSuiv3.Text:='';
      EditDet4.Text:='';EditSuiv4.Text:='';
      LabelDetAss.visible:=false;
      LabelElSuiv.visible:=false;
      EditDet1.Visible:=false;EditDet2.Visible:=false;EditDet3.Visible:=false;EditDet4.Visible:=false;
      EditSuiv1.Visible:=false;EditSuiv2.Visible:=false;EditSuiv3.Visible:=false;EditSuiv4.Visible:=false;
      CheckVerrouCarre.Visible:=false;
      Label24.Visible:=false; Label25.Visible:=false;Label26.Visible:=false;Label27.Visible:=false;
    end;
  end;   
end;

Procedure aff_champs_act;
var i,v, ligne,etatact,erreur, adresse,sortie,fonction,tempo,access : integer;
    s,s2,ss : string;
    trouve : bool;
begin
  with formConfig.MemoAct do
  begin
    ligne:=Perform(EM_LINEFROMCHAR,-1,0);  // numéro de la lignée cliquée
    s:=Uppercase(Lines[ligne]);            
    if s='' then exit;
    SelStart:=Perform(EM_LINEINDEX,Ligne,0);  // début de la sélection
    SelLength:=Length(s) ;  // fin de la sélection
    SetFocus;
  end;

  // actionneur passage à niveau
  if s[1]='(' then 
  begin
    with formconfig do
    begin
      GroupBoxact.Visible:=false;
      GroupBoxPN.Top:=104;
      GroupBoxPN.Left:=16;
      GroupBoxPN.Visible:=true;
      Visible:=true;
      RadioButtonPN.Checked:=true;
      RadioButtonLoc.Checked:=false;
      RadioButtonAccess.Checked:=false;
    end;
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
        EditV2F.Visible:=true;
        EditV2O.Visible:=true;
        labelV2.Visible:=true;
      end;
      if v>=3 then
      begin
        EditV3F.text:=intToSTR(Tablo_PN[i].voie[3].ActFerme);
        EditV3O.text:=intToSTR(Tablo_PN[i].voie[3].ActOuvre);
        EditV3F.Visible:=true;
        EditV3O.Visible:=true;
        labelV3.visible:=true;
      end;
      if v<3 then
      begin
        EditV3F.Visible:=false;
        EditV3O.Visible:=false;
        labelV3.visible:=false;
      end;
      if v<2 then
      begin
        EditV2F.Visible:=false;
        EditV2O.Visible:=false;
        labelV2.visible:=false;
      end;
    end;
  end
  else

  // actionneur fonction F locomotive ou Accessoire
  begin
    with formconfig do
    begin
      GroupBoxAct.Top:=104;
      GroupBoxAct.Left:=16;
      
      GroupBoxact.Visible:=true;
      GroupBoxPN.Visible:=false;     
    end;
    // trouver l'index dans le tableau
    val(s,adresse,erreur);
    i:=0;
    repeat
      inc(i);
      trouve:=(Tablo_actionneur[i].actionneur=adresse);
    until trouve or (i>MaxTablo_act);
    if not(trouve) then exit;
    
    fonction:=Tablo_actionneur[i].fonction;
    Access:=Tablo_actionneur[i].accessoire;
    if fonction<>0 then 
    begin
      etatAct:=Tablo_actionneur[i].etat ;
      //etatFonc:=Tablo_actionneur[i].
      Adresse:=Tablo_actionneur[i].actionneur;
      s2:=Tablo_actionneur[i].train;
      tempo:=tablo_actionneur[i].Tempo;
      with formconfig do
      begin
        CheckRaz.Visible:=false;
        GroupBoxAct.Caption:='Actionneur de fonction F de locomotive';
        LabelTempo.Visible:=true; EditTempo.visible:=true; editEtatFoncSortie.visible:=false;LabelA.Visible:=false;
        editEtatActionneur.Text:=IntToSTR(etatAct);
        LabelFonction.caption:='Fonction';
        RadioButtonPN.Checked:=false;
        RadioButtonLoc.Checked:=true;
        RadioButtonAccess.Checked:=false;
        EditAct.text:=IntToSTR(Adresse);
        EditTrain.Text:=s2;
        editFonctionAccess.Text:=intToSTR(fonction);
        //editEtat.Text:=intToSTR(etatAct);
        editTempo.Text:=intToSTR(tempo);
      end;
    end;  

    if Access<>0 then 
    begin
      etatAct:=Tablo_actionneur[i].etat ;
      Adresse:=Tablo_actionneur[i].actionneur;
      sortie:=Tablo_actionneur[i].sortie;
      s2:=Tablo_actionneur[i].train;
      tempo:=tablo_actionneur[i].Tempo;
      with formconfig do
      begin
        GroupBoxAct.Caption:='Actionneur d''accessoire';
        CheckRaz.Visible:=true;
        CheckRaz.Checked:=Tablo_actionneur[i].Raz;
        LabelTempo.Visible:=false; EditTempo.visible:=false;editEtatFoncSortie.visible:=true;LabelA.Visible:=true;
        LabelFonction.caption:='Accessoire';
        RadioButtonPN.Checked:=false;
        RadioButtonLoc.Checked:=false;
        RadioButtonAccess.Checked:=true;
        EditAct.text:=IntToSTR(Adresse);
        EditTrain.Text:=s2;
        EditEtatActionneur.Text:=IntToSTR(etatAct);
        editFonctionAccess.Text:=intToSTR(Access);
        editEtatFoncSortie.Text:=intToSTR(sortie);
        editTempo.Text:=intToSTR(tempo);
      end;
    end;  

    
  end;
  
  ss:='Actionneur '+InttoSTr(Adresse);
end;  
  


procedure TFormConfig.MemoSignauxClick(Sender: TObject);
begin
  Aff_champs_sig;
end;

procedure TFormConfig.MemoActClick(Sender: TObject);
begin
  Aff_champs_act;
end;

procedure TFormConfig.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage=TabSheetAig then
  begin
  end;
end;

// cliqué sur liste aiguillages
procedure TFormConfig.RichAigMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  clicliste:=true;
  LabelInfo.caption:='';
  Aff_champs_aig;
  clicliste:=false;
end;

// on change la valeur de la description de la pointe de l'aiguillage
procedure change_Pointe;
var AdrAig,adr,erreur : integer;
    b : char;
    s : string;
begin
  // cliqué sur le edit pointe aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[lignecliquee];
      
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=Editpointe_BG.text;
    decodeAig(s,adr,B);
    if ((B='S') or (B='P') or (B='D') or (B=#0)) and (s<>'') then 
    begin
      // RichAig.SelStart:=Perform(EM_LINEINDEX,ligneCliquee,0);  // début de la sélection
      // RichAig.SelLength:=Length(s) ;  // fin de la sélection
      //SetFocus;
      RE_ColorLine(RichAig,ligneCliquee,ClWhite);
      Aiguillage[AdrAig].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';
      
      Aiguillage[AdrAig].APointe:=adr;
      Aiguillage[AdrAig].APointeB:=B;
      // réencoder la ligne
      s:=encode_aig(AdrAig);
      
      formconfig.RichAig.Lines[lignecliquee]:=s;
      labelLigne.Caption:=s;
    end
      else
        LabelInfo.caption:='Erreur pointe aiguillage '+intToSTR(AdrAig);
    end;  
end;

// on change la valeur de la description de la déviation de l'aiguillage
procedure change_Devie;
var AdrAig,adr,erreur : integer;
    b : char;
    tjd : boolean;
    s : string;
begin
  // cliqué sur le edit dévié aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
    
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[lignecliquee];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=EditDevie_HD.text;
    decodeAig(s,adr,B);

   
    if ((B='S') or (B='P') or (B='D') or (B=#0)) and (s<>'') then 
    begin
      // RichAig.SelStart:=Perform(EM_LINEINDEX,ligneCliquee,0);  // début de la sélection
      // RichAig.SelLength:=Length(s) ;  // fin de la sélection
      //SetFocus;
      tjd:=pos('TJD',s)<>0;
      if tjd then 
      begin
        val(EditP1.Text,AdrAig,erreur); // adresse de pointe de la tjd = adresse à utiliser
      end;  
    
      
      RE_ColorLine(RichAig,ligneCliquee,ClWhite);
      Aiguillage[AdrAig].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';
      Aiguillage[AdrAig].ADevie:=adr;
      Aiguillage[AdrAig].ADevieB:=B;
      // réencoder la ligne
      s:=encode_aig(AdrAig);
      formconfig.RichAig.Lines[lignecliquee]:=s;
      labelLigne.Caption:=s;
    end
    else
    begin
      LabelInfo.caption:='Erreur déviation aiguillage '+intToSTR(AdrAig);
    end;
  end;  
end;

// on change la valeur de la description du droit de l'aiguillage
procedure change_Droit;
var AdrAig,adr,erreur : integer;
    b : char;
    tjd : boolean;
    s : string;
begin
  // cliqué sur le edit droit aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[lignecliquee];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=EditDroit_BD.text;
    decodeAig(s,adr,B);

    if ((B='S') or (B='P') or (B='D') or (B=#0)) and (s<>'') then 
    begin
      // RichAig.SelStart:=Perform(EM_LINEINDEX,ligneCliquee,0);  // début de la sélection
      // RichAig.SelLength:=Length(s) ;  // fin de la sélection
      //SetFocus;

      tjd:=pos('TJD',s)<>0;
      if tjd then 
      begin
        val(EditP1.Text,AdrAig,erreur); // adresse de pointe de la tjd = adresse à utiliser
      end; 
      
      RE_ColorLine(RichAig,ligneCliquee,ClWhite);
      Aiguillage[AdrAig].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';
      Aiguillage[AdrAig].ADroit:=adr;
      Aiguillage[AdrAig].ADroitB:=B;
      // réencoder la ligne
      s:=encode_aig(AdrAig);
      formconfig.RichAig.Lines[lignecliquee]:=s;
      labelLigne.Caption:=s;
    end
    else
    begin
      LabelInfo.caption:='Erreur droit aiguillage '+intToSTR(AdrAig);
    end;
  end;  
end;

procedure change_S2;
var AdrAig,adr,erreur : integer;
    b : char;
    s : string;
begin
  // cliqué sur le edit droit aiguillage
  // ne pas traiter si on a cliqué sur la liste
  if clicliste then exit;
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.RichAig.Lines[lignecliquee];
    Val(s,adrAig,erreur);
    //vérifier la syntaxe de P
    s:=EditDevieS2.text;
    decodeAig(s,adr,B);

    if ((B='S') or (B='P') or (B='D') or (B=#0)) and (s<>'') then 
    begin
      // RichAig.SelStart:=Perform(EM_LINEINDEX,ligneCliquee,0);  // début de la sélection
      // RichAig.SelLength:=Length(s) ;  // fin de la sélection
      //SetFocus;
           
      RE_ColorLine(RichAig,ligneCliquee,ClWhite);
      Aiguillage[AdrAig].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de données de l'aiguillage
      if b=#0 then b:='Z';
      Aiguillage[AdrAig].ADevie2:=adr;
      Aiguillage[AdrAig].ADevie2B:=B;
      // réencoder la ligne
      s:=encode_aig(AdrAig);
      formconfig.RichAig.Lines[lignecliquee]:=s;
      labelLigne.Caption:=s;
    end
    else
    begin
      LabelInfo.caption:='Erreur droit aiguillage '+intToSTR(AdrAig);
    end;
  end;  
end;

procedure change_det1;
var s : string;
    i,erreur : integer;
begin
  if clicliste then exit;
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet1.Text;
    Val(s,i,erreur);
    if erreur<>0 then begin LabelInfo.caption:='Erreur détecteur1 ';exit;end;
    LabelInfo.caption:=' '; 
    feux[lignecliquee+1].Adr_det1:=i;
    s:=encode_sig(lignecliquee+1);
    RichSig.Lines[lignecliquee]:=s;
    feux[lignecliquee+1].modifie:=true;
  end;  
end;

procedure change_Suiv1;
var s : string;
    i,erreur : integer;
    B : char;
begin
  if clicliste then exit;
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv1.Text;
    if s='' then begin LabelInfo.caption:='Erreur élément suivant 1';exit;end;
    Val(s,i,erreur);
    //if erreur<>0 then 
    if erreur<>0 then
    begin
      if (s[erreur]='A') and (erreur=1) then 
      begin
        feux[lignecliquee+1].Btype_suiv1:=2;  // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri
        delete(s,erreur,1);
        Val(s,i,erreur);
      end  
      else begin LabelInfo.caption:='Erreur élément suivant 1';exit;end;
    end
    else feux[lignecliquee+1].Btype_suiv1:=1;

    LabelInfo.caption:=' ';
   
    feux[lignecliquee+1].Adr_el_suiv1:=i;  
    s:=encode_sig(lignecliquee+1);
    RichSig.Lines[lignecliquee]:=s; 
  end;  
end;



procedure TFormConfig.EditPointe_BGChange(Sender: TObject);
begin
  change_pointe;
end;

procedure TFormConfig.EditDevie_HDChange(Sender: TObject);
begin
  Change_devie;
end;

procedure TFormConfig.EditDroit_BDChange(Sender: TObject);
begin
  Change_droit;
end;

procedure TFormConfig.EditDevieS2Change(Sender: TObject);
begin
  Change_s2;
end;

procedure TFormConfig.RadioButtonsansClick(Sender: TObject);
var AdrAig,erreur : integer;
    s : string;
begin
  s:=formconfig.RichAig.Lines[lignecliquee];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  aiguillage[AdrAig].vitesse:=0;
  aiguillage[AdrAig].modifie:=true;
  s:=encode_aig(AdrAig);
  formconfig.RichAig.Lines[lignecliquee]:=s;
  labelLigne.Caption:=s;
end;

procedure TFormConfig.RadioButton30kmhClick(Sender: TObject);
var AdrAig,erreur : integer;
    s : string;
begin
  s:=formconfig.RichAig.Lines[lignecliquee];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  aiguillage[AdrAig].vitesse:=30;
  aiguillage[AdrAig].modifie:=true;
  s:=encode_aig(AdrAig);
  formconfig.RichAig.Lines[lignecliquee]:=s;
  labelLigne.Caption:=s;
end;

procedure TFormConfig.RadioButton60kmhClick(Sender: TObject);
var AdrAig,erreur : integer;
    s : string;
begin
  s:=formconfig.RichAig.Lines[lignecliquee];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  aiguillage[AdrAig].vitesse:=60;
  aiguillage[AdrAig].modifie:=true;
  s:=encode_aig(AdrAig);
  formconfig.RichAig.Lines[lignecliquee]:=s;
  labelLigne.Caption:=s;
end;



procedure TFormConfig.ComboBoxDecChange(Sender: TObject);
var s: string;
begin
//  Affiche(IntToStr(ComboBoxDec.ItemIndex),clyellow);
  feux[lignecliquee+1].decodeur:= ComboBoxDec.ItemIndex;
  s:=encode_sig(lignecliquee+1);
  formconfig.RichSig.Lines[lignecliquee]:=s;
end;

// cliqué sur liste feux
procedure TFormConfig.RichSigMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  clicliste:=true;
  LabelInfo.caption:='';
  Aff_champs_sig;
  clicliste:=false;
end;



procedure TFormConfig.EditDet1Change(Sender: TObject);
begin
  change_det1;
end;

procedure TFormConfig.EditSuiv1Change(Sender: TObject);
begin
  change_Suiv1;
end;

procedure TFormConfig.CheckVerrouCarreClick(Sender: TObject);
var s : string;
begin
  if clicliste then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    feux[lignecliquee+1].VerrouCarre:=checkVerrouCarre.Checked;
    s:=encode_sig(lignecliquee+1);
    RichSig.Lines[lignecliquee]:=s;
    feux[lignecliquee+1].modifie:=true;
  end;  
end;



end.



