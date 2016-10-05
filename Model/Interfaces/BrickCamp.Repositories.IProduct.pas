unit BrickCamp.Repositories.IProduct;

interface

uses
  System.JSON,
  BrickCamp.Model.TProduct;

type
  IProductRepository = interface(IInterface)
    ['{0AE577BE-875B-4C1D-B4D7-717F20B73480}']
    function GetOne(const Id: Integer): TProduct;
    function GetList: TJSONArray;
    procedure Insert(const Product: TProduct);
    procedure Update(const Product: TProduct);
    procedure Delete(const Id: Integer);
  end;

implementation

end.
