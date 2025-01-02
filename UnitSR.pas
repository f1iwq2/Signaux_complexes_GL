// Unité pour la configuration du décodeur Stéphane Ravaux
// http://stephane.ravaut.free.fr/Train_miniature/Decodeurs/Decodeur_DCC_Signaux_complexes_SNCF.html

unit UnitSR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls , UnitPrinc, UnitConfig,
  Buttons;

type
  TFormSR = class(TForm)
    LabelAdrSR1: TLabel;
    ComboBoxAdr1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxAdr2: TComboBox;
    Label300: TLabel;
    Label301: TLabel;
    Label302: TLabel;
    Shape1: TShape;
    LabelAdrSR2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label303: TLabel;
    LabelCV1: TLabel;
    LabelCV2: TLabel;
    LabelCV3: TLabel;
    LabelCV4: TLabel;
    ComboBoxAdr3: TComboBox;
    ComboBoxAdr4: TComboBox;
    LabelCV5: TLabel;
    LabelCV6: TLabel;
    LabelCV7: TLabel;
    LabelCV8: TLabel;
    Shape2: TShape;
    LabelAdrSR3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ComboBoxAdr5: TComboBox;
    ComboBoxAdr6: TComboBox;
    LabelCV9: TLabel;
    LabelCV10: TLabel;
    LabelCV11: TLabel;
    LabelCV12: TLabel;
    Shape3: TShape;
    LabelAdrSR4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ComboBoxAdr7: TComboBox;
    ComboBoxAdr8: TComboBox;
    LabelCV13: TLabel;
    LabelCV14: TLabel;
    LabelCV15: TLabel;
    LabelCV16: TLabel;
    Shape4: TShape;
    LabelAdrSR5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ComboBoxAdr9: TComboBox;
    ComboBoxAdr10: TComboBox;
    LabelCV17: TLabel;
    LabelCV18: TLabel;
    LabelCV19: TLabel;
    LabelCV20: TLabel;
    Shape5: TShape;
    LabelAdrSR6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ComboBoxAdr11: TComboBox;
    ComboBoxAdr12: TComboBox;
    LabelCV21: TLabel;
    LabelCV22: TLabel;
    LabelCV23: TLabel;
    LabelCV24: TLabel;
    Shape6: TShape;
    LabelAdrSR7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    LabelCV25: TLabel;
    LabelCV26: TLabel;
    LabelCV27: TLabel;
    LabelCV28: TLabel;
    ComboBoxAdr13: TComboBox;
    ComboBoxAdr14: TComboBox;
    Shape7: TShape;
    LabelAdrSR8: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    LabelCV29: TLabel;
    LabelCV30: TLabel;
    LabelCV31: TLabel;
    LabelCV32: TLabel;
    ComboBoxAdr15: TComboBox;
    ComboBoxAdr16: TComboBox;
    LabelErreur: TLabel;
    Label900: TLabel;
    EditNEsignal: TEdit;
    Button1: TButton;
    Shape8: TShape;
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxAdr1Change(Sender: TObject);
    procedure ComboBoxAdr2Change(Sender: TObject);
    procedure ComboBoxAdr3Change(Sender: TObject);
    procedure ComboBoxAdr4Change(Sender: TObject);
    procedure ComboBoxAdr5Change(Sender: TObject);
    procedure ComboBoxAdr6Change(Sender: TObject);
    procedure ComboBoxAdr7Change(Sender: TObject);
    procedure ComboBoxAdr8Change(Sender: TObject);
    procedure ComboBoxAdr9Change(Sender: TObject);
    procedure ComboBoxAdr10Change(Sender: TObject);
    procedure ComboBoxAdr11Change(Sender: TObject);
    procedure ComboBoxAdr12Change(Sender: TObject);
    procedure ComboBoxAdr13Change(Sender: TObject);
    procedure ComboBoxAdr14Change(Sender: TObject);
    procedure ComboBoxAdr15Change(Sender: TObject);
    procedure ComboBoxAdr16Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditNEsignalChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSR: TFormSR;
  Adr,IndexSig : integer;
  //etatsDefSR : array[1..16] of integer;  // états par défaut du décodeur SR
procedure couleurs_SR;

implementation


{$R *.dfm}

// efface/affiche les composants en fonction du nombre d'adresses (de 1 à 8)
procedure efface(nadr : integer);
var i : integer;
    c : tComboBox;
    Lb : tLabel;
    s : string;
