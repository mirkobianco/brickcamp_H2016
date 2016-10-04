unit BrickCamp.service.impl;

interface

uses
  MARS.Core.Engine,
  MARS.http.Server.Indy,
  MARS.Core.Application,

  Spring.Persistence.Adapters.FireDac,

  BrickCamp.service.interf,
  BrickCamp.Model.Employee.Intf,
  BrickCamp.Repositories.Employee.Mock,
  BrickCamp.Model.Employee.Impl;

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
  Spring.Container,
  BrickCamp.settings.impl,
  BrickCamp.db.impl,
  Spring.Logging.Loggers,
  Spring.Logging.Controller,
  Spring.Logging.Appenders,
  System.SysUtils,
  Spring.Logging.Configuration,
  System.Classes,
  Vcl.SvcMgr,
  Spring.Logging,
  BrickCamp.services,
  BrickCamp.Repositories.Employee.Impl,
  BrickCamp.Resources.Employee,
  MARS.Core.MessageBodyWriter,
  MARS.Core.MessageBodyWriters,
  MARS.Core.URL,
  MARS.Utils.Parameters.IniFile
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
