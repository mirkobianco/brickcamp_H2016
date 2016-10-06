unit BrickCamp.Resources.TAnswer;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  Spring.Container.Common,
  Spring.Container,
  MARS.Core.Registry,
  MARS.Core.Attributes,
  MARS.Core.MediaType,
  MARS.Core.JSON,
  MARS.Core.MessageBodyWriters,
  MARS.Core.MessageBodyReaders,
  BrickCamp.Repositories.IAnswer,
  BrickCamp.Resources.IAnswer,
  BrickCamp.Model,
  BrickCamp.Model.IAnswer,
  BrickCamp.Model.TAnswer;

type
  [Path('/answer'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TAnswerResource = class(TInterfacedObject, IAnswerResurce)
  protected
    function GetAnswerFromJSON(const Value: TJSONValue): TAnswer;
  public
    [GET, Path('/getone/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TAnswer;

    [GET, Path('/getlist/')]
    function GetList: TJSONArray;

    [POST]
    procedure Insert(const [BodyParam] Value: TJSONValue);

    [PUT]
    procedure Update(const [BodyParam] Value: TJSONValue);

    [DELETE, Path('/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);

    [GET, Path('/getlistbyquestionid/QuestionId')]
    function GetListByQuestionId(const [PathParam] QuestionId: Integer): TJSONArray;
  end;

implementation

{ THelloWorldResource }

function TAnswerResource.GetAnswerFromJSON(const Value: TJSONValue): TAnswer;
var
  JSONObject: TJSONObject;
begin
  Result := GlobalContainer.Resolve<TAnswer>;
  JSONObject := TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject;
  try
    Result.QuestionId := JSONObject.ReadIntegerValue('QuestionId', -1);
    Result.UserId := JSONObject.ReadIntegerValue('UserId', -1);
    Result.Text := JSONObject.ReadStringValue('Text', '');
    Result.RankIndex := JSONObject.ReadIntegerValue('RankIndex', -1);
  finally
    JSONObject.Free;
  end;
end;

function TAnswerResource.GetOne(const Id: Integer): TAnswer;
begin
  Result := GlobalContainer.Resolve<IAnswerRepository>.GetOne(Id);
end;

procedure TAnswerResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IAnswerRepository>.Delete(Id);
end;

procedure TAnswerResource.Insert(const Value: TJSONValue);
var
  Answer: TAnswer;
begin
  Answer := GetAnswerFromJSON(Value);
  try
    if Assigned(Answer) then
      GlobalContainer.Resolve<IAnswerRepository>.Insert(Answer);
  finally
    Answer.Free;
  end;
end;

procedure TAnswerResource.Update(const Value: TJSONValue);
var
  Answer: TAnswer;
begin
  Answer := GetAnswerFromJSON(Value);
  try
    if Assigned(Answer) then
      GlobalContainer.Resolve<IAnswerRepository>.Update(Answer);
  finally
    Answer.Free;
  end;
end;

function TAnswerResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IAnswerRepository>.GetList;
end;

function TAnswerResource.GetListByQuestionId(const QuestionId: Integer): TJSONArray;
begin
  Result := GlobalContainer.Resolve<IAnswerRepository>.GetListByQuestionId(QuestionId);
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TAnswerResource>;

end.
