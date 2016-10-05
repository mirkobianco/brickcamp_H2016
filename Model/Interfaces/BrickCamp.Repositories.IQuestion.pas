unit BrickCamp.Repositories.IQuestion;

interface

uses
  System.JSON,
  BrickCamp.Model.TQuestion;

type
  IQuestionRepository = interface(IInterface)
    ['{7F4F7450-E7AF-4CD5-9B69-1FA0A99E09E9}']
    function GetOne(const Id: Integer): TQuestion;
    function GetList: TJSONArray;
    procedure Insert(const Question: TQuestion);
    procedure Update(const Question: TQuestion);
    procedure Delete(const Id: Integer);
    function GetListByProductId(const ProductId: Integer): TJSONArray;
  end;

implementation

end.
