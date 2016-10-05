unit BrickCamp.Repositories.IEmployee;

interface

uses
  System.JSON,
  BrickCamp.Model.TEmployee;

type
  IEmployeeRepository = interface(IInterface)
    ['{1E6661EB-80D8-4A04-A16C-E8EBE3E34660}']
    function GetOne(const Id: Integer): TEmployee;
    function GetList: TJSONArray;
    procedure Insert(const Employee: TEmployee);
    procedure Update(const Employee: TEmployee);
    procedure Delete(const Id: Integer);
  end;

implementation

end.
