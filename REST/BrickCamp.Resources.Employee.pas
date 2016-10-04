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
  , Spring.Container.Common
  , Spring.Collections
  , BrickCamp.Repositories.Employee.Intf
  , BrickCamp.Model.Employee.Intf
  , BrickCamp.Model.Employee
  , Spring.Container
  ;

type
  IEmployeeResurce = interface
    ['{03D2547E-8DA6-443F-AFB8-750A59A334E8}']
  end;

  [Path('/employee'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TEmployeeResource = class(TInterfacedObject, IEmployeeResurce)
  protected var
    [Inject]
    FRepository: IEmployeeRepository;
  protected
  public
    [GET, Path('/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TEmployee;

    [GET, Path('/getlist')]
    function GetList: IList<TEmployee>;
  end;

implementation

uses
  StrUtils
  ;

{ THelloWorldResource }

function TEmployeeResource.GetOne(const Id: Integer): TEmployee;
var
  Rep: IEmployeeRepository;
begin
  Rep := GlobalContainer.Resolve<IEmployeeRepository>;
  Result := Rep.GetOne(Id); //FRepository.GetOne(Id);
end;

function TEmployeeResource.GetList: IList<TEmployee>;
begin
  result := FRepository.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TEmployeeResource>;

end.
