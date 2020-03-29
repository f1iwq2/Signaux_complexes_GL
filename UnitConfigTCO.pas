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
    LabelNbCellX: TLabel;
    LabelNbCellY: TLabel;
    ButtonDessine: TButton;
    CheckDessineGrille: TCheckBox;
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonDessineClick(Sender: TObject);
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

procedure TFormConfigTCO.ButtonOKClick(Sender: TObject);
var i,erreur : integer;
begin
  Val(EditTailleCellX.Text,i,erreur);
  LargeurCell:=i;
  Val(EditTailleCellY.Text,i,erreur);
  HauteurCell:=i;
  with formTCO do
  begin
    ImageTCO.Width:=LargeurCell*NbreCellX;
    ImageTCO.Height:=HauteurCell*NbreCellY;
  end;  
  AvecGrille:=checkDessineGrille.Checked;
  formTCO.affiche_TCO;
  close;
end;

procedure TFormConfigTCO.FormCreate(Sender: TObject);
begin
  EditTailleCellX.Text:=IntToSTR(LargeurCell);
  EditTailleCellY.Text:=IntToSTR(HauteurCell);
  LabelNbCellX.Caption:=IntToSTR(NbreCellX);
  LabelNbCellY.Caption:=IntToSTR(NbreCellY);
  
end;



procedure TFormConfigTCO.ButtonDessineClick(Sender: TObject);
var i,erreur : integer;
    r : Trect;
    c : tCanvas;
begin
   
  Val(EditTailleCellX.Text,i,erreur);
  LargeurCell:=i;
  Val(EditTailleCellY.Text,i,erreur);
  HauteurCell:=i;
  with formTCO do
  begin
    ImageTCO.Width:=LargeurCell*NbreCellX;
    ImageTCO.Height:=HauteurCell*NbreCellY;
  end;  
  formTCO.affiche_TCO;
end;

end.
