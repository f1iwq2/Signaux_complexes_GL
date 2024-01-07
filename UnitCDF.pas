unit UnitCDF;

// configuration des décodeurs CDM et Digikeijs

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls , unitconfig, Buttons , UnitPilote , unitPrinc;

type
  TFormCDF = class(TForm)
    Label20: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ImageDigi: TImage;
    Shape1: TShape;
    Label21: TLabel;
    Label22: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Label23: TLabel;
    EditNAdresses: TEdit;
    LabelTitre: TLabel;
    Label24: TLabel;
    BitBtnOk: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit14Change(Sender: TObject);
    procedure Edit15Change(Sender: TObject);
    procedure Edit16Change(Sender: TObject);
    procedure Edit18Change(Sender: TObject);
    procedure Edit19Change(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure EditNAdressesChange(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormCDF: TFormCDF;
  Adresse,Index : integer;
  dessineCDF : boolean;

{$R *.dfm}

procedure dessine_feu_CDF;
procedure couleurs_cdf;

implementation

procedure couleurs_cdf;
var i : integer;
    c : tComponent;
begin
  if sombre then with formCDF do
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,clWhite);
    end;
  end;
end;

procedure TFormCDF.FormActivate(Sender: TObject);
var i,erreur : integer;
    c : tcomponent;
begin
  Val(FormConfig.EditAdrSig.text,Adresse,erreur);
  index:=index_Signal(Adresse);
  LabelTitre.caption:='Adresse du signal: '+intToSTR(adresse);
  erreur:=Signaux[index].decodeur;
  Signaux[0]:=Signaux[index];
  //Asp:=Signaux[index].aspect;
  if erreur=5 then
  begin
    caption:='Configuration du décodeur Digikeijs';
    label20.caption:='Tables d''aspects du signal en fonction du motif envoyé au décodeur Digikeijs';
    label24.Caption:='1 à 5';
  end;
  if erreur=2 then
  begin
    caption:='Configuration du décodeur CDF';
    label20.Caption:='Tables d''aspects du signal en fonction du motif envoyé au décodeur CDF';
    label24.Caption:='1 à 4';
  end;

  Label1.caption:=etats[1];
  Label2.caption:=etats[2];
  Label3.caption:=etats[3];
  Label4.caption:=etats[4];
  Label5.caption:=etats[5];
  Label6.caption:=etats[6];
  Label7.caption:=etats[7];
  Label8.caption:=etats[8];
  Label9.caption:=etats[9];
  Label10.caption:=etats[10];
  Label11.caption:=etats[11];
  Label12.caption:=etats[12];
  Label13.caption:=etats[13];
  Label14.caption:=etats[14];
  Label15.caption:=etats[15];
  Label16.caption:=etats[16];
  Label17.caption:=etats[17];
  Label18.caption:=etats[18];
  Label19.caption:=etats[19];

  ImageDigi.Picture:=FormConfig.ImageSignal.Picture;
  with ImageDigi.Picture do
  begin
    Bitmap.TransparentMode:=tmAuto;
    Bitmap.TransparentColor:=clblue;
  end;
  ImageDigi.Transparent:=true;

  Edit1.Text:=intToSTR(Signaux[index].SR[1].sortie1);  // carré
  Edit2.Text:=intToSTR(Signaux[index].SR[2].sortie1);  // sémaphore
  Edit3.Text:=intToSTR(Signaux[index].SR[3].sortie1);  // sémaphore cli
  Edit4.Text:=intToSTR(Signaux[index].SR[4].sortie1);
  Edit5.Text:=intToSTR(Signaux[index].SR[5].sortie1);
  Edit6.Text:=intToSTR(Signaux[index].SR[6].sortie1);
  Edit7.Text:=intToSTR(Signaux[index].SR[7].sortie1);
  Edit8.Text:=intToSTR(Signaux[index].SR[8].sortie1);
  Edit9.Text:=intToSTR(Signaux[index].SR[9].sortie1);
  Edit10.Text:=intToSTR(Signaux[index].SR[10].sortie1);
  Edit11.Text:=intToSTR(Signaux[index].SR[11].sortie1);
  Edit12.Text:=intToSTR(Signaux[index].SR[12].sortie1);
  Edit13.Text:=intToSTR(Signaux[index].SR[13].sortie1);
  Edit14.Text:=intToSTR(Signaux[index].SR[14].sortie1);
  Edit15.Text:=intToSTR(Signaux[index].SR[15].sortie1);
  Edit16.Text:=intToSTR(Signaux[index].SR[16].sortie1);
  Edit17.Text:=intToSTR(Signaux[index].SR[17].sortie1);
  Edit18.Text:=intToSTR(Signaux[index].SR[18].sortie1);
  Edit19.Text:=intToSTR(Signaux[index].SR[19].sortie1);

  editNadresses.text:=intToSTR(Signaux[index].NA);


end;

procedure dessine_feu_CDF;
var i,ancienEtat : integer;
    Vcanvas : Tcanvas;
begin
  i:=0;

  //ImagePilote.Picture.Bitmap:=FormPilote.ImagePilote.picture.bitmap;
  EtatFeuPilote:=Signaux[i].EtatSignal;
  AncienEtat:=Signaux[i].AncienEtat;
  dessineCDF:=true; // demande dessin CDF pour les clignotements
  Vcanvas:=FormCDF.ImageDigi.picture.bitmap.Canvas;

  case Signaux[i].aspect of
  // feux de signalisation
   2 : dessine_signal2(Vcanvas,0,0,1,1,EtatFeupilote,1);
   3 : dessine_signal3(Vcanvas,0,0,1,1,EtatFeupilote,AncienEtat,1);
   4 : dessine_signal4(VCanvas,0,0,1,1,EtatFeupilote,1);
   5 : dessine_signal5(VCanvas,0,0,1,1,EtatFeupilote,1);
   7 : dessine_signal7(VCanvas,0,0,1,1,EtatFeupilote,1);
   9 : dessine_signal9(VCanvas,0,0,1,1,EtatFeupilote,1);
  // indicateurs de direction
  12 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,2);
  13 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,3);
  14 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,4);
  15 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,5);
  16 : dessine_dirN(VCanvas,0,0,1,1,EtatFeupilote,1,6);
  end;
