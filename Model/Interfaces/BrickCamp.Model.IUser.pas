unit BrickCamp.Model.IUser;

interface

uses
  Spring;

type
  IUser = interface(IInterface)
  ['{B69AAA6A-253E-47C5-A516-BCEE2DA825A9}']
    function GetId: Integer;
    function GetName: string;
    procedure SetName(const Value: string);
  end;

implementation

end.
