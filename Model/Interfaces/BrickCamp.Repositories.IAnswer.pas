unit BrickCamp.Repositories.IAnswer;

interface

uses
  System.JSON,
  BrickCamp.Model.TAnswer;

type
  IAnswerRepository = interface(IInterface)
    ['{A8CEDDFF-9337-4317-9864-D6FE771937B4}']
    function GetOne(const Id: Integer): TAnswer;
    function GetList: TJSONArray;
    procedure Insert(const Answer: TAnswer);
    procedure Update(const Answer: TAnswer);
    procedure Delete(const Id: Integer);
  end;

implementation

end.
