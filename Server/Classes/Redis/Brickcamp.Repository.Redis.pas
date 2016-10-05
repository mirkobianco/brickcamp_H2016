unit Brickcamp.Repository.Redis;

interface

uses  Redis.Client,
      Redis.NetLib.INDY,
      Redis.Commons,
      Spring.Container.Injection,
      Spring.Container.Common,
      BrickCamp.ISettings,
      BrickCamp.IRedisRepository,
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

  TRedisRepository = class(TInterfacedObject,IRedisRepository)
  protected var
    [Inject]
    FRedisClientProvider : IRedisClientProvider;
    FRedisClient : IRedisClient;
  public
    function Connnect : Boolean;
    function SetValue(Keyname : String; Value : String) : Boolean;
    function GetValue(Keyname : String; var Value : String) : Boolean;
  end;

implementation


{ TRedisEmployeeRepository }

function TRedisRepository.Connnect : boolean;
begin
  FRedisClientProvider.Initialise;
  FRedisClient := FRedisClientProvider.NewRedisClient();
  Result := Assigned(FRedisClient);
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

function TRedisRepository.GetValue(Keyname: String; var Value: String): Boolean;
begin
  result := FRedisClient.&GET(Keyname,Value);
end;

function TRedisRepository.SetValue(Keyname : String; Value: String): Boolean;
begin
  result := FRedisClient.&SET(Keyname,Value);
end;

end.
