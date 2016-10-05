program BrickCampTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestBrickCamp.Repositories.Employee in 'TestBrickCamp.Repositories.Employee.pas',
  BrickCamp.Repositories.TEmployee.Mock in '..\Mocks\BrickCamp.Repositories.TEmployee.Mock.pas',
  BrickCamp.Model.TEmployee in '..\Model\Classes\BrickCamp.Model.TEmployee.pas',
  BrickCamp.service in '..\Server\BrickCamp.service.pas' {srvBrickCamp: TService},
  BrickCamp.services in '..\Server\BrickCamp.services.pas',
  TestBrickCamp.Repository.Redis in 'repository\TestBrickCamp.Repository.Redis.pas',
  Brickcamp.Repository.Redis in '..\Server\Classes\Redis\Brickcamp.Repository.Redis.pas',
  BrickCamp.IRedisClientProvider in '..\Server\Interfaces\Redis\BrickCamp.IRedisClientProvider.pas',
  BrickCamp.IRedisEmployeeRepository in '..\Server\Interfaces\Redis\BrickCamp.IRedisEmployeeRepository.pas',
  BrickCamp.Model.TAnswer in '..\Model\Classes\BrickCamp.Model.TAnswer.pas',
  BrickCamp.Model.TProduct in '..\Model\Classes\BrickCamp.Model.TProduct.pas',
  BrickCamp.Model.TQuestion in '..\Model\Classes\BrickCamp.Model.TQuestion.pas',
  BrickCamp.Model.TUser in '..\Model\Classes\BrickCamp.Model.TUser.pas',
  BrickCamp.Repositories.TAnswer in '..\Model\Classes\BrickCamp.Repositories.TAnswer.pas',
  BrickCamp.Repositories.TProduct in '..\Model\Classes\BrickCamp.Repositories.TProduct.pas',
  BrickCamp.Repositories.TQuestion in '..\Model\Classes\BrickCamp.Repositories.TQuestion.pas',
  BrickCamp.Repositories.TUser in '..\Model\Classes\BrickCamp.Repositories.TUser.pas',
  BrickCamp.Model.IAnswer in '..\Model\Interfaces\BrickCamp.Model.IAnswer.pas',
  BrickCamp.Model.IProduct in '..\Model\Interfaces\BrickCamp.Model.IProduct.pas',
  BrickCamp.Model.IQuestion in '..\Model\Interfaces\BrickCamp.Model.IQuestion.pas',
  BrickCamp.Model.IUser in '..\Model\Interfaces\BrickCamp.Model.IUser.pas',
  BrickCamp.Repositories.IAnswer in '..\Model\Interfaces\BrickCamp.Repositories.IAnswer.pas',
  BrickCamp.Repositories.IProduct in '..\Model\Interfaces\BrickCamp.Repositories.IProduct.pas',
  BrickCamp.Repositories.IQuestion in '..\Model\Interfaces\BrickCamp.Repositories.IQuestion.pas',
  BrickCamp.Repositories.IUser in '..\Model\Interfaces\BrickCamp.Repositories.IUser.pas',
  BrickCamp.Model.IEmployee in '..\Model\Interfaces\BrickCamp.Model.IEmployee.pas',
  BrickCamp.Repositories.IEmployee in '..\Model\Interfaces\BrickCamp.Repositories.IEmployee.pas',
  BrickCamp.Resources.TAnswer in '..\Server\Classes\BrickCamp.Resources.TAnswer.pas',
  BrickCamp.Resources.TEmployee in '..\Server\Classes\BrickCamp.Resources.TEmployee.pas',
  BrickCamp.Resources.TProduct in '..\Server\Classes\BrickCamp.Resources.TProduct.pas',
  BrickCamp.Resources.TQuestion in '..\Server\Classes\BrickCamp.Resources.TQuestion.pas',
  BrickCamp.Resources.TUser in '..\Server\Classes\BrickCamp.Resources.TUser.pas',
  BrickCamp.TDB in '..\Server\Classes\BrickCamp.TDB.pas',
  BrickCamp.TService in '..\Server\Classes\BrickCamp.TService.pas',
  BrickCamp.TSettings in '..\Server\Classes\BrickCamp.TSettings.pas',
  BrickCamp.IDB in '..\Server\Interfaces\BrickCamp.IDB.pas',
  BrickCamp.IService in '..\Server\Interfaces\BrickCamp.IService.pas',
  BrickCamp.ISettings in '..\Server\Interfaces\BrickCamp.ISettings.pas',
  BrickCamp.Resources.IAnswer in '..\Server\Interfaces\BrickCamp.Resources.IAnswer.pas',
  BrickCamp.Resources.IEmployee in '..\Server\Interfaces\BrickCamp.Resources.IEmployee.pas',
  BrickCamp.Resources.IProduct in '..\Server\Interfaces\BrickCamp.Resources.IProduct.pas',
  BrickCamp.Resources.IQuestion in '..\Server\Interfaces\BrickCamp.Resources.IQuestion.pas',
  BrickCamp.Resources.IUser in '..\Server\Interfaces\BrickCamp.Resources.IUser.pas',
  BrickCamp.Repositories.TEmployee in '..\Model\Classes\BrickCamp.Repositories.TEmployee.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

