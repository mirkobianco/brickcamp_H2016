unit BrickCamp.Resources.TEmployee;

interface

uses
  System.Classes,
  System.SysUtils,
  Spring.Container.Common,
  Spring.Container,
  MARS.Core.Registry,
  MARS.Core.Attributes,
  MARS.Core.MediaType,
  MARS.Core.JSON,
  MARS.Core.MessageBodyWriters,
  MARS.Core.MessageBodyReaders,
  BrickCamp.Repositories.IEmployee,
  BrickCamp.Resources.IEmployee,
  BrickCamp.Model.IEmployee,
  BrickCamp.Model.TEmployee;

type
  [Path('/employee'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TEmployeeResource = class(TInterfacedObject, IEmployeeResurce)
  public
    [GET, Path('/getone/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TEmployee;

    [GET, Path('/getlist/')]
    function GetList: TJSONArray;

    [POST]
    procedure Insert(const [BodyParam] Employee: TEmployee);

    [PUT]
    procedure Update(const [BodyParam] Employee: TEmployee);

    [DELETE, Path('/delete/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);
  end;

implementation

{ THelloWorldResource }

function TEmployeeResource.GetOne(const Id: Integer): TEmployee;
begin
  Result := GlobalContainer.Resolve<IEmployeeRepository>.GetOne(Id);
end;

procedure TEmployeeResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IEmployeeRepository>.Delete(Id);
end;

procedure TEmployeeResource.Insert(const Employee: TEmployee);
begin
  GlobalContainer.Resolve<IEmployeeRepository>.Insert(Employee);
end;

procedure TEmployeeResource.Update(const Employee: TEmployee);
begin
  GlobalContainer.Resolve<IEmployeeRepository>.Update(Employee);
end;

function TEmployeeResource.GetList: TJSONArray;
begin
  Result := GlobalContainer.Resolve<IEmployeeRepository>.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TEmployeeResource>;

end.
