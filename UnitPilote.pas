unit UnitPilote;

// cette unité stocke l'état du signal de pilotage dans l'index 0 du tableau EtatSignalcplx

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UnitPrinc,
  jpeg;

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
    LabelDec: TLabel;
    Label1: TLabel;
    CheckVerrouCarre: TCheckBox;
    GroupBox3: TGroupBox;
    CheckChiffre: TCheckBox;
    CheckChevron: TCheckBox;
    CheckClignote: TCheckBox;
    ImageSignaux: TImage;
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
    procedure FormActivate(Sender: TObject);
    procedure CheckVerrouCarreClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CheckChiffreClick(Sender: TObject);
    procedure CheckChevronClick(Sender: TObject);
    procedure CheckClignoteClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

// code des aspects des signaux
const

carre            =0 ; carre_F=1;
semaphore        =1 ; semaphore_F=2;
semaphore_cli    =2 ; semaphore_cli_F=4;
vert             =3 ; vert_F=8;
vert_cli         =4 ; vert_cli_F=16;
violet           =5 ; violet_F=32;
blanc            =6 ; blanc_F=64;
blanc_cli        =7 ; blanc_cli_F=128;
jaune            =8 ; jaune_F=256;
jaune_cli        =9 ; jaune_cli_F=512;
ral_30           =10; ral_30_F=1024;
ral_60           =11; ral_60_F=2048;
rappel_30        =12; rappel_30_F=4096;
rappel_60        =13; rappel_60_F=8192;
Disque_D         =14; // pour décodeur LDT
ral_60_jaune_cli =15;ral_60_jaune_cli_F=32768; // pour décodeur LDT
aspect8          =16 ;

// signal belge
// base
vert_jaune_H     =0 ; vert_jaune_H_F=1; // signal belge
rouge            =1 ; rouge_F=2;
vertB            =2 ; vertB_F=4;
vert_jaune_V     =3 ; vert_jaune_V_F=8;
rouge_blanc      =4 ; rouge_blanc_F=16; // signal belge
deux_jaunes      =5 ; deux_jaunes_F=32; // signal belge
// combinée
chiffre          =6; chiffre_F=64;
chevron          =7; chevron_F=128;
clignote         =8; clignote_F=256;
Bita1           =15; Bita1_F=32768; // mise à 1 de bit signal combiné pour belge

var
  FormPilote: TFormPilote;
  EtatFeuPilote : word;
  AdrPilote : integer;

procedure dessine_feu_pilote;

implementation

{$R *.dfm}

procedure dessine_feu_pilote;
var i,ancienEtat : integer;
    Vcanvas : Tcanvas;
begin
  i:=Index_Signal(AdrPilote);    // adresse du feu d'origine
  if i<>0 then

  //ImagePilote.Picture.Bitmap:=FormPilote.ImagePilote.picture.bitmap;
  EtatFeuPilote:=Signaux[0].EtatSignal;
  AncienEtat:=Signaux[0].ancienEtat;
  Vcanvas:=FormPilote.ImagePilote.picture.bitmap.Canvas;

  case Signaux[i].aspect of
  // feux de signalisation
   2 : dessine_signal2(Vcanvas,0,0,1,1,EtatFeupilote,1);
   3 : dessine_signal3(Vcanvas,0,0,1,1,EtatFeupilote,AncienEtat,1);
   4 : dessine_signal4(VCanvas,0,0,1,1,EtatFeupilote,1);
   5 : dessine_signal5(VCanvas,0,0,1,1,EtatFeupilote,1);
   7 : dessine_signal7(VCanvas,0,0,1,1,EtatFeupilote,1);
   9 : dessine_signal9(VCanvas,0,0,1,1,EtatFeupilote,1);
  20 : dessine_signal20(VCanvas,0,0,1,1,EtatFeupilote,1,Signaux[i].adresse);
  // indicateurs de direction
  12 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,2);
  13 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,3);
  14 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,4);
  15 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,5);
  16 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,6);
  end;
end;

