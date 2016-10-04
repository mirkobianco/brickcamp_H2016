unit BrickCamp.Repositories.Employee.Impl;

interface

uses
 Spring.Collections,
 Spring.Container.Injection,
 Spring.Container.Common,
 BrickCamp.Model.Employee,
 BrickCamp.db.interf,
 BrickCamp.Model.Employee.Intf,
 BrickCamp.Repositories.Employee.Intf;

type
  TEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  protected
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): TEmployee;
    function GetList: IList<TEmployee>;
    procedure Insert(const Employee: TEmployee);
  end;

implementation

uses
  Spring.Persistence.Criteria, Spring.Persistence.Criteria.Properties, Spring.Reflection,
  BrickCamp.Model.Employee.Impl;

{ TEmployeeRepository }

function TEmployeeRepository.GetList: IList<TEmployee>;
begin
  result := FDb.GetSession.FindAll<TEmployee>;
end;

function TEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := FDb.GetSession.FindOne<TEmployee>(Id);
end;

procedure TEmployeeRepository.Insert(const Employee: TEmployee);
begin

end;

end.
