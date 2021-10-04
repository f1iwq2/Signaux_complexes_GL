program Signaux_complexes_GL;

uses
  Forms,
  UnitPrinc in 'UnitPrinc.pas' {FormPrinc},
  UnitDebug in 'UnitDebug.pas' {FormDebug},
  verif_version in 'verif_version.pas' {FormVersion},
  UnitPilote in 'UnitPilote.pas' {FormPilote},
  UnitSimule in 'UnitSimule.pas' {FormSimulation},
  UnitTCO in 'UnitTCO.pas' {FormTCO},
  UnitConfig in 'UnitConfig.pas' {FormConfig},
  UnitConfigTCO in 'UnitConfigTCO.pas' {FormConfigTCO},
  UnitSR in '..\macro fichier\UnitSR.pas' {FormSR};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrinc, FormPrinc);
  Application.CreateForm(TFormDebug, FormDebug);
  Application.CreateForm(TFormPilote, FormPilote);
  Application.CreateForm(TFormSimulation, FormSimulation);
  Application.CreateForm(TFormConfig, FormConfig);
  Application.CreateForm(TFormConfigTCO, FormConfigTCO);
  Application.CreateForm(TFormVersion, FormVersion);
  Application.CreateForm(TFormSR, FormSR);
  Application.Run;
end.
