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
    procedure Insert(const [BodyParam] Product: TProduct);

    [PUT]
    procedure Update(const [BodyParam] Product: TProduct);

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

procedure TProductResource.Insert(const Product: TProduct);
begin
  GlobalContainer.Resolve<IProductRepository>.Insert(Product);
end;

procedure TProductResource.Update(const Product: TProduct);
begin
  GlobalContainer.Resolve<IProductRepository>.Update(Product);
end;

function TProductResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IProductRepository>.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TProductResource>;

end.
