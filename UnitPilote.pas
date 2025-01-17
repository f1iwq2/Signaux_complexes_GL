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

// décodeur LEB
carreLEB=1;
VioletLEB=2;
SemaphoreLEB=3;
avertissementLEB=4;
BlancLeb=5;
VoieLibreLEB=6;
rougeCliLEB=7;
jauneCliLEB=8;
blancCliLEB=9;
vertCliLEB=10;
Rappel30LEB=11;
Rappel60LEB=12;
AvertissementRappel30LEB=13;
JauneCliRappel30LEB=14;
AvertissementRappel60LEB=15;
JaunecliRappel60LEB=16;
Ralen30LEB=17;
Ralen60LEB=18;
JauneCliRalen60LEB=19;

var
  FormPilote: TFormPilote;
  EtatFeuPilote : word;
  AdrPilote : integer;
  tableLEB : array[1..41,1..19] of
     record
       offset,       // offset en mode linéaire
       sortie,       // numéro de sortie en mode linéaire
       code          // code de pilotage en mode binaire
       : integer;
     end;

procedure dessine_signal_pilote;
procedure couleurs_pilote;

implementation

{$R *.dfm}

procedure dessine_signal_pilote;
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
   2 : dessine_signal2(Vcanvas,0,0,1,1,EtatFeupilote,1,i);
   3 : dessine_signal3(Vcanvas,0,0,1,1,EtatFeupilote,1,i);
   4 : dessine_signal4(VCanvas,0,0,1,1,EtatFeupilote,1,i);
   5 : dessine_signal5(VCanvas,0,0,1,1,EtatFeupilote,1,i);
   7 : dessine_signal7(VCanvas,0,0,1,1,EtatFeupilote,1,i);
   9 : dessine_signal9(VCanvas,0,0,1,1,EtatFeupilote,1,i);
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

procedure Raz_combine;
begin
  with FormPilote do
  begin
    RadioRalen30.checked:=false;
    RadioRappel30.checked:=false;
    RadioRalen60.checked:=false;
    RadioRappel60.checked:=false;
  end;
end;

procedure Raz_Base;
begin
  with FormPilote do
  begin
    RadioVert.checked:=false;
    RadioVertCli.checked:=false;
    RadioRouge.checked:=false;
    RadioRougeCli.checked:=false;
    RadioCarre.checked:=false;
    RadioBlanc.checked:=false;
    RadioBlancCli.checked:=false;
    RadioViolet.checked:=false;
  end;
end;


procedure TFormPilote.RadioVertClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,vert) else Maj_Etat_Signal(0,vertB) ;
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioVertCliClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,vert_cli);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioJauneClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  RadioRalen30.Checked:=false;
  RadioRalen60.Checked:=false;
  if nation=1 then Maj_Etat_Signal(0,jaune) else Maj_Etat_Signal(0,deux_jaunes);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioJaunecliClick(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  RadioRalen30.Checked:=false;
  Maj_Etat_Signal(0,jaune_cli);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioRougeClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,semaphore);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioRougeCliClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,semaphore_cli);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioCarreClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,carre) else Maj_Etat_Signal(0,vert_jaune_H);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioBlancClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,blanc) else Maj_Etat_Signal(0,rouge_blanc);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioVioletClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  if nation=1 then Maj_Etat_Signal(0,violet) else Maj_Etat_Signal(0,vert_jaune_V);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioBlancCliClick(Sender: TObject);
begin
  Raz_combine;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,blanc_cli);
  dessine_signal_pilote;
end;

procedure TFormPilote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Affiche('close',clyellow);
  AdrPilote:=0;  // pour désactiver le test des clignotements
end;

procedure TFormPilote.RadioRalen30Click(Sender: TObject);
begin
  Raz_Base;
  RadioJaune.Checked:=false;
  RadioJauneCli.Checked:=false;
  RadioBlanc.checked:=false;
  RadioBlancCli.checked:=false;
  RadioViolet.checked:=false;
  RadioRouge.checked:=false;
  RadioRougeCli.checked:=false;
  RadioVert.Checked:=false;
  RadioVertCli.Checked:=false;
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  Maj_Etat_Signal(0,ral_30);
  dessine_signal_pilote;
end;


procedure TFormPilote.RadioRappel60Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  RadioBlanc.checked:=false;
  RadioBlancCli.checked:=false;
  RadioViolet.checked:=false;
  RadioRouge.checked:=false;
  RadioRougeCli.checked:=false;
  RadioVert.Checked:=false;
  RadioVertCli.Checked:=false;
  Maj_Etat_Signal(0,rappel_60);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioRalen60Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  RadioJaune.Checked:=false;
  RadioBlanc.checked:=false;
  RadioBlancCli.checked:=false;
  RadioViolet.checked:=false;
  RadioRouge.checked:=false;
  RadioRougeCli.checked:=false;
  RadioVert.Checked:=false;
  RadioVertCli.Checked:=false;
  Maj_Etat_Signal(0,ral_60);
  dessine_signal_pilote;
end;

procedure TFormPilote.RadioRappel30Click(Sender: TObject);
begin
  Signaux[0].AncienEtat:=Signaux[0].EtatSignal;
  RadioBlanc.checked:=false;
  RadioBlancCli.checked:=false;
  RadioViolet.checked:=false;
  RadioRouge.checked:=false;
  RadioRougeCli.checked:=false;
  RadioVert.Checked:=false;
  RadioVertCli.Checked:=false;
  Maj_Etat_Signal(0,rappel_30);
  dessine_signal_pilote;
end;

procedure couleurs_pilote;
var i : integer;
    c : tcomponent;
begin
  {$IF CompilerVersion<28.0 }
  if Modesombre then with formPilote do
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;
  {$IFEND}
end;

procedure TFormPilote.FormCreate(Sender: TObject);
begin
  if affevt then affiche('FormPilote create',clLime);
  position:=poMainFormCenter;
  couleurs_pilote;
end;

procedure TFormPilote.ButtonPiloteClick(Sender: TObject);
var i,index,e : integer;
begin
  index:=index_Signal(AdrPilote);
  if isDirectionnel(index) then
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
        dessine_signal_pilote;
      end;
      if (i<0) and (i>6) then EditNbreFeux.text:='1';
    end
    else EditNbreFeux.text:='1';
  end;
