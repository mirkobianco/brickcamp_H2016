unit BrickCamp.TService;

interface

uses
  MARS.Core.Engine,
  MARS.http.Server.Indy,
  MARS.Core.Application,

  BrickCamp.IService;

type
  TCbdService = class(TInterfacedObject, IBrickCampService)
  private
    FEngine: TMARSEngine;
    FServer: TMARShttpServerIndy;

    procedure RegisterClasses;

    procedure InitLogger;
    procedure InitREST;
    function GetLoggerFileName: string;
  public
    destructor Destroy; override;

    procedure Run;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  Spring.Container,
  Spring.Logging,
  Spring.Logging.Loggers,
  Spring.Logging.Controller,
  Spring.Logging.Appenders,
  Spring.Logging.Configuration,
  MARS.Utils.Parameters.IniFile,
  BrickCamp.TSettings,
  BrickCamp.TDB,
  BrickCamp.services,
  BrickCamp.Repositories.TEmployee,
  BrickCamp.Resources.TEmployee,
  BrickCamp.Model.TEmployee,
  BrickCamp.Repositories.TProduct,
  BrickCamp.Resources.TProduct,
  BrickCamp.Model.TProduct
  ;

{ TCbdService }

destructor TCbdService.Destroy;
begin
  FServer.Free;
  FEngine.Free;
  inherited;
end;

function TCbdService.GetLoggerFileName: string;
var
  FileNameFormat: TFormatSettings;
  LogDir: string;
begin
  FileNameFormat := TFormatSettings.Create;
  FileNameFormat.TimeSeparator := '_';
  FileNameFormat.DateSeparator := '-';
  FileNameFormat.LongDateFormat := 'DD-MM-yy';
  FileNameFormat.LongTimeFormat := 'HH_MM_SS';
  FileNameFormat.ShortDateFormat := 'DD-MM-yy';

  LogDir := ExtractFilePath(ParamStr(0)) + 'logs\';
  ForceDirectories(LogDir);

  Result := LogDir + Format('logger-%s.log', [DateTimeToStr(Now, FileNameFormat)]);
  Result := LogDir + 'logger.log';
end;

procedure TCbdService.InitLogger;
var
  FileApp: TFileLogAppender;
begin
  GlobalContainer.RegisterType<ILoggerController, TLoggerController>.AsSingleton;
//  GlobalContainer.RegisterType<TLoggingConfiguration>.Implements<TLoggingConfiguration>.AsSingleton;
  GlobalContainer.RegisterType<Spring.Logging.ILogger, Spring.Logging.Loggers.TLogger>.AsSingleton.AsDefault;
  GlobalContainer.Build;

  FileApp := TFileLogAppender.Create;
  FileApp.FileName := GetLoggerFileName;
  FileApp.Levels := LOG_ALL_LEVELS;
  FileApp.EntryTypes := LOG_ALL_ENTRY_TYPES;
  FileApp.Enabled := True;
  GlobalContainer.Resolve<Spring.Logging.ILoggerController>.AddAppender(FileApp);

  TLoggerController(GlobalContainer.Resolve<Spring.Logging.ILoggerController>).EntryTypes := LOG_ALL_ENTRY_TYPES;
  TLoggerController(GlobalContainer.Resolve<Spring.Logging.ILoggerController>).Levels := LOG_ALL_LEVELS;

  Spring.Logging.Loggers.TLogger(CbLog).Levels := LOG_ALL_LEVELS;
  Spring.Logging.Loggers.TLogger(CbLog).Enabled := True;
  Spring.Logging.Loggers.TLogger(CbLog).EntryTypes := LOG_ALL_ENTRY_TYPES;
end;

procedure TCbdService.InitREST;
begin
  // MARS-Curiosity Engine
  FEngine := TMARSEngine.Create;
  try
    FEngine.Parameters.LoadFromIniFile;
    FEngine.AddApplication('DefaultApp', '/cb', ['BrickCamp.Resources.*']);

    // http server implementation
    FServer := TMARShttpServerIndy.Create(FEngine);
    try
      FServer.Active := True;
    except
      FServer.Free;
      raise;
    end;
  except
    FEngine.Free;
    raise;
  end;
end;

procedure TCbdService.RegisterClasses;
begin
  GlobalContainer.RegisterType<TCbdSettings>;
  GlobalContainer.RegisterType<TCbdDB>;
  GlobalContainer.RegisterType<TEmployeeResource>;
  GlobalContainer.RegisterType<TEmployee>;
  GlobalContainer.RegisterType<TEmployeeRepository>;
  GlobalContainer.RegisterType<TProductResource>;
  GlobalContainer.RegisterType<TProduct>;
  GlobalContainer.RegisterType<TProductRepository>;
  GlobalContainer.RegisterType<TMARSEngine>;
  GlobalContainer.RegisterType<TMARShttpServerIndy>;
  GlobalContainer.Build;
end;

procedure TCbdService.Run;
begin
  InitREST;
  InitLogger;
  RegisterClasses;

end;


end.
