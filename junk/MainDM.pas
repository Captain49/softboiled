unit MainDM;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TMainDataModule = class(TDataModule)
    Connection: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
 end;

var
  MainDataModule: TMainDataModule;

implementation

{$R *.dfm}

uses
  Utilities;

procedure TMainDataModule.DataModuleCreate(Sender: TObject);
var
  ConStr: string;
  DataSourceName: string;
begin
  ConStr := 'Provider=MSDASQL;User ID=Admin;Data Source=%s';
  GetParam('ds', DataSourceName);

  if DataSourceName <> '' then
    Connection.ConnectionString := Format(ConStr, [DataSourceName]); 
      
  Connection.Connected := true;
end;

procedure TMainDataModule.DataModuleDestroy(Sender: TObject);
begin
  Connection.Connected := false;
end;

end.
