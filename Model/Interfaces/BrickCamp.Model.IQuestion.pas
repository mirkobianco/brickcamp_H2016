unit BrickCamp.Model.IQuestion;

interface

uses
  Spring;

type
  IQuestion = interface(IInterface)
  ['{5ECFEDBD-3635-4CFE-ABBA-F6AF16ECD1A7}']
    function GetId: Integer;
    function GetProductId: Integer;
    function GetUserId: Integer;
    function GetText: string;
    function GetIsOpen: SmallInt;
    procedure SetProductId(const Value: Integer);
    procedure SetUserId(const Value: Integer);
    procedure SetText(const Value: string);
    procedure SetIsOpen(const Value: SmallInt);
  end;

implementation

end.
