unit UnitMemZone;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormMemZone = class(TForm)
    ButtonOk: TButton;
    LabeledEditDet1: TLabeledEdit;
    LabeledEditDet2: TLabeledEdit;
    Label1: TLabel;
    LabelInfo: TLabel;
    ButtonAct: TButton;
    ButtonDes: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Label3: TLabel;
    ButtonClicDet1: TButton;
    Button1: TButton;
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonActClick(Sender: TObject);
    procedure ButtonDesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonClicDet1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormMemZone: TFormMemZone;
  det1Z,det2Z: integer;
  formZone,clicDet1,clicDet2   : boolean;

procedure actualise_memZone(indexTCO : integer);

implementation

uses UnitPrinc, unitTCO;

{$R *.dfm}

procedure actualise_memZone(indexTCO : integer);
var adr,x,y,Bim : integer;
begin
  if (indexTCO=0) or (formMemZone=nil) or not(FormZone) then exit;
  x:=XclicCell[indexTCO];
  y:=YclicCell[indexTCO];
  Bim:=Tco[indexTCO,x,y].bimage;
  if IsVoieDroite(bim) then
  begin
    Adr:=tco[indexTCO,x,y].Adresse;
    if (adr>0) and FormZone then
    begin
      if clicDet1 then formMemZone.LabeledEditdet1.Text:=intToStr(Adr);
      if clicDet2 then formMemZone.LabeledEditdet2.Text:=intToStr(Adr);
      clicDet1:=false;
      clicDet2:=false;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TFormMemZone.ButtonOkClick(Sender: TObject);
begin
  FormZone:=false;
  close;
end;

function valide_det : boolean;
var erreur : integer;
    elsuiv : tEquipement;
begin
  result:=false;
  val(FormMemZone.labeledEditDet1.text,det1Z,erreur);
  if (erreur<>0) or (det1Z<1) or (det1Z>NbMaxDet) then
  begin
    FormMemZone.LabelInfo.Caption:='Erreur détecteur 1';exit;
  end;
  val(FormMemZone.labeledEditDet2.text,det2Z,erreur);
  if (erreur<>0) or (det2Z<1) or (det2Z>NbMaxDet) then
  begin
    FormMemZone.LabelInfo.Caption:='Erreur détecteur 2';exit;
  end;

  val(FormMemZone.labeledEditDet2.text,det2Z,erreur);
  det_contigu(det1Z,det2Z,suivant,ElSuiv);

  if suivant=0 then
  begin
    FormMemZone.LabelInfo.Caption:='Les détecteurs '+intToSTR(det1Z)+' / '+intToSTR(det2Z)+' ne sont pas contigus';
    exit;
  end;
  FormMemZone.LabelInfo.caption:='';
  result:=true;
end;

procedure TFormMemZone.ButtonActClick(Sender: TObject);
begin
  if valide_det then
  begin
    Memzone[det1Z,det2Z].etat:=true;
    LabelInfo.caption:='MemZone '+intToSTR(det1Z)+' -> '+intToSTR(det2Z)+' à 1';
    Maj_Signaux(false);
  end;
end;

procedure TFormMemZone.ButtonDesClick(Sender: TObject);
begin
  if valide_det then
  begin
    Memzone[det1Z,det2Z].etat:=false;
    LabelInfo.caption:='MemZone '+intToSTR(det1Z)+' -> '+intToSTR(det2Z)+' à 0';
    Maj_Signaux(false);
  end;
end;

procedure TFormMemZone.FormCreate(Sender: TObject);
begin
  // fenêtre toujours devant
  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
end;

procedure TFormMemZone.FormActivate(Sender: TObject);
begin
  FormZone:=true;
end;

procedure TFormMemZone.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  clicDet1:=false;
  clicDet2:=false;
  Screen.Cursor:=crDefault;
  FormZone:=false;
end;

procedure TFormMemZone.ButtonClicDet1Click(Sender: TObject);
begin
  clicDet1:=true;
  Screen.Cursor:=crHandPoint; //crHourGlass;
end;

procedure TFormMemZone.Button1Click(Sender: TObject);
begin
  clicDet2:=true;
  Screen.Cursor:=crHandPoint;
end;

end.
