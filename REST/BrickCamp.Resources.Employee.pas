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
    function GetOne(const [PathParam] Id: Integer): TEmployee;

    [GET, Path('/GetList')]
    function GetList: IList<TEmployee>;
  end;

implementation

uses
  StrUtils
  ;

{ THelloWorldResource }

function TEmployeeResource.GetOne(const Id: Integer): TEmployee;
begin
  Result := FRepository.GetOne(Id);
end;

function TEmployeeResource.GetList: IList<TEmployee>;
begin
  result := FRepository.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TEmployeeResource>;

end.
