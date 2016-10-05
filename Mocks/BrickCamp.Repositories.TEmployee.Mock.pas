unit BrickCamp.Repositories.TEmployee.Mock;

interface

uses
  System.JSON,
  Spring.Container,
  BrickCamp.Model.TEmployee,
  BrickCamp.Repositories.IEmployee;

type
  TMockEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  public
    //IEmployeeRepository
    function GetOne(const Id: Integer): TEmployee;
    function GetList: TJSONArray;
    procedure Insert(const Employee: TEmployee);
    procedure Update(const Employee: TEmployee);
    procedure Delete(const Id: Integer);
  end;

implementation

{ TMockEmployeeRepository }

procedure TMockEmployeeRepository.Delete(const Id: Integer);
begin
  //
end;

function TMockEmployeeRepository.GetList: TJSONArray;
begin
  result := TJSONArray.Create;
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := GlobalContainer.Resolve<TEmployee>([Id]);
  //result.Id := Id;
end;

procedure TMockEmployeeRepository.Insert(const Employee: TEmployee);
begin
  //
end;

procedure TMockEmployeeRepository.Update(const Employee: TEmployee);
begin
  //
end;

end.