begin
  for i:=1 to 16 do
  begin
    s:='ComboBoxAdr'+intToSTR(i);
    c:=formSR.findComponent(s) as tComboBox;
    c.Visible:=(i-1)<2*nadr ;

    s:='Label'+intToSTR(i);
    Lb:=formSR.findComponent(s) as tLabel;
    Lb.Visible:=i-1<2*nadr;

    if signaux[indexSig].decodeur=7 then
    begin
      s:='LabelCV'+intToSTR(i*2-1);
      Lb:=formSR.findComponent(s) as tLabel;
      Lb.Visible:=i-1<2*nadr;
      s:='LabelCV'+intToSTR(i*2);
      Lb:=formSR.findComponent(s) as tLabel;
      Lb.Visible:=i-1<2*nadr;
    end;
  end;

  for i:=1 to 8 do
  begin
    s:='LabelAdrSR'+intToSTR(i);
    Lb:=formSR.findComponent(s) as tLabel;
    Lb.visible:=(i-1)<nadr ;
  end;

end;

// valeurs des CV du décodeur SR, uniquement pour l'affichage
procedure etat_SR(etat : integer;var etat1,etat2 : integer) ;
begin
  // etat1 correspond à l'allumage des leds du 1er cycle clignotant
  // etat2 correspond à l'allumage des leds du 2eme cycle clignotant
  etat1:=0;
  etat2:=0;
  case etat of
  // carré
  1 : begin etat1:=$81;etat2:=$81;end;
  // sémaphore+oeilleton
  2 : begin etat1:=$88;etat2:=$88;end;
  // sémaphore cli+oeil
  3 : begin etat1:=$88;etat2:=$08;end;
  // vert+oeil
  4 : begin etat1:=$0C;etat2:=$0C;end;
  // vert cli+oeil
  5 : begin etat1:=$0C;etat2:=$08;end;
  // violet
  6 : begin etat1:=$01;etat2:=$01;end;
  // blanc
  7 : begin etat1:=$02;etat2:=$02;end;
  // blanc cli
  8 : begin etat1:=$02;etat2:=$00;end;
  // jaune+oeil
  9 : begin etat1:=$48;etat2:=$48;end;
  // jaune cli+oeil
  10 : begin etat1:=$48;etat2:=$08;end;
  // ralen 30 (non documenté)
  11 : begin etat1:=$20;etat2:=$20;end;
  // ralen 60 (non documenté)
  12 : begin etat1:=$20;etat2:=$00;end;
  // ral 60+jaune cli
  13 : begin etat1:=$60;etat2:=$00;end;
  // rappel 30 (non documenté)
  14 : begin etat1:=$10;etat2:=$10;end;
  // rappel 60 (non documenté)
  15 : begin etat1:=$10;etat2:=$00;end;
  // ral 30+jaune+oeil
  16 : begin etat1:=$68;etat2:=$68;end;
  // rappel 30+jaune cli+oeil
  17 : begin etat1:=$58;etat2:=$18;end;
  // rappel 60+jaune+oeil
  18 : begin etat1:=$58;etat2:=$48;end;
  // rappel 60+jaune cli+oeil
  19 : begin etat1:=$58;etat2:=$08;end;
  end;
end;


procedure Maj_DB;
var s : string;
begin
  s:=encode_signal(indexSig);
  formconfig.ListBoxSig.items[indexSig-1]:=s;
  formconfig.ListBoxSig.selected[ligneClicSig]:=true;
  aff_champs_signaux(indexSig);
end;  

