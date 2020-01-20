program Signaux_complexes_GL;

uses
  Forms,
  UnitPrinc in 'UnitPrinc.pas' {FormPrinc},
  UnitDebug in 'UnitDebug.pas' {FormDebug};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrinc, FormPrinc);
  Application.Run;
end.
