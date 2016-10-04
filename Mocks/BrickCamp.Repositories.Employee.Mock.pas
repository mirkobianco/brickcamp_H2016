unit BrickCamp.Repositories.Employee.Mock;

interface

uses
  System.JSON,
  Generics.Collections,
  Spring.Collections,
  Spring.Container,
  BrickCamp.Model.Employee,
  BrickCamp.Repositories.Employee.Intf;

type
  TMockEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  public
    //IEmployeeRepository
    function GetOne(const Id: Integer): TEmployee;
    function GetListAsJsonArray: TJSONArray;
    function GetList: IList<TEmployee>;
    procedure Insert(const Employee: TEmployee);
  end;

implementation

{ TMockEmployeeRepository }

function TMockEmployeeRepository.GetList: IList<TEmployee>;
begin
  Result := nil;
end;

function TMockEmployeeRepository.GetListAsJsonArray: TJSONArray;
begin
  Result := TJSONArray.Create;
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  Result := GlobalContainer.Resolve<TEmployee>([Id]);
  //result.Id := Id;
end;

procedure TMockEmployeeRepository.Insert(const Employee: TEmployee);
begin
  // I do anothing...
end;

end.
