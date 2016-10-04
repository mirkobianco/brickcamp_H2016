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
  BrickCamp.Repositories.Employee.Mock in '..\Mocks\BrickCamp.Repositories.Employee.Mock.pas',
  TestBrickCamp.Repositories.Employee in 'TestBrickCamp.Repositories.Employee.pas',
  BrickCamp.Resources.Employee in '..\REST\BrickCamp.Resources.Employee.pas',
  BrickCamp.Model.Employee in '..\Models\BrickCamp.Model.Employee.pas',
  BrickCamp.db.Interf in '..\Interfaces\BrickCamp.db.Interf.pas',
  BrickCamp.Repositories.Employee.Intf in '..\Interfaces\BrickCamp.Repositories.Employee.Intf.pas',
  BrickCamp.service.interf in '..\Interfaces\BrickCamp.service.interf.pas',
  BrickCamp.settings.interf in '..\Interfaces\BrickCamp.settings.interf.pas',
  BrickCamp.translationsSynchronizer.interf in '..\Interfaces\BrickCamp.translationsSynchronizer.interf.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

