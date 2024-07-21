program Signaux_complexes_GL;

uses
  Forms,
  UnitDebug in 'UnitDebug.pas' {FormDebug},
  UnitPrinc in 'UnitPrinc.pas' {FormPrinc},
  verif_version in 'verif_version.pas' {FormVersion},
  UnitPilote in 'UnitPilote.pas' {FormPilote},
  UnitSimule in 'UnitSimule.pas' {FormSimulation},
  UnitTCO in 'UnitTCO.pas' {FormTCO},
  UnitConfig in 'UnitConfig.pas' {FormConfig},
  UnitConfigTCO in 'UnitConfigTCO.pas' {FormConfigTCO},
  UnitSR in 'UnitSR.pas' {FormSR},
  Unit_Pilote_aig in 'Unit_Pilote_aig.pas' {FormAig},
  UnitConfigCellTCO in 'UnitConfigCellTCO.pas' {FormConfCellTCO},
  UnitCDF in 'UnitCDF.pas' {FormCDF},
  UnitPareFeu in 'UnitPareFeu.pas',
  UnitAnalyseSegCDM in 'UnitAnalyseSegCDM.pas' {FormAnalyseCDM},
  Importation in 'Importation.pas' {FormImportation},
  MSCommLib_TLB in 'MSCommLib_TLB.pas',
  UnitHorloge in 'UnitHorloge.pas' {FormHorloge},
  UnitFicheHoraire in 'UnitFicheHoraire.pas' {FormFicheHoraire},
  UnitClock in 'UnitClock.pas' {FormClock},
  UnitModifAction in 'UnitModifAction.pas' {FormModifAction},
  selection_train in 'selection_train.pas' {FormSelTrain},
  UnitRoute in 'UnitRoute.pas' {FormRoute},
  UnitRouteTrains in 'UnitRouteTrains.pas' {FormRouteTrain},
  UnitInfo in 'UnitInfo.pas' {FormInfo};

{$R *.res}

begin
  // la form TCO ne doit pas etre créée ici!!
  Application.Initialize;
  Application.Title := 'Signaux complexes GL';
  Application.CreateForm(TFormPrinc, FormPrinc);
  Application.CreateForm(TFormDebug, FormDebug);
  Application.CreateForm(TFormPilote, FormPilote);
  Application.CreateForm(TFormSimulation, FormSimulation);
  Application.CreateForm(TFormConfig, FormConfig);
  Application.CreateForm(TFormConfigTCO, FormConfigTCO);
  Application.CreateForm(TFormSR, FormSR);
  Application.CreateForm(TFormAig, FormAig);
  Application.CreateForm(TFormConfCellTCO, FormConfCellTCO);
  Application.CreateForm(TFormCDF, FormCDF);
  Application.CreateForm(TFormAnalyseCDM, FormAnalyseCDM);
  Application.CreateForm(TFormImportation, FormImportation);
  Application.CreateForm(TFormFicheHoraire, FormFicheHoraire);
  Application.CreateForm(TFormVersion, FormVersion);
  Application.CreateForm(TFormClock, FormClock);
  Application.CreateForm(TFormHorloge, FormHorloge);
  Application.CreateForm(TFormModifAction, FormModifAction);
  Application.CreateForm(TFormSelTrain, FormSelTrain);
  Application.CreateForm(TFormRoute, FormRoute);
  Application.CreateForm(TFormRouteTrain, FormRouteTrain);
  Application.CreateForm(TFormInfo, FormInfo);
  fin_preliminaire;
  Application.Run;
end.
