unit BrickCamp.Repositories.Employee.Mock;

interface

uses
  Spring.Collections,
  Spring.Container,
  BrickCamp.Model.Employee,
  BrickCamp.Repositories.Employee.Intf;

implementation

type
  TMockEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  public
    //IEmployeeRepository
    function GetOne(const Id: Integer): TEmployee;
    function GetList: IList<TEmployee>;
  end;

{ TMockEmployeeRepository }

function TMockEmployeeRepository.GetList: IList<TEmployee>;
begin
  result := nil;
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := nil;
end;

end.
