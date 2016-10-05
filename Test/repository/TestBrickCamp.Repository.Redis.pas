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
  end;

implementation

{ TestTRedisEmployeeRepository }

procedure TestTRedisEmployeeRepository.NewRedisClient_Defaults_Fails;
var
  RedisClientProvider : IRedisClientProvider;
  RedisClient : IRedisClient;
begin
  RedisClientProvider := GlobalContainer.Resolve<IRedisClientProvider>;
   //GlobalContainer.RegisterType<TEmployee>;
  RedisClient := RedisClientProvider.NewRedisClient;

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