procedure TFormSR.ComboBoxAdr1Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr1',clyellow);
  i:=ComboBoxAdr1.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV1.Caption:='CV='+IntToSTR(etat1);
  labelCV2.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[1].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr2Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr2',clyellow);
  i:=ComboBoxAdr2.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV3.Caption:='CV='+IntToSTR(etat1);
  labelCV4.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[1].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr3Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr3',clyellow);
  i:=ComboBoxAdr3.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV5.Caption:='CV='+IntToSTR(etat1);
  labelCV6.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[2].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr4Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr4',clyellow);
  i:=ComboBoxAdr4.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV7.Caption:='CV='+IntToSTR(etat1);
  labelCV8.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[2].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr5Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr5',clyellow);
  i:=ComboBoxAdr5.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV9.Caption:='CV='+IntToSTR(etat1);
  labelCV10.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[3].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr6Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr6',clyellow);
  i:=ComboBoxAdr6.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV11.Caption:='CV='+IntToSTR(etat1);
  labelCV12.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[3].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr7Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  if Affevt then affiche('ComboBoxAdr7',clyellow);
  i:=ComboBoxAdr7.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV13.Caption:='CV='+IntToSTR(etat1);
  labelCV14.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[4].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr8Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr8.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV15.Caption:='CV='+IntToSTR(etat1);
  labelCV16.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[4].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr9Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr9.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV17.Caption:='CV='+IntToSTR(etat1);
  labelCV18.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[5].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr10Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr10.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV19.Caption:='CV='+IntToSTR(etat1);
  labelCV20.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[5].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr11Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr11.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV21.Caption:='CV='+IntToSTR(etat1);
  labelCV22.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[6].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr12Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr12.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV23.Caption:='CV='+IntToSTR(etat1);
  labelCV24.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[6].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr13Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr13.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV25.Caption:='CV='+IntToSTR(etat1);
  labelCV26.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[7].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr14Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr14.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV27.Caption:='CV='+IntToSTR(etat1);
  labelCV28.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[7].sortie0:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr15Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr15.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV29.Caption:='CV='+IntToSTR(etat1);
  labelCV30.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[8].sortie1:=i;
  maj_db;
end;

procedure TFormSR.ComboBoxAdr16Change(Sender: TObject);
var etat1,etat2,i : integer;
begin
  i:=ComboBoxAdr16.ItemIndex;
  etat_SR(i,etat1,etat2);
  labelCV31.Caption:='CV='+IntToSTR(etat1);
  labelCV32.Caption:='CV='+IntToSTR(etat2);
  Signaux[indexSig].SR[8].sortie0:=i;
  maj_db;
end;

procedure couleurs_SR;
var i : integer;
    c : tComponent;
begin
  if modesombre then with formSR do
  begin
    color:=couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;
end;

procedure TFormSR.FormCreate(Sender: TObject);
var i,y : integer;
    c : tComboBox;
    sh : tShape;
    Lb : tLabel;
    s : string;
