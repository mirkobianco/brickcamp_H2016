unit BrickCamp.services;

interface

uses
  Spring.Container,
	Spring.Logging;

  function CbLog: ILogger; inline;

implementation

function CbLog: ILogger; inline;
begin
  Result := GlobalContainer.Resolve<ILogger>;
end;

end.
