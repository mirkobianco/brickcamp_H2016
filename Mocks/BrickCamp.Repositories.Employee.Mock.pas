unit BrickCamp.Repositories.Employee.Mock;

interface

uses
  Spring.Collections,
  Spring.Container,
  BrickCamp.Repositories.Employee.Intf;

implementation

type
  TMockEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  public
    //IEmployeeRepository
    function GetOne(const Id: Integer): IEmployee;
    function GetList: IList<IEmployee>;
  end;

{ TMockEmployeeRepository }

function TMockEmployeeRepository.GetList: IList<IEmployee>;
begin
  result := nil;
end;

function TMockEmployeeRepository.GetOne(const Id: Integer): IEmployee;
begin
  result := nil;
end;

end.
