unit UnitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , verif_version, jpeg, ComCtrls ;

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
    Label10: TLabel;
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
    TabSheet1: TTabSheet;
    MemoAig: TMemo;
    Label12: TLabel;
    TabSheet2: TTabSheet;
    Label14: TLabel;
    MemoBranches: TMemo;
    TabSheet3: TTabSheet;
    MemoSignaux: TMemo;
    Label15: TLabel;
    TabSheet4: TTabSheet;
    Label16: TLabel;
    MemoAct: TMemo;
    CheckBoxSrvSig: TCheckBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    GroupBox9: TGroupBox;
    CheckBoxRazSignaux: TCheckBox;
    procedure ButtonAppliquerEtFermerClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   
  end;

var
  FormConfig: TFormConfig;
  AdresseIPCDM,AdresseIP,PortCom,recuCDM : string;
  portCDM,TempoOctet,TimoutMaxInterface,Valeur_entete,Port,protocole,NumPort : integer;
  
function config_com(s : string) : boolean;
function envoi_CDM(s : string) : boolean;
procedure connecte_CDM;
function place_id(s : string) : string;
  
implementation

uses UnitDebug,UnitPrinc;

{$R *.dfm}

// envoi d'une chaîne à CDM par socket, puis attend l'ack ou le nack
function envoi_CDM(s : string) : boolean;
var temps : integer;
begin
    if parsocketCDM=false then begin envoi_CDM:=false;exit;end;
    //Affiche('Envoi à CDM rail',clRed);Affiche(s,ClGreen);
    Formprinc.ClientSocketCDM.Socket.SendText(s);
    // attend l'ack
    ackCDM:=false;nackCDM:=false;
    if ParSocketCDM then
    begin
      temps:=0;
      repeat
        inc(temps);Sleep(100);
        Application.processMessages;
      until ferme or ackCDM or nackCDM or (temps>10); // CDM répond < 1s
      if not(ackCDM) or nack then
      begin
        Affiche('Pas de réponse de CDM Rail',clRed);
      end;
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
  ParSocketCDM:=false;
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
    until (i>10) or ParSocketCDM;  
    if not(ParSocketCDM) then Affiche('Socket CDM non connecté',clOrange);

    // connexion à CDM rail
    recuCDM:='';
    s:='C-C-00-0001-CMDGEN-_CNCT|000|';
    envoi_cdm(s);
    if pos('_ACK',recuCDM)<>0 then
    begin
      CDM_connecte:=True;
      Id_CDM:=copy(recuCDM,5,2);   // récupère l'ID reçu de CDM, à utiliser dans toutes les futures trames
      s:='Connecté au serveur CDM rail avec l''ID='+Id_CDM;
      Affiche(s,clYellow);
      AfficheDebug(s,clyellow);

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



function Ipok(s : string) : boolean;
var i,posp,n,octet,erreur : integer;
begin
  n:=0;
  for i:=1 to length(s) do
  begin
    posp:=pos('.',s);
    if posp<>0 then 
    begin
      inc(n);
      val(s,octet,erreur);
      if octet>255 then begin IpOK:=false;exit;end;
      delete(s,1,posp);
    end;  
  end;  
  val(s,octet,erreur);
  if octet>255 then begin IpOK:=false;exit;end;
  IpOk:=n=3; 
end;

// vérifie si ma config de la com série/usb est ok
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

