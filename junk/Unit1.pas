unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrm, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid, DB,
  ADODB;

type
  TTestForm = class(TBaseForm)
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    wwDBGrid1: TwwDBGrid;
    ADOQuery2: TADOQuery;
    LookupCombo1: TwwDBLookupCombo;
    procedure LookupCombo1CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  MainDM;

procedure TTestForm.LookupCombo1CloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if modified then
  begin
	  ADOQuery1.FieldByName('GroupID').AsInteger := ADOQuery2.FieldByName('ID').AsInteger;
  end;
end;

procedure TTestForm.FormShow(Sender: TObject);
begin
  inherited;
  ADOQuery1.Open;
  ADOQuery2.Open;
end;

end.

