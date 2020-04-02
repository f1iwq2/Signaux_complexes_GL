unit UnitPilote;

// cet unité utilise stocke l'état du signal de pilotage dans l'index 0 du tableau EtatSignalcplx 

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UnitPrinc;

type
  TFormPilote = class(TForm)
    LabelTitrePilote: TLabel;
    ImagePilote: TImage;
    GroupBox1: TGroupBox;
    RadioVert: TRadioButton;
    RadioVertCli: TRadioButton;
    RadioJaune: TRadioButton;
    RadioJaunecli: TRadioButton;
    RadioRouge: TRadioButton;
    RadioRougeCli: TRadioButton;
    RadioCarre: TRadioButton;
    RadioBlanc: TRadioButton;
    RadioBlancCli: TRadioButton;
    RadioViolet: TRadioButton;
    GroupBox2: TGroupBox;
    RadioRalen30: TRadioButton;
    RadioRappel30: TRadioButton;
    RadioRalen60: TRadioButton;
    RadioRappel60: TRadioButton;
    ButtonPilote: TButton;
    EditNbreFeux: TEdit;
    LabelNbFeux: TLabel;
    procedure RadioVertClick(Sender: TObject);
    procedure RadioVertCliClick(Sender: TObject);
    procedure RadioJauneClick(Sender: TObject);
    procedure RadioJaunecliClick(Sender: TObject);
    procedure RadioRougeClick(Sender: TObject);
    procedure RadioRougeCliClick(Sender: TObject);
    procedure RadioCarreClick(Sender: TObject);
    procedure RadioBlancClick(Sender: TObject);
    procedure RadioVioletClick(Sender: TObject);
    procedure RadioBlancCliClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioRalen30Click(Sender: TObject);
    procedure RadioRappel60Click(Sender: TObject);
    procedure RadioRalen60Click(Sender: TObject);
    procedure RadioRappel30Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonPiloteClick(Sender: TObject);
    procedure EditNbreFeuxKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

// définition des adresses normalisées du décodeur de leds de digitalBahn
//    l'ordre des adresses est à respecter dans la programation des signaux.
//    L'oeilleton est cablé sur la sortie 4, il est géré directement par le décodeur. **/
// code des aspects des signaux
const

carre          =0 ; carre_F=1;
semaphore      =1 ; semaphore_F=2;
semaphore_cli  =2 ; semaphore_cli_F=4;
vert           =3 ; vert_F=8;
vert_cli       =4 ; vert_cli_F=16;
violet         =5 ; violet_F=32;
blanc          =6 ; blanc_F=64;
blanc_cli      =7 ; blanc_cli_F=128;
jaune          =8 ; jaune_F=256;
jaune_cli      =9 ; jaune_cli_F=512;
ral_30         =10; ral_30_F=1024;
ral_60         =11; ral_60_F=2048;
rappel_30      =12; rappel_30_F=4096;
rappel_60      =13; rappel_60_F=8192;
Disque_D       =14; // pour décodeur LDT
ral_60_jaune_cli =15;ral_60_jaune_cli_F=16384; // pour décodeur LDT
aspect8        =16 ;

  
var
  FormPilote: TFormPilote;
  EtatFeuPilote : word;
  AdrPilote : integer;
  
procedure dessine_feu_pilote;

implementation

{$R *.dfm}

procedure dessine_feu_pilote;
var i : integer;
    Vcanvas : Tcanvas;
begin
  i:=Index_feu(AdrPilote);    // adresse du feu d'origine
  if i<>0 then
  
  //ImagePilote.Picture.Bitmap:=FormPilote.ImagePilote.picture.bitmap;
  EtatFeuPilote:=EtatSignalCplx[0];
  Vcanvas:=FormPilote.ImagePilote.picture.bitmap.Canvas;
  
  case feux[i].aspect of
  // feux de signalisation
   2 : dessine_feu2(Vcanvas,0,0,1,1,EtatFeupilote,1);
   3 : dessine_feu3(Vcanvas,0,0,1,1,EtatFeupilote,1);
   4 : dessine_feu4(VCanvas,0,0,1,1,EtatFeupilote,1);
   5 : dessine_feu5(VCanvas,0,0,1,1,EtatFeupilote,1);
   7 : dessine_feu7(VCanvas,0,0,1,1,EtatFeupilote,1);
   9 : dessine_feu9(VCanvas,0,0,1,1,EtatFeupilote,1);
  // indicateurs de direction
  12 : dessine_dir2(VCanvas,EtatFeupilote);
  13 : dessine_dir3(VCanvas,EtatFeupilote);
  14 : dessine_dir4(VCanvas,EtatFeupilote);
  15 : dessine_dir5(VCanvas,EtatFeupilote);
  16 : dessine_dir6(VCanvas,EtatFeupilote);
  end;
end;

procedure TFormPilote.RadioVertClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,vert);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioVertCliClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,vert_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioJauneClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,jaune);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioJaunecliClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,jaune_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioRougeClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,semaphore);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioRougeCliClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,semaphore_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioCarreClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,carre);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioBlancClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,blanc);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioVioletClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,violet);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioBlancCliClick(Sender: TObject);
begin
  Maj_Etat_Signal(0,blanc_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AdrPilote:=0;  // pour désactiver le test des clignotements
end;

procedure TFormPilote.RadioRalen30Click(Sender: TObject);
begin
  Maj_Etat_Signal(0,ral_30);
  dessine_feu_pilote;
end;


procedure TFormPilote.RadioRappel60Click(Sender: TObject);
begin
  Maj_Etat_Signal(0,rappel_60);
  dessine_feu_pilote;
end;


procedure TFormPilote.RadioRalen60Click(Sender: TObject);
begin
  Maj_Etat_Signal(0,ral_60);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioRappel30Click(Sender: TObject);
begin
  Maj_Etat_Signal(0,rappel_30);
  dessine_feu_pilote;
end;

procedure TFormPilote.FormCreate(Sender: TObject);
var i : integer;
begin
   radioVert.Checked:=false;
   radioVertCli.Checked:=false;
   i:=index_feu(AdrPilote);
   
end;

procedure TFormPilote.ButtonPiloteClick(Sender: TObject);
var i,e : integer;
begin
  i:=index_feu(AdrPilote);
  if feux[i].aspect<10 then
  begin
    EtatSignalCplx[AdrPilote]:=EtatSignalCplx[0];
    //Affiche(IntToSTR(EtatSignalCplx[AdrPilote]),clyellow);
    envoi_signal(AdrPilote);
  end
  else
    begin
      val(EditNbreFeux.Text,i,e);
      pilote_direction(AdrPilote,i);
    end;
end;

procedure TFormPilote.EditNbreFeuxKeyPress(Sender: TObject; var Key: Char);
var i,e : integer;
begin
if ord(Key) = VK_RETURN then
  begin
    Key := #0; // prevent beeping
    val(EditNbreFeux.text,i,e);
    if e=0 then
    begin
      if (i>=0) and (i<=6) then
      begin
        EtatSignalCplx[0]:=i;
        dessine_feu_pilote;
      end;

      if (i<0) and (i>6) then EditNbreFeux.text:='1';
    end
    else EditNbreFeux.text:='1';
  end;
end;


end.