end;

procedure TFormPilote.FormActivate(Sender: TObject);
var n,i,d : integer;
begin
  if fermeSC then exit;
  // mise à jour du champ décodeur
  if affevt then affiche('FormPilote activate',clLime);
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

  {
  // checkcarré
  if (n<4) or (n>10) then checkVerrouCarre.Visible:=false else
  begin
    checkVerrouCarre.Visible:=false; //true;
    checkVerrouCarre.Checked:=Signaux[i].VerrouCarre;
  end;
  }
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

  if isDirectionnel(i) then
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
    //Signaux[i].EtatVerrouCarre:=checkVerrouCarre.Checked=true;
    Maj_Etat_Signal(AdrPilote,carre);
    envoi_signal(Adrpilote);
    Maj_Etat_Signal(0,carre);
    dessine_signal_pilote;
  end;
end;

procedure TFormPilote.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

procedure TFormPilote.CheckChiffreClick(Sender: TObject);
begin
  if checkChiffre.Checked then Maj_Etat_Signal_belge(0,chiffre_F or bita1_F) else Maj_Etat_Signal_belge(0,chiffre_F);
  dessine_signal_pilote;
end;

procedure TFormPilote.CheckChevronClick(Sender: TObject);
begin
  if checkChevron.Checked then Maj_Etat_Signal(0,chevron_F or bita1_F) else Maj_Etat_Signal(0,chevron_F );
  dessine_signal_pilote;
end;

procedure TFormPilote.CheckClignoteClick(Sender: TObject);
begin
  if checkclignote.Checked then Maj_Etat_Signal(0,clignote_F or bita1_F) else Maj_Etat_Signal(0,clignote_F );
  dessine_signal_pilote;
end;

