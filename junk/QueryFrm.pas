unit QueryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrm, DB, ADODB, fcButton, fcImgBtn, fcShapeBtn,
  fcClearPanel, fcButtonGroup, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid,
  StdCtrls, ComCtrls, wwriched, PrintDAT, SAMSSplitter;

type
  TQueryForm = class(TBaseForm)
    TopPanel: TPanel;
    ButtonGroupTop: TfcButtonGroup;
    btnRun: TfcShapeBtn;
    Query: TADOQuery;
    DataSource: TDataSource;
    btnPrint: TfcShapeBtn;
    PrintDAT: TPdtPrintDAT;
    SplitterPanel: TSAMSSplitterPanel;
    Edit: TwwDBRichEdit;
    Grid: TwwDBGrid;
    procedure btnRunClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure GridTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  MainDM;
  
procedure TQueryForm.btnRunClick(Sender: TObject);
var
  CallSQL: string;
begin
  inherited;

  CallSQL := Query.SQL.Text;
  Query.Close;
  Query.SQL.Assign(Edit.Lines);
  try
    Query.Open;
  except
    on E: Exception do
    begin
      Application.ShowException(E);
      if pos('SELECT', CallSQL) > 0 then
      begin
        Query.SQL.Text := CallSQL;
        Query.Open;
      end;  
    end;  
  end;
  btnRun.Down := false;
end;

procedure TQueryForm.btnExecuteClick(Sender: TObject);
begin
  inherited;

  Query.Close;
  Query.SQL.Assign(Edit.Lines);
  Query.ExecSQL;
end;

procedure TQueryForm.btnPrintClick(Sender: TObject);
begin
  inherited;
  PrintDat.Print;
  btnPrint.Down := false;
end;

procedure TQueryForm.GridTitleButtonClick(Sender: TObject; AFieldName: String);
begin
  inherited;
  if (MessageDlg('Remove ' +AFieldName +' from grid', mtConfirmation, [mbNo, mbOK], 0) in [mrOk]) then
    Grid.RemoveField(AFieldName, true);
end;

procedure TQueryForm.FormCreate(Sender: TObject);
begin
  inherited;

  SplitterPanel.Align := alClient;
  Edit.Parent := SplitterPanel.Panel1;
  Grid.Parent := SplitterPanel.Panel2;

  Edit.Align := alClient;
  Grid.Align := alClient;
  
  Edit.Lines.Text := 'SELECT * FROM tDisc ORDER BY DateFirstAdded desc';
end;

end.
