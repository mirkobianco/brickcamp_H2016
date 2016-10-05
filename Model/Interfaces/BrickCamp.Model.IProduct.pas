unit BrickCamp.Model.IProduct;

interface

uses
  Spring;

type
  IProduct = interface(IInterface)
  ['{C2DA14B4-A905-4665-85AE-5BE3A25B5C42}']

    function GetId: Integer;
    function GetName: string;
    function GetDescription: string;
    function GetPrice: Extended;
    procedure SetName(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetPrice(const Value: Extended);
  end;

implementation

end.
