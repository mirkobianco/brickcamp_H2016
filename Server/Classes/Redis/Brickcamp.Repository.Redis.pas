unit Brickcamp.Repository.Redis;

interface

uses  Redis.Client,
      Redis.NetLib.INDY,
      Redis.Commons,
      Spring.Container.Injection,
      Spring.Container.Common,
      BrickCamp.ISettings,
      BrickCamp.IRedisEmployeeRepository,
      BrickCamp.IRedisClientProvider;

type


  ///******** TRedisClientProvider *********///
  ///Provide the a wrapper to create a Redis Client and provide the settings to it
  TRedisClientProvider = class(TInterfacedObject,IRedisClientProvider)
  protected
  [Inject]
    FSettings: IBrickCampSettings;
    FIpV4Address : string;
  public
    function NewRedisClient : IRedisClient;
    procedure Initialise;
  end;

  TRedisEmployeeRepository = class(TInterfacedObject,IRedisEmployeeRepository)
  protected var
    [Inject]
    FRedis : IRedisClientProvider;
  public
    procedure Connnect;
  end;

implementation


{ TRedisEmployeeRepository }

procedure TRedisEmployeeRepository.Connnect;
begin
  //FRedis := NewRedisClient('localhost');
end;

{ TRedisClientProvider }

procedure TRedisClientProvider.Initialise;
begin
  FIpV4Address := FSettings.GetRedisIpAddress;
end;

function TRedisClientProvider.NewRedisClient: IRedisClient;
begin
  result := Redis.Client.NewRedisClient(FIpV4Address);
end;

end.
