inherited BaseMaintenanceForm2: TBaseMaintenanceForm2
  Caption = 'BaseMaintenanceForm2'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TopPanel: TPanel
    inherited ButtonGroupTop: TfcButtonGroup
      inherited btnNew: TfcShapeBtn
        NumGlyphs = 1
      end
      inherited btnEdit: TfcShapeBtn
        NumGlyphs = 0
      end
      inherited btnDelete: TfcShapeBtn
        NumGlyphs = 0
      end
      inherited btnSearch: TfcShapeBtn
        NumGlyphs = 0
      end
      inherited btnPrint: TfcShapeBtn
        NumGlyphs = 0
      end
      inherited btnQuery: TfcShapeBtn
        NumGlyphs = 0
      end
    end
  end
  inherited SplitterPanel: TSAMSSplitterPanel
    Panel1Controls = (
      ParentGroup)
    Panel2Controls = ()
    inherited NotesGroup: TGroupBox
      TabOrder = 2
    end
  end
end
