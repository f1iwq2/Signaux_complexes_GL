unit UnitIntro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormIntro = class(TForm)
    LabeledEditDetAig: TLabeledEdit;
    ButtonTrouver: TButton;
    procedure ButtonTrouverClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormIntro: TFormIntro;
  Achercher : integer;

implementation

{$R *.dfm}

procedure TFormIntro.ButtonTrouverClick(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditDetAig.text,i,erreur);
  Achercher:=i;
  close;
end;

end.
