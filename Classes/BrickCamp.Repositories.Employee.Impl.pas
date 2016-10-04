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
    function GetListAsJsonArray: TJSONArray;
    function GetList: IList<TEmployee>;

    procedure Insert(const Employee: TEmployee);
  end;

implementation

uses
	Spring.Persistence.Criteria, Spring.Persistence.Criteria.Properties, Spring.Reflection;

{ TEmployeeRepository }
function TEmployeeRepository.GetList: IList<TEmployee>;
begin
  Result := FDb.GetSession.FindAll<TEmployee>;
end;

function TEmployeeRepository.GetListAsJsonArray: TJSONArray;
var
  List: IList<TEmployee>;
  Item: TObject;
begin
  List := GetList;
  Result := TJSONArray.Create;
  for Item in List do
    Result.Add(ObjectToJson(Item));
end;

function TEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := FDb.GetSession.FindOne<TEmployee>(Id);
end;

procedure TEmployeeRepository.Insert(const Employee: TEmployee);
begin

end;

end.
