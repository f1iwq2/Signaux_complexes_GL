unit UnitPareFeu;

interface
function verifie_regle : integer;
function cree_regle : boolean;

implementation

uses
  SysUtils,ActiveX,ComObj,Variants,UnitPrinc,Graphics,unitConfig,verif_version;
Const
  NET_FW_ACTION_ALLOW=1;
  NET_FW_IP_PROTOCOL_TCP=6;
  NET_FW_IP_PROTOCOL_UDP=17;
  NET_FW_IP_PROTOCOL_ANY=256;
  net_fw_profile2_private=2;
  net_fw_profile2_public=4;
  net_fw_rule_dir_out=2;
  net_fw_rule_dir_in=1;
  NET_FW_MODIFY_STATE_OK=0;
  NET_FW_MODIFY_STATE_GP_OVERRIDE=1;
  NET_FW_MODIFY_STATE_INBOUND_BLOCKED=2;
  nom_regle_cdm='CDM rail';

// Ajoute une règle à un programme en utilisant Microsoft Windows Firewall APIs.
function AddApplicationRule : boolean;
var
  CurrentProfiles,fwPolicy2,RulesObject,NewRule : OleVariant;
  s,fichier : string;
  r : boolean;
begin
  fichier:=CheminProgrammes+'\CDM-Rail\cdr.exe';
  
  // Crée l'objet FwPolicy2
  fwPolicy2:=CreateOleObject('HNetCfg.FwPolicy2');
  RulesObject:=fwPolicy2.Rules;
  CurrentProfiles:=fwPolicy2.CurrentProfileTypes;
  //CurrentProfiles:=net_fw_profile2_private or net_fw_profile2_public;

  //Crée l'objet de la règle.
  NewRule:=CreateOleObject('HNetCfg.FWRule');

  NewRule.Name:=nom_regle_cdm;
  NewRule.Description:='Autorise le socket de/vers CDM rail';

  NewRule.Applicationname:=fichier;
  NewRule.Protocol:=NET_FW_IP_PROTOCOL_TCP;
  //NewRule.LocalPorts := '9999';   // '80,443,4520-4533'   sans spécif=tous ports
  NewRule.Direction:=net_fw_rule_dir_in;
  NewRule.Enabled:=True;
  NewRule.Grouping:='';
  NewRule.Profiles:=CurrentProfiles;
  NewRule.Action:=NET_FW_ACTION_ALLOW;

  //Ajouter une règle
  try
    RulesObject.Add(NewRule);
    r:=true;
  except
    begin
      s:='Erreur: impossible d''accéder au pare feu windows. Le pare feu est géré par un programme tiers.';
      Affiche(s,clred);
      formconfig.Labelinfo.caption:=s;
      r:=false;
    end;
  end;
  result:=r;
end;

function cree_regle : boolean;
var CoResult : Hresult;
    s : string;
    r : boolean;
begin
  r:=false;
  try
    CoResult:=CoInitializeEx(nil,COINIT_MULTITHREADED);
    try
      r:=AddApplicationRule;
    finally
    begin
      CoUninitialize;
      if r then
      begin
        s:='Ajout de la règle '+nom_regle_cdm+' dans le pare-feu';
        formconfig.Labelinfo.caption:=s;
        Affiche(s,clyellow);
      end;
    end;
  end;
  except
    on E:EOleException do
    begin
      Affiche('EOleException '+E.Message+intToSTR(E.ErrorCode),clred);
      r:=false;
    end;
    on E:Exception do
    begin
      Affiche(E.Classname+':'+E.Message,clred);
      r:=false;
    end;
  end;
  result:=r;
end;


// vérifie si la règle cdm est dans le parefeu windows
// retour =0 : pas dans le pare feu
// =1 oui mais inactive
// =2 oui et active
function CheckingRuleEnabled : integer;
var
  fwPolicy2,RulesObject,regle : OleVariant;
  CurrentProfiles : Integer;
  bIsEnabled,trouve : Boolean;
  oEnum : IEnumvariant;
  iValue : LongWord;
  s : string;
begin
  fwPolicy2:=CreateOleObject('HNetCfg.FwPolicy2');
  RulesObject:=fwPolicy2.Rules;
  CurrentProfiles:=fwPolicy2.CurrentProfileTypes;
  trouve:=false ;
  oEnum:=IUnknown(Rulesobject._NewEnum) as IEnumVariant;
  while (oEnum.Next(1,regle,iValue)=0) and not(trouve) do
  begin
    if (regle.Profiles And CurrentProfiles)<>0 then
    begin
      s:=regle.Name;
      trouve:=s=nom_regle_cdm;
      if trouve then
      begin
        Affiche('Description de l''autorisation socket pour CDM rail dans le pare-feu Windows',clyellow);
        Affiche('Nom : ' + s,clLime);
        Affiche('Description : ' + regle.Description,clLime);
        Affiche('Nom d''application: ' + regle.ApplicationName,clLime);
        Affiche('Nom du service: ' + regle.ServiceName,clLime);
        bIsEnabled:=regle.enabled;
        if bisEnabled then affiche('Activée',clLime) else affiche('désactivée',clLime) ;
        if (regle.Protocol=NET_FW_IP_PROTOCOL_TCP) or (regle.Protocol=NET_FW_IP_PROTOCOL_UDP) then
        begin
          if (regle.Protocol=NET_FW_IP_PROTOCOL_TCP) then Affiche('Protocole : TCP',clLime);
          if (regle.Protocol=NET_FW_IP_PROTOCOL_UDP) then Affiche('Protocole : UDP',clLime);
          Affiche('Ports locaux : ' + regle.LocalPorts,clLime);
          Affiche('Ports distants : ' + regle.RemotePorts,clLime);
          Affiche('Adresses locales : ' + regle.LocalAddresses,clLime);
          Affiche('Adresses distantes : ' + regle.RemoteAddresses,clLime);
        end;
      end;
    end;
  end;
  if not(trouve) then
  begin
    result:=0;
  end
  else
    begin
      if bIsEnabled then result:=2 else result:=1;
    end;
end;

function verifie_regle : integer;
var i : integer;
begin
  i:=0;
  try
    CoInitialize(nil);
    try
      i:=CheckingRuleEnabled;
    finally
      CoUninitialize;
    end;
  except
    on E:EOleException do
        Affiche('EOleException '+E.Message+intToSTR(E.ErrorCode),clred);
    on E:Exception do
        Affiche(E.Classname+':'+E.Message,clred);
  end;
  result:=i;
end;


begin
end.

