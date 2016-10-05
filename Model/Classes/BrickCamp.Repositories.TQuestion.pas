unit BrickCamp.Repositories.TQuestion;

interface

uses
 System.JSON,
 Spring.Container.Injection,
 Spring.Container.Common,
 BrickCamp.IDB,
 BrickCamp.Model.TQuestion,
 BrickCamp.Repositories.IQuestion;

type
  TQuestionRepository = class(TInterfacedObject, IQuestionRepository)
  protected
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): TQuestion;
    function GetList: TJSONArray;
    procedure Insert(const Question: TQuestion);
    procedure Update(const Question: TQuestion);
    procedure Delete(const Id: Integer);
    function GetListByProduct(const ProductId: Integer): TJSONArray;
  end;

implementation

uses
  Spring.Collections,
  Spring.Persistence.Criteria.Interfaces,
  Spring.Persistence.Criteria.Properties,
  MARS.Core.Utils;

{ TQuestionRepository }

procedure TQuestionRepository.Delete(const Id: Integer);
var
  Question: TQuestion;
begin
  Question := FDb.GetSession.FindOne<TQuestion>(Id);
  if Assigned(Question) then
    FDb.GetSession.Delete(Question);
end;

function TQuestionRepository.GetList: TJSONArray;
var
  LList: IList<TQuestion>;
  LItem: TQuestion;
begin
  LList := FDb.GetSession.FindAll<TQuestion>;
  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TQuestionRepository.GetListByProduct(const ProductId: Integer): TJSONArray;
var
  ProductIdCriteria: Prop;
  LList: IList<TQuestion>;
  LItem: TQuestion;
begin
  ProductIdCriteria := Prop.Create('NAME');
  LList := FDb.GetSession.FindWhere<TQuestion>(ProductIdCriteria = ProductId);

  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TQuestionRepository.GetOne(const Id: Integer): TQuestion;
begin
  result := FDb.GetSession.FindOne<TQuestion>(Id);
end;

procedure TQuestionRepository.Insert(const Question: TQuestion);
begin
  FDb.GetSession.Insert(Question);
end;

procedure TQuestionRepository.Update(const Question: TQuestion);
begin
  FDb.GetSession.Update(Question);
end;

end.
