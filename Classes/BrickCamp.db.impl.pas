unit BrickCamp.db.impl;

interface

uses
	BrickCamp.db.interf, Spring.Persistence.Adapters.FireDac, BrickCamp.settings.interf, Spring.Container.Common,
  Spring.Persistence.Core.Session, FireDAC.Phys;

type
  TCbdDB = class(TInterfacedObject, IBrickCampDb)
  protected var
    [Inject]
    FSettings: IBrickCampSettings;

    FCon: TFireDACConnectionAdapter;
    FSession: TSession;
  public
    function GetDbConnection: TFireDACConnectionAdapter;
    function GetSession: TSession;
  end;

implementation

uses
	Spring.Container, Data.Win.ADODB, Spring.Persistence.Core.ListSession,
  Spring.Collections, FireDAC.Comp.Client, FireDAC.Phys.IBDef, FireDAC.Phys.IBWrapper,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.FB;

{ TCbdDB }

function TCbdDB.GetDbConnection: TFireDACConnectionAdapter;
begin
  if FCon <> nil then
    Exit;


  FCon := TFireDACConnectionAdapter.Create(TFDConnection.Create(nil));
  FCon.Connection.ConnectionString := FSettings.GetDBStringConnection;
  FCon.Connection.LoginPrompt := false;
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
