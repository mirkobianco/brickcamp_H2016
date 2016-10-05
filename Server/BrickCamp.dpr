program BrickCamp;

uses
  Vcl.SvcMgr,
  BrickCamp.service in 'BrickCamp.service.pas' {srvBrickCamp: TService},
  BrickCamp.IService in 'Interfaces\BrickCamp.IService.pas',
  BrickCamp.ISettings in 'Interfaces\BrickCamp.ISettings.pas',
  BrickCamp.IDB in 'Interfaces\BrickCamp.IDB.pas',
  BrickCamp.services in 'BrickCamp.services.pas',
  BrickCamp.Model.TEmployee in '..\Model\Classes\BrickCamp.Model.TEmployee.pas',
  BrickCamp.Resources.TEmployee in 'Classes\BrickCamp.Resources.TEmployee.pas',
  BrickCamp.TDB in 'Classes\BrickCamp.TDB.pas',
  BrickCamp.TService in 'Classes\BrickCamp.TService.pas',
  BrickCamp.TSettings in 'Classes\BrickCamp.TSettings.pas',
  BrickCamp.Resources.IEmployee in 'Interfaces\BrickCamp.Resources.IEmployee.pas',
  BrickCamp.Model.IEmployee in '..\Model\Interfaces\BrickCamp.Model.IEmployee.pas',
  BrickCamp.Repositories.TEmployee in '..\Model\Classes\BrickCamp.Repositories.TEmployee.pas',
  BrickCamp.Repositories.IEmployee in '..\Model\Interfaces\BrickCamp.Repositories.IEmployee.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;

  Application.CreateForm(TsrvBrickCamp, srvBrickCamp);
  {$IFDEF CONSOLE}
  srvBrickCamp.Initialize;
  {$ENDIF}
  Application.Run;
end.
