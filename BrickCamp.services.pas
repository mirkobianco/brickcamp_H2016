unit BrickCamp.services;

interface

uses
	Spring.Logging,
  Spring.Container;

  function CbLog: ILogger; inline;

implementation

function CbLog: ILogger; inline;
begin
  Result := GlobalContainer.Resolve<ILogger>;
end;

end.
