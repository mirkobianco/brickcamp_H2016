unit BrickCamp.Repositories.Employee.Mock;

interface

uses
  Spring.Collections,
  Spring.Container,
  BrickCamp.Model.Employee,
  BrickCamp.Repositories.Employee.Intf;

uses
	BrickCamp.Model.Employee.Inter;

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
  result := Spring.Collections.TCollections.CreateList<IEmployee>();
  Result.Add(GetOne(-1));
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): IEmployee;
begin
  result := GlobalContainer.Resolve<IEmployee>([Id]);
  //result.Id := Id;
end;

end.
