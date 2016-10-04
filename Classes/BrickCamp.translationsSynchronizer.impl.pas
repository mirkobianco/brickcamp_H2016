unit BrickCamp.translationsSynchronizer.impl;

interface

uses
  BrickCamp.translationsSynchronizer.interf,
  BrickCamp.settings.interf,
  Spring.Logging,
  Spring.Container,
  Spring.Container.Common, BrickCamp.db.interf;

type
  TCbdTransSynchronizer = class(TInterfacedObject, ITranslationSynchronizer)
  private
    [Inject]
    FSettings: IBrickCampSettings;
    [Inject]
    FDb: IBrickCampDb;

    procedure LoadTranslationFromDB;
  public
    procedure Synchronize;

    function GetSecondsInterval: Cardinal;
  end;

implementation

uses
  BrickCamp.services, Spring.Collections, Spring.Persistence.Criteria.Properties,
  BrickCamp.Repositories.Employee.Intf, BrickCamp.Model.Employee.Inter;

{ TCbdTransSynchronizer }

function TCbdTransSynchronizer.GetSecondsInterval: Cardinal;
begin
  result := 9;
end;

procedure TCbdTransSynchronizer.LoadTranslationFromDB;
var
  Employees: IEmployeeRepository;
  Status: Prop;
  Empl: IEmployee;
begin
  Employees := GlobalContainer.Resolve<IEmployeeRepository>;
  CbLog.Info('Loaded %d', [Employees.GetList.Count]);
  Empl := Employees.GetOne(2);
  CbLog.Info('translation %s', [Empl.GetFirstName + ' ' + Empl.GetLastName]);
end;

procedure TCbdTransSynchronizer.Synchronize;
begin
  CbLog.Info('Synchronization started.');
  CbLog.Text(FSettings.GetDBStringConnection);
  LoadTranslationFromDB;
end;

end.
