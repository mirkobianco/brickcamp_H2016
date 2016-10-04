unit BrickCamp.Repositories.Employee.Intf;

interface

uses
  Spring.Collections, Spring, BrickCamp.Model.Employee.Inter;

type
  IEmployeeRepository = interface(IInterface)
    ['{1E6661EB-80D8-4A04-A16C-E8EBE3E34660}']
    function GetOne(const Id: Integer): IEmployee;
    function GetList: IList<IEmployee>;
  end;

implementation

end.
