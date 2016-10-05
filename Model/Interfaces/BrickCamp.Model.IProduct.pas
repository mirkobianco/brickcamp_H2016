unit BrickCamp.Model.IProduct;

interface

uses
  Spring;

type
  IProduct = interface(IInterface)
  ['{CA35B767-9C87-4539-AFEF-36A371684A30}']

    function GetId: Integer;
    function GetName: string;
    function GetDescription: string;
    function GetPrice: Nullable<Extended>;
    procedure SetName(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetPrice(const Value: Nullable<Extended>);
  end;

implementation

end.
