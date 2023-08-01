unit Importation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormImportation = class(TForm)
    ButtonCompiler: TButton;
    GroupBox2: TGroupBox;
    CheckDebugAnalyse: TCheckBox;
    CheckDebugBranches: TCheckBox;
    GroupBox3: TGroupBox;
    RadioGroup1: TRadioGroup;
    RadioCroisSuite: TRadioButton;
    RadioCroisBase: TRadioButton;
    EditBaseCrois: TEdit;
    ButtonAnnuler: TButton;
    procedure ButtonCompilerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckDebugAnalyseClick(Sender: TObject);
    procedure CheckDebugBranchesClick(Sender: TObject);
    procedure EditBaseCroisChange(Sender: TObject);
    procedure ButtonAnnulerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormImportation: TFormImportation;
  BaseCroisement : integer;
  debugAnalyse,debugBranche,coloration_diff,faireImport : boolean;

implementation

{$R *.dfm}

procedure TFormImportation.ButtonCompilerClick(Sender: TObject);
begin
  faireImport:=true;
  close;
end;

procedure TFormImportation.FormCreate(Sender: TObject);
begin
  radioCroisBase.Checked:=true;
  radioCroisSuite.checked:=false;
  BaseCroisement:=100;
  EditBaseCrois.Text:=IntToSTR(BaseCroisement);
end;

procedure TFormImportation.CheckDebugAnalyseClick(Sender: TObject);
begin
  debugAnalyse:=checkDebugAnalyse.checked;
end;

procedure TFormImportation.CheckDebugBranchesClick(Sender: TObject);
begin
  debugBranche:=checkDebugBranches.checked;
end;

procedure TFormImportation.EditBaseCroisChange(Sender: TObject);
var i,erreur : integer;
begin
  val(editBaseCrois.text,i,erreur);
  if erreur=0 then BaseCroisement:=i;
end;

procedure TFormImportation.ButtonAnnulerClick(Sender: TObject);
begin
  faireImport:=false;
  close;
end;

end.
