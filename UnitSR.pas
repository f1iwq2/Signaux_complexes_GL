// Unité pour la configuration du décodeur Stéphane Ravaux

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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape1: TShape;
    LabelAdrSR2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
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
    Label10: TLabel;
    Label11: TLabel;
    ComboBoxAdr5: TComboBox;
    ComboBoxAdr6: TComboBox;
    LabelCV9: TLabel;
    LabelCV10: TLabel;
    LabelCV11: TLabel;
    LabelCV12: TLabel;
    Shape3: TShape;
    LabelAdrSR4: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBoxAdr7: TComboBox;
    ComboBoxAdr8: TComboBox;
    LabelCV13: TLabel;
    LabelCV14: TLabel;
    LabelCV15: TLabel;
    LabelCV16: TLabel;
    Shape4: TShape;
    LabelAdrSR5: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComboBoxAdr9: TComboBox;
    ComboBoxAdr10: TComboBox;
    LabelCV17: TLabel;
    LabelCV18: TLabel;
    LabelCV19: TLabel;
    LabelCV20: TLabel;
    Shape5: TShape;
    LabelAdrSR6: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    ComboBoxAdr11: TComboBox;
    ComboBoxAdr12: TComboBox;
    LabelCV21: TLabel;
    LabelCV22: TLabel;
    LabelCV23: TLabel;
    LabelCV24: TLabel;
    Shape6: TShape;
    LabelAdrSR7: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LabelCV25: TLabel;
    LabelCV26: TLabel;
    LabelCV27: TLabel;
    LabelCV28: TLabel;
    ComboBoxAdr13: TComboBox;
    ComboBoxAdr14: TComboBox;
    Shape7: TShape;
    LabelAdrSR8: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    LabelCV29: TLabel;
    LabelCV30: TLabel;
    LabelCV31: TLabel;
    LabelCV32: TLabel;
    ComboBoxAdr15: TComboBox;
    ComboBoxAdr16: TComboBox;
    LabelErreur: TLabel;
    BitBtnok: TBitBtn;
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
    procedure BitBtnokClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSR: TFormSR;
  Adr,IndexSig : integer;
  
procedure couleurs_SR;

implementation


{$R *.dfm}

procedure etat_SR(etat : integer;var etat1,etat2 : integer) ;
begin
  // etat1 correspond à l'allumage des leds du 1er cycle clignotant
  // etat2 correspond à l'allumage des leds du 2eme cycle clignotant
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


procedure TFormSR.FormActivate(Sender: TObject);
var erreur,etat1,etat2 : integer;
begin
  Val(FormConfig.EditAdrSig.text,Adr,erreur);
  indexSig:=index_Signal(Adr);
  if IndexSig=0 then LabelErreur.caption:='Erreur feu inexistant'
  else
  begin
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
  if sombre then with formSR do
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
var i : integer;
begin
  position:=poMainFormCenter;
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

procedure TFormSR.BitBtnokClick(Sender: TObject);
begin
  close;
end;

begin
end.

