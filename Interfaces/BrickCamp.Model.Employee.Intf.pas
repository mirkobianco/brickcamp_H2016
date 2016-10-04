unit BrickCamp.Model.Employee.Intf;

interface

uses
  Spring;

type
  IToObject = interface(IInterface)
  ['{1C1E682F-CB60-40C6-A668-805D479EE079}']
    function ToObject: TObject;
  end;

  IEmployee = interface(IToObject)
  ['{E31612DC-EB02-4576-B119-575696111EF6}']

    //IToObject
    function ToObject: TObject;

    function GetDepartmentNumber: string;
    function GetFirstName: string;
    function GetHireDate: TDateTime;
    function GetId: Integer;
    function GetJobCode: string;
    function GetJobCountry: string;
    function GetJobGrade: SmallInt;
    function GetLastName: string;
    function GetPhoneExt: Nullable<string>;
    function GetSalary: Extended;
    procedure SetDepartmentNumber(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetHireDate(const Value: TDateTime);
    procedure SetJobCode(const Value: string);
    procedure SetJobCountry(const Value: string);
    procedure SetJobGrade(const Value: SmallInt);
    procedure SetLastName(const Value: string);
    procedure SetPhoneExt(const Value: Nullable<string>);
    procedure SetSalary(const Value: Extended);
  end;



implementation

end.