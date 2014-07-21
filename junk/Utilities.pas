{$I sbs.inc}

unit Utilities;

interface

uses
  ADODB,
  {$IFDEF DELPHI7ABOVE}
  Variants,
  {$ENDIF}
  Controls,
  SysUtils,
  DB,
  Forms;

{Command Line Parameters}
function ParamAsString(Name: string): string;

// If UseValue is true then, if a parameter was not found, will be the passed in value
// If UseValue is false then, if a parameter was not found, will be the default value
procedure GetParam(Name: string; var Value: boolean; UseValue: boolean = false); overload;
procedure GetParam(Name: string; var Value: string; UseValue: boolean = false); overload;
procedure GetParam(Name: string; var Value: integer; UseValue: boolean = false); overload;
procedure GetParam(Name: string; var Value: double; UseValue: boolean = false); overload;
procedure GetParam(Name: string; var Value: TDate; UseValue: boolean = false); overload;

procedure FieldIsNull(var AValue: string; const AFieldName: string; Query: TDataSet); overload;
procedure FieldIsNull(var AValue: Integer; const AFieldName: string; Query: TDataSet); overload;
procedure FieldIsNull(var AValue: double; const AFieldName: string; Query: TDataSet); overload;
procedure FieldIsNull(var AValue: TDate; const AFieldName: string; Query: TDataSet); overload;
procedure FieldIsNull(var AValue: TTime; const AFieldName: string; Query: TDataSet); overload;

//procedure SetField(var AValue: string; const AFieldName: string; Query: TADOQuery); overload;
//procedure SetField(var AValue: Integer; const AFieldName: string; Query: TADOQuery); overload;
//procedure SetField(var AValue: double; const AFieldName: string; Query: TADOQuery); overload;
//procedure SetField(var AValue: TDate; const AFieldName: string; Query: TADOQuery); overload;
//procedure SetField(var AValue: TTime; const AFieldName: string; Query: TADOQuery); overload;

function GetPrimaryKey(SQL: string): string;
function GetKey(SQL: string): string;
function GetConstraint(SQL: string): string;
function GetCleanCreateTable(ATableName, NewTableName: string; Connection: TADOConnection): string;
function GetCreateTempTable(ATableName, NewTableName: string; Connection: TADOConnection): string;

procedure TryExecSQL(Query1: TADOQuery; Query2: TADOQuery = nil; Query3: TADOQuery = nil);

const
  BorderPad = 2;
  NOT_NULL = true;
  NULL_OK = false;
  ADD_COMMA = true;
  NULL_FLOAT = -9999;
  NULL_STRING = 'NULL';
  NULL_DATE = -9999; 
  NULL_TIME = -9999; 
  NULL_INTEGER = -9999; 
  MAX_LENGTH = 65536;

implementation

{Command Line Parameters}

procedure GetParam(Name: string; var Value: boolean; UseValue: boolean);
var
  i : integer;
  ThisParam : string;
begin
  if not UseValue then
    Value := false;
    
  Name := UpperCase(Name);
  if Copy(Name, 1, 1) <> '/' then
    Name := '/' +Name;
  for i := 1 to ParamCount do begin
    ThisParam := UpperCase(ParamStr(i));
    if (Name = ThisParam) then begin
      Value := true;
      break;
    end;
  end;    
end;

procedure GetParam(Name: string; var Value: string; UseValue: boolean);
var
  ThisParam: string;
begin
  ThisParam := ParamAsString(Name);
  if (ThisParam = '') and UseValue then
    ThisParam := Value;

  Value := ThisParam;
end;

procedure GetParam(Name: string; var Value: integer; UseValue: boolean);
var
  ThisParam: string;
begin
  Name := UpperCase(Name);
  ThisParam := ParamAsString(Name);

  if (ThisParam = '') then
  begin
    if not UseValue then
      Value := -999999999;
    Exit;    //------------> out of here!!!!
  end;

  try
    Value := StrToInt(ThisParam);
  except
    on E:Exception do
      if E is EConvertError then try
        // Try a float
        Value := Round(StrToFloat(ThisParam));
      except
        on E:Exception do
          if not (E is EConvertError) then
            raise;
      end else
        raise;
  end;
end;

procedure GetParam(Name: string; var Value: double; UseValue: boolean);
var
  ThisParam: string;
begin
  Name := UpperCase(Name);
  ThisParam := ParamAsString(Name);

  if (ThisParam = '') then
  begin
    if not UseValue then
      Value := -999999999;
    Exit;    //------------> out of here!!!!
  end;

  try
    Value := StrToFloat(ThisParam);
  except
    on E:Exception do
      if not (E is EConvertError) then
        raise;
  end;