begin
  {
  // états par défaut du décodeur SR , d'après le tableau Etats[]   il y a 13 états valides.
  // manque états 11: ralen30 - 12: ralen 60 - 13 rappel 30 - 14 rappel 60 - 15: ralen 60 + jaune cli - 17 : rappel 30 + jaune cli ??
  // sortie 0
  etatsDefSR[1]:=1;   // carré  - sortie 1
  etatsDefSR[2]:=6;   // violet - sortie 2
  // sortie 1
  etatsDefSR[3]:=2;   // sémaphore  - sortie 1
  etatsDefSR[4]:=3;   // sémaphore cli - sortie 2
  // sortie 2
  etatsDefSR[5]:=9;   // jaune  - sortie 1
  etatsDefSR[6]:=10;  // jaune cli - sortie 2
  // sortie 3
  etatsDefSR[7]:=4;   // vert  - sortie 1
  etatsDefSR[8]:=5;   // vert cli - sortie 2
  // sortie 4
  etatsDefSR[9]:=7;   // blanc  - sortie 1
  etatsDefSR[10]:=8;  // blanc cli - sortie 2
  // sortie 5
  etatsDefSR[11]:=0;  // invalide- sortie 1
  etatsDefSR[12]:=0;  // invalide- sortie 2
  // sortie 6
  etatsDefSR[13]:=16; // jaune + rappel 30  - sortie 1
  etatsDefSR[14]:=18; // jaune + rappel 60 - sortie 2
  // sortie 7
  etatsDefSR[15]:=19; // jaune cli + rappel 60  - sortie 1
  etatsDefSR[16]:=0;  // invalide - sortie 2
  }

  // ajustement des composants
  for i:=1 to 16 do
  begin
    y:=(i-1)*30+30;
    s:='ComboBoxAdr'+intToSTR(i);
    c:=findComponent(s) as tcomboBox;
    c.Top:=y;

    s:='Label'+intToSTR(i);
    Lb:=findComponent(s) as tLabel;
    Lb.top:=y+4;

    s:='LabelCV'+intToSTR(i*2-1);
    Lb:=findComponent(s) as tLabel;
    Lb.top:=y+4;
    s:='LabelCV'+intToSTR(i*2);
    Lb:=findComponent(s) as tLabel;
    Lb.top:=y+4;
  end;
  for i:=1 to 8 do
  begin
    y:=(i-1)*60;
    s:='Shape'+intToSTR(i);
    sh:=findComponent(s) as tshape;
    sh.top:=y+86;
  end;

  for i:=1 to 8 do
  begin
    y:=(i-1)*60;
    s:='LabelAdrSR'+intToSTR(i);
    Lb:=findComponent(s) as tLabel;
    Lb.top:=y+48;
    Lb.Font.Style:=[fsBold];
  end;


  position:=poMainFormCenter;
  {
  for i:=1 to 16 do
  begin

    ComboBoxAdr1.items.add('');
    ComboBoxAdr2.items.add('');
    ComboBoxAdr3.items.add('');
    ComboBoxAdr4.items.add('');
    ComboBoxAdr5.items.add('');
    ComboBoxAdr6.items.add('');
    ComboBoxAdr7.items.add('');
    ComboBoxAdr8.items.add('');
    ComboBoxAdr9.items.add('');
    ComboBoxAdr10.items.add('');
    ComboBoxAdr11.items.add('');
    ComboBoxAdr12.items.add('');
    ComboBoxAdr13.items.add('');
    ComboBoxAdr14.items.add('');
    ComboBoxAdr15.items.add('');
    ComboBoxAdr16.items.add('');
   }
  for i:=0 to 19 do
  begin
    ComboBoxAdr1.items.add(etats[i]);
    ComboBoxAdr2.items.add(etats[i]);
    ComboBoxAdr3.items.add(etats[i]);
    ComboBoxAdr4.items.add(etats[i]);
    ComboBoxAdr5.items.add(etats[i]);
    ComboBoxAdr6.items.add(etats[i]);
    ComboBoxAdr7.items.add(etats[i]);
    ComboBoxAdr8.items.add(etats[i]);
    ComboBoxAdr9.items.add(etats[i]);
    ComboBoxAdr10.items.add(etats[i]);
    ComboBoxAdr11.items.add(etats[i]);
    ComboBoxAdr12.items.add(etats[i]);
    ComboBoxAdr13.items.add(etats[i]);
    ComboBoxAdr14.items.add(etats[i]);
    ComboBoxAdr15.items.add(etats[i]);
    ComboBoxAdr16.items.add(etats[i]);
  end;
  couleurs_SR;
end;

procedure TFormSR.FormActivate(Sender: TObject);
const p2d='+ 2 droit';
      m1d='- 1 dévié';

