unit BrickCamp.settings.impl;

interface

uses
	BrickCamp.settings.intf,
  System.IniFiles;

type
  TCbdSettings = class(TInterfacedObject, IBrickCampSettings)
  protected const
    CONFIG_INI = 'config.ini';
  protected
    function GetConfigFile: TIniFile;

    function GetValueAsString(Section, Key: string): string;
  public
    function GetDBStringConnection: string;
  end;

implementation

uses
	System.SysUtils;

const
  DB_SEC = 'DB';
  DB_KEY_CONSTR = 'ConnectionString';


{ TCbdSettings }

function TCbdSettings.GetConfigFile: TIniFile;
begin
  Result := TIniFile.Create(ExtractFilePath(ParamStr(0)) + CONFIG_INI);
end;

function TCbdSettings.GetDBStringConnection: string;
begin
  Result := GetValueAsString(DB_SEC, DB_KEY_CONSTR);
end;

function TCbdSettings.GetValueAsString(Section, Key: string): string;
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

end.
