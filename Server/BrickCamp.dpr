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
  BrickCamp.Repositories.IEmployee in '..\Model\Interfaces\BrickCamp.Repositories.IEmployee.pas',
  Brickcamp.Repository.Redis in 'Classes\Redis\Brickcamp.Repository.Redis.pas',
  BrickCamp.Model.IProduct in '..\Model\Interfaces\BrickCamp.Model.IProduct.pas',
  BrickCamp.Repositories.IProduct in '..\Model\Interfaces\BrickCamp.Repositories.IProduct.pas',
  BrickCamp.Model.TProduct in '..\Model\Classes\BrickCamp.Model.TProduct.pas',
  BrickCamp.Repositories.TProduct in '..\Model\Classes\BrickCamp.Repositories.TProduct.pas',
  BrickCamp.Resources.IProduct in 'Interfaces\BrickCamp.Resources.IProduct.pas',
  BrickCamp.Resources.TProduct in 'Classes\BrickCamp.Resources.TProduct.pas';

{$R *.RES}

begin
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;

  Application.CreateForm(TsrvBrickCamp, srvBrickCamp);
  {$IFDEF CONSOLE}
  srvBrickCamp.Initialize;
  {$ENDIF}
  Application.Run;
end.
