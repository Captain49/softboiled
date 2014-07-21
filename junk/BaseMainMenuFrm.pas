{$I sbs.inc}

unit BaseMainMenuFrm;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI7ABOVE} Variants, {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, Menus, BaseFrm;

type
  TBaseMainMenuForm = class(TBaseForm)
    MainMenu: TMainMenu;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
