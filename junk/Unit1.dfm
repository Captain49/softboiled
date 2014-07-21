inherited TestForm: TTestForm
  Left = 732
  Top = 457
  Width = 510
  Height = 509
  Caption = 'TestForm'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 14
    Top = 48
    Width = 473
    Height = 418
    ControlType.Strings = (
      'GroupName;CustomEdit;LookupCombo1;F')
    Selected.Strings = (
      'ID'#9'10'#9'ID'
      'DiscName'#9'35'#9'DiscName'
      'GroupID'#9'10'#9'GroupID'
      'GroupName'#9'11'#9'GroupName'
      'Comments'#9'10'#9'Comments')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object LookupCombo1: TwwDBLookupCombo
    Left = 208
    Top = 14
    Width = 121
    Height = 21
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Group'#9'129'#9'Group'#9#9)
    LookupTable = ADOQuery2
    LookupField = 'Group'
    TabOrder = 1
    AutoDropDown = False
    ShowButton = True
    UseTFields = False
    AllowClearKey = False
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = MainDataModule.Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  tDisc.ID AS ID,'
      '  tDisc.Name AS DiscName,'
      '  tDisc.GroupID AS GroupID,'
      '  tDiscGroups.Group AS GroupName,'
      '  tDisc.Comments AS Comments'
      'FROM'
      '    (tDisc'
      '  LEFT OUTER JOIN tUnit ON tUnit.ID = tDisc.UnitID)'
      '  LEFT OUTER JOIN tDiscGroups ON tDiscGroups.ID = tDisc.GroupID')
    Left = 14
    Top = 12
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 54
    Top = 12
  end
  object ADOQuery2: TADOQuery
    Active = True
    Connection = MainDataModule.Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM tDiscGroups')
    Left = 118
    Top = 12
  end
end