end;

procedure GetParam(Name: string; var Value: TDate; UseValue: boolean);
var
  ThisParam: string;
begin
  Name := UpperCase(Name);
  ThisParam := ParamAsString(Name);

  if (ThisParam = '') then
  begin
    if not UseValue then
      Value := Now -999999999;
    Exit;    //------------> out of here!!!!
  end;

  try
    Value := StrToDate(ThisParam);
  except
    on E:Exception do
      if not (E is EConvertError) then
        raise;
  end;
end;

function ParamAsString(Name: string): string;
var
  i : integer;
  iPos: integer;
  ThisParam: string;
  ThisParamName: string;
begin
  Result := '';
  Name := UpperCase(Name);
  if Copy(Name, 1, 1) <> '/' then
    Name := '/' +Name;
  for i := 1 to ParamCount do
  begin
    ThisParam := UpperCase(ParamStr(i));
    iPos := Pos('=', ThisParam);

    if iPos > 0 then
    begin
      ThisParamName := Copy(ThisParam, 1, iPos -1);

      if (Name = ThisParamName) then
      begin
        Result := Copy(ParamStr(i), iPos +1, 255);
        break;
      end;
    end;
  end;
end;

  
procedure FieldIsNull(var AValue: string;
  const AFieldName: string; Query: TDataSet);
begin
  if not Query.FieldByName(AFieldName).IsNull then
    AValue := Query.FieldByName(AFieldName).AsString
  else
    AValue := NULL_STRING;
end;

procedure FieldIsNull(var AValue: Integer;
  const AFieldName: string; Query: TDataSet);
begin
  if not Query.FieldByName(AFieldName).IsNull then
    AValue := Query.FieldByName(AFieldName).AsInteger
  else
    AValue := NULL_INTEGER;
end;

procedure FieldIsNull(var AValue: double;
  const AFieldName: string; Query: TDataSet);
begin
  if not Query.FieldByName(AFieldName).IsNull then
    AValue := Query.FieldByName(AFieldName).AsFloat
  else
    AValue := NULL_FLOAT;
end;

procedure FieldIsNull(var AValue: TDate;
  const AFieldName: string; Query: TDataSet);
begin
  if not Query.FieldByName(AFieldName).IsNull then
    AValue := Query.FieldByName(AFieldName).AsDateTime
  else
    AValue := NULL_DATE;

end;

procedure FieldIsNull(var AValue: TTime;
  const AFieldName: string; Query: TDataSet);
begin
  if not Query.FieldByName(AFieldName).IsNull then
    AValue := Query.FieldByName(AFieldName).AsDateTime
  else
    AValue := NULL_TIME;
end;

//procedure SetField(var AValue: Integer;
//  const AFieldName: string; Query: TADOQuery);
//begin
//  if AValue <> NULL_INTEGER then
//    Query.ParamByName(AFieldName).AsInteger := AValue
//  else
//    Query.ParamByName(AFieldName).Value := null;
//
//end;

//procedure SetField(var AValue: string;
//  const AFieldName: string; Query: TADOQuery);
//begin
//  if AValue <> NULL_STRING then
//    Query.ParamByName(AFieldName).AsString := AValue
//  else
//    Query.ParamByName(AFieldName).Value := null;
//
//end;

//procedure SetField(var AValue: double;
//  const AFieldName: string; Query: TADOQuery);
//begin
//  if AValue <> NULL_FLOAT then
//    Query.ParamByName(AFieldName).AsFloat := AValue
//  else
//    Query.ParamByName(AFieldName).Value := null;
//                                        
//end;

//procedure SetField(var AValue: TTime;
//  const AFieldName: string; Query: TADOQuery);
//begin
//  if AValue <> NULL_TIME then
//    Query.ParamByName(AFieldName).AsTime := AValue
//  else
//    Query.ParamByName(AFieldName).Value := null;
//    
//end;

procedure SetField(var AValue: TDate;
  const AFieldName: string; Query: TADOQuery);                       
begin
  if AValue <> NULL_DATE then
    Query.Parameters.FindParam(AFieldName).Value := AValue
//    Query.ParamByName(AFieldName).AsDate := AValue
  else
    Query.Parameters.FindParam(AFieldName).Value := null;
//    Query.ParamByName(AFieldName).Value := null;

end;

