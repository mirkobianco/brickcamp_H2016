unit BrickCamp.Repositories.Employee.Intf;

interface

uses
  Spring.Collections,
  BrickCamp.Model.Employee.Inter;

type
  IEmployeeRepository = interface(IInterface)
    ['{1E6661EB-80D8-4A04-A16C-E8EBE3E34660}']
    function GetOne(const Id: Integer): TEmployee;
    function GetList: IList<TEmployee>;
    procedure Insert(const Employee: TEmployee);
  end;

implementation

end.
