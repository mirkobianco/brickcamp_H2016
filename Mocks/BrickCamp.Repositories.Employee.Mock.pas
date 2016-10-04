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
    procedure Insert(const Employee: TEmployee);
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

procedure TMockEmployeeRepository.Insert(const Employee: TEmployee);
begin
  // I do anothing...
end;

end.
