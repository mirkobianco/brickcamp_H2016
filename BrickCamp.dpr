program BrickCamp;

uses
  Vcl.SvcMgr,
  BrickCamp.service in 'BrickCamp.service.pas' {srvBrickCamp: TService},
  BrickCamp.service.intf in 'Interfaces\BrickCamp.service.intf.pas',
  BrickCamp.settings.intf in 'Interfaces\BrickCamp.settings.intf.pas',
  BrickCamp.db.intf in 'Interfaces\BrickCamp.db.intf.pas',
  BrickCamp.services in 'BrickCamp.services.pas',
  BrickCamp.Model.Employee.Impl in 'Classes\BrickCamp.Model.Employee.Impl.pas',
  BrickCamp.Repositories.Employee.Intf in 'Interfaces\BrickCamp.Repositories.Employee.Intf.pas',
  BrickCamp.Resources.Employee.Impl in 'Classes\BrickCamp.Resources.Employee.Impl.pas',
  BrickCamp.Repositories.Employee.Mock in 'Mocks\BrickCamp.Repositories.Employee.Mock.pas',
  BrickCamp.db.impl in 'Classes\BrickCamp.db.impl.pas',
  BrickCamp.service.impl in 'Classes\BrickCamp.service.impl.pas',
  BrickCamp.settings.impl in 'Classes\BrickCamp.settings.impl.pas',
  BrickCamp.Repositories.Employee.Impl in 'Classes\BrickCamp.Repositories.Employee.Impl.pas',
  BrickCamp.Model.Employee.Intf in 'Interfaces\BrickCamp.Model.Employee.Intf.pas',
  BrickCamp.Resources.Employee.Intf in 'Interfaces\BrickCamp.Resources.Employee.Intf.pas';

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
