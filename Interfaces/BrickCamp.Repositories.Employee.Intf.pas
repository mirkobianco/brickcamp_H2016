unit BrickCamp.Repositories.Employee.Intf;

interface

uses
  System.JSON,
  Generics.Collections,
  BrickCamp.Model.Employee, Spring.Collections;

type
  IEmployeeRepository = interface(IInterface)
    ['{1E6661EB-80D8-4A04-A16C-E8EBE3E34660}']
    function GetOne(const Id: Integer): TEmployee;
    function GetListAsJsonArray: TJSONArray;
    function GetList: IList<TEmployee>;
    procedure Insert(const Employee: TEmployee);
  end;

implementation

end.
