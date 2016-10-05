unit BrickCamp.TSettings;

interface

uses
  BrickCamp.ISettings,
  System.IniFiles;

type
  TCbdSettings = class(TInterfacedObject, IBrickCampSettings)
  protected const
    CONFIG_INI = 'config.ini';
  protected
    function GetConfigFile: TIniFile;

    function GetValueAsString(Section, Key: String): String;
    function GetValueAsInteger(Section, Key: String): Integer;
  public
    function GetDBStringConnection: String;
    function GetRedisIpAddress: String;
    function GetRedisIpPort: String;
  end;

implementation

uses
	System.SysUtils;

const
  DB_SEC = 'DB';
  DB_KEY_CONSTR = 'ConnectionString';
  REDIS_SEC = 'Redis';
  REDIS_ADDRESS_IPV4 = 'Address_IpV4';
  REDIS_PORT_IPV4 = 'Port';

{ TCbdSettings }

function TCbdSettings.GetConfigFile: TIniFile;
begin
  //TODO - renamed athe config file to the name of exe, and use an after build event to leave it in target folder from project folder
  Result := TIniFile.Create(ExtractFilePath(ParamStr(0)) + CONFIG_INI);
end;

function TCbdSettings.GetDBStringConnection: String;
begin
  Result := GetValueAsString(DB_SEC, DB_KEY_CONSTR);
end;

function TCbdSettings.GetRedisIpAddress: String;
begin
  Result := GetValueAsString(REDIS_SEC, REDIS_ADDRESS_IPV4);
end;

function TCbdSettings.GetRedisIpPort: String;
begin
  Result := GetValueAsString(REDIS_SEC, REDIS_PORT_IPV4);
end;

function TCbdSettings.GetValueAsString(Section, Key: String): String;
var
  Config: TIniFile;
begin
  Config := GetConfigFile;
  try
    Result := Config.ReadString(Section, Key, '');
  finally
    Config.Free;
  end;
end;

function TCbdSettings.GetValueAsInteger(Section, Key: String): Integer;
var
  Config: TIniFile;
begin
  Config := GetConfigFile;
  try
    Result := Config.ReadInteger(Section, Key, -1);
  finally
    Config.Free;
  end;
end;


end.
