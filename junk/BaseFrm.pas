{$I sbs.inc}

unit BaseFrm;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF DELPHI7ABOVE} Variants, {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, Registry;

type
  TBaseForm = class(TForm)
  private
    FPersistent: boolean;
    FSection: string;
    FRegBasePath: string;
    FRegINIFile: TRegINIFile;
    FTest: boolean;
    FBaseCaption: TCaption;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure AfterConstruction; override;

    procedure LoadFromReg; virtual;
    procedure SaveToReg; virtual;
    procedure SetPersistent(const Value: boolean); virtual;
    procedure ClearRegistry;
    procedure SetTest(const Value: boolean); virtual;
    
    property Persistent: boolean read FPersistent write SetPersistent;
    property Section: string  read FSection write FSection;
    property RegBasePath: string  read FRegBasePath write FRegBasePath;
    property RegINIFile: TRegINIFile read FRegINIFile write FRegINIFile;
    property Test: boolean read FTest write SetTest;
    property BaseCaption: TCaption read FBaseCaption write FBaseCaption;
  end;

const  
  _RegINIFile: TRegINIFile = nil;
  
implementation

{$R *.dfm}

procedure TBaseForm.AfterConstruction;
begin
  inherited;
  
  if FPersistent then
    LoadFromReg;
end;

procedure TBaseForm.ClearRegistry;
begin
  try
    if RegINIFile = nil then
      Raise Exception.Create('No RegINIfile assigned');
    RegINIFile.EraseSection(RegBasePath);
  except
    on E:Exception do
      Application.ShowException(E);
  end;
end;

constructor TBaseForm.Create(AOwner: TComponent);
var
  i: Integer;
begin
  // No menus from here!!!
//  Menu := nil;

  inherited;

  FBaseCaption := Caption;
  
  Test := false;
  for i := 1 to ParamCount do
  begin
    if LowerCase(ParamStr(i)) = '/test' then
      Test := true;
  end;

  FRegINIFile := _RegINIFile;
  
  FRegBasePath := 'Software\SBS\Stakka Controller Version 0.0.1\';

  if AOwner = nil then
    FSection     := RegBasePath +Name
  else
    FSection     := RegBasePath +AOwner.Name +'\' +Name;

  Persistent := true;
end;

destructor TBaseForm.Destroy;
begin
  if Persistent then
    SaveToReg;
    
  inherited;
end;

procedure TBaseForm.LoadFromReg;
var
  _top : Integer;
begin
  try
    if RegINIFile = nil then
      Raise Exception.Create('No RegINIfile assigned');
  
    _Top         := RegINIFile.ReadInteger(FSection, 'Top', -1);

    if (_top > -1) then
    begin
      Top         := _Top;
      Left        := RegINIFile.ReadInteger(FSection, 'Left',   0);
      Height      := RegINIFile.ReadInteger(FSection, 'Height', Height);
      Width       := RegINIFile.ReadInteger(FSection, 'Width',  Width);
      WindowState := TWindowState(RegINIFile.ReadInteger(FSection, 'WindowState', ord(wsNormal)));
    end
    else
    begin
      Left := (Screen.{Desktop}Width - Width) div 2;
      Top  := (Screen.{Desktop}Height - Height) div 2;
    end;

    if (WindowState = wsMaximized) then
    begin
      Top  := 0;
      Left := 0;
    end;	
  except
    on E:Exception do
      Application.ShowException(E);
  end;
end;


procedure TBaseForm.SaveToReg;
begin
  try
    if RegINIFile = nil then
      Raise Exception.Create('No RegINIfile assigned');
  
    RegINIFile.WriteInteger(FSection, 'WindowState', ord(WindowState));

    if (WindowState = wsNormal) then
    begin
      RegINIFile.WriteInteger(FSection, 'Top', Top);
      RegINIFile.WriteInteger(FSection, 'Left', Left);
      RegINIFile.WriteInteger(FSection, 'Height', Height);
      RegINIFile.WriteInteger(FSection, 'Width', Width);
    end;
  except
    on E:Exception do
      Application.ShowException(E);
  end;

end;

procedure TBaseForm.SetPersistent(const Value: boolean);
begin
  FPersistent := Value;
end;

procedure TBaseForm.SetTest(const Value: boolean);
begin
  FTest := Value;
  if FTest then
    Caption := FBaseCaption +' - Test mode'
  else  
    Caption := FBaseCaption;
end;

initialization
  _RegINIFile := TRegINIFile.Create;
  _RegINIFile.RootKey := HKEY_CURRENT_USER;
  
finalization
  FreeAndNil(_RegINIFile);

end.

