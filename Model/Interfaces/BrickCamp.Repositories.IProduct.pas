unit BrickCamp.Repositories.IProduct;

interface

uses
  System.JSON,
  BrickCamp.Model.TProduct;

type
  IProductRepository = interface(IInterface)
    ['{1E6661EB-80D8-4A04-A16C-E8EBE3E34660}']
    function GetOne(const Id: Integer): TProduct;
    function GetList: TJSONArray;
    procedure Insert(const Product: TProduct);
    procedure Update(const Product: TProduct);
    procedure Delete(const Id: Integer);
  end;

implementation

end.
