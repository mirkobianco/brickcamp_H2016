unit BrickCamp.Repositories.IUser;

interface

uses
  System.JSON,
  BrickCamp.Model.TUser;

type
  IUserRepository = interface(IInterface)
    ['{9477B244-BFF7-4FBB-86EA-AC6ADAB82833}']
    function GetOne(const Id: Integer): TUser;
    function GetOneByName(const Name: string): TUser;
    function GetList: TJSONArray;
    procedure Insert(const User: TUser);
    procedure Update(const User: TUser);
    procedure Delete(const Id: Integer);
  end;

implementation

end.
