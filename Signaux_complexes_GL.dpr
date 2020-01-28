program Signaux_complexes_GL;

uses
  Forms,
  UnitPrinc in 'UnitPrinc.pas' {FormPrinc},
  UnitDebug in 'UnitDebug.pas' {FormDebug},
  verif_version in 'verif_version.pas' {FormVersion},
  UnitPilote in 'UnitPilote.pas' {FormPilote};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrinc, FormPrinc);
  Application.CreateForm(TFormDebug, FormDebug);
  Application.CreateForm(TFormPilote, FormPilote);
  Application.Run;
end.
