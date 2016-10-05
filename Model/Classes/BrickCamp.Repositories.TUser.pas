unit BrickCamp.Repositories.TUser;

interface

uses
 System.JSON,
 Spring.Container,
 Spring.Container.Injection,
 Spring.Container.Common,
 BrickCamp.IDB,
 BrickCamp.Model.TUser,
 BrickCamp.Repositories.IUser;

type
  TUserRepository = class(TInterfacedObject, IUserRepository)
  protected
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): TUser;
    function GetOneByName(const Name: string): TUser;
    function GetList: TJSONArray;
    procedure Insert(const User: TUser);
    procedure Update(const User: TUser);
    procedure Delete(const Id: Integer);
  end;

implementation

uses
  Spring.Collections,
  Spring.Persistence.Criteria.Interfaces,
  Spring.Persistence.Criteria.Properties,
  MARS.Core.Utils;

{ TUserRepository }

procedure TUserRepository.Delete(const Id: Integer);
var
  User: TUser;
begin
  User := FDb.GetSession.FindOne<TUser>(Id);
  if Assigned(User) then
    FDb.GetSession.Delete(User);
end;

function TUserRepository.GetList: TJSONArray;
var
  LList: IList<TUser>;
  LItem: TUser;
begin
  LList := FDb.GetSession.FindAll<TUser>;
  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TUserRepository.GetOne(const Id: Integer): TUser;
begin
  result := FDb.GetSession.FindOne<TUser>(Id);
end;

function TUserRepository.GetOneByName(const Name: string): TUser;
var
  NameCriteria: Prop;
  List: IList<TUser>;
begin
  NameCriteria := Prop.Create('NAME');
  List := FDb.GetSession.FindWhere<TUser>(NameCriteria = Name);
  if List.Count>=1 then
    Result := List.First
  else
  begin
    Result := GlobalContainer.Resolve<TUser>;
    Result.Name := Name;
    FDb.GetSession.Insert(Result);
  end;

end;

procedure TUserRepository.Insert(const User: TUser);
begin
  FDb.GetSession.Insert(User);
end;

procedure TUserRepository.Update(const User: TUser);
begin
  FDb.GetSession.Update(User);
end;

end.
