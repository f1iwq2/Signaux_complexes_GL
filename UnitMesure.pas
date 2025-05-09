unit UnitMesure;

// mesure de la vitesse des trains

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormMesure = class(TForm)
    ButtonOk: TButton;
    ComboBoxTrains: TComboBox;
    Label1: TLabel;
    LabelEtat: TLabel;
    ButtonLanceMes: TButton;
    Label2: TLabel;
    EditNbrePassages: TEdit;
    ButtonArret: TButton;
    LabelP: TLabel;
    LabelProg: TLabel;
    LabeledEditV1: TLabeledEdit;
    LabeledEditV2: TLabeledEdit;
    LabeledEditV3: TLabeledEdit;
    LabelMesC: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxTrainsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBoxTrainsChange(Sender: TObject);
    procedure ButtonLanceMesClick(Sender: TObject);
    procedure EditNbrePassagesChange(Sender: TObject);
    procedure ButtonArretClick(Sender: TObject);
    procedure LabeledEditV1Change(Sender: TObject);
    procedure LabeledEditV2Change(Sender: TObject);
    procedure LabeledEditV3Change(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormMesure: TFormMesure;
  IndexTrainMes,NbreArret,PhaseVitesse,v1,v2,v3,detecteurREF : integer;

implementation

uses UnitPrinc,unitTCO;

{$R *.dfm}

procedure arret_mesure ;
begin
  mesureTrains:=false;
  vitesse_loco('',0,trains[indexTrainMes].adresse,0,10,ActionVitesse);  // action vitesse pour ne pas g�n�rer d'event vitesse
  with formMesure do
  begin
    ComboBoxTrains.Enabled:=true;
    ButtonLanceMes.Enabled:=true;
  end;
end;

procedure TFormMesure.ButtonOkClick(Sender: TObject);
begin
  arret_mesure;
  close;
end;

procedure TFormMesure.FormCreate(Sender: TObject);
var i : integer;
begin
  with comboBoxTrains do
  begin
    Font.size:=12; // d�termine la hauteur de la combobox
    Style:=csOwnerDrawFixed; // csOwnerDrawVariable;
    items.clear;
    for i:=1 to Ntrains do
    begin
      items.AddObject(Trains[i].nom_train, Trains[i].icone.Picture.graphic);
    end;
    ItemIndex:=-1;
  end;
  IndexTrainMes:=0;
  EditNbrePassages.Text:='3';
  LabeledEditV1.Text:='40';
  LabeledEditV2.Text:='60';
  LabeledEditV3.Text:='80';
  LabelMesC.Visible:=false;
end;


procedure TFormMesure.ComboBoxTrainsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var LargDest,HautDest,l,h : integer;
    cv : TCanvas;
begin
  Cv:=ComboBoxTrains.canvas;
  LargDest:=70;
  HautDest:=18;
  l:=Trains[index+1].Icone.width;
  h:=Trains[index+1].Icone.Height;

  if index mod 2<>1 then
  begin
    cv.brush.color:=clWindow;
    cv.fillrect(rect);
  end
  else
    begin
    cv.brush.color:=clWindow;
    cv.fillrect(rect);
  end;
     // Affichage du texte
     cv.font.style:=canvas.font.style+[fsbold];
     cv.textout(rect.left+largDest+5,rect.top,ComboBoxTrains.items[index]);
     if (odSelected in state) then
     begin
       cv.brush.color:=clWindowFrame;
       cv.fillrect(rect);
       //cv.font.color:=clblue;
       cv.textout(rect.left+largDest+5,rect.top,ComboBoxTrains.items[index]);
     end;

     TransparentBlt(cv.Handle,rect.Left+2,rect.Top,largDest,hautDest,
                    Trains[index+1].Icone.canvas.Handle,0,0,l,h,clWhite);
end;

procedure TFormMesure.ComboBoxTrainsChange(Sender: TObject);
var i,idc : integer;
    trouve : boolean;
begin
  i:=ComboBoxTrains.itemindex+1;
  if i<1 then exit;
  idc:=1;
  repeat
    trouve:=canton[idc].adresseTrain=trains[i].adresse;
    inc(idc);
  until (idc>ncantons) or trouve;
  dec(idc);
  if not trouve then
  begin
    LabelEtat.Caption:='Le train '+trains[i].nom_train+' n''est d�pos� sur aucun canton';
    IndexTrainMes:=0;
    ButtonLanceMes.Enabled:=false;
  end
  else
  begin
    IndexTrainMes:=i;
    LabelEtat.caption:='';
    ButtonLanceMes.Enabled:=true;
  end;
end;

procedure TFormMesure.ButtonLanceMesClick(Sender: TObject);
var el1,el2,i,det_depart,el : integer;
    t1,t2,t : Tequipement;
    s: string;
    boucle : boolean;
begin
  if (IndexTrainMes<1) or mesureTrains then exit;
  i:=trains[indexTrainMes].canton;       // num�ro du canton sur lequel le train se trouve
  if i=0 then
  begin
    Affiche('Le train '+trains[indexTrainMes].nom_train+'ne se trouve sur aucun canton',clred);
    exit;
  end;
  el1:=canton[i].el1; t1:=canton[i].typ1;
  el2:=canton[i].el2; t2:=canton[i].typ2;
  if t1=det then det_depart:=el1;
  if t2=det then det_depart:=el2;

  i:=0;
  repeat
    el:=suivant_alg3(el1,t1,el2,t2,1);
    t:=typeGen;

    el1:=el2;t1:=t2;
    el2:=el;t2:=t;

    inc(i);
  until (i>50) or (el>9000) or (el=det_depart);

  boucle:=true;
  if el>9000 then
  begin
    if el=9996 then
    begin
      s:='La position de l''aiguillage '+intToSTR(el1)+' est inconnue'+#13;
      s:=s+'L''itin�raire du train '+trains[indexTrainMes].nom_train+' peut ne pas �tre boucl�.'+#13;
      boucle:=false;
    end
    else
    begin
      s:='Il n''est pas possible de d�terminer si l''itin�raire du train '+trains[indexTrainMes].nom_train+' est boucl�.'+#13;
      boucle:=false;
    end;
  end
  else
    if el<>det_depart then
    begin
      s:='Il n''est pas possible de d�terminer si l''itin�raire du train '+trains[indexTrainMes].nom_train+' est boucl�.'+#13;
      boucle:=false;
    end;

  if not boucle then
  begin
    s:=s+'Voulez vous continuer?';
    if MessageDlg(s,mtConfirmation,[mbNo,mbYes],0)=mrNo then exit;
  end;

  ComboBoxTrains.Enabled:=false;
  ButtonLanceMes.Enabled:=false;
  Affiche('Mesure vitesse 1',clYellow);
  PhaseVitesse:=1;  // vitesse 1 2 ou 3
  DetecteurREF:=0;

  mesureTrains:=true;
  vitesse_loco('',0,trains[indexTrainMes].adresse,v1,10,ActionVitesse);  // ActionVitesse pour ne pas g�n�rer d'event_vitesse

  LabelMesC.Visible:=true;
  LabelMesC.top:=178;
end;

procedure TFormMesure.EditNbrePassagesChange(Sender: TObject);
var i,erreur  : integer;
begin
  val(editNbrePassages.Text,i,erreur);
  if (erreur<>0) or (i<2) or (i>6) then
  begin
    editNbrePassages.Text:='3';
    exit;
  end;
  NbreArret:=i;
end;

procedure TFormMesure.ButtonArretClick(Sender: TObject);
begin
  arret_mesure;
  Affiche('Arret',clYellow);
end;

procedure TFormMesure.LabeledEditV1Change(Sender: TObject);
var erreur : integer;
begin
  val(LabeledEditV1.Text,v1,erreur);
  if IndexTrainMes<1 then exit;
end;

procedure TFormMesure.LabeledEditV2Change(Sender: TObject);
var erreur : integer;
begin
  val(LabeledEditV2.Text,v2,erreur);
  if IndexTrainMes<1 then exit;
end;

procedure TFormMesure.LabeledEditV3Change(Sender: TObject);
var erreur : integer;
begin
  val(LabeledEditV3.Text,v3,erreur);
  if IndexTrainMes<1 then exit;
end;


end.
