program BrickCamp;

uses
  Vcl.SvcMgr,
  BrickCamp.IService in 'Interfaces\BrickCamp.IService.pas',
  BrickCamp.ISettings in 'Interfaces\BrickCamp.ISettings.pas',
  BrickCamp.IDB in 'Interfaces\BrickCamp.IDB.pas',
  Brickcamp.Repository.Redis in 'Classes\Redis\Brickcamp.Repository.Redis.pas',
  BrickCamp.IRedisClientProvider in 'Interfaces\Redis\BrickCamp.IRedisClientProvider.pas',
  BrickCamp.IRedisRepository in 'Interfaces\Redis\BrickCamp.IRedisRepository.pas',
  BrickCamp.Model.TAnswer in '..\Model\Classes\BrickCamp.Model.TAnswer.pas',
  BrickCamp.Model.TProduct in '..\Model\Classes\BrickCamp.Model.TProduct.pas',
  BrickCamp.Model.TUser in '..\Model\Classes\BrickCamp.Model.TUser.pas',
  BrickCamp.Repositories.TAnswer in '..\Model\Classes\BrickCamp.Repositories.TAnswer.pas',
  BrickCamp.Repositories.TProduct in '..\Model\Classes\BrickCamp.Repositories.TProduct.pas',
  BrickCamp.Repositories.TUser in '..\Model\Classes\BrickCamp.Repositories.TUser.pas',
  BrickCamp.Model.IProduct in '..\Model\Interfaces\BrickCamp.Model.IProduct.pas',
  BrickCamp.Repositories.IProduct in '..\Model\Interfaces\BrickCamp.Repositories.IProduct.pas',
  BrickCamp.Resources.IProduct in 'Interfaces\BrickCamp.Resources.IProduct.pas',
  BrickCamp.Model.IAnswer in '..\Model\Interfaces\BrickCamp.Model.IAnswer.pas',
  BrickCamp.Repositories.IAnswer in '..\Model\Interfaces\BrickCamp.Repositories.IAnswer.pas',
  BrickCamp.Resources.IAnswer in 'Interfaces\BrickCamp.Resources.IAnswer.pas',
  BrickCamp.Resources.TAnswer in 'Classes\BrickCamp.Resources.TAnswer.pas',
  BrickCamp.Model.IUser in '..\Model\Interfaces\BrickCamp.Model.IUser.pas',
  BrickCamp.Repositories.IUser in '..\Model\Interfaces\BrickCamp.Repositories.IUser.pas',
  BrickCamp.Resources.IUser in 'Interfaces\BrickCamp.Resources.IUser.pas',
  BrickCamp.Resources.TUser in 'Classes\BrickCamp.Resources.TUser.pas',
  BrickCamp.Model.IQuestion in '..\Model\Interfaces\BrickCamp.Model.IQuestion.pas',
  BrickCamp.Repositories.IQuestion in '..\Model\Interfaces\BrickCamp.Repositories.IQuestion.pas',
  BrickCamp.Model.TQuestion in '..\Model\Classes\BrickCamp.Model.TQuestion.pas',
  BrickCamp.Repositories.TQuestion in '..\Model\Classes\BrickCamp.Repositories.TQuestion.pas',
  BrickCamp.Resources.TQuestion in 'Classes\BrickCamp.Resources.TQuestion.pas',
  BrickCamp.Resources.IQuestion in 'Interfaces\BrickCamp.Resources.IQuestion.pas',
  BrickCamp.Model.TEmployee in '..\Model\Classes\BrickCamp.Model.TEmployee.pas',
  BrickCamp.Repositories.TEmployee in '..\Model\Classes\BrickCamp.Repositories.TEmployee.pas',
  BrickCamp.Model.IEmployee in '..\Model\Interfaces\BrickCamp.Model.IEmployee.pas',
  BrickCamp.Repositories.IEmployee in '..\Model\Interfaces\BrickCamp.Repositories.IEmployee.pas',
  BrickCamp.services in 'BrickCamp.services.pas',
  BrickCamp.service in 'BrickCamp.service.pas' {srvBrickCamp: TService},
  BrickCamp.TService in 'Classes\BrickCamp.TService.pas',
  BrickCamp.TSettings in 'Classes\BrickCamp.TSettings.pas',
  BrickCamp.TDB in 'Classes\BrickCamp.TDB.pas',
  BrickCamp.Resources.TEmployee in 'Classes\BrickCamp.Resources.TEmployee.pas',
  BrickCamp.Resources.IEmployee in 'Interfaces\BrickCamp.Resources.IEmployee.pas',
  BrickCamp.Resources.TProduct in 'Classes\BrickCamp.Resources.TProduct.pas',
  BrickCamp.Common.JsonContract in 'Classes\BrickCamp.Common.JsonContract.pas',
  BrickCamp.Common.Mapping in 'Classes\BrickCamp.Common.Mapping.pas',
  BrickCamp.JsonUser in '..\Model\JsonEntities\BrickCamp.JsonUser.pas';

{$R *.RES}

begin
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;

  Application.CreateForm(TsrvBrickCamp, srvBrickCamp);
  Application.CreateForm(TsrvBrickCamp, srvBrickCamp);
  Application.CreateForm(TsrvBrickCamp, srvBrickCamp);
  Application.CreateForm(TsrvBrickCamp, srvBrickCamp);
  {$IFDEF CONSOLE}
  srvBrickCamp.Initialize;
  {$ENDIF}
  Application.Run;
end.