// renvoie la nation du signal 0
function nation : integer;
var i,dec,asp : integer;
begin
  i:=1;
  dec:=Signaux[0].decodeur;
  asp:=Signaux[0].aspect;
  if asp=20 then i:=2;
  // si décodeur personalisé
  if (dec>=NbDecodeurdeBase) and (dec<NbDecodeurdeBase+NbreDecPers) then
  begin
    if decodeur_pers[dec-NbDecodeurdeBase+1].nation=2 then i:=2;
  end;
  result:=i;

end;

procedure TFormPilote.RadioVertClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,vert) else Maj_Etat_Signal(0,vertB) ;
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioVertCliClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,vert_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioJauneClick(Sender: TObject);
begin
    Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,jaune) else Maj_Etat_Signal(0,deux_jaunes);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioJaunecliClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,jaune_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioRougeClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,semaphore);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioRougeCliClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,semaphore_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioCarreClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,carre) else Maj_Etat_Signal(0,vert_jaune_H);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioBlancClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,blanc) else Maj_Etat_Signal(0,rouge_blanc);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioVioletClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,violet) else Maj_Etat_Signal(0,vert_jaune_V);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioBlancCliClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,blanc_cli);
  dessine_feu_pilote;
end;

procedure TFormPilote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Affiche('close',clyellow);
  AdrPilote:=0;  // pour désactiver le test des clignotements
end;

procedure TFormPilote.RadioRalen30Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,ral_30);
  dessine_feu_pilote;
end;


procedure TFormPilote.RadioRappel60Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,rappel_60);
  dessine_feu_pilote;
end;


procedure TFormPilote.RadioRalen60Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,ral_60);
  dessine_feu_pilote;
end;

procedure TFormPilote.RadioRappel30Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,rappel_30);
  dessine_feu_pilote;
end;

procedure TFormPilote.FormCreate(Sender: TObject);
begin
//  radioVert.Checked:=false;
//  radioVertCli.Checked:=false;
end;

procedure TFormPilote.ButtonPiloteClick(Sender: TObject);
var i,index,e : integer;
begin
  index:=index_Signal(AdrPilote);
  if (Signaux[index].aspect>10) and (Signaux[index].aspect<20 )then
  begin
    val(EditNbreFeux.Text,i,e);
    Signaux[0].EtatSignal:=i;
    pilote_direction(AdrPilote,i);
  end;
  Signaux[index].EtatSignal:=Signaux[0].EtatSignal;
  envoi_signal(AdrPilote);
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
        Signaux[0].EtatSignal:=i;
        dessine_feu_pilote;
      end;
      if (i<0) and (i>6) then EditNbreFeux.text:='1';
    end
    else EditNbreFeux.text:='1';
  end;
end;