// initialisation de l'unité
begin
  // les offsets sont incrémentés tous les 2, on alterne les sorties entre droit et dévié ;
  // offset et sortie sont pour le mode linéaire ; code est pour le mode binaire
  // cible 1 vert rouge
  tableLeb[1,3].offset:=0;  tableLeb[1,3].sortie:=const_droit; tableLeb[1,3].code:=0;// sémaphore
  tableLeb[1,6].offset:=0;  tableLeb[1,6].sortie:=const_devie; tableLeb[1,6].code:=1;// voie libre
  tableLeb[1,7].offset:=1;  tableLeb[1,7].sortie:=const_droit; tableLeb[1,7].code:=2;// rouge cli
  tableLeb[1,10].offset:=1; tableLeb[1,10].sortie:=const_devie;tableLeb[1,10].code:=4; // vert cli

  // cible 2 vert rouge
  tableLeb[2,3].offset:=0;  tableLeb[2,3].sortie:=const_droit; tableLeb[2,3].code:=0; // sémaphore
  tableLeb[2,6].offset:=0;  tableLeb[2,6].sortie:=const_devie; tableLeb[2,6].code:=1;// voie libre
  tableLeb[2,7].offset:=1;  tableLeb[2,7].sortie:=const_droit; tableLeb[2,7].code:=2;// rouge cli
  tableLeb[2,10].offset:=1; tableLeb[2,10].sortie:=const_devie; tableLeb[2,10].code:=4;// vert cli

  // cible 3 vert rouge jaune
  tableLeb[3,3].offset:=0;  tableLeb[3,3].sortie:=const_droit; tableLeb[3,3].code:=0; // sémaphore
  tableLeb[3,4].offset:=0;  tableLeb[3,4].sortie:=const_devie; tableLeb[3,4].code:=1; // avertissement
  tableLeb[3,6].offset:=1;  tableLeb[3,6].sortie:=const_droit; tableLeb[3,6].code:=2; // voie libre
  tableLeb[3,7].offset:=1;  tableLeb[3,7].sortie:=const_devie; tableLeb[3,7].code:=3; // rouge cli
  tableLeb[3,8].offset:=2;  tableLeb[3,8].sortie:=const_droit; tableLeb[3,8].code:=4; // jaune cli
  tableLeb[3,10].offset:=2; tableLeb[3,10].sortie:=const_devie;tableLeb[3,10].code:=5; // vert cli

  // cible 4 blanc violet
  tableLeb[4,2].offset:=0;  tableLeb[4,2].sortie:=const_droit; tableLeb[4,2].code:=0;// violet
  tableLeb[4,5].offset:=0;  tableLeb[4,5].sortie:=const_devie; tableLeb[4,5].code:=1;// blanc
  tableLeb[4,9].offset:=1;  tableLeb[4,9].sortie:=const_droit; tableLeb[4,9].code:=2;// blanc cli

  // cible 5 carré vert
  tableLeb[5,1].offset:=0;  tableLeb[5,1].sortie:=const_droit; tableLeb[5,1].code:=0;// carré
  tableLeb[5,3].offset:=0;  tableLeb[5,3].sortie:=const_devie; tableLeb[5,3].code:=1;// sémaphore
  tableLeb[5,6].offset:=1;  tableLeb[5,6].sortie:=const_droit; tableLeb[5,6].code:=2;// voie libre
  tableLeb[5,7].offset:=1;  tableLeb[5,7].sortie:=const_devie; tableLeb[5,7].code:=3;// rouge cli
  tableLeb[5,10].offset:=2; tableLeb[5,10].sortie:=const_droit; tableLeb[5,10].code:=4;// vert cli

  // cible 6 carré vert jaune
  tableLeb[6,1].offset:=0;  tableLeb[6,1].sortie:=const_droit;tableLeb[6,1].code:=0; // carré
  tableLeb[6,3].offset:=0;  tableLeb[6,3].sortie:=const_devie;tableLeb[6,3].code:=1; // sémaphore
  tableLeb[6,4].offset:=1;  tableLeb[6,4].sortie:=const_droit;tableLeb[6,4].code:=2; // avertissement
  tableLeb[6,6].offset:=1;  tableLeb[6,6].sortie:=const_droit;tableLeb[6,6].code:=3; // voie libre
  tableLeb[6,7].offset:=2;  tableLeb[6,7].sortie:=const_devie;tableLeb[6,7].code:=4; // rouge cli
  tableLeb[6,8].offset:=2;  tableLeb[6,8].sortie:=const_devie;tableLeb[6,8].code:=5; // jaune cli
  tableLeb[6,10].offset:=3; tableLeb[6,10].sortie:=const_droit;tableLeb[6,10].code:=6; // vert cli

  // cible 7 carré vert jaune blanc
  tableLeb[7,1].offset:=0;  tableLeb[7,1].sortie:=const_droit;tableLeb[7,1].code:=0; // carré
  tableLeb[7,3].offset:=0;  tableLeb[7,3].sortie:=const_devie;tableLeb[7,3].code:=2; // sémaphore
  tableLeb[7,4].offset:=1;  tableLeb[7,4].sortie:=const_droit;tableLeb[7,4].code:=3; // avertissement
  tableLeb[7,5].offset:=1;  tableLeb[7,5].sortie:=const_devie;tableLeb[7,5].code:=1; // blanc
  tableLeb[7,6].offset:=2;  tableLeb[7,6].sortie:=const_droit;tableLeb[7,6].code:=4; // voie libre
  tableLeb[7,7].offset:=2;  tableLeb[7,7].sortie:=const_devie;tableLeb[7,7].code:=6; // rouge cli
  tableLeb[7,8].offset:=3;  tableLeb[7,8].sortie:=const_devie;tableLeb[7,8].code:=7; // jaune cli
  tableLeb[7,9].offset:=3;  tableLeb[7,9].sortie:=const_droit;tableLeb[7,9].code:=5; // blanc cli
  tableLeb[7,10].offset:=4; tableLeb[7,10].sortie:=const_droit;tableLeb[7,10].code:=8; // vert cli

  // cible 8 violet rouge vert jaune blanc
  tableLeb[8,2].offset:=0;  tableLeb[8,2].sortie:=const_droit;tableLeb[8,2].code:=0; // violet
  tableLeb[8,3].offset:=0;  tableLeb[8,3].sortie:=const_devie;tableLeb[8,3].code:=2; // sémaphore
  tableLeb[8,4].offset:=1;  tableLeb[8,4].sortie:=const_droit;tableLeb[8,4].code:=3; // avertissement
  tableLeb[8,5].offset:=1;  tableLeb[8,5].sortie:=const_devie;tableLeb[8,5].code:=1; // blanc
  tableLeb[8,6].offset:=2;  tableLeb[8,6].sortie:=const_droit;tableLeb[8,6].code:=4; // voie libre
  tableLeb[8,7].offset:=2;  tableLeb[8,7].sortie:=const_devie;tableLeb[8,7].code:=6; // rouge cli
  tableLeb[8,8].offset:=3;  tableLeb[8,8].sortie:=const_devie;tableLeb[8,8].code:=7; // jaune cli
  tableLeb[8,9].offset:=3;  tableLeb[8,9].sortie:=const_droit;tableLeb[8,9].code:=5; // blanc cli
  tableLeb[8,10].offset:=4; tableLeb[8,10].sortie:=const_droit;tableLeb[8,10].code:=8; // vert cli

  // cible 9 rouge vert jaune ralen
  tableLeb[9,3].offset:=0;  tableLeb[9,3].sortie:=const_droit;tableLeb[9,3].code:=0; // sémaphore
  tableLeb[9,4].offset:=0;  tableLeb[9,4].sortie:=const_devie;tableLeb[9,4].code:=1; // avertissement
  tableLeb[9,6].offset:=1;  tableLeb[9,6].sortie:=const_droit;tableLeb[9,6].code:=2; // voie libre
  tableLeb[9,7].offset:=1;  tableLeb[9,7].sortie:=const_devie;tableLeb[9,7].code:=3; // rouge cli
  tableLeb[9,8].offset:=2;  tableLeb[9,8].sortie:=const_droit;tableLeb[9,8].code:=4; // jaune cli
  tableLeb[9,10].offset:=2; tableLeb[9,10].sortie:=const_devie;tableLeb[9,10].code:=5; // vert cli
  tableLeb[9,17].offset:=3; tableLeb[9,17].sortie:=const_droit;tableLeb[9,17].code:=6; // ralen 30
  tableLeb[9,18].offset:=3; tableLeb[9,18].sortie:=const_devie;tableLeb[9,18].code:=7; // ralen 60
  tableLeb[9,19].offset:=4; tableLeb[9,19].sortie:=const_droit;tableLeb[9,19].code:=8; // jaune cli + ralen 60

  // cible 10 carré sémaphore  vert jaune ralen
  tableLeb[10,1].offset:=0;  tableLeb[10,1].sortie:=const_droit; tableLeb[10,1].code:=0;// carré
  tableLeb[10,3].offset:=0;  tableLeb[10,3].sortie:=const_devie; tableLeb[10,3].code:=1;// sémaphore
  tableLeb[10,4].offset:=1;  tableLeb[10,4].sortie:=const_droit; tableLeb[10,4].code:=2;// avertissement
  tableLeb[10,6].offset:=1;  tableLeb[10,6].sortie:=const_devie; tableLeb[10,6].code:=3;// voie libre
  tableLeb[10,7].offset:=2;  tableLeb[10,7].sortie:=const_droit; tableLeb[10,7].code:=4;// rouge cli
  tableLeb[10,8].offset:=2;  tableLeb[10,8].sortie:=const_devie; tableLeb[10,8].code:=5;// jaune cli
  tableLeb[10,10].offset:=3; tableLeb[10,10].sortie:=const_droit;tableLeb[10,10].code:=6; // vert cli
  tableLeb[10,17].offset:=3; tableLeb[10,17].sortie:=const_devie;tableLeb[10,17].code:=7; // ralen 30
  tableLeb[10,18].offset:=4; tableLeb[10,18].sortie:=const_droit;tableLeb[10,18].code:=8; // ralen 60
  tableLeb[10,19].offset:=4; tableLeb[10,19].sortie:=const_devie;tableLeb[10,19].code:=9; // jaune cli + ralen 60

  // cible 11 violet sémaphore  vert jaune ralen
  tableLeb[11,2].offset:=0;  tableLeb[11,2].sortie:=const_droit; tableLeb[11,2].code:=0;// violet
  tableLeb[11,3].offset:=0;  tableLeb[11,3].sortie:=const_devie; tableLeb[11,3].code:=1;// sémaphore
  tableLeb[11,4].offset:=1;  tableLeb[11,4].sortie:=const_droit; tableLeb[11,4].code:=2;// avertissement
  tableLeb[11,6].offset:=1;  tableLeb[11,6].sortie:=const_devie; tableLeb[11,6].code:=3;// voie libre
  tableLeb[11,7].offset:=2;  tableLeb[11,7].sortie:=const_droit; tableLeb[11,7].code:=4;// rouge cli
  tableLeb[11,8].offset:=2;  tableLeb[11,8].sortie:=const_devie; tableLeb[11,8].code:=5;// jaune cli
  tableLeb[11,10].offset:=3; tableLeb[11,10].sortie:=const_droit;tableLeb[11,10].code:=6; // vert cli
  tableLeb[11,17].offset:=3; tableLeb[11,17].sortie:=const_devie;tableLeb[11,17].code:=7; // ralen 30
  tableLeb[11,18].offset:=4; tableLeb[11,18].sortie:=const_droit;tableLeb[11,18].code:=8; // ralen 60
  tableLeb[11,19].offset:=4; tableLeb[11,19].sortie:=const_devie;tableLeb[11,19].code:=9; // jaune cli + ralen 60

  // cible 12 carré blanc sémaphore  vert jaune ralen
  tableLeb[12,1].offset:=0;  tableLeb[12,1].sortie:=const_droit; tableLeb[12,1].code:=0;// carré
  tableLeb[12,3].offset:=0;  tableLeb[12,3].sortie:=const_devie; tableLeb[12,3].code:=2;// sémaphore
  tableLeb[12,4].offset:=1;  tableLeb[12,4].sortie:=const_droit; tableLeb[12,4].code:=3;// avertissement
  tableLeb[12,5].offset:=1;  tableLeb[12,5].sortie:=const_devie; tableLeb[12,5].code:=1;// blanc
  tableLeb[12,6].offset:=2;  tableLeb[12,6].sortie:=const_droit; tableLeb[12,6].code:=4;// voie libre
  tableLeb[12,7].offset:=2;  tableLeb[12,7].sortie:=const_devie; tableLeb[12,7].code:=6;// rouge cli
  tableLeb[12,8].offset:=3;  tableLeb[12,8].sortie:=const_droit; tableLeb[12,8].code:=7;// jaune cli
  tableLeb[12,9].offset:=3;  tableLeb[12,9].sortie:=const_devie; tableLeb[12,9].code:=5;// blanc cli
  tableLeb[12,10].offset:=4; tableLeb[12,10].sortie:=const_droit;tableLeb[12,10].code:=8; // vert cli
  tableLeb[12,17].offset:=4; tableLeb[12,17].sortie:=const_devie;tableLeb[12,17].code:=9; // ralen 30
  tableLeb[12,18].offset:=5; tableLeb[12,18].sortie:=const_droit;tableLeb[12,18].code:=10; // ralen 60
  tableLeb[12,19].offset:=5; tableLeb[12,19].sortie:=const_devie;tableLeb[12,19].code:=11; // jaune cli + ralen 60

  // cible 13 violet blanc sémaphore  vert jaune ralen
  tableLeb[13,2].offset:=0;  tableLeb[13,2].sortie:=const_droit; tableLeb[13,2].code:=0;// violet
  tableLeb[13,3].offset:=0;  tableLeb[13,3].sortie:=const_devie; tableLeb[13,3].code:=2;// sémaphore
  tableLeb[13,4].offset:=1;  tableLeb[13,4].sortie:=const_droit; tableLeb[13,4].code:=3;// avertissement
  tableLeb[13,5].offset:=1;  tableLeb[13,5].sortie:=const_devie; tableLeb[13,5].code:=1;// blanc
  tableLeb[13,6].offset:=2;  tableLeb[13,6].sortie:=const_droit; tableLeb[13,6].code:=4;// voie libre
  tableLeb[13,7].offset:=2;  tableLeb[13,7].sortie:=const_devie; tableLeb[13,7].code:=6;// rouge cli
  tableLeb[13,8].offset:=3;  tableLeb[13,8].sortie:=const_droit; tableLeb[13,8].code:=7;// jaune cli
  tableLeb[13,9].offset:=3;  tableLeb[13,9].sortie:=const_devie; tableLeb[13,9].code:=5;// blanc cli
  tableLeb[13,10].offset:=4; tableLeb[13,10].sortie:=const_droit;tableLeb[13,10].code:=8; // vert cli
  tableLeb[13,17].offset:=4; tableLeb[13,17].sortie:=const_devie;tableLeb[13,17].code:=9; // ralen 30
  tableLeb[13,18].offset:=5; tableLeb[13,18].sortie:=const_droit;tableLeb[13,18].code:=10; // ralen 60
  tableLeb[13,19].offset:=5; tableLeb[13,19].sortie:=const_devie;tableLeb[13,19].code:=11; // jaune cli + ralen 60

  // cible 14 mode linéaire
  tableLeb[14,1].offset:=0;  tableLeb[14,1].sortie:=const_droit; tableLeb[14,1].code:=0; // carré
  tableLeb[14,3].offset:=0;  tableLeb[14,3].sortie:=const_devie; tableLeb[14,3].code:=1;// sémaphore
  tableLeb[14,4].offset:=1;  tableLeb[14,4].sortie:=const_droit; tableLeb[14,4].code:=2;// avertissement
  tableLeb[14,6].offset:=1;  tableLeb[14,6].sortie:=const_devie; tableLeb[14,6].code:=3;// voie libre
  tableLeb[14,7].offset:=2;  tableLeb[14,7].sortie:=const_droit; tableLeb[14,7].code:=4;// rouge cli
  tableLeb[14,8].offset:=2;  tableLeb[14,8].sortie:=const_devie; tableLeb[14,8].code:=5;// jaune cli
  tableLeb[14,10].offset:=3; tableLeb[14,10].sortie:=const_droit; tableLeb[14,10].code:=6;// vert cli
  tableLeb[14,11].offset:=3; tableLeb[14,11].sortie:=const_devie; tableLeb[14,11].code:=7;// rappel 30
  tableLeb[14,12].offset:=4; tableLeb[14,12].sortie:=const_droit; tableLeb[14,12].code:=8;// rappel 60
  tableLeb[14,13].offset:=4; tableLeb[14,13].sortie:=const_devie; tableLeb[14,13].code:=9;// avertissement + rappel 30
  tableLeb[14,14].offset:=5; tableLeb[14,14].sortie:=const_droit; tableLeb[14,14].code:=10;// jaune cli + rappel 30
  tableLeb[14,15].offset:=5; tableLeb[14,15].sortie:=const_devie; tableLeb[14,15].code:=11;// avertissement + rappel 60
  tableLeb[14,16].offset:=6; tableLeb[14,16].sortie:=const_droit; tableLeb[14,16].code:=12;// jaune cli + rappel 60

  // cible 15 mode linéaire ralen et rappel
  tableLeb[15,1].offset:=0;  tableLeb[15,1].sortie:=const_droit; tableLeb[15,1].code:=0;// carré
  tableLeb[15,3].offset:=0;  tableLeb[15,3].sortie:=const_devie; tableLeb[15,3].code:=1;// sémaphore
  tableLeb[15,4].offset:=1;  tableLeb[15,4].sortie:=const_droit; tableLeb[15,4].code:=2;// avertissement
  tableLeb[15,6].offset:=1;  tableLeb[15,6].sortie:=const_devie; tableLeb[15,6].code:=3;// voie libre
  tableLeb[15,7].offset:=2;  tableLeb[15,7].sortie:=const_droit; tableLeb[15,7].code:=4;// rouge cli
  tableLeb[15,8].offset:=2;  tableLeb[15,8].sortie:=const_devie; tableLeb[15,8].code:=5;// jaune cli
  tableLeb[15,10].offset:=3; tableLeb[15,10].sortie:=const_droit;tableLeb[15,10].code:=6; // vert cli
  tableLeb[15,11].offset:=3; tableLeb[15,11].sortie:=const_devie;tableLeb[15,11].code:=7; // rappel 30
  tableLeb[15,12].offset:=4; tableLeb[15,12].sortie:=const_droit;tableLeb[15,12].code:=8; // rappel 60
  tableLeb[15,13].offset:=4; tableLeb[15,13].sortie:=const_devie;tableLeb[15,13].code:=9; // avertissement + rappel 30
  tableLeb[15,14].offset:=5; tableLeb[15,14].sortie:=const_droit;tableLeb[15,14].code:=10; // jaune cli + rappel 30
  tableLeb[15,15].offset:=5; tableLeb[15,15].sortie:=const_devie;tableLeb[15,15].code:=11; // avertissement + rappel 60
  tableLeb[15,16].offset:=6; tableLeb[15,16].sortie:=const_droit;tableLeb[15,16].code:=12; // jaune cli + rappel 60
  tableLeb[15,17].offset:=6; tableLeb[15,17].sortie:=const_devie;tableLeb[15,17].code:=13; // ralen 30
  tableLeb[15,18].offset:=7; tableLeb[15,18].sortie:=const_droit;tableLeb[15,18].code:=14; // ralen 60
  tableLeb[15,19].offset:=7; tableLeb[15,19].sortie:=const_devie;tableLeb[15,19].code:=15; // jaune cli + ralen 60

  // cible 16 mode linéaire violet rappel
  tableLeb[16,2].offset:=0;  tableLeb[16,2].sortie:=const_droit; tableLeb[16,2].code:=0;// violet
  tableLeb[16,3].offset:=0;  tableLeb[16,3].sortie:=const_devie; tableLeb[16,3].code:=1;// sémaphore
  tableLeb[16,4].offset:=1;  tableLeb[16,4].sortie:=const_droit; tableLeb[16,4].code:=2;// avertissement
  tableLeb[16,6].offset:=1;  tableLeb[16,6].sortie:=const_devie; tableLeb[16,6].code:=3;// voie libre
  tableLeb[16,7].offset:=2;  tableLeb[16,7].sortie:=const_droit; tableLeb[16,7].code:=4;// rouge cli
  tableLeb[16,8].offset:=2;  tableLeb[16,8].sortie:=const_devie; tableLeb[16,8].code:=5;// jaune cli
  tableLeb[16,10].offset:=3; tableLeb[16,10].sortie:=const_droit; tableLeb[16,10].code:=6;// vert cli
  tableLeb[16,11].offset:=3; tableLeb[16,11].sortie:=const_devie; tableLeb[16,11].code:=7;// rappel 30
  tableLeb[16,12].offset:=4; tableLeb[16,12].sortie:=const_droit; tableLeb[16,12].code:=8;// rappel 60
  tableLeb[16,13].offset:=4; tableLeb[16,13].sortie:=const_devie; tableLeb[16,13].code:=9;// avertissement + rappel 30
  tableLeb[16,14].offset:=5; tableLeb[16,14].sortie:=const_droit; tableLeb[16,14].code:=10;// jaune cli + rappel 30
  tableLeb[16,15].offset:=5; tableLeb[16,15].sortie:=const_devie; tableLeb[16,15].code:=11;// avertissement + rappel 60
  tableLeb[16,16].offset:=6; tableLeb[16,16].sortie:=const_droit; tableLeb[16,16].code:=12;// jaune cli + rappel 60

  // cible 17 mode linéaire carré violet blanc rappel
  tableLeb[17,1].offset:=0;  tableLeb[17,1].sortie:=const_droit; tableLeb[17,1].code:=0;// carré
  tableLeb[17,3].offset:=0;  tableLeb[17,3].sortie:=const_devie; tableLeb[17,3].code:=2;// sémaphore
  tableLeb[17,4].offset:=1;  tableLeb[17,4].sortie:=const_droit; tableLeb[17,4].code:=3;// avertissement
  tableLeb[17,5].offset:=1;  tableLeb[17,5].sortie:=const_devie; tableLeb[17,5].code:=1;// blanc
  tableLeb[17,6].offset:=2;  tableLeb[17,6].sortie:=const_droit; tableLeb[17,6].code:=4;// voie libre
  tableLeb[17,7].offset:=2;  tableLeb[17,7].sortie:=const_devie; tableLeb[17,7].code:=6;// rouge cli
  tableLeb[17,8].offset:=3;  tableLeb[17,8].sortie:=const_droit; tableLeb[17,8].code:=7;// jaune cli
  tableLeb[17,9].offset:=3;  tableLeb[17,9].sortie:=const_devie; tableLeb[17,9].code:=5;// blanc cli
  tableLeb[17,10].offset:=4; tableLeb[17,10].sortie:=const_droit; tableLeb[17,10].code:=8;// vert cli
  tableLeb[17,11].offset:=4; tableLeb[17,11].sortie:=const_devie; tableLeb[17,11].code:=9;// rappel 30
  tableLeb[17,12].offset:=5; tableLeb[17,12].sortie:=const_droit; tableLeb[17,12].code:=10;// rappel 60
  tableLeb[17,13].offset:=5; tableLeb[17,13].sortie:=const_devie; tableLeb[17,13].code:=11;// avertissement + rappel 30
  tableLeb[17,14].offset:=6; tableLeb[17,14].sortie:=const_droit; tableLeb[17,14].code:=12;// jaune cli + rappel 30
  tableLeb[17,15].offset:=6; tableLeb[17,15].sortie:=const_devie; tableLeb[17,15].code:=13;// avertissement + rappel 60
  tableLeb[17,16].offset:=7; tableLeb[17,16].sortie:=const_droit; tableLeb[17,16].code:=14;// jaune cli + rappel 60

  // cible 18 mode linéaire Violet blanc rappel
  tableLeb[18,2].offset:=0;  tableLeb[18,2].sortie:=const_droit; tableLeb[18,2].code:=0;// violet
  tableLeb[18,3].offset:=0;  tableLeb[18,3].sortie:=const_devie; tableLeb[18,3].code:=2;// sémaphore
  tableLeb[18,4].offset:=1;  tableLeb[18,4].sortie:=const_droit; tableLeb[18,4].code:=3;// avertissement
  tableLeb[18,5].offset:=1;  tableLeb[18,5].sortie:=const_devie; tableLeb[18,5].code:=1;// blanc
  tableLeb[18,6].offset:=2;  tableLeb[18,6].sortie:=const_droit; tableLeb[18,6].code:=4;// voie libre
  tableLeb[18,7].offset:=2;  tableLeb[18,7].sortie:=const_devie; tableLeb[18,7].code:=6;// rouge cli
  tableLeb[18,8].offset:=3;  tableLeb[18,8].sortie:=const_droit; tableLeb[18,8].code:=7;// jaune cli
  tableLeb[18,9].offset:=3;  tableLeb[18,9].sortie:=const_devie; tableLeb[18,9].code:=5;// blanc cli
  tableLeb[18,10].offset:=4; tableLeb[18,10].sortie:=const_droit; tableLeb[18,10].code:=8;// vert cli
  tableLeb[18,11].offset:=4; tableLeb[18,11].sortie:=const_devie; tableLeb[18,11].code:=9;// rappel 30
  tableLeb[18,12].offset:=5; tableLeb[18,12].sortie:=const_droit; tableLeb[18,12].code:=10;// rappel 60
  tableLeb[18,13].offset:=5; tableLeb[18,13].sortie:=const_devie; tableLeb[18,13].code:=11;// avertissement + rappel 30
  tableLeb[18,14].offset:=6; tableLeb[18,14].sortie:=const_droit; tableLeb[18,14].code:=12;// jaune cli + rappel 30
  tableLeb[18,15].offset:=6; tableLeb[18,15].sortie:=const_devie; tableLeb[18,15].code:=13;// avertissement + rappel 60
  tableLeb[18,16].offset:=7; tableLeb[18,16].sortie:=const_droit; tableLeb[18,16].code:=14;// jaune cli + rappel 60

  // cible 19 mode linéaire carré blanc ralen rappel
  tableLeb[19,1].offset:=0;  tableLeb[19,1].sortie:=const_droit; tableLeb[19,1].code:=0;// carré
  tableLeb[19,3].offset:=0;  tableLeb[19,3].sortie:=const_devie; tableLeb[19,3].code:=2;// sémaphore
  tableLeb[19,4].offset:=1;  tableLeb[19,4].sortie:=const_droit; tableLeb[19,4].code:=3;// avertissement
  tableLeb[19,5].offset:=1;  tableLeb[19,5].sortie:=const_devie; tableLeb[19,5].code:=1;// blanc
  tableLeb[19,6].offset:=2;  tableLeb[19,6].sortie:=const_droit; tableLeb[19,6].code:=4;// voie libre
  tableLeb[19,7].offset:=2;  tableLeb[19,7].sortie:=const_devie; tableLeb[19,7].code:=6;// rouge cli
  tableLeb[19,8].offset:=3;  tableLeb[19,8].sortie:=const_droit; tableLeb[19,8].code:=7;// jaune cli
  tableLeb[19,9].offset:=3;  tableLeb[19,9].sortie:=const_devie; tableLeb[19,9].code:=5;// blanc cli
  tableLeb[19,10].offset:=4; tableLeb[19,10].sortie:=const_droit;tableLeb[19,10].code:=8; // vert cli
  tableLeb[19,11].offset:=4; tableLeb[19,11].sortie:=const_devie;tableLeb[19,11].code:=9; // rappel 30
  tableLeb[19,12].offset:=5; tableLeb[19,12].sortie:=const_droit;tableLeb[19,12].code:=10; // rappel 60
  tableLeb[19,13].offset:=5; tableLeb[19,13].sortie:=const_devie;tableLeb[19,13].code:=11; // avertissement + rappel 30
  tableLeb[19,14].offset:=6; tableLeb[19,14].sortie:=const_droit;tableLeb[19,14].code:=12; // jaune cli + rappel 30
  tableLeb[19,15].offset:=6; tableLeb[19,15].sortie:=const_devie;tableLeb[19,15].code:=13; // avertissement + rappel 60
  tableLeb[19,16].offset:=7; tableLeb[19,16].sortie:=const_droit;tableLeb[19,16].code:=14; // jaune cli + rappel 60
  tableLeb[19,17].offset:=7; tableLeb[19,17].sortie:=const_devie;tableLeb[19,17].code:=15; // ralen 30
  tableLeb[19,18].offset:=8; tableLeb[19,18].sortie:=const_droit;tableLeb[19,18].code:=16; // ralen 60
  tableLeb[19,19].offset:=8; tableLeb[19,19].sortie:=const_devie;tableLeb[19,19].code:=17; // jaune cli + ralen 60

  // cible 20 mode linéaire violet blanc ralen rappel
  tableLeb[20,2].offset:=0;  tableLeb[20,2].sortie:=const_droit; tableLeb[20,2].code:=0;// violet
  tableLeb[20,3].offset:=0;  tableLeb[20,3].sortie:=const_devie; tableLeb[20,3].code:=2;// sémaphore
  tableLeb[20,4].offset:=1;  tableLeb[20,4].sortie:=const_droit; tableLeb[20,4].code:=3;// avertissement
  tableLeb[20,5].offset:=1;  tableLeb[20,5].sortie:=const_devie; tableLeb[20,5].code:=1;// blanc
  tableLeb[20,6].offset:=2;  tableLeb[20,6].sortie:=const_droit; tableLeb[20,6].code:=4;// voie libre
  tableLeb[20,7].offset:=2;  tableLeb[20,7].sortie:=const_devie; tableLeb[20,7].code:=6;// rouge cli
  tableLeb[20,8].offset:=3;  tableLeb[20,8].sortie:=const_droit; tableLeb[20,8].code:=7;// jaune cli
  tableLeb[20,9].offset:=3;  tableLeb[20,9].sortie:=const_devie; tableLeb[20,9].code:=5;// blanc cli
  tableLeb[20,10].offset:=4; tableLeb[20,10].sortie:=const_droit;tableLeb[20,10].code:=8; // vert cli
  tableLeb[20,11].offset:=4; tableLeb[20,11].sortie:=const_devie;tableLeb[20,11].code:=9; // rappel 30
  tableLeb[20,12].offset:=5; tableLeb[20,12].sortie:=const_droit;tableLeb[20,12].code:=10; // rappel 60
  tableLeb[20,13].offset:=5; tableLeb[20,13].sortie:=const_devie;tableLeb[20,13].code:=11; // avertissement + rappel 30
  tableLeb[20,14].offset:=6; tableLeb[20,14].sortie:=const_droit;tableLeb[20,14].code:=12; // jaune cli + rappel 30
  tableLeb[20,15].offset:=6; tableLeb[20,15].sortie:=const_devie;tableLeb[20,15].code:=13; // avertissement + rappel 60
  tableLeb[20,16].offset:=7; tableLeb[20,16].sortie:=const_droit;tableLeb[20,16].code:=14; // jaune cli + rappel 60
  tableLeb[20,17].offset:=7; tableLeb[20,17].sortie:=const_devie;tableLeb[20,17].code:=15; // ralen 30
  tableLeb[20,18].offset:=8; tableLeb[20,18].sortie:=const_droit;tableLeb[20,18].code:=16; // ralen 60
  tableLeb[20,19].offset:=8; tableLeb[20,19].sortie:=const_devie;tableLeb[20,19].code:=17; // jaune cli + ralen 60

  // cible 21 ronde vert jaune
  tableLeb[21,4].offset:=0;  tableLeb[21,4].sortie:=const_droit; tableLeb[21,4].code:=0;// avertissement
  tableLeb[21,6].offset:=0;  tableLeb[21,6].sortie:=const_devie; tableLeb[21,6].code:=1;// voie libre
  tableLeb[21,8].offset:=1;  tableLeb[21,8].sortie:=const_droit; tableLeb[21,8].code:=2;// jaune cli
  tableLeb[21,10].offset:=1; tableLeb[21,10].sortie:=const_devie;tableLeb[21,10].code:=3; // vert cli

  // cible 22 ronde vert jaune rouge
  tableLeb[22,4].offset:=0;  tableLeb[22,4].sortie:=const_droit;tableLeb[22,4].code:=0; // avertissement
  tableLeb[22,6].offset:=0;  tableLeb[22,6].sortie:=const_devie;tableLeb[22,6].code:=1; // voie libre
  tableLeb[22,8].offset:=1;  tableLeb[22,8].sortie:=const_droit;tableLeb[22,8].code:=2; // jaune cli

  // cible 23 ronde vert 2 jaune rouge
  tableLeb[23,1].offset:=0;  tableLeb[23,1].sortie:=const_droit;tableLeb[23,1].code:=0; // carré
  tableLeb[23,4].offset:=0;  tableLeb[23,4].sortie:=const_devie;tableLeb[23,4].code:=1; // avertissement
  tableLeb[23,6].offset:=1;  tableLeb[23,6].sortie:=const_droit;tableLeb[23,6].code:=2; // voie libre
  tableLeb[23,8].offset:=1;  tableLeb[23,8].sortie:=const_devie;tableLeb[23,8].code:=3; // jaune cli
  tableLeb[23,10].offset:=2; tableLeb[23,10].sortie:=const_droit;tableLeb[23,10].code:=4; // vert cli

  // cible 24 ronde 3 jaunes
  tableLeb[24,4].offset:=0;  tableLeb[24,4].sortie:=const_droit;  tableLeb[24,4].code:=0;// avertissement
  tableLeb[24,8].offset:=0;  tableLeb[24,8].sortie:=const_devie;  tableLeb[24,8].code:=1;// jaune cli
  tableLeb[24,17].offset:=1; tableLeb[24,17].sortie:=const_droit; tableLeb[24,17].code:=2;// ralen 30
  tableLeb[24,18].offset:=1; tableLeb[24,18].sortie:=const_devie; tableLeb[24,18].code:=3;// ralen 60
  tableLeb[24,19].offset:=2; tableLeb[24,19].sortie:=const_droit; tableLeb[24,19].code:=4;// jaune cli + ralen 60

  // cible 25 ronde vert 3 jaunes
  tableLeb[25,4].offset:=0;  tableLeb[25,4].sortie:=const_droit;  tableLeb[25,4].code:=0;// avertissement
  tableLeb[25,6].offset:=0;  tableLeb[25,6].sortie:=const_devie;  tableLeb[25,6].code:=1; // voie libre
  tableLeb[25,8].offset:=1;  tableLeb[25,8].sortie:=const_droit;  tableLeb[25,8].code:=2; // jaune cli
  tableLeb[25,10].offset:=1; tableLeb[25,10].sortie:=const_devie; tableLeb[25,10].code:=3;// vert cli
  tableLeb[25,17].offset:=2; tableLeb[25,17].sortie:=const_droit; tableLeb[25,17].code:=4;// ralen 30
  tableLeb[25,18].offset:=2; tableLeb[25,18].sortie:=const_devie; tableLeb[25,18].code:=5;// ralen 60
  tableLeb[25,19].offset:=3; tableLeb[25,19].sortie:=const_droit; tableLeb[25,19].code:=6;// jaune cli + ralen 60

  // cible 26 ronde rouge vert 4 jaunes
  tableLeb[26,1].offset:=0;  tableLeb[26,1].sortie:=const_droit; tableLeb[26,1].code:=0;// carré
  tableLeb[26,4].offset:=0;  tableLeb[26,4].sortie:=const_devie; tableLeb[26,4].code:=1;// avertissement
  tableLeb[26,6].offset:=1;  tableLeb[26,6].sortie:=const_droit; tableLeb[26,6].code:=2;// voie libre
  tableLeb[26,8].offset:=1;  tableLeb[26,8].sortie:=const_devie; tableLeb[26,8].code:=3;// jaune cli
  tableLeb[26,10].offset:=2; tableLeb[26,10].sortie:=const_droit;tableLeb[26,10].code:=4; // vert cli
  tableLeb[26,17].offset:=2; tableLeb[26,17].sortie:=const_devie;tableLeb[26,17].code:=5; // ralen 30
  tableLeb[26,18].offset:=3; tableLeb[26,18].sortie:=const_droit;tableLeb[26,18].code:=6; // ralen 60
  tableLeb[26,19].offset:=3; tableLeb[26,19].sortie:=const_devie;tableLeb[26,19].code:=7; // jaune cli + ralen 60

  // cible 27 carré vert blanc
  tableLeb[27,1].offset:=0;  tableLeb[27,1].sortie:=const_droit; tableLeb[27,1].code:=0;// carré
  tableLeb[27,3].offset:=0;  tableLeb[27,3].sortie:=const_devie; tableLeb[27,3].code:=2;// sémaphore
  tableLeb[27,5].offset:=1;  tableLeb[27,5].sortie:=const_droit; tableLeb[27,5].code:=1;// blanc
  tableLeb[27,6].offset:=1;  tableLeb[27,6].sortie:=const_devie; tableLeb[27,6].code:=3;// voie libre
  tableLeb[27,7].offset:=2;  tableLeb[27,7].sortie:=const_droit; tableLeb[27,7].code:=5;// rouge cli
  tableLeb[27,9].offset:=2;  tableLeb[27,9].sortie:=const_devie; tableLeb[27,9].code:=4;// blanc cli
  tableLeb[27,10].offset:=3; tableLeb[27,10].sortie:=const_droit;tableLeb[27,10].code:=6; // vert cli

  // cible 28 carré vert violet blanc jaune
  tableLeb[28,2].offset:=0;  tableLeb[28,2].sortie:=const_droit; tableLeb[28,2].code:=0;// violet
  tableLeb[28,4].offset:=0;  tableLeb[28,4].sortie:=const_devie; tableLeb[28,4].code:=2;// avertissement
  tableLeb[28,5].offset:=1;  tableLeb[28,5].sortie:=const_droit; tableLeb[28,5].code:=1;// blanc
  tableLeb[28,6].offset:=1;  tableLeb[28,6].sortie:=const_devie; tableLeb[28,6].code:=3;// voie libre
  tableLeb[28,8].offset:=2;  tableLeb[28,8].sortie:=const_droit; tableLeb[28,8].code:=5;// jaune cli
  tableLeb[28,9].offset:=2;  tableLeb[28,9].sortie:=const_devie; tableLeb[28,9].code:=4;// blanc cli
  tableLeb[28,10].offset:=3; tableLeb[28,10].sortie:=const_droit; tableLeb[28,10].code:=6;// vert cli

  // cible 29 carré vert rouge
  tableLeb[29,3].offset:=0;  tableLeb[29,3].sortie:=const_droit; tableLeb[29,3].code:=0;// sémaphore
  tableLeb[29,6].offset:=0;  tableLeb[29,6].sortie:=const_devie; tableLeb[29,6].code:=1;// voie libre
  tableLeb[29,7].offset:=1;  tableLeb[29,7].sortie:=const_droit; tableLeb[29,7].code:=2;// rouge cli
  tableLeb[29,10].offset:=1; tableLeb[29,10].sortie:=const_devie; tableLeb[29,10].code:=3;// vert cli

  // cible 41 carré jaune rappel
  tableLeb[41,1].offset:=0;  tableLeb[41,1].sortie:=const_droit;tableLeb[41,1].code:=0; // carré
  tableLeb[41,3].offset:=0;  tableLeb[41,3].sortie:=const_devie;tableLeb[41,3].code:=1; // sémaphore
  tableLeb[41,4].offset:=1;  tableLeb[41,4].sortie:=const_droit;tableLeb[41,4].code:=2; // avertissement
  tableLeb[41,7].offset:=1;  tableLeb[41,7].sortie:=const_devie;tableLeb[41,7].code:=3; // rouge cli
  tableLeb[41,8].offset:=2;  tableLeb[41,8].sortie:=const_droit;tableLeb[41,8].code:=4; // jaune cli
  tableLeb[41,11].offset:=2; tableLeb[41,11].sortie:=const_devie;tableLeb[41,11].code:=5; // rappel 30
  tableLeb[41,12].offset:=3; tableLeb[41,12].sortie:=const_droit;tableLeb[41,12].code:=6; // rappel 60
  tableLeb[41,13].offset:=3; tableLeb[41,13].sortie:=const_devie;tableLeb[41,13].code:=7; // avertissement + rappel 30
  tableLeb[41,14].offset:=4; tableLeb[41,14].sortie:=const_droit;tableLeb[41,14].code:=8; // jaune cli + rappel 30
  tableLeb[41,15].offset:=4; tableLeb[41,15].sortie:=const_devie;tableLeb[41,15].code:=9; // avertissement + rappel 60
  tableLeb[41,16].offset:=5; tableLeb[41,16].sortie:=const_droit;tableLeb[41,16].code:=10; // jaune cli + rappel 60

end.
