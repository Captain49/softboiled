inherited QueryForm: TQueryForm
  Left = 598
  Top = 397
  Width = 682
  Height = 465
  Caption = 'Query'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 674
    Height = 29
    Align = alTop
    TabOrder = 0
    object ButtonGroupTop: TfcButtonGroup
      Left = 1
      Top = 1
      Width = 136
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
      object btnRun: TfcShapeBtn
        Left = 0
        Top = 0
        Width = 68
        Height = 27
        Caption = '&Run'
        Color = clBtnFace
        DitherColor = clWhite
        GroupIndex = 1
        NumGlyphs = 0
        ParentClipping = True
        RoundRectBias = 25
        ShadeStyle = fbsHighlight
        TabOrder = 0
        TextOptions.Alignment = taCenter
        TextOptions.VAlignment = vaVCenter
        OnClick = btnRunClick
      end
      object btnPrint: TfcShapeBtn
        Left = 69
        Top = 0
        Width = 67
        Height = 27
        Caption = '&Print'
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
        OnClick = btnPrintClick
      end
    end
  end
  object SplitterPanel: TSAMSSplitterPanel
    Left = 30
    Top = 52
    Width = 513
    Height = 285
    Aligned = alNone
    ColorGrabBar = 16686723
    ColorPanel = clBtnFace
    PanelStyle = spsFramed
    SplitterOrientation = spoHorizontal
    SplitterPos = 125
    SplitterPosPercent = 45
    Panel1Controls = ()
    Panel2Controls = ()
    object Edit: TwwDBRichEdit
      Left = 0
      Top = 133
      Width = 928
      Height = 462
      AutoURLDetect = False
      PrintJobName = 'Delphi 7'
      TabOrder = 2
      EditorCaption = 'Edit Rich Text'
      EditorPosition.Left = 0
      EditorPosition.Top = 0
      EditorPosition.Width = 0
      EditorPosition.Height = 0
      MeasurementUnits = muInches
      PrintMargins.Top = 1.000000000000000000
      PrintMargins.Bottom = 1.000000000000000000
      PrintMargins.Left = 1.000000000000000000
      PrintMargins.Right = 1.000000000000000000
      RichEditVersion = 2
      Data = {
        CA0000007B5C727466315C616E73695C616E7369637067313235325C64656666
        305C6465666C616E67333038317B5C666F6E7474626C7B5C66305C666E696C5C
        666368617273657430204D532053616E732053657269663B7D7B5C66315C666E
        696C204D532053616E732053657269663B7D7D0D0A5C766965776B696E64345C
        7563315C706172645C66305C667331362053454C454354202A2046524F4D2074
        44697363204F5244455220425920446174654669727374416464656420646573
        635C66315C7061720D0A7D0D0A00}
    end
    object Grid: TwwDBGrid
      Left = 122
      Top = 16
      Width = 202
      Height = 170
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DataSource
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgNoLimitColSize]
      ReadOnly = True
      TabOrder = 3
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = True
      OnTitleButtonClick = GridTitleButtonClick
    end
  end
  object Query: TADOQuery
    Active = True
    Connection = MainDataModule.Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM tDisc')
    Left = 244
    Top = 2
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 292
    Top = 4
  end
  object PrintDAT: TPdtPrintDAT
    ReportId = '(965.772)'
    Version = '1.58O Pro W2W'
    Left = 366
    Top = 6
  end
end
