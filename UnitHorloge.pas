unit UnitHorloge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unitPrinc, ComCtrls, jpeg, ExtCtrls, Spin ;

type
  TFormHorloge = class(TForm)
    GroupBox1: TGroupBox;
    RadioButtonHS: TRadioButton;
    RadioButtonHI: TRadioButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ButtonOk: TButton;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    EditMInit: TEdit;
    Label4: TLabel;
    TrackBarTemps: TTrackBar;
    LabelDuree: TLabel;
    ImageHorloge: TImage;
    ButtonInit: TButton;
    LabelErreur: TLabel;
    Label5: TLabel;
    EditRetourHeure: TEdit;
    EditRetourMinute: TEdit;
    Label6: TLabel;
    ButtonS: TButton;
    CheckBoxLanceHorl: TCheckBox;
    CheckBoxRedemarre: TCheckBox;
    ButtonAh: TButton;
    CheckBoxAffiche: TCheckBox;
    SpinEditHInit: TSpinEdit;
    ButtonLance: TButton;
    ButtonArrete: TButton;
    procedure ButtonOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TrackBarTempsChange(Sender: TObject);
    procedure ButtonInitClick(Sender: TObject);
    procedure EditMInitChange(Sender: TObject);
    procedure RadioButtonHSClick(Sender: TObject);
    procedure RadioButtonHIClick(Sender: TObject);
    procedure EditRetourHeureChange(Sender: TObject);
    procedure EditRetourMinuteChange(Sender: TObject);
    procedure ButtonSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxLanceHorlClick(Sender: TObject);
    procedure CheckBoxRedemarreClick(Sender: TObject);
    procedure ButtonAhClick(Sender: TObject);
    procedure CheckBoxAfficheClick(Sender: TObject);
    procedure SpinEditHInitChange(Sender: TObject);
    procedure ButtonLanceClick(Sender: TObject);
    procedure ButtonArreteClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormHorloge: TFormHorloge;
  heure,minute,seconde,comptsec,DureeMinute,CompteurDixiemes,HeureInit,MinuteInit,
  RetourHeure,RetourMinute,Asec : integer;
  horlogeInterne,horloge,relanceHorl_init,AffHorl : boolean;

procedure Init_Horloge;
procedure Demarre_horloge;

implementation

uses unitconfig, UnitClock, UnitFicheHoraire;

{$R *.dfm}

procedure valide_hi;
begin
  with formHorloge do
  begin
    GroupBox3.Enabled:=true;
    GroupBox2.Enabled:=true;
    SpinEditHinit.Enabled:=true;
    editMinit.Enabled:=true;
    ButtonInit.Enabled:=true;
    TrackBarTemps.Enabled:=true;
    EditRetourHeure.Enabled:=true;
    EditRetourMinute.Enabled:=true;
  end;
end;

procedure devalide_hi;
begin
  with formHorloge do
  begin
    GroupBox3.Enabled:=false;
    GroupBox2.Enabled:=false;
    SpinEditHinit.Enabled:=false;
    editMinit.Enabled:=false;
    ButtonInit.Enabled:=false;
    TrackBarTemps.Enabled:=false;
    EditRetourHeure.Enabled:=false;
    EditRetourMinute.Enabled:=false;
  end;
end;

procedure TFormHorloge.ButtonOkClick(Sender: TObject);
begin
  close;
end;

// démarre l'horloge de façon synchrone à l'horloge windows
procedure Demarre_horloge;
var h,m,sec,ms : word;
begin
  decodeTime(GetTime,h,m,sec,ms);
  comptSec:=ms div 100;
  if comptsec>9 then comptsec:=0;
  horloge:=true;
end;

procedure TFormHorloge.FormActivate(Sender: TObject);
begin
  if formHorloge=nil then exit;

  if horlogeinterne then
  begin
    valide_hi;
  end
  else
  begin
    devalide_hi;
  end;
end;


procedure TFormHorloge.TrackBarTempsChange(Sender: TObject);
begin
  //DureeMinute:=TrackBarTemps.position;
  //if (DureeMinute<1) or (DureeMinute>60) then DureeMinute:=30;
  //LabelDuree.caption:=intToSTR(6*(DureeMinute*5) div 30);

  CompteurDixiemes:=TrackBarTemps.position;

  DureeMinute:=CompteurDixiemes;       // variable de sauvegarde
  LabelDuree.caption:=intToSTR(6*CompteurDixiemes);
end;

