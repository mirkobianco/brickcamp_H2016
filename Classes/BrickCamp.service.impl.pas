unit BrickCamp.service.impl;

interface

uses
  BrickCamp.service.interf,
  Spring.Persistence.Adapters.Oracle;

type
  TCbdService = class(TInterfacedObject, IBrickCampService)
  private
    procedure RegisterClasses;

    procedure InitLogger;
    procedure StartSynchronization;

    function GetLoggerFileName: string;
  public
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
  BrickCamp.services, BrickCamp.translationsSynchronizer.impl, BrickCamp.translationsSynchronizer.interf;

{ TCbdService }

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

procedure TCbdService.RegisterClasses;
begin
  GlobalContainer.RegisterType<TCbdSettings>;
  GlobalContainer.RegisterType<TCbdDB>;
  GlobalContainer.RegisterType<TCbdTransSynchronizer>;
  GlobalContainer.Build;
end;

procedure TCbdService.Run;
begin
  InitLogger;
  RegisterClasses;
  StartSynchronization;
end;

procedure TCbdService.StartSynchronization;
begin
  GlobalContainer.Resolve<ITranslationSynchronizer>.Synchronize;
end;

end.
