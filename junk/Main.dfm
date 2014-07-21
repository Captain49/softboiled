inherited MainForm: TMainForm
  Left = 380
  Top = 381
  Caption = 'Stakka'
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainMenu: TMainMenu
    object mnuFile: TMenuItem
      Caption = '&File'
      object mnuFileDiskMaintenance: TMenuItem
        Caption = '&Disk maintenance'
        OnClick = mnuFileDiskMaintenanceClick
      end
      object mnuExit: TMenuItem
        Caption = 'E&xit'
        OnClick = mnuExitClick
      end
      object mnuTest: TMenuItem
        Caption = '&Test'
        OnClick = mnuTestClick
      end
    end
  end
end
