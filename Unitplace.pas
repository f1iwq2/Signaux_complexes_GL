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
var i : integer;
begin
  LabelTrain1.Caption:=trains[1].nom_train;
  Edit1.text:=intToSTR(placement[1].detecteur);
  LabelTrain2.Caption:=trains[2].nom_train;
  Edit2.text:=intToSTR(placement[2].detecteur);
  LabelTrain3.Caption:=trains[3].nom_train;
  Edit3.text:=intToSTR(placement[3].detecteur);
  LabelTrain4.Caption:=trains[4].nom_train;
  Edit4.text:=intToSTR(placement[4].detecteur);
  LabelTrain5.Caption:=trains[5].nom_train;
  Edit5.text:=intToSTR(placement[5].detecteur);
  LabelTrain6.Caption:=trains[6].nom_train;
  Edit6.text:=intToSTR(placement[6].detecteur);
end;

procedure TFormPlace.ButtonPlaceClick(Sender: TObject);
var detect,erreur : integer;
    s : string;
begin
  if cdm_connecte then
  begin
    Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
    exit;
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
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect),clLime);
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
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect),clLime);
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
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect),clLime);
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
      detecteur[detect].adrTrain:=trains[4].adresse;
      event_detecteur(detect,true,trains[4].nom_train);
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect),clLime);
    end
    else
    begin
      detecteur[detect].etat:=false;
      detecteur[detect].train:='';
      detecteur[detect].adrTrain:=0;
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
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect),clLime);
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
      Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect),clLime);
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
      vitesse_loco('',adrTrain,trains[j].VitNominale,true);
      trouve:=true;
    end;
  end;
  if not(trouve) then Affiche('Pas de train placé',clOrange);
end;

procedure TFormPlace.ButtonArretroutageClick(Sender: TObject);
var i : integer;
begin
  roulage:=false;
  Affiche('Arrêt du roulage de tous les trains',clorange);
  for i:=1 to ntrains do
    vitesse_loco('',trains[i].adresse,0,true);
end;

end.
