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

procedure TProductResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IProductRepository>.Delete(Id);
end;

procedure TProductResource.Insert(const Value: TJSONValue);
var
  Product: TProduct;
begin
  Product := GlobalContainer.Resolve<TProduct>;
  with (TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject) do
  begin
    Product.Name := GetValue('Name').Value;
    Product.Description := GetValue('Description').Value;
    Product.Price := StrToFloatDef(GetValue('Price').Value, 0.0);
  end;
  GlobalContainer.Resolve<IProductRepository>.Insert(Product);
end;

procedure TProductResource.Update(const Value: TJSONValue);
var
  Product: TProduct;
begin
  Product := GlobalContainer.Resolve<TProduct>;
  with (TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject) do
  begin
    Product.Name := GetValue('Name').Value;
    Product.Description := GetValue('Description').Value;
    Product.Price := StrToFloatDef(GetValue('Price').Value, 0.0);
  end;
  GlobalContainer.Resolve<IProductRepository>.Update(Product);
end;

function TProductResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IProductRepository>.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TProductResource>;

end.