end;

procedure Maj_DB;
var s : string;
begin
  s:=encode_sig_feux(index);
  formconfig.ListBoxSig.items[index-1]:=s;
  formconfig.ListBoxSig.selected[ligneClicSig]:=true;
  aff_champs_sig_feux(index);
end;

procedure TFormCDF.Edit1Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit1.Text,Signaux[index].SR[1].sortie1,erreur);
    Maj_DB;
    if label1.Caption=etats[1] then Maj_Etat_Signal(0,carre);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit2Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit2.Text,Signaux[index].SR[2].sortie1,erreur);
    Maj_DB;
    if label2.Caption=etats[2] then Maj_Etat_Signal(0,semaphore);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit3Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit3.Text,Signaux[index].SR[3].sortie1,erreur);
    Maj_DB;
    if label3.Caption=etats[3] then Maj_Etat_Signal(0,semaphore_cli);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit4Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit4.Text,Signaux[index].SR[4].sortie1,erreur);
    Maj_DB;
    if label4.Caption=etats[4] then Maj_Etat_Signal(0,vert);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit5Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit5.Text,Signaux[index].SR[5].sortie1,erreur);
    Maj_DB;
    if label5.Caption=etats[5] then Maj_Etat_Signal(0,vert_cli);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit6Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit6.Text,Signaux[index].SR[6].sortie1,erreur);
    Maj_DB;
    if label6.Caption=etats[6] then Maj_Etat_Signal(0,violet);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit7Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit7.Text,Signaux[index].SR[7].sortie1,erreur);
    Maj_DB;
    if label7.Caption=etats[7] then Maj_Etat_Signal(0,blanc);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit8Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit8.Text,Signaux[index].SR[8].sortie1,erreur);
    Maj_DB;
    if label8.Caption=etats[8] then Maj_Etat_Signal(0,blanc_cli);
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit9Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit9.Text,Signaux[index].SR[9].sortie1,erreur);
    Maj_DB;
    if label9.Caption=etats[9] then  begin Maj_Etat_Signal(0,semaphore);Maj_Etat_Signal(0,jaune);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit10Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit10.Text,Signaux[index].SR[10].sortie1,erreur);
    Maj_DB;
    if label10.Caption=etats[10] then
    begin
      Maj_Etat_Signal(0,semaphore);
      Maj_Etat_Signal(0,jaune_cli);
    end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit11Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit11.Text,Signaux[index].SR[11].sortie1,erreur);
    Maj_DB;
    if label11.Caption=etats[11] then begin Maj_Etat_Signal(0,semaphore);Maj_Etat_Signal(0,ral_30);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit12Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit12.Text,Signaux[index].SR[12].sortie1,erreur);
    Maj_DB;
    if label12.Caption=etats[12] then begin Maj_Etat_Signal(0,semaphore);Maj_Etat_Signal(0,ral_60);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit13Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit13.Text,Signaux[index].SR[13].sortie1,erreur);
    Maj_DB;
    if label13.Caption=etats[13] then begin Maj_Etat_Signal(0,ral_60);Maj_Etat_Signal(0,jaune_cli);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit14Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit14.Text,Signaux[index].SR[14].sortie1,erreur);
    Maj_DB;
    if label14.Caption=etats[14] then begin Maj_Etat_Signal(0,semaphore);Maj_Etat_Signal(0,rappel_30);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit15Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit15.Text,Signaux[index].SR[15].sortie1,erreur);
    Maj_DB;
    if label15.Caption=etats[15] then begin Maj_Etat_Signal(0,semaphore);Maj_Etat_Signal(0,rappel_60);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit16Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit16.Text,Signaux[index].SR[16].sortie1,erreur);
    Maj_DB;
    if label16.Caption=etats[16] then begin Maj_Etat_Signal(0,rappel_30); Maj_Etat_Signal(0,jaune);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit17Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit17.Text,Signaux[index].SR[17].sortie1,erreur);
    Maj_DB;
    if label17.Caption=etats[17] then begin Maj_Etat_Signal(0,rappel_30); Maj_Etat_Signal(0,jaune_cli);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit18Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit18.Text,Signaux[index].SR[18].sortie1,erreur);
    Maj_DB;
    if label18.Caption=etats[18] then begin Maj_Etat_Signal(0,rappel_60); Maj_Etat_Signal(0,jaune);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.Edit19Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit19.Text,Signaux[index].SR[19].sortie1,erreur);
    Maj_DB;
    if label19.Caption=etats[19] then begin Maj_Etat_Signal(0,rappel_60);  Maj_Etat_Signal(0,jaune_cli);end;
    dessine_feu_CDF;
  end;
end;

procedure TFormCDF.EditNAdressesChange(Sender: TObject);
var erreur,i : integer;
begin
  if index<>0 then
  begin
    val(EditNAdresses.Text,i,erreur);
    if (i>0) and (i<6) then
    begin
      Signaux[index].Na:=i;
      Maj_DB;
    end;  
  end;
end;

procedure TFormCDF.BitBtnOkClick(Sender: TObject);
begin
  close;
end;

procedure TFormCDF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dessineCDF:=false;
end;

procedure TFormCDF.FormCreate(Sender: TObject);
begin
  couleurs_cdf;
end;

end.
