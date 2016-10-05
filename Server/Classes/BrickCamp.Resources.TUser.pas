unit BrickCamp.Resources.TUser;

interface

uses
  System.JSON,
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
  BrickCamp.Repositories.IUser,
  BrickCamp.Resources.IUser,
  BrickCamp.Model.IUser,
  BrickCamp.Model.TUser;

type
  [Path('/user'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TUserResource = class(TInterfacedObject, IUserResurce)
  public
    [GET, Path('/getone/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TUser;

    [GET, Path('/getonebyname/{Name}')]
    function GetOneByName(const [PathParam] Name: string): TUser;

    [GET, Path('/getlist/')]
    function GetList: TJSONArray;

    [POST]
    procedure Insert(const [BodyParam] Value: TJSONValue {TUser});

    [PUT]
    procedure Update(const [BodyParam] Value: TJSONValue);

    [DELETE, Path('/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);
  end;

implementation

{ THelloWorldResource }

function TUserResource.GetOne(const Id: Integer): TUser;
begin
  Result := GlobalContainer.Resolve<IUserRepository>.GetOne(Id);
end;

function TUserResource.GetOneByName(const Name: string): TUser;
begin
  Result := GlobalContainer.Resolve<IUserRepository>.GetOneByName(Name);
end;

procedure TUserResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IUserRepository>.Delete(Id);
end;

procedure TUserResource.Insert(const Value: TJSONValue);
var
  User: TUser;
begin
  User := GlobalContainer.Resolve<TUser>;
  with (TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject) do
    User.Name := GetValue('Name').Value;
  GlobalContainer.Resolve<IUserRepository>.Insert(User);
end;

procedure TUserResource.Update(const Value: TJSONValue);
var
  User: TUser;
begin
  User := GlobalContainer.Resolve<TUser>;
  with (TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject) do
    User.Name := GetValue('Name').Value;
  GlobalContainer.Resolve<IUserRepository>.Update(User);
end;

function TUserResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IUserRepository>.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TUserResource>;

end.
