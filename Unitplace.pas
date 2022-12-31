unit Unitplace;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unitprinc;

type
  TFormPlace = class(TForm)
    Buttonferme: TButton;
    Label1: TLabel;
    ButtonInitAig: TButton;
    ButtonSauve: TButton;
    LabelTrain1: TLabel;
    LabelTrain2: TLabel;
    LabelTrain3: TLabel;
    LabelTrain4: TLabel;
    LabelTrain5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    LabelTrain6: TLabel;
    Edit6: TEdit;
    Label2: TLabel;
    ButtonPlace: TButton;
    LabelTexte: TLabel;
    Label3: TLabel;
    ButtonLanceRoutage: TButton;
    Button1: TButton;
    ButtonArretroutage: TButton;
    CheckInverse1: TCheckBox;
    CheckInverse2: TCheckBox;
    CheckInverse3: TCheckBox;
    CheckInverse4: TCheckBox;
    CheckInverse5: TCheckBox;
    CheckInverse6: TCheckBox;
    EditDir1: TEdit;
    Label4: TLabel;
    EditDir2: TEdit;
    EditDir3: TEdit;
    EditDir4: TEdit;
    EditDir5: TEdit;
    EditDir6: TEdit;
    Label5: TLabel;
    procedure ButtonfermeClick(Sender: TObject);
    procedure ButtonInitAigClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonPlaceClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSauveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonLanceRoutageClick(Sender: TObject);
    procedure ButtonArretroutageClick(Sender: TObject);
    procedure CheckInverse1Click(Sender: TObject);
    procedure CheckInverse2Click(Sender: TObject);
    procedure CheckInverse3Click(Sender: TObject);
    procedure CheckInverse4Click(Sender: TObject);
    procedure CheckInverse5Click(Sender: TObject);
    procedure CheckInverse6Click(Sender: TObject);
    procedure EditDir1Change(Sender: TObject);
    procedure EditDir2Change(Sender: TObject);
    procedure EditDir3Change(Sender: TObject);
    procedure EditDir4Change(Sender: TObject);
    procedure EditDir5Change(Sender: TObject);
    procedure EditDir6Change(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormPlace: TFormPlace;

implementation

uses UnitConfig, UnitTCO;

{$R *.dfm}

procedure TFormPlace.ButtonfermeClick(Sender: TObject);
begin
  close;
end;

procedure TFormPlace.ButtonInitAigClick(Sender: TObject);
begin
  if cdm_connecte then
  begin
    Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;
  ButtonLanceRoutage.Enabled:=false;
  init_aiguillages;
  ButtonLanceRoutage.Enabled:=true;
end;

procedure TFormPlace.FormActivate(Sender: TObject);
begin
  LabelTrain1.Caption:=trains[1].nom_train;
  Edit1.text:=intToSTR(placement[1].detecteur);
  EditDir1.Text:=IntToSTR(placement[1].detdir);
  CheckInverse1.Checked:=placement[1].inverse;
  LabelTrain2.Caption:=trains[2].nom_train;
  EditDir2.Text:=IntToSTR(placement[2].detdir);
  CheckInverse2.Checked:=placement[2].inverse;
  Edit2.text:=intToSTR(placement[2].detecteur);
  CheckInverse3.Checked:=placement[3].inverse;
  EditDir3.Text:=IntToSTR(placement[3].detdir);
  LabelTrain3.Caption:=trains[3].nom_train;
  Edit3.text:=intToSTR(placement[3].detecteur);
  LabelTrain4.Caption:=trains[4].nom_train;
  EditDir4.Text:=IntToSTR(placement[4].detdir);
  Edit4.text:=intToSTR(placement[4].detecteur);
  CheckInverse4.Checked:=placement[4].inverse;
  LabelTrain5.Caption:=trains[5].nom_train;
  EditDir5.Text:=IntToSTR(placement[5].detdir);
  Edit5.text:=intToSTR(placement[5].detecteur);
  CheckInverse5.Checked:=placement[5].inverse;
  LabelTrain6.Caption:=trains[6].nom_train;
  EditDir6.Text:=IntToSTR(placement[6].detdir);
  Edit6.text:=intToSTR(placement[6].detecteur);
  CheckInverse6.Checked:=placement[6].inverse;
end;

procedure TFormPlace.ButtonPlaceClick(Sender: TObject);
var suiv,detect,erreur : integer;
    s : string;
begin
  if cdm_connecte then
  begin
    Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;

  for detect:=1 to NbMemZone do
  begin
    detecteur[detect].train:='';
    detecteur[detect].AdrTrain:=0;
  end;

  s:=edit1.Text;
  if s<>'' then
  begin
    val(s,detect,erreur);
    if (erreur<>0) or (detect>NbMemZone )then LabelTexte.caption:='Erreur détecteur train 1';
    if detect<>0 then
    begin
      detecteur[detect].adrTrain:=trains[1].adresse;
      event_detecteur(detect,true,trains[1].nom_train);
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+EditDir1.Text,clLime);
    end
    else
    begin
      detecteur[detect].etat:=false;
      detecteur[detect].train:='';
      detecteur[detect].adrTrain:=0;
    end;
  end;

  s:=edit2.Text;
  if s<>'' then
  begin
    val(s,detect,erreur);
    if (erreur<>0) or (detect>NbMemZone )then LabelTexte.caption:='Erreur détecteur train 2';
    if detect<>0 then
    begin
      detecteur[detect].adrTrain:=trains[2].adresse;
      event_detecteur(detect,true,trains[2].nom_train);
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+EditDir2.Text,clLime);
    end
    else
    begin
      detecteur[detect].etat:=false;
      detecteur[detect].train:='';
      detecteur[detect].adrTrain:=0;
    end;
  end;

  s:=edit3.Text;
  if s<>'' then
  begin
    val(s,detect,erreur);
    if (erreur<>0) or (detect>NbMemZone )then LabelTexte.caption:='Erreur détecteur train 3';
    if detect<>0 then
    begin
      detecteur[detect].adrTrain:=trains[3].adresse;
      event_detecteur(detect,true,trains[3].nom_train);
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+EditDir3.Text,clLime);
    end
    else
    begin
      detecteur[detect].etat:=false;
      detecteur[detect].train:='';
      detecteur[detect].adrTrain:=0;
    end;
  end;

  s:=edit4.Text;
  if s<>'' then
  begin
    val(s,detect,erreur);
    if (erreur<>0) or (detect>NbMemZone )then LabelTexte.caption:='Erreur détecteur train 4';
    if detect<>0 then
    begin
      det_adj(detect);
      val(editDir4.Text,Suiv,erreur);
      if detect<>0 then
      begin
        detecteur[detect].adrTrain:=trains[4].adresse;
        event_detecteur(detect,true,trains[4].nom_train);
        Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+EditDir4.Text,clLime);
      end
      else
      begin
        detecteur[detect].etat:=false;
        detecteur[detect].train:='';
        detecteur[detect].adrTrain:=0;
      end;
    end;
  end;

  s:=edit5.Text;
  if s<>'' then
  begin
    val(s,detect,erreur);
    if (erreur<>0) or (detect>NbMemZone )then LabelTexte.caption:='Erreur détecteur train 5';
    if detect<>0 then
    begin
      detecteur[detect].adrTrain:=trains[5].adresse;
      event_detecteur(detect,true,trains[5].nom_train);
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+EditDir5.Text,clLime);
    end
    else
    begin
      detecteur[detect].etat:=false;
      detecteur[detect].train:='';
      detecteur[detect].adrTrain:=0;
    end;
  end;

  s:=edit6.Text;
  if s<>'' then
  begin
    val(s,detect,erreur);
    if (erreur<>0) or (detect>NbMemZone )then LabelTexte.caption:='Erreur détecteur train 6';
    if detect<>0 then
    begin
      detecteur[detect].adrTrain:=trains[6].adresse;
      event_detecteur(detect,true,trains[6].nom_train);
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+EditDir6.Text,clLime);
    end
    else
    begin
      detecteur[detect].etat:=false;
      detecteur[detect].train:='';
      detecteur[detect].adrTrain:=0;
    end;
  end;
  if formTCO.Showing then
  begin
    affiche_tco;
  end;

