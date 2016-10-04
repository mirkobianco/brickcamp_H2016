unit BrickCamp.Repositories.Employee.Impl;

interface

uses
  Spring.Collections,
  BrickCamp.db.interf, Spring.Container.Injection, Spring.Container.Common, BrickCamp.Repositories.Employee.Intf,
  BrickCamp.Model.Employee.Inter;

type
  TRepEmployee = class(TInterfacedObject, IEmployeeRepository)
  private
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): IEmployee;
    function GetList: IList<IEmployee>;
  end;

implementation

uses
  Spring.Persistence.Criteria, Spring.Persistence.Criteria.Properties, Spring.Reflection,
  BrickCamp.Model.Employee.Impl;

{ TCdbRepEmployee }

function TRepEmployee.GetList: IList<IEmployee>;
begin
  Result := FDb.GetSession.FindAll<TEmployee> as IList<IEmployee>;
end;

function TRepEmployee.GetOne(const Id: Integer): IEmployee;
begin
  Result := FDb.GetSession.FindOne<TEmployee>(Id);
end;

end.
