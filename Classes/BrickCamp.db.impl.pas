unit BrickCamp.db.impl;

interface

uses
	Spring.Persistence.Adapters.FireDac,
  Spring.Container.Common,
  Spring.Persistence.Core.Session,
  BrickCamp.db.intf,
  BrickCamp.settings.intf;

type
  TCbdDB = class(TInterfacedObject, IBrickCampDb)
  protected var
    [Inject]
    FSettings: IBrickCampSettings;

    FCon: TFireDACConnectionAdapter;
    FSession: TSession;
  public
    destructor Destroy; override;

    procedure InitializeDbConnection;
    function GetSession: TSession;
  end;

implementation

uses
	Spring.Container,
  Spring.Persistence.Core.ListSession,
  Spring.Collections,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBDef,
  FireDAC.Phys.IBWrapper,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IB,
  FireDAC.Phys.FB;

{ TCbdDB }

procedure TCbdDB.InitializeDbConnection;
begin
  if FCon <> nil then
    Exit;

  FCon := TFireDACConnectionAdapter.Create(TFDConnection.Create(nil));
  FCon.Connection.ConnectionString := FSettings.GetDBStringConnection;
  FCon.Connection.LoginPrompt := false;
  FCon.Connect;

  FSession := TSession.Create(FCon);
end;

destructor TCbdDB.Destroy;
begin
  inherited;
end;

function TCbdDB.GetSession: TSession;
begin
  InitializeDbConnection;
  Result := FSession;
end;

end.
