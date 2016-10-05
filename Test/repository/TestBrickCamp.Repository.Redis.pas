unit TestBrickCamp.Repository.Redis;

interface

uses
  System.Classes,
  TestFramework,
  Spring.Container,
  Spring.Collections,
  Brickcamp.Repository.Redis,
  Redis.Commons,
  BrickCamp.IRedisRepository,
  BrickCamp.IRedisClientProvider,
  BrickCamp.ISettings,
  BrickCamp.TSettings
  ;


type
  //integration test
  TestTRedisRepository = class(TTestCase)
  private
    function GetNewRedisClient : IRedisClient;
    function SetValue(redisClient : IRedisClient;value : string) : boolean;
    function GetRedisRepository : IRedisRepository;
    function GetConnectedRedisRepository(var Connected : Boolean) : IRedisRepository;
  public
    procedure SetUp; override;
  published
    procedure RedisClientSettings_Exist_Succeeds;
    procedure NewRedisClient_Defaults_Fails;
    procedure NewRedisClient_ConnectionSpecified_Succeeds;
    procedure NewRedisClient_SetValue_Succeeds;
    Procedure RedisRepository_Created_Succeeds;
    Procedure RedisRepository_Connected_Succeeds;
    Procedure RedisRepository_SetValue_Succeeds;
    Procedure RedisRepository_GetValue_Succeeds;

  end;

implementation

{ TestTRedisEmployeeRepository }


function TestTRedisRepository.GetConnectedRedisRepository(var Connected : Boolean) : IRedisRepository;
begin
  Result := GetRedisRepository;
  if Assigned(Result) then
    Connected := result.Connnect;
end;

function TestTRedisRepository.GetNewRedisClient: IRedisClient;
var
  RedisClientProvider : IRedisClientProvider;
begin
  RedisClientProvider := GlobalContainer.Resolve<IRedisClientProvider>;
  RedisClientProvider.Initialise;
  result := RedisClientProvider.NewRedisClient;
end;

function TestTRedisRepository.GetRedisRepository: IRedisRepository;
begin
  result := GlobalContainer.Resolve<IRedisRepository>;
end;

procedure TestTRedisRepository.NewRedisClient_ConnectionSpecified_Succeeds;
var
  RedisClient : IRedisClient;
begin
  RedisClient := GetNewRedisClient;
  Check(Assigned(RedisClient),'Check test connection parameters in ini file');
end;

procedure TestTRedisRepository.NewRedisClient_Defaults_Fails;
var
  RedisClientProvider : IRedisClientProvider;
  RedisClient : IRedisClient;
begin
  RedisClientProvider := GlobalContainer.Resolve<IRedisClientProvider>;
  RedisClient := RedisClientProvider.NewRedisClient;
  Check(not Assigned(RedisClient),'Out of the box should not connect');
end;

procedure TestTRedisRepository.NewRedisClient_SetValue_Succeeds;
var
  RedisClient : IRedisClient;
  Passed : Boolean;
begin
  RedisClient := GetNewRedisClient;
  Passed := SetValue(RedisClient,'BrickCamp');
  Check(Passed); //this will except, underlying code passes back true if no except
end;

procedure TestTRedisRepository.RedisClientSettings_Exist_Succeeds;
var
  BrickCampSettings: IBrickCampSettings;
  IpAddress : String;
begin
  BrickCampSettings := GlobalContainer.Resolve<IBrickCampSettings>;
  IpAddress := BrickCampSettings.GetRedisIpAddress;
  CheckNotEqualsString(IpAddress,'','Setting Redis IpV4 address Not Found ');
end;

procedure TestTRedisRepository.RedisRepository_Connected_Succeeds;
var
  CheckValue : Boolean;
begin
  GetConnectedRedisRepository(CheckValue);
  Check(CheckValue);
end;

procedure TestTRedisRepository.RedisRepository_Created_Succeeds;
var
  CheckValue : IRedisRepository;
begin
  CheckValue := GetRedisRepository;
  Check(assigned(CheckValue));
end;

procedure TestTRedisRepository.RedisRepository_GetValue_Succeeds;
var
  RedisRepository : IRedisRepository;
  CheckValue : Boolean;
  StringToCheck : string;
const
  VALUETOCHECK = 'V1';
begin
  RedisRepository := GetConnectedRedisRepository(CheckValue);
  if CheckValue then
    CheckValue := RedisRepository.SetValue('BrickCamp',VALUETOCHECK);
  if CheckValue then
    CheckValue := RedisRepository.GetValue('BrickCamp',StringToCheck);
  CheckEqualsString(StringToCheck,VALUETOCHECK,'Set Value failed, due to no connection or failure to set/get value');
end;

procedure TestTRedisRepository.RedisRepository_SetValue_Succeeds;
var
  RedisRepository : IRedisRepository;
  CheckValue : Boolean;
begin
  RedisRepository := GetConnectedRedisRepository(CheckValue);
  if CheckValue then
    CheckValue := RedisRepository.SetValue('BrickCamp','V1');
  Check(CheckValue,'Set Value failed, due to no connection or failure to set value');
end;

procedure TestTRedisRepository.SetUp;
begin
  inherited;
end;

function TestTRedisRepository.SetValue(redisClient: IRedisClient;
  value: string): boolean;
begin
  result := RedisClient.&SET('firstname', 'BrickCamp');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTRedisRepository.Suite);
  //register spring 4d here. requires a run once set up..TODO move out initialisation
  GlobalContainer.RegisterType<TCbdSettings>;
  GlobalContainer.RegisterType<TRedisClientProvider>;
  GlobalContainer.RegisterType<TRedisRepository>;

  GlobalContainer.Build;

end.


