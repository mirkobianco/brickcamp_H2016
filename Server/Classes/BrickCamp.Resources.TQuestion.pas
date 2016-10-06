unit BrickCamp.Resources.TQuestion;

interface

uses
  System.Classes,
  System.SysUtils,
  system.JSON,
  Spring.Container.Common,
  Spring.Container,
  MARS.Core.Registry,
  MARS.Core.Attributes,
  MARS.Core.MediaType,
  MARS.Core.JSON,
  MARS.Core.MessageBodyWriters,
  MARS.Core.MessageBodyReaders,
  BrickCamp.Repositories.IQuestion,
  BrickCamp.Resources.IQuestion,
  BrickCamp.Model.IQuestion,
  BrickCamp.Model.TQuestion;

type
  [Path('/question'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TQuestionResource = class(TInterfacedObject, IQuestionResurce)
  protected
    function GetQuestionFromJSON(const Value: TJSONValue): TQuestion;
  public
    [GET, Path('/getone/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TQuestion;

    [GET, Path('/getlist/')]
    function GetList: TJSONArray;

    [POST]
    procedure Insert(const [BodyParam] Value: TJSONValue);

    [PUT]
    procedure Update(const [BodyParam] Value: TJSONValue);

    [DELETE, Path('/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);

    [GET, Path('/getlistbyproductid/{ProductId}')]
    function GetListByProductId(const [PathParam] ProductId: Integer): TJSONArray;
  end;

implementation

{ THelloWorldResource }

function TQuestionResource.GetQuestionFromJSON(const Value: TJSONValue): TQuestion;
var
  JSONObject: TJSONObject;
begin
  Result := GlobalContainer.Resolve<TQuestion>;
  JSONObject := TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject;
  try
    Result.ProductId := JSONObject.ReadIntegerValue('PRODUCTID', -1);
    Result.UserId := JSONObject.ReadIntegerValue('USERID', -1);
    Result.Text := JSONObject.ReadStringValue('TEXT', '');
    Result.IsOpen := JSONObject.ReadIntegerValue('ISOPEN', -1);
  finally
    JSONObject.Free;
  end;
end;

function TQuestionResource.GetOne(const Id: Integer): TQuestion;
begin
  Result := GlobalContainer.Resolve<IQuestionRepository>.GetOne(Id);
end;

procedure TQuestionResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IQuestionRepository>.Delete(Id);
end;

procedure TQuestionResource.Insert(const Value: TJSONValue);
var
  Question: TQuestion;
begin
  Question := GetQuestionFromJSON(Value);
  try
    if Assigned(Question) then
      GlobalContainer.Resolve<IQuestionRepository>.Insert(Question);
  finally
    Question.Free;
  end;
end;

procedure TQuestionResource.Update(const Value: TJSONValue);
var
  Question: TQuestion;
begin
  Question := GetQuestionFromJSON(Value);
  try
    if Assigned(Question) then
      GlobalContainer.Resolve<IQuestionRepository>.Update(Question);
  finally
    Question.Free;
  end;
end;

function TQuestionResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IQuestionRepository>.GetList;
end;

function TQuestionResource.GetListByProductId(const ProductId: Integer): TJSONArray;
begin
  Result := GlobalContainer.Resolve<IQuestionRepository>.GetListByProductId(ProductId);
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TQuestionResource>;

end.
