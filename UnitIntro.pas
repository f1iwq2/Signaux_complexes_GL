unit UnitIntro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormIntro = class(TForm)
    LabeledEditDetAig: TLabeledEdit;
    ButtonTrCanton: TButton;
    LabeledEditCanton: TLabeledEdit;
    ButtonTrDet: TButton;
    procedure ButtonTrCantonClick(Sender: TObject);
    procedure ButtonTrDetClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormIntro: TFormIntro;
  AchercherDetAig,AchercherCanton : integer;

implementation

{$R *.dfm}

procedure TFormIntro.ButtonTrCantonClick(Sender: TObject);
var erreur : integer;
begin
  val(LabeledEditCanton.text,Acherchercanton,erreur);
  close;
end;



procedure TFormIntro.ButtonTrDetClick(Sender: TObject);
var erreur : integer;
begin
  val(LabeledEditDetAig.text,AchercherDetAig,erreur);
  close;
end;

end.
