unit BrickCamp.IRedisClientProvider;

interface
uses
  Redis.Commons;
type
  IRedisClientProvider = interface
    ['{A0AA57D9-8808-4B65-9B00-FA13A8843C5C}']
    function NewRedisClient : IRedisClient;
    procedure Initialise;
  end;

implementation

end.
