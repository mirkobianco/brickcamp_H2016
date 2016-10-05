unit BrickCamp.Repositories.TEmployee;

interface

uses
 System.JSON,
 Spring.Container.Injection,
 Spring.Container.Common,
 BrickCamp.IDB,
 BrickCamp.Model.TEmployee,
 BrickCamp.Repositories.IEmployee;

type
  TEmployeeRepository = class(TInterfacedObject, IEmployeeRepository)
  protected
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): TEmployee;
    function GetList: TJSONArray;
    procedure Insert(const Employee: TEmployee);
    procedure Update(const Employee: TEmployee);
    procedure Delete(const Id: Integer);
  end;

implementation

uses
  Spring.Collections,
  MARS.Core.Utils;

{ TEmployeeRepository }

procedure TEmployeeRepository.Delete(const Id: Integer);
var
  Employee: TEmployee;
begin
  Employee := FDb.GetSession.FindOne<TEmployee>(Id);
  if Assigned(Employee) then
    FDb.GetSession.Delete(Employee);
end;

function TEmployeeRepository.GetList: TJSONArray;
var
  LList: IList<TEmployee>;
  LItem: TEmployee;
begin
  LList := FDb.GetSession.FindAll<TEmployee>;
  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TEmployeeRepository.GetOne(const Id: Integer): TEmployee;
begin
  result := FDb.GetSession.FindOne<TEmployee>(Id);
end;

procedure TEmployeeRepository.Insert(const Employee: TEmployee);
begin
  FDb.GetSession.Insert(Employee);
end;

procedure TEmployeeRepository.Update(const Employee: TEmployee);
begin
  FDb.GetSession.Update(Employee);
end;

end.
