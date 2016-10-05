unit TestBrickCamp.Repository.Redis;

interface

uses
  System.Classes,
  TestFramework,
  Spring.Container,
  Spring.Collections,
  Brickcamp.Repository.Redis,
  Redis.Commons,
  BrickCamp.IRedisEmployeeRepository,
  BrickCamp.IRedisClientProvider,
  BrickCamp.ISettings,
  BrickCamp.TSettings
  ;


type
  //integration test
  TestTRedisEmployeeRepository = class(TTestCase)
  public
    procedure SetUp; override;
  published
    procedure RedisClientSettings_Exist_Succeeds;
    procedure NewRedisClient_Defaults_Fails;
    procedure NewRedisClient_ConnectionSpecified_Succeeds;
  end;

implementation

{ TestTRedisEmployeeRepository }

procedure TestTRedisEmployeeRepository.NewRedisClient_ConnectionSpecified_Succeeds;
var
  RedisClientProvider : IRedisClientProvider;
  RedisClient : IRedisClient;
begin
  RedisClientProvider := GlobalContainer.Resolve<IRedisClientProvider>;
  RedisClientProvider.Initialise;
  RedisClient := RedisClientProvider.NewRedisClient;
  Check(Assigned(RedisClient),'Check test connection parameters in ini file');
end;

procedure TestTRedisEmployeeRepository.NewRedisClient_Defaults_Fails;
var
  RedisClientProvider : IRedisClientProvider;
  RedisClient : IRedisClient;
begin
  RedisClientProvider := GlobalContainer.Resolve<IRedisClientProvider>;
  RedisClient := RedisClientProvider.NewRedisClient;
  Check(not Assigned(RedisClient),'Out of the box should not connect');
end;

procedure TestTRedisEmployeeRepository.RedisClientSettings_Exist_Succeeds;
var
  BrickCampSettings: IBrickCampSettings;
  IpAddress : String;
begin
  BrickCampSettings := GlobalContainer.Resolve<IBrickCampSettings>;
  IpAddress := BrickCampSettings.GetRedisIpAddress;
  CheckNotEqualsString(IpAddress,'','Setting Redis IpV4 address Not Found ');
end;

procedure TestTRedisEmployeeRepository.SetUp;
begin
  inherited;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTRedisEmployeeRepository.Suite);
  //register spring 4d here. requires a run once set up..TODO move out initialisation
  GlobalContainer.RegisterType<TCbdSettings>;
  GlobalContainer.RegisterType<TRedisClientProvider>;
  GlobalContainer.RegisterType<TRedisEmployeeRepository>;

  GlobalContainer.Build;

end.


