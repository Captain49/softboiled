unit DiskMaintenanceFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB, StdCtrls, BaseMaintenanceFrm,
  BaseFrm, Wwlocate, wwDialog, wwrcdvw, Menus, Wwdatsrc, wwdblook,
  fcButton, fcImgBtn, fcShapeBtn, fcClearPanel, fcButtonGroup, fcLabel,
  ExtCtrls, PrintDAT, QueryFrm, Mask, wwdbedit, SAMSSplitter, DBCtrls;

type
  TDiskMaintenanceForm = class(TBaseMaintenanceForm)
    procedure FormShow(Sender: TObject);
    procedure ParentGridTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
    FQueryForm: TQueryForm;
//    procedure CheckFields; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ResetGrids(const ClearSelected: boolean = true); override;
    procedure SetRecordView; override;

    procedure SetNewRowValues; override;
    procedure SetParams; override;
    
    property QueryForm: TQueryForm read FQueryForm write FQueryForm; 
  end;

implementation

{$R *.dfm}

uses
  MainDM;

constructor TDiskMaintenanceForm.Create(AOwner: TComponent);
begin
  inherited;

  ParentTable := 'tDisc';
  ParentKey   := 'ID';

  ParentQuery.Close;
  ParentQuery.SQL.Clear;
  ParentQuery.SQL.Add('SELECT');
  ParentQuery.SQL.Add('  tDisc.ID AS ID,');
  ParentQuery.SQL.Add('  tDisc.Name AS DiscName,');
//  ParentQuery.SQL.Add('  tDisc.GroupID AS GroupID,');
//  ParentQuery.SQL.Add('  tUnit.Name AS UnitName,');
//  ParentQuery.SQL.Add('  tDisc.Slot AS Slot,');
  ParentQuery.SQL.Add('  tDisc.Comments AS Comments,');
  ParentQuery.SQL.Add('  tDiscGroups.Group AS GroupName');
  ParentQuery.SQL.Add('FROM');
  ParentQuery.SQL.Add('  (tDisc');
  ParentQuery.SQL.Add('LEFT OUTER JOIN tUnit ON tUnit.ID = tDisc.UnitID)');
  ParentQuery.SQL.Add('LEFT OUTER JOIN tDiscGroups ON tDiscGroups.ID = tDisc.GroupID');
end;


procedure TDiskMaintenanceForm.ResetGrids(const ClearSelected: boolean);
begin
  inherited;

  ParentQuery.DisableControls;

  ParentGrid.Selected.Clear;
  
  if ShowHidden then
  begin
    SetGridField('ID', ParentGrid);
  end;  
  SetGridField('UnitName', ParentGrid, 'Unit');
  SetGridField('DiscName', ParentGrid, 'Name');
  SetGridField('GroupName', ParentGrid, 'Group');
//  SetGridField('Slot', ParentGrid, 'Slot');
//  SetGridField('Comments', ParentGrid, 'Comments');

  NotesMemo.DataField := 'Comments';
  
  ParentGrid.ApplySelected;
  ParentQuery.EnableControls;

end;


procedure TDiskMaintenanceForm.FormShow(Sender: TObject);
begin
  ResetGrids(false);
  
  inherited;
end;

procedure TDiskMaintenanceForm.SetRecordView;
begin
  inherited;

  LookupQuery1.SQL.Clear;
  LookupQuery1.SQL.Add('SELECT * FROM tDiscGroups');
  LookupQuery1.Open;

  LookupCombo1.LookupTable := LookupQuery1;
  LookupCombo1.LookupField := 'Group';
  
  RecordEdit.Selected.Add('Name'#9'50'#9'Name');
  RecordEdit.Selected.Add('GroupID'#9'20'#9'Group');

//  RecordEdit.ControlType.Clear;
//  RecordEdit.ControlType.Add('GroupID;CustomEdit;LookUpCombo1;F');
end;

procedure TDiskMaintenanceForm.ParentGridTitleButtonClick(Sender: TObject;
  AFieldName: String);
var 
  ASortFields: TSortFields;
begin
  inherited;

  if SameText(AFieldName, 'DiscName') then
  begin
    SetLength(ASortFields, 1); 
    ASortFields[0] := 'tDisc.Name'; 
    SetSortOrder(ParentGrid, ASortFields);
  end else if SameText(AFieldName, 'UnitName') then 
  begin
    SetLength(ASortFields, 2); 
    ASortFields[0] := 'tUnit.Name'; 
    ASortFields[1] := 'tDisc.Name'; 
    SetSortOrder(ParentGrid, ASortFields);
  end else if SameText(AFieldName, 'GroupName') then 
  begin
    SetLength(ASortFields, 2); 
    ASortFields[0] := 'tDiscGroups.Group'; 
    ASortFields[1] := 'tDisc.Name'; 
    SetSortOrder(ParentGrid, ASortFields);
  end;  
  
end;

procedure TDiskMaintenanceForm.btnQueryClick(Sender: TObject);
begin
  inherited;

  if FQueryForm = nil then
    QueryForm := TQueryForm.Create(nil);
  FQueryForm.ShowModal;
  btnQuery.Down := false;
end;

procedure TDiskMaintenanceForm.SetNewRowValues;
begin
  inherited;
  // Nothing to do yet
end;

procedure TDiskMaintenanceForm.SetParams;
begin
  inherited;
  // Nothing to do yet
end;

end.
