unit BrickCamp.Repositories.TAnswer;

interface

uses
 System.JSON,
 Spring.Container.Injection,
 Spring.Container.Common,
 BrickCamp.IDB,
 BrickCamp.Model.TAnswer,
 BrickCamp.Repositories.IAnswer;

type
  TAnswerRepository = class(TInterfacedObject, IAnswerRepository)
  protected
    [Inject]
    FDb: IBrickCampDb;
  public
    function GetOne(const Id: Integer): TAnswer;
    function GetList: TJSONArray;
    procedure Insert(const Answer: TAnswer);
    procedure Update(const Answer: TAnswer);
    procedure Delete(const Id: Integer);
  end;

implementation

uses
  Spring.Collections,
  MARS.Core.Utils;

{ TAnswerRepository }

procedure TAnswerRepository.Delete(const Id: Integer);
var
  Answer: TAnswer;
begin
  Answer := FDb.GetSession.FindOne<TAnswer>(Id);
  if Assigned(Answer) then
    FDb.GetSession.Delete(Answer);
end;

function TAnswerRepository.GetList: TJSONArray;
var
  LList: IList<TAnswer>;
  LItem: TAnswer;
begin
  LList := FDb.GetSession.FindAll<TAnswer>;
  result := TJSONArray.Create;
  for LItem in LList do
    Result.Add(ObjectToJson(LItem));
end;

function TAnswerRepository.GetOne(const Id: Integer): TAnswer;
begin
  result := FDb.GetSession.FindOne<TAnswer>(Id);
end;

procedure TAnswerRepository.Insert(const Answer: TAnswer);
begin
  FDb.GetSession.Insert(Answer);
end;

procedure TAnswerRepository.Update(const Answer: TAnswer);
begin
  FDb.GetSession.Update(Answer);
end;

end.
