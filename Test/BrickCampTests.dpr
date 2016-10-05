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
  BrickCamp.IDB in '..\Server\Interfaces\BrickCamp.IDB.pas',
  BrickCamp.Repositories.IEmployee in '..\Server\Interfaces\BrickCamp.Repositories.IEmployee.pas',
  BrickCamp.IService in '..\Server\Interfaces\BrickCamp.IService.pas',
  BrickCamp.ISettings in '..\Server\Interfaces\BrickCamp.ISettings.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

