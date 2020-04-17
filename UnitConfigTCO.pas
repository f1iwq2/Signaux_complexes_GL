unit UnitConfigTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , UnitTCO;

type
  TFormConfigTCO = class(TForm)
    ButtonOK: TButton;
    Label1: TLabel;
    EditTailleCellX: TEdit;
    EditTailleCellY: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ButtonDessine: TButton;
    CheckDessineGrille: TCheckBox;
    EditNbCellX: TEdit;
    EditNbCellY: TEdit;
    LabelErreur: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonDessineClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var  FormConfigTCO: TFormConfigTCO;
     AvecGrille : boolean;

implementation

uses UnitPrinc;


{$R *.dfm}

function verif_config_TCO : boolean;  // renvoie true si ok
var erreur : integer;
    nokNbX,nokNbY,nokHt,nokLg : boolean;
begin
  with formConfigTCO do
  begin
    Val(EditNbCellX.Text,NbreCellX,erreur);
    nokNbX:=erreur<>0;
    if nokNbX then LabelErreur.caption:='Erreur nombre de cellules X';
    nokNbX:=(NbreCellX<20) or (NbreCellX>MaxCellX);
    if nokNbX then LabelErreur.caption:='Erreur: nombre de cellules X: mini=20 maxi='+IntToSTR(MaxCellX);

    Val(EditNbCellY.Text,NbreCellY,erreur);
    nokNbY:=erreur<>0;
    if nokNbY then LabelErreur.caption:='Erreur: nombre de cellules Y';
    nokNbY:=nokNbY or (NbreCellY<10) or (NbreCellY>MaxCellY);
    if nokNbY then LabelErreur.caption:='Erreur: nombre de cellules Y: mini=10 maxi='+IntToSTR(MaxCellY);

    Val(EditTailleCellX.Text,LargeurCell,erreur);
    nokLg:=erreur<>0;
    if nokLg then LabelErreur.caption:='Erreur largeur de cellules';
    nokLg:=nokLg or (LargeurCell<20) or (LargeurCell>50)  ;
    if nokLg then LabelErreur.caption:='Erreur: Tailles des cellules - largeur cellules mini=20 maxi=50';
  
    Val(EditTailleCellY.Text,HauteurCell,erreur);
    nokHt:=erreur<>0;
    if nokHt then LabelErreur.caption:='Erreur hauteur de cellules';
    nokHt:=nokHt or (HauteurCell<20) or (HauteurCell>50)  ;
    if nokHt then LabelErreur.caption:='Erreur: Tailles des cellules - hauteur cellules mini=20 maxi=50';

    AvecGrille:=checkDessineGrille.Checked;
  end;
  verif_config_TCO:=not(nokNbX or nokNbY or nokHt or nokLg);
end;

procedure TFormConfigTCO.ButtonOKClick(Sender: TObject);
var i : integer;   
    
begin
  if verif_config_TCO then
  begin
    with formTCO do
    begin
      ImageTCO.Width:=LargeurCell*NbreCellX;
      ImageTCO.Height:=HauteurCell*NbreCellY;
    end;  
    AvecGrille:=checkDessineGrille.Checked;
    formTCO.affiche_TCO;
    LabelErreur.caption:='';
    close;
  end; 
end;

procedure TFormConfigTCO.ButtonDessineClick(Sender: TObject);
var i,erreur : integer;
    r : Trect;
    c : tCanvas;
begin
  if verif_config_TCO then
  begin
    with formTCO do
    begin
      ImageTCO.Width:=LargeurCell*NbreCellX;
      ImageTCO.Height:=HauteurCell*NbreCellY;
    end;  
    formTCO.affiche_TCO;
  end;  
end;




procedure TFormConfigTCO.FormActivate(Sender: TObject);
begin
  EditTailleCellX.Text:=IntToSTR(LargeurCell);
  EditTailleCellY.Text:=IntToSTR(HauteurCell);
  EditNbCellX.Text:=IntToSTR(NbreCellX);
  EditNbCellY.Text:=IntToSTR(NbreCellY);
  checkDessineGrille.Checked:=AvecGrille;
end;

end.
