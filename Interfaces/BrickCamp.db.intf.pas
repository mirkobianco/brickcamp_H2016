unit BrickCamp.db.intf;

interface

uses
	Spring.Persistence.Core.Session;

type
  IBrickCampDb =  interface
  ['{E0B403C3-425B-4298-8697-ACED510B6F5F}']
    procedure InitializeDbConnection;
    function GetSession: TSession;
  end;

implementation

end.
