unit Brickcamp.Repository.Redis;

interface

uses  Redis.Client,
      Redis.NetLib.INDY,
      Redis.Commons,
      Spring.Container.Injection,
      Spring.Container.Common,
      BrickCamp.ISettings;

type

  IRedisEmployeeRepository = interface
    ['{12C2DA6A-ADD0-4097-9FC5-115CCAA7797D}']
    procedure Connnect;
  end;

  IRedisClientProvider = interface
    ['{A0AA57D9-8808-4B65-9B00-FA13A8843C5C}']
    function NewRedisClient : IRedisClient;
  end;

  ///******** TRedisClientProvider *********///
  ///Provide the a wrapper to create a Redis Client and provide the settings to it
  TRedisClientProvider = class(TInterfacedObject,IRedisClientProvider)
  protected
  [Inject]
    FSettings: IBrickCampSettings;
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