procedure Init_Horloge;
var i : integer;
begin
  heure:=HeureInit;
  minute:=MinuteInit;
  seconde:=0;
  if clock<>nil then clock.DrawArrows;
  FormPrinc.labelClock.Caption:=format('%.2dh%.2d:%.2d',[heure,minute,seconde] );
  if formFicheHoraire<>nil then
  begin
    for i:=1 to Nombre_horaires do
      FormFicheHoraire.StringGridFO.Cells[1,i]:=GrilleHoraire[i].NomTrain;
  end;
end;

procedure TFormHorloge.ButtonInitClick(Sender: TObject);
begin
  init_horloge;
end;



procedure TFormHorloge.EditMInitChange(Sender: TObject);
var i,erreur : integer;
begin
  val(editMInit.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>60) then
  begin
    LabelErreur.Caption:='Erreur minute';
    exit;
  end;
  LabelErreur.Caption:='';
  MinuteInit:=i;
  config_modifie:=true;
end;

procedure TFormHorloge.RadioButtonHSClick(Sender: TObject);
begin
  horlogeInterne:=false;
  devalide_hi;
  config_modifie:=true;
end;

procedure TFormHorloge.RadioButtonHIClick(Sender: TObject);
begin
  horlogeInterne:=true;
  valide_hi;
  config_modifie:=true;
end;

procedure TFormHorloge.EditRetourHeureChange(Sender: TObject);
var i,erreur : integer;
begin
  val(editRetourHeure.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>23) then
  begin
    LabelErreur.Caption:='Erreur heure init';
    exit;
  end;
  LabelErreur.Caption:='';
  RetourHeure:=i;
  config_modifie:=true;
end;

procedure TFormHorloge.EditRetourMinuteChange(Sender: TObject);
var i,erreur : integer;
begin
  val(editRetourMinute.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>60) then
  begin
    LabelErreur.Caption:='Erreur retour minute';
    exit;
  end;
  LabelErreur.Caption:='';
  RetourMinute:=i;
  config_modifie:=true;
end;

procedure TFormHorloge.ButtonSClick(Sender: TObject);
begin
  sauve_config;
end;

procedure couleurs_horloge;
var c : tcomponent;
    i : integer;
    fond,texte : tColor;
begin
  if Modesombre then
  begin
    fond:=couleurFond;
    texte:=couleurTexte;

    formHorloge.Color:=fond;
    for i:=0 to formHorloge.ComponentCount-1 do
    begin
      c:=formHorloge.Components[i];
      //Affiche(c.Name,clyellow);
      composant(c,fond,texte);
    end;
  end;
end;

procedure TFormHorloge.FormCreate(Sender: TObject);
begin
  CompteurDixiemes:=DureeMinute;
  couleurs_horloge;
  TrackBarTemps.position:=DureeMinute;
  
  RadioButtonHI.Checked:=horlogeInterne;
  RadioButtonHS.Checked:=not(horlogeInterne);
  CheckBoxLanceHorl.Checked:=LanceHorl;
  CheckBoxAffiche.checked:=AffHorl;
  CheckBoxRedemarre.Checked:=relanceHorl_init;
  TrackBarTemps.position:=DureeMinute;
  SpinEditHInit.Text:=intToSTR(HeureInit);
  EditMInit.Text:=intToSTR(MinuteInit);
  EditRetourHeure.Text:=intToSTR(RetourHeure);
  EditRetourMinute.Text:=intToSTR(RetourMinute);
  LabelDuree.caption:=intToSTR(6*CompteurDixiemes);
  config_modifie:=false;

end;

procedure TFormHorloge.CheckBoxLanceHorlClick(Sender: TObject);
begin
  LanceHorl:=CheckBoxLanceHorl.Checked;
  config_modifie:=true;
end;

procedure TFormHorloge.CheckBoxRedemarreClick(Sender: TObject);
begin
  relanceHorl_init:=CheckBoxRedemarre.checked;
  config_modifie:=true;
end;

procedure TFormHorloge.ButtonAhClick(Sender: TObject);
begin
  formClock.Show;
end;

procedure TFormHorloge.CheckBoxAfficheClick(Sender: TObject);
begin
  AffHorl:=CheckBoxAffiche.checked;
end;

procedure TFormHorloge.SpinEditHInitChange(Sender: TObject);
var i,erreur : integer;
begin
  val(spinEditHInit.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>23) then
  begin
    LabelErreur.Caption:='Erreur heure';
    SpinEditHInit.value:=0;
    exit;
  end;
  SpinEditHInit.Value:=i;
  LabelErreur.Caption:='';
  HeureInit:=i;
  config_modifie:=true;
end;

procedure TFormHorloge.ButtonLanceClick(Sender: TObject);
begin
  Demarre_horloge;
end;

procedure TFormHorloge.ButtonArreteClick(Sender: TObject);
begin
  horloge:=false;
end;

end.
