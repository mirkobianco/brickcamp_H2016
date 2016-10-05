unit BrickCamp.Repositories.TProduct;

interface

uses
 System.JSON,
 Spring.Container.Injection,
 Spring.Container.Common,
 BrickCamp.IDB,
 BrickCamp.Model.TProduct,
 BrickCamp.Repositories.IProduct;

type
  TProductRepository = class(TInterfacedObject, IProductRepository)
  protected
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): TProduct;
    function GetList: TJSONArray;
    procedure Insert(const Product: TProduct);
    procedure Update(const Product: TProduct);
    procedure Delete(const Id: Integer);
  end;

implementation

uses
  Spring.Collections,
  MARS.Core.Utils;

{ TProductRepository }

procedure TProductRepository.Delete(const Id: Integer);
var
  Product: TProduct;
begin
  Product := FDb.GetSession.FindOne<TProduct>(Id);
  if Assigned(Product) then
    FDb.GetSession.Delete(Product);
end;

function TProductRepository.GetList: TJSONArray;
var
  LList: IList<TProduct>;
  LItem: TProduct;
begin
  LList := FDb.GetSession.FindAll<TProduct>;
  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TProductRepository.GetOne(const Id: Integer): TProduct;
begin
  result := FDb.GetSession.FindOne<TProduct>(Id);
end;

procedure TProductRepository.Insert(const Product: TProduct);
begin
  FDb.GetSession.Insert(Product);
end;

procedure TProductRepository.Update(const Product: TProduct);
begin
  FDb.GetSession.Update(Product);
end;

end.