var dec,erreur,etat1,etat2,ne : integer;
begin
  Val(FormConfig.EditAdrSig.text,Adr,erreur);
  indexSig:=index_Signal(Adr);

  if IndexSig=0 then LabelErreur.caption:='Erreur 512 : signal '+intToSTR(Adr)+' inexistant'
  else
  begin
    dec:=signaux[IndexSig].decodeur;
    // SR
    if dec=7 then
    begin
      label1.Caption:=p2d;
      label2.Caption:=m1d;
      label3.Caption:=p2d;
      label4.Caption:=m1d;
      label5.Caption:=p2d;
      label6.Caption:=m1d;
      label7.Caption:=p2d;
      label8.Caption:=m1d;
      label9.Caption:=p2d;
      label10.Caption:=m1d;
      label11.Caption:=p2d;
      label12.Caption:=m1d;
      label13.Caption:=p2d;
      label14.Caption:=m1d;
      label15.Caption:=p2d;
      label16.Caption:=m1d;
      Caption:='Configuration du décodeur de signal Stéphane Ravaut';
      label303.Visible:=true;
      labelCV1.Visible:=true; labelCV2.Visible:=true; labelCV3.Visible:=true; labelCV4.Visible:=true;
      labelCV5.Visible:=true; labelCV6.Visible:=true; labelCV7.Visible:=true; labelCV8.Visible:=true;
      labelCV9.Visible:=true; labelCV10.Visible:=true; labelCV11.Visible:=true; labelCV12.Visible:=true;
      labelCV13.Visible:=true; labelCV14.Visible:=true; labelCV15.Visible:=true; labelCV16.Visible:=true;
      labelCV17.Visible:=true; labelCV18.Visible:=true; labelCV19.Visible:=true; labelCV20.Visible:=true;
      labelCV21.Visible:=true; labelCV22.Visible:=true; labelCV23.Visible:=true; labelCV24.Visible:=true;
      labelCV25.Visible:=true; labelCV26.Visible:=true; labelCV27.Visible:=true; labelCV28.Visible:=true;
      labelCV29.Visible:=true; labelCV30.Visible:=true; labelCV31.Visible:=true; labelCV32.Visible:=true;
    end;
    // LEA
    if dec=11 then
    begin
      FormSR.Caption:='Configuration du décodeur de signal LEA';
      label303.Visible:=false;
      labelCV1.Visible:=false; labelCV2.Visible:=false; labelCV3.Visible:=false; labelCV4.Visible:=false;
      labelCV5.Visible:=false; labelCV6.Visible:=false; labelCV7.Visible:=false; labelCV8.Visible:=false;
      labelCV9.Visible:=false; labelCV10.Visible:=false; labelCV11.Visible:=false; labelCV12.Visible:=false;
      labelCV13.Visible:=false; labelCV14.Visible:=false; labelCV15.Visible:=false; labelCV16.Visible:=false;
      labelCV17.Visible:=false; labelCV18.Visible:=false; labelCV19.Visible:=false; labelCV20.Visible:=false;
      labelCV21.Visible:=false; labelCV22.Visible:=false; labelCV23.Visible:=false; labelCV24.Visible:=false;
      labelCV25.Visible:=false; labelCV26.Visible:=false; labelCV27.Visible:=false; labelCV28.Visible:=false;
      labelCV29.Visible:=false; labelCV30.Visible:=false; labelCV31.Visible:=false; labelCV32.Visible:=false;
      label1.Caption:=m1d;
      label2.Caption:=p2d;
      label3.Caption:=m1d;
      label4.Caption:=p2d;
      label5.Caption:=m1d;
      label6.Caption:=p2d;
      label7.Caption:=m1d;
      label8.Caption:=p2d;
      label9.Caption:=m1d;
      label10.Caption:=p2d;
      label11.Caption:=m1d;
      label12.Caption:=p2d;
      label13.Caption:=m1d;
      label14.Caption:=p2d;
      label15.Caption:=m1d;
      label16.Caption:=p2d;
    end;
    LabelAdrSR1.caption:=intToSTR(Adr);
    LabelAdrSR2.caption:=intToSTR(Adr+1);
    LabelAdrSR3.caption:=intToSTR(Adr+2);
    LabelAdrSR4.caption:=intToSTR(Adr+3);
    LabelAdrSR5.caption:=intToSTR(Adr+4);
    LabelAdrSR6.caption:=intToSTR(Adr+5);
    LabelAdrSR7.caption:=intToSTR(Adr+6);
    LabelAdrSR8.caption:=intToSTR(Adr+7);

    ComboBoxAdr1.ItemIndex:=Signaux[indexSig].SR[1].sortie1;
    ComboBoxAdr2.ItemIndex:=Signaux[indexSig].SR[1].sortie0;
    ComboBoxAdr3.ItemIndex:=Signaux[indexSig].SR[2].sortie1;
    ComboBoxAdr4.ItemIndex:=Signaux[indexSig].SR[2].sortie0;
    ComboBoxAdr5.ItemIndex:=Signaux[indexSig].SR[3].sortie1;
    ComboBoxAdr6.ItemIndex:=Signaux[indexSig].SR[3].sortie0;
    ComboBoxAdr7.ItemIndex:=Signaux[indexSig].SR[4].sortie1;
    ComboBoxAdr8.ItemIndex:=Signaux[indexSig].SR[4].sortie0;
    ComboBoxAdr9.ItemIndex:=Signaux[indexSig].SR[5].sortie1;
    ComboBoxAdr10.ItemIndex:=Signaux[indexSig].SR[5].sortie0;
    ComboBoxAdr11.ItemIndex:=Signaux[indexSig].SR[6].sortie1;
    ComboBoxAdr12.ItemIndex:=Signaux[indexSig].SR[6].sortie0;
    ComboBoxAdr13.ItemIndex:=Signaux[indexSig].SR[7].sortie1;
    ComboBoxAdr14.ItemIndex:=Signaux[indexSig].SR[7].sortie0;
    ComboBoxAdr15.ItemIndex:=Signaux[indexSig].SR[8].sortie1;
    ComboBoxAdr16.ItemIndex:=Signaux[indexSig].SR[8].sortie0;

    ne:=Signaux[indexSig].Na;  // nombre d'états du signal (2 à 19)
    EditNESignal.Text:=intToSTr(ne);

    if ne=2 then
    begin
      ComboBoxAdr3.Enabled:=false;
      ComboBoxAdr4.Enabled:=false;
      ComboBoxAdr5.Enabled:=false;
      ComboBoxAdr6.Enabled:=false;
      ComboBoxAdr7.Enabled:=false;
      ComboBoxAdr8.Enabled:=false;
      ComboBoxAdr9.Enabled:=false;
      ComboBoxAdr10.Enabled:=false;
      ComboBoxAdr11.Enabled:=false;
      ComboBoxAdr12.Enabled:=false;
      ComboBoxAdr13.Enabled:=false;
      ComboBoxAdr14.Enabled:=false;
      ComboBoxAdr15.Enabled:=false;
      ComboBoxAdr16.Enabled:=false;
    end;


    etat_SR(Signaux[indexSig].SR[1].sortie1,etat1,etat2);
    labelCV1.Caption:='CV='+IntToSTR(etat1);
    labelCV2.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[1].sortie0,etat1,etat2);
    labelCV3.Caption:='CV='+IntToSTR(etat1);
    labelCV4.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[2].sortie1,etat1,etat2);
    labelCV5.Caption:='CV='+IntToSTR(etat1);
    labelCV6.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[2].sortie0,etat1,etat2);
    labelCV7.Caption:='CV='+IntToSTR(etat1);
    labelCV8.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[3].sortie1,etat1,etat2);
    labelCV9.Caption:='CV='+IntToSTR(etat1);
    labelCV10.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[3].sortie0,etat1,etat2);
    labelCV11.Caption:='CV='+IntToSTR(etat1);
    labelCV12.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[4].sortie1,etat1,etat2);
    labelCV13.Caption:='CV='+IntToSTR(etat1);
    labelCV14.Caption:='CV='+IntToSTR(etat2);

    etat_SR(Signaux[indexSig].SR[4].sortie0,etat1,etat2);
    labelCV15.Caption:='CV='+IntToSTR(etat1);
    labelCV16.Caption:='CV='+IntToSTR(etat2);

    etat_SR(Signaux[indexSig].SR[5].sortie1,etat1,etat2);
    labelCV17.Caption:='CV='+IntToSTR(etat1);
    labelCV18.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[5].sortie0,etat1,etat2);
    labelCV19.Caption:='CV='+IntToSTR(etat1);
    labelCV20.Caption:='CV='+IntToSTR(etat2);

    etat_SR(Signaux[indexSig].SR[6].sortie1,etat1,etat2);
    labelCV21.Caption:='CV='+IntToSTR(etat1);
    labelCV22.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[6].sortie0,etat1,etat2);
    labelCV23.Caption:='CV='+IntToSTR(etat1);
    labelCV24.Caption:='CV='+IntToSTR(etat2);

    etat_SR(Signaux[indexSig].SR[7].sortie1,etat1,etat2);
    labelCV25.Caption:='CV='+IntToSTR(etat1);
    labelCV26.Caption:='CV='+IntToSTR(etat2);
    etat_SR(Signaux[indexSig].SR[7].sortie0,etat1,etat2);
    labelCV27.Caption:='CV='+IntToSTR(etat1);
    labelCV28.Caption:='CV='+IntToSTR(etat2);

    etat_SR(Signaux[indexSig].SR[8].sortie1,etat1,etat2);
    labelCV29.Caption:='CV='+IntToSTR(etat1);
    labelCV30.Caption:='CV='+IntToSTR(etat2);

    etat_SR(Signaux[indexSig].SR[8].sortie0,etat1,etat2);
    labelCV31.Caption:='CV='+IntToSTR(etat1);
    labelCV32.Caption:='CV='+IntToSTR(etat2);

  end;
end;

procedure TFormSR.EditNEsignalChange(Sender: TObject);
var i,erreur : integer;
begin
  val(EditNESignal.Text,i,erreur);
  if (erreur<>0) or (i<1) or (i>8) then exit;
  Signaux[ligneClicSig+1].na:=i;
  maj_db;
  efface(i);
end;

procedure TFormSR.Button1Click(Sender: TObject);
begin
  close;
end;

begin
end.