end;

procedure TFormPlace.Edit1Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit1.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[1].train:=trains[1].nom_train;
  placement[1].detecteur:=i;
end;

procedure TFormPlace.Edit2Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit2.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[2].train:=trains[2].nom_train;
  placement[2].detecteur:=i;
end;

procedure TFormPlace.Edit3Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit3.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[3].train:=trains[3].nom_train;
  placement[3].detecteur:=i;
end;

procedure TFormPlace.Edit4Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit4.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[4].train:=trains[4].nom_train;
  placement[4].detecteur:=i;
end;

procedure TFormPlace.Edit5Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit5.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[5].train:=trains[5].nom_train;
  placement[5].detecteur:=i;
end;

procedure TFormPlace.Edit6Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit6.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[6].train:=trains[6].nom_train;
  placement[6].detecteur:=i;
end;

procedure TFormPlace.Button1Click(Sender: TObject);
begin
  formconfig.PageControl.ActivePage:=formconfig.TabSheetTrains;
  formconfig.showmodal;
  formconfig.Close;
end;

procedure TFormPlace.ButtonSauveClick(Sender: TObject);
begin
  sauve_config;
end;

procedure TFormPlace.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

procedure TFormPlace.ButtonLanceRoutageClick(Sender: TObject);
var i,j,adrDet,AdrTrain : integer;
    trouve : boolean;
