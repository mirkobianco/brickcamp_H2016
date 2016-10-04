unit BrickCamp.Resources.Employee;

interface

uses
  Classes, SysUtils

  , MARS.Core.Registry
  , MARS.Core.Attributes
  , MARS.Core.MediaType
  , MARS.Core.JSON
  , MARS.Core.MessageBodyWriters
  , MARS.Core.MessageBodyReaders
  , Spring
  , Spring.Collections
  , BrickCamp.Repositories.Employee.Intf
  , BrickCamp.Model.Employee
  ;

type
  [Path('/Employee'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TEmployeeResource = class
  private
    [Inject]
    FRepository: IEmployeeRepository;
  protected
  public
    [GET, Path('/{Id}')]
    function GetOne(const [PathParam] Id: Integer): IEmployee;

    [GET, Path('/GetList')]
    function GetList: IList<IEmployee>;
  end;

implementation

uses
  StrUtils
  ;

{ THelloWorldResource }

function TEmployeeResource.GetOne(const Id: Integer): IEmployee;
begin
  Result := FRepository.GetOne(Id);
end;

function TEmployeeResource.GetList: IList<IEmployee>;
begin
  result := FRepository.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TEmployeeResource>;

end.
