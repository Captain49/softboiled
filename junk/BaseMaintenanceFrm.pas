{$I sbs.inc}

unit BaseMaintenanceFrm;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI7ABOVE} Variants, {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, Wwdbigrd, Wwdbgrid, Contnrs, wwMemo,
  Wwdatsrc, fcButton, fcImgBtn, fcShapeBtn, wwDialog, wwrcdvw, StdCtrls,
  wwdblook, Wwdbdlg, Wwlocate, fcLabel, BaseFrm, Menus,
  ExtCtrls, fcClearPanel, fcButtonGroup, ADODB, PrintDAT, Mask, wwdbedit,
  SAMSSplitter, DBCtrls;

type
  TSortFields = array of string;
  TSQLMode = (SQLInsert, SQLUpdate, SQLDelete);
  TSQLModes = set of TSQLMode;
  TAfterSQL = procedure of object;
  
  TFieldWarning = class(TObject)
  private
    FText: string;                                                                         
    FFieldName: string;
    FOriginalValue: variant;
    FValidated: boolean;
    FSQLModes: TSQLModes;
  public
    property FieldName: string read FFieldName write FFieldName;
    property Text: string read FText write FText;
    property OriginalValue: variant read FOriginalValue write FOriginalValue;
    property Validated: boolean read FValidated write FValidated;
    property SQLModes: TSQLModes read FSQLModes write FSQLModes;
  end;

  TFieldWarnings = class(TObjectList)
  protected
    function GetItems(Index: Integer): TFieldWarning;
    procedure SetItems(Index: Integer; AFieldWarning: TFieldWarning);
  public
    procedure SetInsertValues(DataSet: TDataSet);
    procedure CheckValues(Sender: TObject; DataSet: TDataSet);
    property Items[Index: Integer]: TFieldWarning read GetItems write SetItems; default;
  end;

  TBaseMaintenanceForm = class(TBaseForm)
    TopPanel: TPanel;
    lblStatus: TfcLabel;
    RecordViewDialogMenu: TMainMenu;
    RecordEdit: TwwRecordViewDialog;
    LocateDialog: TwwLocateDialog;
    ButtonGroupTop: TfcButtonGroup;
    btnNew: TfcShapeBtn;
    btnEdit: TfcShapeBtn;
    btnDelete: TfcShapeBtn;
    btnSearch: TfcShapeBtn;
    btnPrint: TfcShapeBtn;
    PrintDAT: TPdtPrintDAT;
    btnQuery: TfcShapeBtn;
    SplitterPanel: TSAMSSplitterPanel;
    NotesGroup: TGroupBox;
    ParentGroup: TGroupBox;
    ParentGrid: TwwDBGrid;
    LookupCombo2: TwwDBLookupCombo;
    LookupCombo3: TwwDBLookupCombo;
    LookupCombo4: TwwDBLookupCombo;
    LookupCombo5: TwwDBLookupCombo;
    NotesMemo: TDBMemo;
    RecordEditQuery: TADOQuery;
    LookupQuery1: TADOQuery;
    LookupQuery2: TADOQuery;
    LookupQuery3: TADOQuery;
    LookupQuery4: TADOQuery;
    LookupQuery5: TADOQuery;
    ParentQuery: TADOQuery;
    ParentDataSource: TwwDataSource;
    RecordEditDataSource: TwwDataSource;
    LookupCombo1: TwwDBLookupCombo;
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSearchClick(Sender: TObject);
    procedure ParentGridCellChanged(Sender: TObject);
    procedure RecordEditCloseDialog(Form: TwwRecordViewForm);
    procedure ParentGridEnter(Sender: TObject);
    procedure ParentGridRowChanged(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDeleteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnNewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnSearchMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ParentGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure ParentGridTitleButtonClick(Sender: TObject;
      AFieldName: String);
  private
    { Private declarations }
    FLastFieldChange: string;
    FRecordModified: boolean;
    FNoParentRows: boolean;
    FParentSQL: TStrings;
    FEditRowTable: string;
    FNewRowTable: string;
    FLastID_1: integer;
    FParentTable: string;
    FParentKey: string;
    FNewRowValues: TParams;
    FFieldWarnings: TFieldWarnings;
    FSQLMode: TSQLMode;
    FUseLastID: boolean;
    FLastID_2: integer;
    FShowHidden: boolean;
    FAfterInsert: TAfterSQL;

    procedure ClearRecordView;
    function GetParentKey: integer;
    procedure CheckAltPress(Button: TMouseButton; Shift: TShiftState); overload;
    procedure CheckAltPress(var Key: Word; Shift: TShiftState); overload;
    procedure CheckCtrlPress(Button: TMouseButton; Shift: TShiftState); overload;
    procedure CheckCtrlPress(var Key: Word; Shift: TShiftState); overload;
    
    function GetAltPress: boolean;
    procedure SetAltPress(const Value: boolean);
    function GetCtrlPress: boolean;
    procedure SetCtrlPress(const Value: boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetPersistent(const Value: boolean); override;

    procedure SaveToReg; override;    
    procedure LoadFromReg; override;    
    
    function FindField(FieldName: string; List: TStrings): integer;

    procedure ResetGrids(const ClearSelected: boolean = true); virtual;
    procedure SetEditButton; virtual;
    procedure SetDeleteButton; virtual;
    procedure SetSearchButton; virtual;
    procedure SetSortOrder(Grid: TwwDBGrid; ASortFields: TSortFields); virtual;

    procedure SetGridField(AFieldName: String;
       Grid: TwwDBGrid; AFieldLabel: string = ''; LabelWidth: integer = 10); virtual;
    
//    procedure SetGridTestField(AFieldName: String;
//       Grid: TwwDBGrid; AFieldLabel: string = ''; LabelWidth: integer = 10); virtual;

    function MakeSetLine(const AAlias, AFieldName: string; AddComma: boolean = false): string;   
       
       
    procedure UpdateField(Query: TADOQuery; AFieldName: string;
      NotNull: boolean = false);

    procedure FieldNotEmpty(Query: TADOQuery; AFieldName: string);
      
    procedure FieldNotNull(Query: TADOQuery; AFieldName: string);
    procedure ParamNotNull(Query: TADOQuery; AParamName: string);

    procedure ParamToQuery(QueryTo, QueryFrom: TADOQuery; AFieldName: string);
      
    procedure SetRecordViewCaption(ACaption: TCaption; AMode: TSQLMode);

    procedure SetRecordView; virtual;
    procedure SetNewRowValues; virtual; abstract;
    procedure SetParams; virtual; abstract;

    procedure SetTest(const Value: boolean); override;
    
    procedure SetHidden(var Key: Word; Shift: TShiftState);

    property LastID_1: integer read FLastID_1 write FLastID_1;
    property LastID_2: integer read FLastID_2 write FLastID_2;
    property LastFieldChange: string read FLastFieldChange write FLastFieldChange;
    property RecordModified: boolean read FRecordModified write FRecordModified;
    property NoParentRows: boolean read FNoParentRows write FNoParentRows;
    property ParentSQL: TStrings read FParentSQL write FParentSQL;
    property NewRowTable: string read FNewRowTable write FNewRowTable;
    property EditRowTable: string read FEditRowTable write FEditRowTable;

    property ParentTable: string read FParentTable write FParentTable;
    property ParentKey: string read FParentKey write FParentKey;
    
    property NewRowValues: TParams read FNewRowValues write FNewRowValues;
    property FieldWarnings: TFieldWarnings read FFieldWarnings write FFieldWarnings;
    property SQLMode: TSQLMode read FSQLMode write FSQLMode;
    property UseLastID: boolean read FUseLastID write FUseLastID;
    property CtrlPress: boolean read GetCtrlPress write SetCtrlPress;
    property AltPress: boolean read GetAltPress write SetAltPress;
    property ShowHidden: boolean read FShowHidden write FShowHidden;

    property AfterInsert: TAfterSQL read FAfterInsert write FAfterInsert;
  end;

const
  BorderPad = 2;
  NOT_NULL = true;
  NULL_OK = false;
  ADD_COMMA = true;
  FAltPress: boolean = false;
  FCtrlPress: boolean = false;
  
implementation

uses
  ComObj,
  Math,
  Main, MainDM, Utilities;

{$R *.dfm}

constructor TBaseMaintenanceForm.Create(AOwner: TComponent);
  function MakeTempName(Seed: PChar): string;
  var
    pc: PChar;
  begin
    pc := StrAlloc(MAX_PATH + 1);
    GetTempFileName(PChar(''), Seed, 0, pc);
    Result := copy(string(pc), 2, 60);
    Result := ChangeFileExt(Result, '');
    DeleteFile(pc);
  end;
begin
  inherited;


  RecordEditQuery.Close;
  LookupQuery1.Close;
  LookupQuery2.Close;
  LookupQuery3.Close;
  LookupQuery4.Close;
  LookupQuery5.Close;
  ParentQuery.Close;
  
  RecordEditQuery.Connection := MainDataModule.Connection;
  ParentQuery.Connection  := MainDataModule.Connection; 
  LookupQuery1.Connection := MainDataModule.Connection;
  LookupQuery2.Connection := MainDataModule.Connection;
  LookupQuery3.Connection := MainDataModule.Connection;
  LookupQuery4.Connection := MainDataModule.Connection;
  LookupQuery5.Connection := MainDataModule.Connection;

  RecordEditDataSource.DataSet := RecordEditQuery;
  ParentDataSource.DataSet := ParentQuery;
  
  FUseLastID := false;
  FFieldWarnings := TFieldWarnings.Create;

  FNewRowValues := TParams.Create(nil);
  FNewRowTable := MakeTempName('new');
  FEditRowTable := MakeTempName('edt');

  FParentSQL := TStringList.Create;
  ParentQuery.Close;

  // This will blank them all
//  ClearRecordView;

  // This will hide 'em
  LookupCombo1.Visible := false;
  LookupCombo2.Visible := false;
  LookupCombo3.Visible := false;
  LookupCombo4.Visible := false;
  LookupCombo5.Visible := false;
  
  // We need to make sure the DataSets, DataSources etc are assigned correctly...
  ParentDataSource.DataSet := ParentQuery;
  ParentGrid.DataSource := ParentDataSource;

  NotesMemo.DataSource  := ParentDataSource;

  RecordEditDataSource.DataSet := RecordEditQuery;
  RecordEdit.DataSource := RecordEditDataSource;

  LocateDialog.DataSource := ParentDataSource;

  if Test then
    RecordEdit.Options := RecordEdit.Options -[rvoHideNavigator]
  else
    RecordEdit.Options := RecordEdit.Options +[rvoHideNavigator];

  ParentGrid.Options := ParentGrid.Options -[dgEditing];
  ParentGrid.Options := ParentGrid.Options +[dgPerfectRowFit];
  ParentGrid.ReadOnly := true;

  ParentGrid.MemoAttributes := ParentGrid.MemoAttributes +[mGridShow];

  lblStatus.Visible := false;
end;

destructor TBaseMaintenanceForm.Destroy;
var
  i: integer;
begin
  FreeAndNil(FNewRowValues);
  FreeAndNil(FParentSQL);

  for i := 0 to FFieldWarnings.Count -1 do
    FFieldWarnings[i].Free;
//  FFieldWarnings.Free;
  inherited;
end;


procedure TBaseMaintenanceForm.btnEditClick(Sender: TObject);
begin
  inherited;

  btnEdit.Down := false;
  
  if ParentTable = '' then
    Raise Exception.Create('ParentTable NOT set');

  if ParentKey = '' then
    Raise Exception.Create('ParentKey NOT set');
  
  ClearRecordView;
  SetRecordView;
                  
  RecordEditQuery.SQL.Clear;
  RecordEditQuery.SQL.Add('SELECT * FROM ' +ParentTable);
  RecordEditQuery.SQL.Add('WHERE ' +ParentKey +' = :' +ParentKey);
  if FUseLastID then
//    RecordEditQueryXXX.ParamByName(ParentKey).AsInteger := FLastID_1
    RecordEditQuery.Parameters.FindParam(ParentKey).Value := FLastID_1
  else
//    RecordEditQueryXXX.ParamByName(ParentKey).AsInteger := GetParentKey;
    RecordEditQuery.Parameters.FindParam(ParentKey).Value := GetParentKey;
//  RecordEditQueryXXX.ExecSQL;     
//  RecordEditQueryXXX.Close;
//  RecordEditQueryXXX.SQL.Clear;
//  RecordEditQueryXXX.SQL.Add('SELECT * FROM ' +EditRowTable);
  RecordEditQuery.Open;

  FieldWarnings.SetInsertValues(RecordEditQuery);

  while RecordEdit.Execute do
  begin
    try
//      CheckFields;
    except
      on E:Exception do
      begin
        Application.ShowException(E);
        continue;
      end;
    end;  
(*
    UpdateQuery.Close;
    UpdateQuery.SQL.Clear;
    UpdateQuery.SQL.Add('UPDATE ' +ParentTable);
    UpdateQuery.SQL.Add(Format(UpdateSQL, [ParentKey, LastID_1]));

    SetParams;
    
    try
      UpdateQuery.ExecSQL;
    except
      on E:Exception do
      begin
        if (E is EDatabaseError) then
        begin
          Application.ShowException(E);
          continue;
        end
        else
          Raise;
      end;
    end;
*)
    ParentQuery.Refresh;

    // If we got this far then outa here -------------------------------->
    break;
  end;
end;

procedure TBaseMaintenanceForm.btnNewClick(Sender: TObject);
var
  i: integer;
begin
  inherited;

  btnNew.Down := false;
  
  if ParentTable = '' then
    Raise Exception.Create('ParentTable NOT set');

  if ParentKey = '' then
    Raise Exception.Create('ParentKey NOT set');

  SetNewRowValues;  
    
  ClearRecordView;
  SetRecordView;
  
  RecordEditQuery.SQL.Clear; 
  RecordEditQuery.SQL.Add(GetCreateTempTable(ParentTable, NewRowTable, MainDataModule.Connection));
  RecordEditQuery.ExecSQL;
  
  for i := 0 to NewRowValues.Count -1 do
    if NewRowValues[i] <> nil then
//      RecordEditQueryXXX.ParamByName(NewRowValues[i].Name).Value := NewRowValues[i].Value;
      RecordEditQuery.Parameters.FindParam(NewRowValues[i].Name).Value := NewRowValues[i].Value;
  
  RecordEditQuery.ExecSQL;
  
  RecordEditQuery.Close;
  RecordEditQuery.SQL.Clear;
  RecordEditQuery.SQL.Add('SELECT * FROM ' +NewRowTable);
//  RecordEditQueryXXX.RequestLive := true;
  RecordEditQuery.Open;

  LastID_1 := -1;
  while RecordEdit.Execute do
  begin
    try
    //  CheckFields;
    except
      on E:Exception do
      begin
        Application.ShowException(E);
        continue;
      end;
    end;  

    if ParentQuery.Active then
       ParentQuery.Refresh;

    // If we got this far then outa here -------------------------------->
    break;
  end;
end;

procedure TBaseMaintenanceForm.FormShow(Sender: TObject);
begin
  inherited;
  (*
  TopPanel.Height := btnNew.Height +(BorderPad * 2);
  TopPanel.Align := alTop;

  btnNew.Top := BorderPad;
  btnEdit.Top := BorderPad;
  btnDelete.Top := BorderPad;
  btnSearch.Top := BorderPad;

  btnNew.Left := BorderPad;
  btnEdit.Left := btnNew.Left +btnNew.Width +BorderPad;
  btnDelete.Left := btnEdit.Left +btnEdit.Width +BorderPad;
  btnSearch.Left := btnDelete.Left +btnDelete.Width +BorderPad;
  *)

  if ClassParent = TBaseMaintenanceForm then
  begin
    ParentGroup.Parent := SplitterPanel.Panel1;
    NotesGroup.Parent := SplitterPanel.Panel2;
  
//    NotesGroup.Align := alNone;
//    ParentGroup.Align := alNone;
  
//    NotesGroup.Align := alRight;
//    ParentGroup.Align := alClient;
  end;
  ParentQuery.Open;
end;

procedure TBaseMaintenanceForm.SetPersistent(const Value: boolean);
begin
  inherited;

  if Value then
  begin
    ParentGrid.UseTFields := false;
    ParentGrid.IniAttributes.CheckNewFields := true;
    ParentGrid.IniAttributes.Enabled := true;
    ParentGrid.IniAttributes.FileName := Section;
    ParentGrid.IniAttributes.SaveToRegistry := true;
    ParentGrid.IniAttributes.SectionName := ParentGrid.Name;
  end;

end;

function TBaseMaintenanceForm.FindField(FieldName: string; List: TStrings): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to List.Count -1 do
  begin
    if Pos(FieldName, List[i]) > 0 then
    begin
      Result := i;
      break;
    end;
  end;
end;

procedure TBaseMaintenanceForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ParentQuery.Close;
end;

procedure TBaseMaintenanceForm.ClearRecordView;
begin
  inherited;

  RecordEditQuery.Close;
  RecordEditQuery.SQL.Clear;
  RecordEditQuery.SQL.Add('DROP TABLE ' +NewRowTable);
  try
    RecordEditQuery.ExecSQL;
  except
    on E: Exception do
      if not (E is EOleException) then
        Raise;
  end;  
  RecordEditQuery.Close;

  RecordEditQuery.Close;
  RecordEditQuery.SQL.Clear;
  RecordEditQuery.SQL.Add('DROP TABLE ' +EditRowTable);
  try
    RecordEditQuery.ExecSQL;
  except
    on E: Exception do
      if not (E is EOleException) then
        Raise;
  end;  
  
  // Start off 'blank'
  ParentGrid.ControlType.Clear;
  
  RecordEdit.Selected.Clear;
  RecordEdit.ControlType.Clear;
  LookupCombo1.Selected.Clear;
  LookupCombo1.DataField := '';
  LookupCombo1.DataSource := nil;
  LookupCombo1.LookupTable := nil;
  LookupCombo1.LookupField := '';
  LookUpQuery1.Close;
  LookUpQuery1.SQL.Clear;

  LookUpCombo2.Selected.Clear;
  LookUpCombo2.DataField := '';
  LookUpCombo2.DataSource := nil;
  LookUpCombo2.LookupTable := nil;
  LookUpCombo2.LookupField := '';
  LookUpQuery2.Close;
  LookUpQuery2.SQL.Clear;

  LookUpCombo3.Selected.Clear;
  LookUpCombo3.DataField := '';
  LookUpCombo3.DataSource := nil;
  LookUpCombo3.LookupTable := nil;
  LookUpCombo3.LookupField := '';
  LookUpQuery3.Close;
  LookUpQuery3.SQL.Clear;

  LookUpCombo4.Selected.Clear;
  LookUpCombo4.DataField := '';
  LookUpCombo4.DataSource := nil;
  LookUpCombo4.LookupTable := nil;
  LookUpCombo4.LookupField := '';
  LookUpQuery4.Close;
  LookUpQuery4.SQL.Clear;
  
  LookUpCombo5.Selected.Clear;
  LookUpCombo5.DataField := '';
  LookUpCombo5.DataSource := nil;
  LookUpCombo5.LookupTable := nil;
  LookUpCombo5.LookupField := '';
  LookUpQuery5.Close;
  LookUpQuery5.SQL.Clear;
end;

procedure TBaseMaintenanceForm.ResetGrids(const ClearSelected: boolean);
begin
  inherited;

  if ClearSelected then
    ParentGrid.Selected.Clear;
end;

procedure TBaseMaintenanceForm.btnSearchClick(Sender: TObject);
begin
  inherited;

  btnSearch.Down := false;
  
  LocateDialog.DataSource := ParentDataSource;
  LocateDialog.SearchField := LastFieldChange;
  if LocateDialog.Execute then
  begin
  end;

end;

procedure TBaseMaintenanceForm.ParentGridCellChanged(Sender: TObject);
begin
  inherited;
  if TwwDBGrid(Sender).GetActiveField <> nil then
    LastFieldChange := TwwDBGrid(Sender).GetActiveField.FieldName;
end;

procedure TBaseMaintenanceForm.RecordEditCloseDialog(
  Form: TwwRecordViewForm);
begin
  inherited;

  RecordModified := RecordEditQuery.Modified;
  FieldWarnings.CheckValues(Self, RecordEditQuery);
end;


procedure TBaseMaintenanceForm.SetDeleteButton;
begin
  if ParentGrid.Focused then
    btnDelete.Enabled := (not NoParentRows);
end;

procedure TBaseMaintenanceForm.SetEditButton;
begin
  if ParentGrid.Focused then
    btnEdit.Enabled := (not NoParentRows);
end;

procedure TBaseMaintenanceForm.SetSearchButton;
begin
  if ParentGrid.Focused then
    btnSearch.Enabled := (not NoParentRows);
end;

procedure TBaseMaintenanceForm.ParentGridEnter(Sender: TObject);
begin
  inherited;
  ParentGridRowChanged(Sender);
end;

procedure TBaseMaintenanceForm.ParentGridRowChanged(Sender: TObject);
begin
  inherited;
  NoParentRows := (ParentGrid.DataSource.DataSet.BoF and ParentGrid.DataSource.DataSet.EoF);
  SetDeleteButton;
  SetEditButton;
  SetSearchButton;
end;

procedure TBaseMaintenanceForm.SetSortOrder(Grid: TwwDBGrid; ASortFields: TSortFields);
var
  i: integer;
  CallSQL: string;
  LastLine: string;
  OrderLine: string;
  CallID: integer;
  Query: TADOQuery;
begin
  inherited;

  // Just makes it easier.......
  if not (Grid.DataSource.DataSet is TADOQuery) then
    Raise Exception.Create('SetSortOrder must have a TADOQuery as the Grid.DataSource.DataSet');
  
  Query := TADOQuery(Grid.DataSource.DataSet);
  
  if dgMultiSelect in Grid.Options then
    Grid.UnSelectAll;
  
//  FLastFieldChange := ASortField;

  OrderLine := 'ORDER BY ';
  for i := 0 to length(ASortFields) -2 do
    OrderLine := OrderLine +ASortFields[i] +',';
  OrderLine := OrderLine +ASortFields[length(ASortFields) -1];
    
  CallSQL := Query.SQL.Text;
  CallID := Query.Fields[0].AsInteger;
  Query.Close;
  LastLine := Query.SQL[Pred(Query.SQL.Count)];
  if (Copy(LastLine, 1, 8) <> 'ORDER BY') then
    Query.SQL.Add(OrderLine)
  else
  begin
    if (LastLine = OrderLine) then
      OrderLine := OrderLine +' DESC';
    Query.SQL[Pred(Query.SQL.Count)] := OrderLine;
  end;

  try
    Query.Open;
    Query.First;
    while not Query.Eof do
    begin
      if (Query.Fields[0].AsInteger = CallID) then
        break;
      Query.Next;
    end;    
  except
    on E: Exception do
    begin
      if (E is EDatabaseError) then
      begin
        Query.SQL.Text := CallSQL;
        Query.Open;
      end else
        Raise;
    end;
  end;
end;

(*
procedure TContributionBaseMaintenanceForm.SetGridTestField(
  AFieldName: String; Grid: TwwDBGrid; AFieldLabel: string; LabelWidth: integer);
var
  i: integer;
begin
  i := FindField(AFieldName, Grid.Selected);
  if not Test then
  begin
    if i > -1 then
    begin
      Grid.Selected.Delete(i);
    end;
  end else
  begin
    if i = -1 then
    begin
      if AFieldLabel = '' then
        AFieldLabel := AFieldName;
      Grid.Selected.Add(AFieldName +#9 +IntToStr(LabelWidth) +#9 +AFieldLabel);
    end;
  end;
end;
*)

procedure TBaseMaintenanceForm.SetGridField(AFieldName: String;
  Grid: TwwDBGrid; AFieldLabel: string; LabelWidth: integer);
var
  FieldSpec: string;  
begin
  try
    if RegINIFile = nil then
      Raise Exception.Create('No RegINIfile assigned');
    FieldSpec := RegINIFile.ReadString(Section +'\' +Grid.Name, AFieldName, '');
    if FieldSpec <> '' then
      LabelWidth := StrToInt(Copy(FieldSpec, 1, Pos(';', FieldSpec) -1));  
  except
    on E:Exception do
      Application.ShowException(E);
  end;

  if AFieldLabel = '' then
    AFieldLabel := AFieldName;
  if FindField(AFieldName, Grid.Selected) = -1 then
    Grid.Selected.Add(AFieldName +#9 +IntToStr(LabelWidth) +#9 +AFieldLabel);
end;

procedure TBaseMaintenanceForm.UpdateField(Query: TADOQuery;
  AFieldName: string; NotNull: boolean);
var
  ThisField: TField;  
begin
  if NotNull then
    FieldNotNull(RecordEditQuery, AFieldName);

  ThisField := Query.FieldByName(AFieldName);
  if ThisField = nil then
    Raise Exception.Create('A field named: ' +AFieldName +' not found');
(*    
  case ThisField.DataType of
    ftInteger: Query.ParamByName(AFieldName).AsInteger := RecordEditQueryXXX.FieldByName(AFieldName).AsInteger;
    ftFloat: Query.ParamByName(AFieldName).AsFloat := RecordEditQueryXXX.FieldByName(AFieldName).AsFloat;
    ftDate: Query.ParamByName(AFieldName).AsDate := RecordEditQueryXXX.FieldByName(AFieldName).AsDateTime;
    ftTime: Query.ParamByName(AFieldName).AsTime := RecordEditQueryXXX.FieldByName(AFieldName).AsDateTime;
    ftString: Query.ParamByName(AFieldName).AsString := RecordEditQueryXXX.FieldByName(AFieldName).AsString;
  else
    Query.ParamByName(AFieldName).Value := RecordEditQueryXXX.FieldByName(AFieldName).Value;
  end;
*)
  Query.Parameters.FindParam(AFieldName).Value := RecordEditQuery.FieldByName(AFieldName).Value;  
end;


function TBaseMaintenanceForm.MakeSetLine(
          const AAlias, AFieldName: string; AddComma: boolean = false): string;
begin
  Result := '  ';
  if AAlias <> '' then
    Result := Result +AAlias +'.' +AFieldName +' = :' +AFieldName
  else  
    Result := Result +AFieldName +' = :' +AFieldName;
  if AddComma then
    Result := Result +',';   
end;


procedure TBaseMaintenanceForm.FieldNotNull(Query: TADOQuery; AFieldName: string);
begin
  if Query.FieldByName(AFieldName).IsNull then 
    Raise Exception.Create(AFieldName +' - field is NULL');
end;

procedure TBaseMaintenanceForm.ParamNotNull(Query: TADOQuery; AParamName: string);
begin
//  if Query.ParamByName(AParamName).IsNull then  
  if Query.Parameters.FindParam(AParamName) = nil then
    Raise Exception.Create(AParamName +' - parameter is nil');
end;

procedure TBaseMaintenanceForm.FieldNotEmpty(Query: TADOQuery; AFieldName: string);
var
  ThisField: TField;  
begin
  ThisField := Query.FieldByName(AFieldName);
  if ThisField = nil then
    Raise Exception.Create('No field named: ' +AFieldName +' found');

  case ThisField.DataType of
    ftInteger: begin
      if Query.FieldByName(AFieldName).AsInteger = 0 then
        Raise Exception.Create(AFieldName +' - field is 0');
    end;  
    ftFloat: begin
      if Query.FieldByName(AFieldName).AsFloat = 0 then
        Raise Exception.Create(AFieldName +' - field is 0');
    end;  
    ftDate: begin
      if Query.FieldByName(AFieldName).AsDateTime = 0 then
        Raise Exception.Create(AFieldName +' - field is empty date');
    end;  
    
    ftTime: begin
      if Query.FieldByName(AFieldName).AsDateTime = 0 then
        Raise Exception.Create(AFieldName +' - field is empty time');
    end;  
    ftString: begin
      if Query.FieldByName(AFieldName).AsString = '' then
        Raise Exception.Create(AFieldName +' - field is empty string');
    end;  
  end;
end;

function TBaseMaintenanceForm.GetParentKey: integer;
begin
  Result := ParentQuery.FieldByName(ParentKey).AsInteger;
  FLastID_1 := Result;
end;

procedure TBaseMaintenanceForm.btnDeleteClick(Sender: TObject);
var
  MessageText: string;
begin
  inherited;

  btnDelete.Down := false;
  
  if ParentTable = '' then
    Raise Exception.Create('ParentTable NOT set');

  if ParentKey = '' then
    Raise Exception.Create('ParentKey NOT set');
  
  try
    try
    except
      on E:Exception do
      begin
        if (E is EDatabaseError) then
        begin
          MessageText := 'This record can''t be deleted'+#13+#10;
          MessageText := MessageText +'OK for more details';
          if MessageBox(0, PAnsiChar(MessageText), 'Deletion error', MB_ICONINFORMATION or MB_OKCANCEL or MB_DEFBUTTON2) = idOk then
            MessageDlg(E.Message, mtWarning, [mbOK], 0);
        end else
          Raise;
      end;
    end;
  finally
    ParentQuery.Refresh;
  end;
end;

procedure TBaseMaintenanceForm.ParamToQuery(
  QueryTo, QueryFrom: TADOQuery; AFieldName: string);
begin
//  QueryTo.ParamByName(AFieldName).Value := QueryFrom.FieldByName(AFieldName).Value;
  QueryTo.Parameters.FindParam(AFieldName).Value := QueryFrom.FieldByName(AFieldName).Value;
end;


{ TFieldWarnings }

function TFieldWarnings.GetItems(Index: Integer): TFieldWarning;
begin
  Result := TFieldWarning(inherited Items[Index]);
end;

procedure TFieldWarnings.CheckValues(Sender: TObject; DataSet: TDataSet);
var
  i: integer;
  ThisField: TField;
  ThisForm: TBaseMaintenanceForm;
begin
  if Sender is TBaseMaintenanceForm then
    ThisForm := TBaseMaintenanceForm(Sender)
  else
    ThisForm := nil;  
               
  for i := 0 to Count -1 do
  begin
    ThisField := DataSet.FieldByName(Self[i].FieldName);
    if ThisField <> nil then
    begin
      if (Self[i].OriginalValue <> ThisField.Value) and (not Self[i].Validated) then
      begin
        if (ThisForm <> nil) and (ThisForm.SQLMode in Self[i].SQLModes) then
        begin   
          if (MessageDlg(Self[i].Text +#13#10 +'Accept changes?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
          begin
            Self[i].Validated := true;
          end else
          begin
            ThisField.Value := Self[i].OriginalValue;
            Self[i].Validated := true;
          end;  
        end;     
      end;
    end;  
  end;  
end;

procedure TFieldWarnings.SetItems(Index: Integer; AFieldWarning: TFieldWarning);
begin
  inherited Items[Index] := AFieldWarning;
  AFieldWarning.Validated := false;
end;

procedure TFieldWarnings.SetInsertValues(DataSet: TDataSet);
var
  i: integer;
  ThisField: TField;
begin
  for i := 0 to Count -1 do
  begin
    ThisField := DataSet.FieldByName(Self[i].FieldName);
    if ThisField <> nil then
      Self[i].OriginalValue := ThisField.Value;      
  end;  
end;

procedure TBaseMaintenanceForm.SetRecordView;
var
  i: integer;
begin
  for i := 0 to FieldWarnings.Count -1 do  
    FieldWarnings[i].Validated := false;

  RecordEdit.Selected.Clear;
  RecordEdit.ControlType.Clear;
end;

procedure TBaseMaintenanceForm.SetRecordViewCaption(ACaption: TCaption; AMode: TSQLMode);
begin
  RecordEdit.Caption := Text;
  FSQLMode := AMode;
end;

procedure TBaseMaintenanceForm.CheckAltPress(
  Button: TMouseButton; Shift: TShiftState);
begin
  inherited;
  FAltPress := (Button = mbLeft) and (ssAlt in Shift);
end;

procedure TBaseMaintenanceForm.CheckAltPress(
   var Key: Word; Shift: TShiftState);
begin
  inherited;
  FAltPress := (ssAlt in Shift);
end;

procedure TBaseMaintenanceForm.CheckCtrlPress(
  Button: TMouseButton; Shift: TShiftState);
begin
  FAltPress := (Button = mbLeft) and (ssCtrl in Shift);
end;

procedure TBaseMaintenanceForm.CheckCtrlPress(var Key: Word;
  Shift: TShiftState);
begin
  FAltPress := (ssCtrl in Shift);
end;


procedure TBaseMaintenanceForm.btnEditMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CheckAltPress(Button, Shift);
end;

procedure TBaseMaintenanceForm.btnDeleteMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  CheckAltPress(Button, Shift);
end;

procedure TBaseMaintenanceForm.btnNewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CheckAltPress(Button, Shift);
end;

procedure TBaseMaintenanceForm.btnSearchMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  CheckAltPress(Button, Shift);
end;

function TBaseMaintenanceForm.GetAltPress: boolean;
begin
  Result := FAltPress;
end;

procedure TBaseMaintenanceForm.SetAltPress(const Value: boolean);
begin
  FAltPress := Value;
end;

function TBaseMaintenanceForm.GetCtrlPress: boolean;
begin
  Result := FCtrlPress;
end;

procedure TBaseMaintenanceForm.SetCtrlPress(
  const Value: boolean);
begin
  FCtrlPress := Value;
end;

procedure TBaseMaintenanceForm.ParentGridKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  SetHidden(Key, Shift);
end;

procedure TBaseMaintenanceForm.SetHidden(var Key: Word; Shift: TShiftState);
begin
  inherited;
  CheckAltPress(Key, Shift);
  
  if FAltPress then   // the d key
  begin
    if Key = 72 then // h key
    begin
      FShowHidden := not FShowHidden;
      ResetGrids(true);
    end;  
    FAltPress := false;
  end;
end;

procedure TBaseMaintenanceForm.SetTest(const Value: boolean);
begin
  inherited;
  ShowHidden := Value;  
end;

procedure TBaseMaintenanceForm.FormResize(Sender: TObject);
begin
  inherited;

  // No smaller than this
  ButtonGroupTop.Width := Max(Width div 2, 200);

  // No bigger than this
  ButtonGroupTop.Width := Min(ButtonGroupTop.Width, 300);
end;

procedure TBaseMaintenanceForm.btnPrintClick(Sender: TObject);
begin
  inherited;
  PrintDat.Print;
  btnPrint.Down := false;
end;

procedure TBaseMaintenanceForm.LoadFromReg;
begin
  inherited;
//  ParentGrid.ApplySelected;
  SplitterPanel.SplitterPos := RegINIFile.ReadInteger(Section, 'SplitterPos', SplitterPanel.SplitterPos);
end;


procedure TBaseMaintenanceForm.SaveToReg;
begin
  inherited;
  RegINIFile.WriteInteger(Section, 'SplitterPos', SplitterPanel.SplitterPos);
end;

procedure TBaseMaintenanceForm.ParentGridTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  inherited;
  // Leave this........
end;


end.