function GetCreateTempTable(ATableName, NewTableName: string; Connection: TADOConnection): string;
begin
  Result := GetCleanCreateTable(ATableName, NewTableName, Connection);
  Result := StringReplace(Result, 'CREATE TABLE', 'CREATE TEMPORARY TABLE', [rfReplaceAll, rfIgnoreCase]);
end;

function GetCleanCreateTable(ATableName, NewTableName: string; Connection: TADOConnection): string;
var
  Query: TADOQuery;
  KeyStr: string;
  PrimaryKey: string;
begin
  Result := '';
  Query := TADOQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Add('SHOW CREATE TABLE ' +ATableName);
    Query.Open;
    Result := Query.Fields[1].AsString;
    Result := StringReplace(Result, 'NOT NULL', '', [rfReplaceAll, rfIgnoreCase]);

    KeyStr := GetConstraint(Result);
    while KeyStr <> '' do
    begin
      Result := StringReplace(Result, KeyStr, '', [rfReplaceAll, rfIgnoreCase]);
      KeyStr := GetConstraint(Result);
    end;

    PrimaryKey := GetPrimaryKey(Result);
    Result := StringReplace(Result, PrimaryKey +',' , 'NEVER_THIS', [rfReplaceAll]);
    Result := StringReplace(Result, PrimaryKey, 'NEVER_THIS', [rfReplaceAll]);
        
    KeyStr := GetKey(Result);
    while KeyStr <> '' do
    begin
      Result := StringReplace(Result, KeyStr, '', [rfReplaceAll, rfIgnoreCase]);
      KeyStr := GetKey(Result);
    end;

    Result := StringReplace(Result, 'NEVER_THIS', PrimaryKey, [rfReplaceAll]);
    
    if NewTableName <> '' then
      Result := StringReplace(Result, ATableName, NewTableName, [rfReplaceAll, rfIgnoreCase]);
    
    if Result = '' then
      Raise Exception.Create('No CREATE TABLE SQL found');  
  finally
    Query.Close;
    Query.Free;
  end;  
end;


function GetPrimaryKey(SQL: string): string;
var
  i, j: integer;
begin
  Result := SQL;
  i := Pos('PRIMARY KEY', Result);
  if i > 0 then
  begin
    Result := Copy(Result, i, MAX_LENGTH);
    j := Pos(',', Result);
    if j > 0 then
      Result := Copy(Result, 1, j);
  end else
    Result := '';
          
  if Copy(Result, length(Result), 1) = ',' then
    Result := Copy(Result, 1, Length(Result) -1);
end;

function GetKey(SQL: string): string;
var
  i, j: integer;
begin
  Result := SQL;
  i := Pos('KEY', Result);
  if i > 0 then
  begin
    Result := Copy(Result, i, MAX_LENGTH);
    j := Pos(',', Result);
    if j > 0 then  
      Result := Copy(Result, 1, j)
    else
    begin  
      j := Pos('ENGINE', Result);
      Result := Copy(Result, j +2, MAX_LENGTH)
    end;  
  end else
    Result := '';    
end;

function GetConstraint(SQL: string): string;
var
  i, j: integer;
begin
  Result := SQL;
  i := Pos('CONSTRAINT', Result);
  if i > 0 then
  begin
    Result := Copy(Result, i, MAX_LENGTH);
    j := Pos(',', Result);
    if j > 0 then  
      Result := Copy(Result, 1, j +1)
    else
    begin  
      j := Pos('ENGINE', Result);
      Result := Copy(Result, 1, j -3)
    end;
  end else
    Result := '';
end;

procedure TryExecSQL(Query1: TADOQuery; Query2: TADOQuery; Query3: TADOQuery);
var
  ControlQuery: TADOQuery;
begin
  ControlQuery := TADOQuery.Create(nil);
  try
    ControlQuery.Connection := Query1.Connection;
    try
      ControlQuery.SQL.Clear;
      ControlQuery.SQL.Add('START TRANSACTION');
      ControlQuery.ExecSQL;
  
      Query1.ExecSQL;
      
      if Query2 <> nil then              
        Query2.ExecSQL;              

      if Query3 <> nil then              
        Query3.ExecSQL;              
        
      ControlQuery.SQL.Clear;
      ControlQuery.SQL.Add('COMMIT');
    except
      on E:Exception do
      begin
        ControlQuery.SQL.Clear;
        ControlQuery.SQL.Add('ROLLBACK');
        Raise;
      end;
    end;
    ControlQuery.ExecSQL;
  finally
    ControlQuery.Free;
  end;    
end;
  
end.