procedure TFormPilote.FormActivate(Sender: TObject);
var n,i,d : integer;
begin
  // mise à jour du champ décodeur
  i:=Index_Signal(AdrPilote);
  d:=Signaux[i].decodeur;
  n:=Signaux[i].aspect;
  with LabelDec do
  begin
    Caption:=decodeur[d];
    width:=114;
    height:=42;
  end;
  Signaux[0].decodeur:=d;
  Signaux[0].aspect:=n;
  Signaux[0].contrevoie:=Signaux[i].contrevoie;


  // signal belge
  if (n=20) then
  begin
    Radiocarre.Caption:='Vert jaune horizontal';
    Radioviolet.Caption:='Vert jaune vertical';
    RadioJaune.Caption:='Deux jaunes';
    RadioJauneCli.Caption:='Deux jaunes clignotants';
    RadioBlanc.caption:='Rouge Blanc';
    RadioBlancCli.caption:='Rouge Blanc clignotants';
    RadioRouge.caption:='Rouge';

    radiovertcli.visible:=false;
    radioJaunecli.visible:=false;
    radioRougecli.visible:=false;
    radioBlanccli.visible:=false;

    groupBox3.Top:=GroupBox2.Top;
    groupBox3.Left:=GroupBox2.Left;
    groupBox2.Visible:=false;
    groupBox3.Visible:=true;
  end;

  if n<>20 then
  begin
    groupBox3.Visible:=false;
    Radiocarre.Caption:='Carré';
    Radioviolet.Caption:='Violet';
    RadioRouge.Caption:='Sémaphore';
    RadioJauneCli.Caption:='Avertissement clignotant';
    RadioJaune.Caption:='Avertissement';
    RadioBlanc.caption:='Blanc';
    RadioBlancCli.caption:='Blanc clignotant';
    radiovertcli.visible:=true;
    radioJaunecli.visible:=true;
    radioRougecli.visible:=true;
    radioBlanccli.visible:=true;
  end;


  // checkcarré
  if (n<4) or (n>10) then checkVerrouCarre.Visible:=false else
  begin
    checkVerrouCarre.Visible:=false; //true;
    checkVerrouCarre.Checked:=Signaux[i].VerrouCarre;
  end;

  with imagePilote do
  begin
    Parent:=FormPilote;
    Picture.Bitmap.TransparentMode:=tmAuto;
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;
    Picture.BitMap:=Signaux[i].Img.Picture.Bitmap;
    //left:=groupBox1.width+50;
  end;

  LabelTitrePilote.Caption:='Pilotage du signal '+intToSTR(AdrPilote);
  Signaux[0].EtatSignal:=Signaux[i].EtatSignal;

  if (Signaux[i].aspect>10) and (Signaux[i].aspect<20) then
  begin
    // signaux directionnels
    GroupBox1.Visible:=false;
    GroupBox2.Visible:=false;
    LabelNbFeux.Visible:=true;
    EditNbreFeux.Visible:=true;
    EditNbreFeux.Text:='1';
  end
  else
  begin
    LabelNbFeux.Visible:=False;
    EditNbreFeux.Visible:=false;
    GroupBox1.Visible:=true;
    if (Signaux[i].aspect<10) then GroupBox2.Visible:=true else GroupBox2.Visible:=false;
  end;

  radioVert.Checked:=false;
  radioVertCli.Checked:=false;
  radioJaune.Checked:=false;
  radioJauneCli.Checked:=false;
  radioRouge.Checked:=false;
  radioRougeCli.Checked:=false;
  radiocarre.Checked:=false;
  radioBlanc.Checked:=false;
  radioViolet.Checked:=false;
  radioRalen30.Checked:=false;
  radioRappel30.Checked:=false;
  radioRalen60.Checked:=false;
  radioRappel60.Checked:=false;
  CheckChiffre.Checked:=false;
  CheckChevron.Checked:=false;
  CheckClignote.Checked:=false;
end;

procedure TFormPilote.CheckVerrouCarreClick(Sender: TObject);
var i : integer;
begin
  i:=Index_Signal(AdrPilote);
  if Signaux[i].VerrouCarre then
  begin
    Signaux[i].EtatVerrouCarre:=checkVerrouCarre.Checked=true;
    Maj_Etat_Signal(AdrPilote,carre);
    envoi_signal(Adrpilote);
    Maj_Etat_Signal(0,carre);
    dessine_feu_pilote;
  end;
end;

procedure TFormPilote.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

procedure TFormPilote.CheckChiffreClick(Sender: TObject);
begin
  if checkChiffre.Checked then Maj_Etat_Signal_belge(0,chiffre_F or bita1_F) else Maj_Etat_Signal_belge(0,chiffre_F);
  dessine_feu_pilote;
end;

procedure TFormPilote.CheckChevronClick(Sender: TObject);
begin
  if checkChevron.Checked then Maj_Etat_Signal(0,chevron_F or bita1_F) else Maj_Etat_Signal(0,chevron_F );
  dessine_feu_pilote;
end;

procedure TFormPilote.CheckClignoteClick(Sender: TObject);
begin
  if checkclignote.Checked then Maj_Etat_Signal(0,clignote_F or bita1_F) else Maj_Etat_Signal(0,clignote_F );
  dessine_feu_pilote;
end;

begin
end.
