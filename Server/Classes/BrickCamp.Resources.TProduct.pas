unit BrickCamp.Resources.TProduct;

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
  BrickCamp.Repositories.IProduct,
  BrickCamp.Resources.IProduct,
  BrickCamp.Model,
  BrickCamp.Model.IProduct,
  BrickCamp.Model.TProduct;

type
  [Path('/product'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TProductResource = class(TInterfacedObject, IProductResurce)
  protected
    function GetProductFromJSON(const Value: TJSONValue): TProduct;
  public
    [GET, Path('/getone/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TProduct;

    [GET, Path('/getlist/')]
    function GetList: TJSONArray;

    [POST]
    procedure Insert(const [BodyParam] Value: TJSONValue);

    [PUT]
    procedure Update(const [BodyParam] Value: TJSONValue);

    [DELETE, Path('/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);
  end;

implementation

{ THelloWorldResource }

function TProductResource.GetOne(const Id: Integer): TProduct;
begin
  Result := GlobalContainer.Resolve<IProductRepository>.GetOne(Id);
end;

function TProductResource.GetProductFromJSON(const Value: TJSONValue): TProduct;
var
  JSONObject: TJSONObject;
begin
  Result := GlobalContainer.Resolve<TProduct>;
  JSONObject := TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject;
  try
    Result.Name := JSONObject.ReadStringValue('Name', '');
    Result.Description := JSONObject.ReadStringValue('Description', '');
    Result.Price := JSONObject.ReadDoubleValue('Price', 0.0);
  finally
    JSONObject.Free;
  end;
end;

procedure TProductResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IProductRepository>.Delete(Id);
end;

procedure TProductResource.Insert(const Value: TJSONValue);
var
  Product: TProduct;
begin
  Product := GetProductFromJSON(Value);
  try
    if Assigned(Product) then
      GlobalContainer.Resolve<IProductRepository>.Insert(Product);
  finally
    Product.Free;
  end;
end;

procedure TProductResource.Update(const Value: TJSONValue);
var
  Product: TProduct;
begin
  Product := GetProductFromJSON(Value);
  try
    if Assigned(Product) then
      GlobalContainer.Resolve<IProductRepository>.Update(Product);
  finally
    Product.Free;
  end;
end;

function TProductResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IProductRepository>.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TProductResource>;

end.
