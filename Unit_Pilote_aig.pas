unit Unit_Pilote_aig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UnitPrinc, UnitTCO;

type
  TFormAig = class(TForm)
    ButtonOK: TButton;
    Label1: TLabel;
    ButtonDev: TButton;
    ButtonDroit: TButton;
    ButtonDev2: TButton;
    ButtonDroit2: TButton;
    LabelAdr1: TLabel;
    LabelAdr2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ButtonDevClick(Sender: TObject);
    procedure ButtonDroitClick(Sender: TObject);
    procedure ButtonDev2Click(Sender: TObject);
    procedure ButtonDroit2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormAig: TFormAig;
  aiguille,aiguille2 : integer;
  tjdC,aigC : boolean;
implementation

{$R *.dfm}

procedure commande_simple;
var i : integer;
begin
  with formAig do
  begin
    LabelAdr2.Visible:=false;
    LabelAdr1.Visible:=false;
    ButtonDev2.Visible:=false;
    ButtonDroit2.Visible:=false;
    ButtonOk.Visible:=true;
    buttonDev.Visible:=true;
    buttonDroit.Visible:=true;

    ButtonDev.Left:=48;
    ButtonDroit.Left:=216;

    i:=Index_aig(Aiguille);
    i:=aiguillage[i].position;
    if i=const_devie then
    begin
      buttonDev.SetFocus;
    end;
    if i=const_droit then
    begin
      buttonDroit.SetFocus;
    end;

  end;
end;

// activation de la form, l'aiguillage à piloter est dans la variable globale "Aiguille"
procedure TFormAig.FormActivate(Sender: TObject);
var i : integer;
    s : string;
begin
  i:=Index_aig(Aiguille);
  if aiguillage[i].AdrTrain<>0 then
  begin
    tjdC:=(aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs);
    if tjdC then s:='Pilotage de la TJD/S '+intToSTR(aiguille) else s:='Pilotage de l''aiguillage '+intToSTR(aiguille);
    Label1.Caption:=s;
    if tjdC then s:='La TJD/S '+intToSTR(aiguille)+' est réservée ' else s:='L''aiguillage '+intToSTR(aiguille)+' est réservé ';
    labelAdr1.caption:=s+'par le train '+intToSTR(aiguillage[i].AdrTrain);
    labelAdr1.Visible:=true;
    buttonDev.Visible:=false;
    buttonDroit.Visible:=false;
    buttonDev2.Visible:=false;
    buttonDroit2.Visible:=false;
    LabelAdr2.Visible:=false;
    if diffusion then exit;   
  end;

  aigC:=(aiguillage[i].modele=aig);
  tjdC:=(aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs);
  if aigC then
  begin
    s:='Pilotage de l''aiguillage '+intToSTR(aiguille);
    commande_simple;
  end;
  if tjdC then
  begin
    s:='Pilotage de la TJD '+intToSTR(aiguille);

    if aiguillage[i].EtatTJD=4 then
    begin
      LabelAdr1.Caption:='Adresse1: '+intToSTR(aiguille);
      aiguille2:=aiguillage[i].DDevie;
      LabelAdr2.Caption:='Adresse2: '+intToSTR(aiguille2);
      s:=s+'/'+intToSTR(aiguille2);
      LabelAdr2.Visible:=true;
      LabelAdr1.Visible:=true;
      ButtonDev2.Visible:=true;
      ButtonOk.Visible:=true;
      ButtonDroit2.Visible:=true;
      ButtonDev.Left:=8;
      ButtonDroit.Left:=88;

      buttonDroit.Visible:=true;
      buttonDev.Visible:=true;

    end;
  end;
  if aiguillage[i].EtatTJD=2 then
  begin
    commande_simple;
  end;

  Label1.Caption:=s;
end;

procedure TFormAig.ButtonDevClick(Sender: TObject);
var s : string;
begin
  efface_entoure(indexTCOCourant);
  SelectionAffichee[indexTCOCourant]:=false;
  pilote_acc(aiguille,const_devie,aigP);
  s:='accessoire '+IntToSTR(aiguille)+' dévié';
  Affiche(s,clyellow);
  if AigC then close;
end;

procedure TFormAig.ButtonDroitClick(Sender: TObject);
var s : string;
begin
  efface_entoure(indexTCOcourant);
  SelectionAffichee[indexTCOcourant]:=false;
  pilote_acc(aiguille,const_droit,aigP);
  s:='accessoire '+IntToSTR(aiguille)+' droit';
  Affiche(s,clyellow);
  if AigC then close;
end;

procedure TFormAig.ButtonDev2Click(Sender: TObject);
var s : string;
begin
  efface_entoure(indexTCOcourant);
  SelectionAffichee[indexTCOcourant]:=false;
  pilote_acc(aiguille2,const_devie,aigP);
  s:='accessoire '+IntToSTR(aiguille2)+' dévié';
  Affiche(s,clyellow);
  if AigC then close;
end;

procedure TFormAig.ButtonDroit2Click(Sender: TObject);
var s : string;
begin
  efface_entoure(indexTCOCOurant);
  SelectionAffichee[indexTCOcourant]:=false;
  pilote_acc(aiguille2,const_droit,aigP);
  s:='accessoire '+IntToSTR(aiguille2)+' droit';
  Affiche(s,clyellow);
  if AigC then close;
end;

procedure TFormAig.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

begin




end.