// modifie les fichiers de config en fonction du paramétrage
procedure genere_config2;
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
  writeln(fichierN,TailleFonte);
  copie_commentaire;

  // adresse ip et port de CDM
  writeln(fichierN,adresseIPCDM+':'+intToSTR(portCDM));
  copie_commentaire;

  // adresse ip interface XpressNet
  writeln(fichierN,adresseIP+':'+intToSTR(port));
  copie_commentaire;

  // port com
  writeln(fichierN,portcom);
  copie_commentaire;

  // temporisation caractère TempoOctet
  writeln(fichierN,IntToSTR(TempoOctet));
  copie_commentaire;

  // temporisation attente maximale interface
  writeln(fichierN,IntToSTR(TimoutMaxInterface));
  copie_commentaire;

  // entete Valeur_entete
  writeln(fichierN,intToSTR(Valeur_entete));
  copie_commentaire;

  // avec ou sans initialisation des aiguillages
  writeln(fichierN,IntToSTR(AvecInitAiguillages));
  copie_commentaire;

  writeln(fichierN,s);
  // valeurs des initialisations
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);
  copie_commentaire;
  
  // Vérification des versions au démarrage
  if verifVersion then s:='1' else s:='0';
  writeln(fichierN,s);
  copie_commentaire;

  // Notification de nouvelle version
  if notificationVersion then s:='1' else s:='0';
  writeln(fichierN,s);
  copie_commentaire;
 
  // Avec TCO
  if AvecTCO then s:='1' else s:='0';
  writeln(fichierN,s);
  copie_commentaire; 

  // lancement de CDM
  if LanceCDM then s:='1' else s:='0';
  writeln(fichierN,s);
  copie_commentaire; 

  // Nom du LAY
  writeln(fichierN,Lay);
  copie_commentaire; 

  // Serveur d'interface de CDM
  writeln(fichierN,intToSTR(ServeurInterfaceCDM));
  copie_commentaire; 

  // Serveur de rétrosignalisation Lenz de CDM
  writeln(fichierN,intToSTR(ServeurRetroCDM));
  copie_commentaire; 
  
  closefile(fichier);
  closefile(fichierN);

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

  writeln(fichierN,s);
  // modélisation des aiguillages
  if s[1]<>'0' then
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);
  copie_commentaire;
  
  writeln(fichierN,s);
  // modélisation des branches de réseau
  if s[1]<>'0' then
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);
  copie_commentaire;

  writeln(fichierN,s);
  // modélisation des signaux
  if s[1]<>'0' then
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);
  copie_commentaire;

  writeln(fichierN,s);
  // Fonctions Fx
  if s[1]<>'0' then
  repeat
    readln(fichier,s);
    writeln(fichierN,s);
    continue:=s[1]<>'0';
  until not(continue);
  copie_commentaire;
  
  closefile(fichier);
  closefile(fichierN);
  
  deletefile('config.cfg');
  deletefile('client-GL.cfg');

  renameFile('config.tmp','config.cfg');
  renameFile('client-GL.tmp','client-GL.cfg');

end;

procedure TFormConfig.ButtonAppliquerEtFermerClick(Sender: TObject);
var i,erreur : integer;
    s : string;
    ChangeCDM,changeInterface,changeUSB,change_srv : boolean;
begin
  // contrôle adresse IP CDM
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
  if not(IpOk(s)) then begin labelInfo.Caption:='Adresse IP Lenz incorrecte';exit;end; 
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

  if RadioButton1.checked then Valeur_entete:=0;
  if RadioButton2.checked then Valeur_entete:=1;
  if RadioButton3.checked then Valeur_entete:=2;

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

  if change_srv then services_CDM;
  
  // générer le fichiers config.cfg et clieng-GL.cfg
  genere_config2;
  formConfig.close;
end;

procedure TFormConfig.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormConfig.FormActivate(Sender: TObject);
var i : integer;
begin
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

  if Valeur_entete=0 then RadioButton1.checked:=true;
  if Valeur_entete=1 then RadioButton2.checked:=true;
  if Valeur_entete=2 then RadioButton3.checked:=true;

  CheckVerifVersion.Checked:=verifVersion;
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
                
end;



procedure TFormConfig.FormCreate(Sender: TObject);
var i : integer;
begin
  // remplit les 4 fenêtres de config des aiguillages branches signaux, actionneurs
  for i:=1 to MaxAiguillage do
    MemoAig.Lines.Add(mod_aiguillages[i]);
  for i:=1 to NbreBranches do
    MemoBranches.Lines.Add(mod_Branches[i]);
  for i:=1 to NbreFeux do
    MemoSignaux.Lines.Add(mod_Signaux[i]);
  for i:=1 to maxTablo_act do
    MemoAct.Lines.Add(mod_Act[i]);
  PageControl.ActivePage:=TabSheetCDM;  // force le premier onglet sur la page
end;








end.
