unit TestBrickCamp.Repository.Redis;

interface

uses
  TestFramework,
  Spring.Container,
  Spring.Collections,
  Brickcamp.Repository.Redis,
  Redis.Commons;


type
  //integration test
  TestTRedisEmployeeRepository = class(TTestCase)
  public
    procedure SetUp; override;
  published
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

procedure TestTRedisEmployeeRepository.SetUp;
begin
  inherited;
  GlobalContainer.RegisterType<TRedisClientProvider>;
  GlobalContainer.RegisterType<TRedisEmployeeRepository>;
  GlobalContainer.Build;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTRedisEmployeeRepository.Suite);

end.


