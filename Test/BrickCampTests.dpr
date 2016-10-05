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
  BrickCamp.Model.IEmployee in '..\Model\Interfaces\BrickCamp.Model.IEmployee.pas',
  BrickCamp.Repositories.TEmployee in '..\Server\Classes\BrickCamp.Repositories.TEmployee.pas',
  BrickCamp.Resources.TEmployee in '..\Server\Classes\BrickCamp.Resources.TEmployee.pas',
  BrickCamp.TDB in '..\Server\Classes\BrickCamp.TDB.pas',
  BrickCamp.TService in '..\Server\Classes\BrickCamp.TService.pas',
  BrickCamp.TSettings in '..\Server\Classes\BrickCamp.TSettings.pas',
  BrickCamp.IDB in '..\Server\Interfaces\BrickCamp.IDB.pas',
  BrickCamp.IService in '..\Server\Interfaces\BrickCamp.IService.pas',
  BrickCamp.ISettings in '..\Server\Interfaces\BrickCamp.ISettings.pas',
  BrickCamp.Repositories.IEmployee in '..\Server\Interfaces\BrickCamp.Repositories.IEmployee.pas',
  BrickCamp.Resources.IEmployee in '..\Server\Interfaces\BrickCamp.Resources.IEmployee.pas',
  BrickCamp.service in '..\Server\BrickCamp.service.pas' {srvBrickCamp: TService},
  BrickCamp.services in '..\Server\BrickCamp.services.pas',
  Brickcamp.Repository.Redis in '..\Repository\Redis\Brickcamp.Repository.Redis.pas',
  TestBrickCamp.Repository.Redis in 'repository\TestBrickCamp.Repository.Redis.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

