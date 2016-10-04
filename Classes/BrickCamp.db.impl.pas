unit BrickCamp.db.impl;

interface

uses
	BrickCamp.db.interf, Spring.Persistence.Adapters.Oracle, BrickCamp.settings.interf, Spring.Container.Common,
  Spring.Persistence.Core.Session;

type
  TCbdDB = class(TInterfacedObject, IBrickCampDb)
  protected var
    [Inject]
    FSettings: IBrickCampSettings;

    FCon: TOracleConnectionAdapter;
    FSession: TSession;
  public
    function GetDbConnection: TOracleConnectionAdapter;
    function GetSession: TSession;
  end;

implementation

uses
	Spring.Container, Data.Win.ADODB, Spring.Persistence.Core.ListSession,
  Spring.Collections;

{ TCbdDB }

function TCbdDB.GetDbConnection: TOracleConnectionAdapter;
begin
  if FCon <> nil then
    Exit;

  FCon := TOracleConnectionAdapter.Create(TADOConnection.Create(nil));
  FCon.Connection.ConnectionString := FSettings.GetDBStringConnection;
  FCon.Connect;

  FSession := TSession.Create(FCon);
  result := FCon;
end;

function TCbdDB.GetSession: TSession;
begin
  GetDbConnection;
  Result := FSession;
end;

end.
