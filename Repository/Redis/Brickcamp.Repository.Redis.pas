unit Brickcamp.Repository.Redis;

interface

uses  Redis.Client,
      Redis.NetLib.INDY,
      Redis.Commons,
      Spring.Container.Injection,
      Spring.Container.Common;

type
  IRedisEmployeeRepository = interface
    ['{12C2DA6A-ADD0-4097-9FC5-115CCAA7797D}']
  end;

  //[Inject]
  ///TRedisClientProvider
  ///Provide the a wrapper to create a Redis Client and provide the settings to it
  TRedisClientProvider = class
  public
    function NewRedisClient : IRedisClient;
  end;

  TRedisEmployeeRepository = class(TInterfacedObject,IRedisEmployeeRepository)
  protected var
    [Inject]
    FRedis : IRedisClient;
  public
    procedure Connnect;
  end;

implementation


{ TRedisEmployeeRepository }

procedure TRedisEmployeeRepository.Connnect;
begin
  FRedis := NewRedisClient('localhost');
end;

{ TRedisClientProvider }

function TRedisClientProvider.NewRedisClient: IRedisClient;
begin

end;

end.