begin
  if cdm_connecte then
  begin
    Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;

  trouve:=false;
  for i:=1 to NDetecteurs do
  begin
    adrDet:=Adresse_detecteur[i];
    if Detecteur[adrDet].etat and (detecteur[adrDet].train<>'') then
    begin
      Affiche('Lancement du train '+detecteur[adrDet].train+' depuis détecteur '+intToSTR(adrDet),clYellow);
      AdrTrain:=detecteur[AdrDet].AdrTrain;
      j:=index_train_adresse(AdrTrain);
      vitesse_loco('',adrTrain,trains[j].VitNominale,not(placement[j].inverse));
      trouve:=true;
      roulage:=true;
      maj_feux;
      reserve_canton(AdrDet,placement[j].detdir,adrtrain);

    end;
  end;
  if trouve then
  begin
    Maj_feux;
    Formprinc.LabelTitre.caption:=titre+' - Mode roulage en cours';
  end;
  if not(trouve) then Affiche('Pas de train placé',clOrange);
end;

procedure TFormPlace.ButtonArretroutageClick(Sender: TObject);
var i : integer;
begin
  roulage:=false;
  Affiche('Arrêt du roulage de tous les trains',clorange);
  Formprinc.LabelTitre.caption:=titre+' ';
  for i:=1 to ntrains do
    vitesse_loco('',trains[i].adresse,0,true);
end;

procedure TFormPlace.CheckInverse1Click(Sender: TObject);
begin
  placement[1].inverse:=CheckInverse1.Checked;
end;

procedure TFormPlace.CheckInverse2Click(Sender: TObject);
begin
  placement[2].inverse:=CheckInverse2.Checked;
end;

procedure TFormPlace.CheckInverse3Click(Sender: TObject);
begin
  placement[3].inverse:=CheckInverse3.Checked;
end;

procedure TFormPlace.CheckInverse4Click(Sender: TObject);
begin
  placement[4].inverse:=CheckInverse4.Checked;
end;

procedure TFormPlace.CheckInverse5Click(Sender: TObject);
begin
  placement[5].inverse:=CheckInverse4.Checked;
end;

procedure TFormPlace.CheckInverse6Click(Sender: TObject);
begin
  placement[6].inverse:=CheckInverse6.Checked;
end;

procedure TFormPlace.EditDir1Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir1.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[1].detdir:=i;
end;

procedure TFormPlace.EditDir2Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir2.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[2].detdir:=i;
end;

procedure TFormPlace.EditDir3Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir3.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[3].detdir:=i;
end;



procedure TFormPlace.EditDir4Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir4.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[4].detdir:=i;
end;

procedure TFormPlace.EditDir5Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir5.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[5].detdir:=i;
end;

procedure TFormPlace.EditDir6Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir6.Text,i,erreur);
  if erreur<>0 then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[6].detdir:=i;
end;

end.
