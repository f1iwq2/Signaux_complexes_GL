unit UnitConfigTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

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
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormConfigTCO: TFormConfigTCO;
  LargeurCell,HauteurCell,NbreCellX,NbreCellY : integer ;

implementation

uses UnitTCO;

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
    Affiche_TCO;
  end;  
  close;
end;

procedure TFormConfigTCO.FormCreate(Sender: TObject);
begin
  EditTailleCellX.Text:=IntToSTR(LargeurCell);
  EditTailleCellY.Text:=IntToSTR(HauteurCell);
  LabelNbCellX.Caption:=IntToSTR(NbreCellX);
  LabelNbCellY.Caption:=IntToSTR(NbreCellY);
  
end;



end.
