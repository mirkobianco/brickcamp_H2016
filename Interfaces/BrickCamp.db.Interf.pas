unit BrickCamp.db.interf;

interface

uses
	Spring.Persistence.Adapters.Firedac, Spring.Persistence.Core.Session;

type
  IBrickCampDb =  interface
  ['{E0B403C3-425B-4298-8697-ACED510B6F5F}']
    function GetDbConnection: TFireDACConnectionAdapter;
    function GetSession: TSession;
  end;

implementation

end.
