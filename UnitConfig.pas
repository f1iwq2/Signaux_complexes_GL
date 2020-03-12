unit UnitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls ;

type
  TFormConfig = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditAdrIPCDM: TEdit;
    Label2: TLabel;
    EditPortCDM: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EditcomUSB: TEdit;
    Label4: TLabel;
    EditTempoOctetUSB: TEdit;
    Label5: TLabel;
    EditTempoReponse: TEdit;
    Button1: TButton;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    EditIPLenz: TEdit;
    Label8: TLabel;
    EditportLenz: TEdit;
    GroupBox4: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label6: TLabel;
    LabelInfo: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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

procedure connecte_CDM;
var s : string;
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

      // demande des services : ATNT=aiguillages, ADET=détecteurs AACT=actionneurs
      s:=place_id('C-C-00-0002-RQSERV-RTSIM|030|03|SRV=ATNT;SRV=ADET;SRV=AACT;');
      envoi_CDM(s);
      if pos('_ACK',recuCDM)<>0 then Affiche('Services acceptés: aiguillages - détecteurs - actionneurs',clYellow);
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
  config_com:=not( (NumPort>9) or (protocole=-1) or (protocole>4) or (i=0) );
end;

procedure TFormConfig.Button1Click(Sender: TObject);
var i,erreur : integer;
    s : string;
    ChangeCDM,changeInterface,changeUSB : boolean;
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
  
  formConfig.close;
end;

procedure TFormConfig.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFormConfig.FormActivate(Sender: TObject);
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
end;

end.
