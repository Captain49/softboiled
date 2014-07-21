program Stakka;

uses
  Forms,
  DiskMaintenanceFrm in 'DiskMaintenanceFrm.pas' {DiskMaintenanceForm},
  BaseFrm in 'BaseFrm.pas' {BaseForm},
  MainDM in 'MainDM.pas' {MainDataModule: TDataModule},
  BaseMainMenuFrm in 'BaseMainMenuFrm.pas' {BaseMainMenuForm},
  BaseMaintenanceFrm in 'BaseMaintenanceFrm.pas' {BaseMaintenanceForm},
  Main in 'Main.pas' {MainForm},
  Utilities in 'Utilities.pas',
  QueryFrm in 'QueryFrm.pas' {QueryForm},
  Unit1 in 'Unit1.pas' {TestForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainDataModule, MainDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
