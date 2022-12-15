unit UnitCDF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls , unitconfig, UnitPrinc;

type
  TFormCDF = class(TForm)
    Button1: TButton;
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
    procedure Button1Click(Sender: TObject);
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
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormCDF: TFormCDF;
  Adresse,Index : integer;

implementation

{$R *.dfm}

procedure TFormCDF.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormCDF.FormActivate(Sender: TObject);
var erreur : integer;
begin
  Val(FormConfig.EditAdrSig.text,Adresse,erreur);
  index:=index_feu(Adresse);
  LabelTitre.caption:='Adresse du signal: '+intToSTR(adresse);
  erreur:=feux[index].decodeur;
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

  Edit1.Text:=intToSTR(Feux[index].SR[1].sortie1);  // carré
  Edit2.Text:=intToSTR(Feux[index].SR[2].sortie1);  // sémaphore
  Edit3.Text:=intToSTR(Feux[index].SR[3].sortie1);  // sémaphore cli
  Edit4.Text:=intToSTR(Feux[index].SR[4].sortie1);
  Edit5.Text:=intToSTR(Feux[index].SR[5].sortie1);
  Edit6.Text:=intToSTR(Feux[index].SR[6].sortie1);
  Edit7.Text:=intToSTR(Feux[index].SR[7].sortie1);
  Edit8.Text:=intToSTR(Feux[index].SR[8].sortie1);
  Edit9.Text:=intToSTR(Feux[index].SR[9].sortie1);
  Edit10.Text:=intToSTR(Feux[index].SR[10].sortie1);
  Edit11.Text:=intToSTR(Feux[index].SR[11].sortie1);
  Edit12.Text:=intToSTR(Feux[index].SR[12].sortie1);
  Edit13.Text:=intToSTR(Feux[index].SR[13].sortie1);
  Edit14.Text:=intToSTR(Feux[index].SR[14].sortie1);
  Edit15.Text:=intToSTR(Feux[index].SR[15].sortie1);
  Edit16.Text:=intToSTR(Feux[index].SR[16].sortie1);
  Edit17.Text:=intToSTR(Feux[index].SR[17].sortie1);
  Edit18.Text:=intToSTR(Feux[index].SR[18].sortie1);
  Edit19.Text:=intToSTR(Feux[index].SR[19].sortie1);

  editNadresses.text:=intToSTR(feux[index].NA); 
end;

procedure Maj_DB;
var s : string;
begin
  s:=encode_sig_feux(index);
  formconfig.RichSig.Lines[index-1]:=s;
  aff_champs_sig_feux(index);
end;

procedure TFormCDF.Edit1Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit1.Text,Feux[index].SR[1].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit2Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit2.Text,Feux[index].SR[2].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit3Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit3.Text,Feux[index].SR[3].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit4Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit4.Text,Feux[index].SR[4].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit5Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit5.Text,Feux[index].SR[5].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit6Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit6.Text,Feux[index].SR[6].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit7Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit7.Text,Feux[index].SR[7].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit8Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit8.Text,Feux[index].SR[8].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit9Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit9.Text,Feux[index].SR[9].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit10Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit10.Text,Feux[index].SR[10].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit11Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit11.Text,Feux[index].SR[11].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit12Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit12.Text,Feux[index].SR[12].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit13Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit13.Text,Feux[index].SR[13].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit14Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit14.Text,Feux[index].SR[14].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit15Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit15.Text,Feux[index].SR[15].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit16Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit16.Text,Feux[index].SR[16].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit17Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit17.Text,Feux[index].SR[17].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit18Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit18.Text,Feux[index].SR[18].sortie1,erreur);
    Maj_DB;
  end;
end;

procedure TFormCDF.Edit19Change(Sender: TObject);
var erreur : integer;
begin
  if index<>0 then
  begin
    val(Edit19.Text,Feux[index].SR[19].sortie1,erreur);
    Maj_DB;
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
      Feux[index].Na:=i;
      Maj_DB;
    end;  
  end;
end;

end.
