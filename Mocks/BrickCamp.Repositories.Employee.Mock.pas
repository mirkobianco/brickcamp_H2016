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
    function GetOne(const Id: Integer): TEmployee;
    function GetList: IList<TEmployee>;
  end;

implementation

{ TMockEmployeeRepository }

function TMockEmployeeRepository.GetList: IList<TEmployee>;
begin
  result := Spring.Collections.TCollections.CreateList<TEmployee>();
  Result.Add(GetOne(-1));
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := GlobalContainer.Resolve<TEmployee>([Id]);
  //result.Id := Id;
end;

end.
