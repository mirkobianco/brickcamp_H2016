unit BrickCamp.Repositories.Employee.Impl;

interface

uses
 System.JSON,
 Generics.Collections,
 Spring.Collections,
 Spring.Container.Injection,
 Spring.Container.Common,
 MARS.Core.Utils,
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
    function GetList: TJSONArray;
    procedure Insert(const Employee: TEmployee);
  end;

implementation

uses
	Spring.Persistence.Criteria, Spring.Persistence.Criteria.Properties, Spring.Reflection;

{ TEmployeeRepository }

function TEmployeeRepository.GetList: TJSONArray;
var
  LList: IList<TEmployee>;
  LItem: TEmployee;
begin
  LList := FDb.GetSession.FindAll<TEmployee>;
  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := FDb.GetSession.FindOne<TEmployee>(Id);
end;

procedure TEmployeeRepository.Insert(const Employee: TEmployee);
begin

end;

end.
