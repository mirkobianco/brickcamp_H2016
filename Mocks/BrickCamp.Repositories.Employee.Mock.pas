unit BrickCamp.Repositories.Employee.Mock;

interface

uses
  Spring.Collections,
  Spring.Container,
  BrickCamp.Model.Employee,
  BrickCamp.Repositories.Employee.Intf;

type
  TMockEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  public
    //IEmployeeRepository
    function GetOne(const Id: Integer): TEmployee;
    function GetList: IList<TEmployee>;
  end;

implementation

{ TMockEmployeeRepository }

function TMockEmployeeRepository.GetList: IList<TEmployee>;
begin
  result := Spring.Collections.TCollections.CreateList();
  Result.Add(TEmployee.Create);
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := TEmployee.Create;
  //result.Id := Id;
end;

end.
