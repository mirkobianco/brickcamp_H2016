unit BrickCamp.Repositories.Employee.Mock;

interface

uses
  Spring.Collections,
  Spring.Container,
  BrickCamp.Repositories.Employee.Intf;

type
  TMockEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  public
    //IEmployeeRepository
    function GetOne(const Id: Integer): IEmployee;
    function GetList: IList<IEmployee>;
  end;

implementation

{ TMockEmployeeRepository }

function TMockEmployeeRepository.GetList: IList<IEmployee>;
begin
  result := Spring.Collections.TCollections.CreateList();
  Result.Add(TEmployee.Create);
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): IEmployee;
begin
  result := TEmployee.Create;
  //result.Id := Id;
end;

end.
