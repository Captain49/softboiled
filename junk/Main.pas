unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseMainMenuFrm, Menus, DiskMaintenanceFrm;

type
  TMainForm = class(TBaseMainMenuForm)
    mnuFile: TMenuItem;
    mnuFileDiskMaintenance: TMenuItem;
    mnuExit: TMenuItem;
    mnuTest: TMenuItem;
    procedure mnuFileDiskMaintenanceClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuTestClick(Sender: TObject);
  private
    FDiskMaintenanceForm: TDiskMaintenanceForm;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    property DiskMaintenanceForm: TDiskMaintenanceForm read FDiskMaintenanceForm write FDiskMaintenanceForm;
    
  end;
  
var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Unit1;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  //
end;

destructor TMainForm.Destroy;
begin
  FreeAndNil(FDiskMaintenanceForm);
  inherited;
end;

procedure TMainForm.mnuFileDiskMaintenanceClick(Sender: TObject);
begin
  inherited;

  if FDiskMaintenanceForm = nil then
    FDiskMaintenanceForm := TDiskMaintenanceForm.Create(nil);
  FDiskMaintenanceForm.Show;    
end;

procedure TMainForm.mnuExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TMainForm.mnuTestClick(Sender: TObject);
var
  TestForm: TTestForm;
begin
  TestForm := TTestForm.Create(nil);
  try
    TestForm.ShowModal; 
  finally
    TestForm.Free;
  end;
                      
  
end;

end.
