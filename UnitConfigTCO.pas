unit UnitConfigTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormConfigTCO = class(TForm)
    ButtonOK: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelNbCellX: TLabel;
    LabelNbCellY: TLabel;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormConfigTCO: TFormConfigTCO;

implementation

{$R *.dfm}

procedure TFormConfigTCO.ButtonOKClick(Sender: TObject);
begin
  close;
end;

end.
