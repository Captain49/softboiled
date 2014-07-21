inherited BaseMaintenanceForm: TBaseMaintenanceForm
  Left = 279
  Top = 330
  Width = 1175
  Height = 712
  Caption = 'BaseMaintenanceForm'
  Constraints.MinHeight = 140
  Constraints.MinWidth = 250
  Menu = RecordViewDialogMenu
  OldCreateOrder = True
  OnClose = FormClose
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 1167
    Height = 29
    Align = alTop
    TabOrder = 0
    object lblStatus: TfcLabel
      Left = 421
      Top = 12
      Width = 104
      Height = 13
      Caption = 'Status stuff goes here'
      TextOptions.Alignment = taLeftJustify
      TextOptions.VAlignment = vaTop
    end
    object ButtonGroupTop: TfcButtonGroup
      Left = 1
      Top = 1
      Width = 312
      Height = 27
      Align = alLeft
      AutoBold = True
      BevelOuter = bvNone
      ButtonClassName = 'TfcShapeBtn'
      ClickStyle = bcsRadioGroup
      ControlSpacing = 1
      Columns = 1
      Layout = loHorizontal
      MaxControlSize = 0
      TabOrder = 0
      Transparent = False
      object btnNew: TfcShapeBtn
        Left = 0
        Top = 0
        Width = 52
        Height = 27
        Caption = '&New'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 0
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
        OnClick = btnNewClick
      end
      object btnEdit: TfcShapeBtn
        Left = 53
        Top = 0
        Width = 51
        Height = 27
        Caption = '&Edit'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        NumGlyphs = 0
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 1
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
        OnClick = btnEditClick
      end
      object btnDelete: TfcShapeBtn
        Left = 105
        Top = 0
        Width = 51
        Height = 27
        Caption = '&Delete'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        NumGlyphs = 0
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 2
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
        OnClick = btnDeleteClick
      end
      object btnSearch: TfcShapeBtn
        Left = 157
        Top = 0
        Width = 51
        Height = 27
        Caption = '&Search'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        NumGlyphs = 0
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 3
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
        OnClick = btnSearchClick
      end
      object btnPrint: TfcShapeBtn
        Left = 209
        Top = 0
        Width = 51
        Height = 27
        Caption = '&Print'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        NumGlyphs = 0
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 4
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
        OnClick = btnPrintClick
      end
      object btnQuery: TfcShapeBtn
        Left = 261
        Top = 0
        Width = 51
        Height = 27
        Caption = '&Query'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        NumGlyphs = 0
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 5
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
      end
    end
  end
  object SplitterPanel: TSAMSSplitterPanel
    Left = 0
    Top = 29
    Width = 1167
    Height = 649
    Aligned = alClient
    ColorGrabBar = 16686723
    ColorPanel = clBtnFace
    PanelStyle = spsFramed
    SplitterOrientation = spoVertical
    SplitterPos = 780
    SplitterPosPercent = 67
    Panel1Controls = (
      ParentGroup)
    Panel2Controls = ()
    object NotesGroup: TGroupBox
      Left = 788
      Top = 0
      Width = 379
      Height = 649
      Align = alClient
      Caption = 'Notes'
      TabOrder = 1
      object NotesMemo: TDBMemo
        Left = 2
        Top = 15
        Width = 375
        Height = 632
        Align = alClient
        TabOrder = 0
      end
    end
    object ParentGroup: TGroupBox
      Left = 2
      Top = 2
      Width = 776
      Height = 645
      Align = alClient
      Caption = 'Disks'
      TabOrder = 0
      object ParentGrid: TwwDBGrid
        Left = 2
        Top = 15
        Width = 772
        Height = 628
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnRowChanged = ParentGridRowChanged
        OnCellChanged = ParentGridCellChanged
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = True
        OnTitleButtonClick = ParentGridTitleButtonClick
        OnEnter = ParentGridEnter
        OnKeyDown = ParentGridKeyDown
      end
      object LookupCombo2: TwwDBLookupCombo
        Left = 422
        Top = 276
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Full_Name'#9'61'#9'Full_Name'#9#9)
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object LookupCombo3: TwwDBLookupCombo
        Left = 424
        Top = 308
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Full_Name'#9'61'#9'Full_Name'#9#9)
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object LookupCombo4: TwwDBLookupCombo
        Left = 424
        Top = 340
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Full_Name'#9'61'#9'Full_Name'#9#9)
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object LookupCombo5: TwwDBLookupCombo
        Left = 424
        Top = 366
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Full_Name'#9'61'#9'Full_Name'#9#9)
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object LookupCombo1: TwwDBLookupCombo
        Left = 424
        Top = 244
        Width = 121
        Height = 21
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Full_Name'#9'61'#9'Full_Name'#9#9)
        TabOrder = 5
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
    end
  end
  object RecordViewDialogMenu: TMainMenu
    Left = 512
  end
  object RecordEdit: TwwRecordViewDialog
    FormPosition.Left = 0
    FormPosition.Top = 0
    FormPosition.Width = 0
    FormPosition.Height = 0
    NavigatorButtons = [nbsPost, nbsCancel, nbsRefresh, nbsFilterDialog, nbsRecordViewDialog, nbsLocateDialog]
    Options = [rvoHideNavigator, rvoUseCustomControls, rvoShortenEditBox, rvoModalForm, rvoConfirmCancel, rvoCloseIsCancel, rvoMaximizeMemoWidth, rvoUseDateTimePicker]
    ControlOptions = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OnCloseDialog = RecordEditCloseDialog
    Caption = 'Record View'
    NavigatorFlat = True
    Left = 484
  end
  object LocateDialog: TwwLocateDialog
    Caption = 'Locate Field Value'
    MatchType = mtPartialMatchStart
    CaseSensitive = False
    SortFields = fsSortByFieldNo
    DefaultButton = dbFindNext
    FieldSelection = fsVisibleFields
    ShowMessages = True
    Options = []
    Left = 456
  end
  object PrintDAT: TPdtPrintDAT
    ObjectToPrint = ParentGrid
    ReportId = '(645.635)'
    Version = '1.58O Pro W2W'
    Left = 344
    Top = 2
  end
  object RecordEditQuery: TADOQuery
    Parameters = <>
    Left = 589
  end
  object LookupQuery1: TADOQuery
    Parameters = <>
    Left = 617
  end
  object LookupQuery2: TADOQuery
    Parameters = <>
    Left = 645
  end
  object LookupQuery3: TADOQuery
    Parameters = <>
    Left = 671
  end
  object LookupQuery4: TADOQuery
    Parameters = <>
    Left = 699
  end
  object LookupQuery5: TADOQuery
    Parameters = <>
    Left = 725
  end
  object ParentQuery: TADOQuery
    Connection = MainDataModule.Connection
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  tDisc.ID AS ID,'
      '  tDisc.Name AS DiscName,'
      '  tDisc.Comments AS Comments,'
      '  tDiscGroups.Group AS GroupName'
      'FROM'
      '  (tDisc'
      '  LEFT OUTER JOIN tUnit ON tUnit.ID = tDisc.UnitID)'
      '  LEFT OUTER JOIN tDiscGroups ON tDiscGroups.ID = tDisc.GroupID')
    Left = 562
  end
  object ParentDataSource: TwwDataSource
    Left = 792
  end
  object RecordEditDataSource: TwwDataSource
    Left = 820
  end
end
