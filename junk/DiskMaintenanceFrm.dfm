inherited DiskMaintenanceForm: TDiskMaintenanceForm
  Left = 390
  Top = 357
  Width = 1157
  Height = 512
  Caption = 'DiskMaintenanceForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TopPanel: TPanel
    Width = 1149
    inherited ButtonGroupTop: TfcButtonGroup
      inherited btnEdit: TfcShapeBtn
        NumGlyphs = 1
      end
      inherited btnDelete: TfcShapeBtn
        NumGlyphs = 1
      end
      inherited btnSearch: TfcShapeBtn
        NumGlyphs = 1
      end
      inherited btnPrint: TfcShapeBtn
        NumGlyphs = 1
      end
      inherited btnQuery: TfcShapeBtn
        NumGlyphs = 1
        OnClick = btnQueryClick
      end
    end
  end
  inherited SplitterPanel: TSAMSSplitterPanel
    Width = 1149
    Height = 449
    SplitterPos = 218
    SplitterPosPercent = 19
    Panel1Controls = ()
    Panel2Controls = ()
    inherited NotesGroup: TGroupBox
      Left = 226
      Width = 923
      Height = 449
      TabOrder = 0
      inherited NotesMemo: TDBMemo
        Width = 919
        Height = 432
      end
    end
    inherited ParentGroup: TGroupBox
      Left = 226
      Top = 0
      Width = 923
      Height = 449
      TabOrder = 3
      inherited ParentGrid: TwwDBGrid
        Width = 919
        Height = 432
        Selected.Strings = (
          'DiscName'#9'61'#9'DiscName'
          'Comments'#9'19'#9'Comments'
          'GroupName'#9'46'#9'GroupName'
          'UserDefined'#9'255'#9'Box')
        DataSource = ParentDataSource
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      end
      inherited LookupCombo2: TwwDBLookupCombo
        Left = 52
        Top = 86
      end
      inherited LookupCombo3: TwwDBLookupCombo
        Left = 56
        Top = 118
      end
      inherited LookupCombo4: TwwDBLookupCombo
        Left = 56
        Top = 150
      end
      inherited LookupCombo5: TwwDBLookupCombo
        Left = 56
        Top = 176
      end
    end
  end
  inherited RecordEdit: TwwRecordViewDialog
    ControlType.Strings = (
      'GroupID;CustomEdit;LookUpCombo1;F')
    Selected.Strings = (
      'ID'#9'10'#9'ID'#9#9
      'UnitID'#9'10'#9'UnitID'#9#9
      'Slot'#9'10'#9'Slot'#9#9
      'Name'#9'129'#9'Name'#9#9
      'GroupID'#9'10'#9'GroupID'#9#9
      'Type'#9'10'#9'Type'#9#9
      'Volume'#9'33'#9'Volume'#9#9
      'UniqueData'#9'10'#9'UniqueData'#9#9
      'State'#9'10'#9'State'#9#9
      'DateFirstAdded'#9'18'#9'DateFirstAdded'#9#9
      'DateLastAccess'#9'18'#9'DateLastAccess'#9#9
      'DateLastEject'#9'18'#9'DateLastEject'#9#9
      'DateLastInsert'#9'18'#9'DateLastInsert'#9#9
      'Capacity'#9'21'#9'Capacity'#9#9
      'Used'#9'21'#9'Used'#9#9
      'History'#9'5'#9'History'#9#9
      'OutTo'#9'57'#9'OutTo'#9#9
      'DueBack'#9'18'#9'DueBack'#9#9
      'Access'#9'5'#9'Access'#9#9
      'Password'#9'10'#9'Password'#9#9
      'Hint'#9'57'#9'Hint'#9#9
      'Comments'#9'10'#9'Comments'#9#9
      'SecurityDescriptor'#9'10'#9'SecurityDescriptor'#9#9
      'Image'#9'10'#9'Image'#9#9
      'ContentsRefresh'#9'18'#9'ContentsRefresh'#9#9
      'DataContentsStore'#9'10'#9'DataContentsStore'#9#9
      'DataContentsLevel'#9'10'#9'DataContentsLevel'#9#9
      'DataContents'#9'5'#9'DataContents'#9#9
      'AudioContents'#9'5'#9'AudioContents'#9#9
      'ErrorCount'#9'10'#9'ErrorCount'#9#9
      'ErrorHighwater'#9'10'#9'ErrorHighwater'#9#9
      'UserDefined'#9'255'#9'UserDefined'#9#9
      'GUID'#9'38'#9'GUID'#9#9)
  end
  inherited PrintDAT: TPdtPrintDAT
    ReportId = '(704.604)'
  end
  inherited LookupQuery1: TADOQuery
    Connection = MainDataModule.Connection
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT * FROM tDiscGroups')
  end
  inherited ParentQuery: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT'
      '  tDisc.ID AS ID,'
      '  tDisc.Name AS DiscName,'
      '  tDisc.Comments AS Comments,'
      '  tDisc.UserDefined AS UserDefined,'
      '  tDiscGroups.ID AS GroupID,'
      '  tDiscGroups.Group AS GroupName'
      'FROM'
      '  (tDisc'
      '  LEFT OUTER JOIN tUnit ON tUnit.ID = tDisc.UnitID)'
      '  LEFT OUTER JOIN tDiscGroups ON tDiscGroups.ID = tDisc.GroupID')
  end
  inherited ParentDataSource: TwwDataSource
    DataSet = ParentQuery
  end
end
