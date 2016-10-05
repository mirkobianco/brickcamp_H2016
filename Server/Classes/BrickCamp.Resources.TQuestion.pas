unit BrickCamp.Resources.TQuestion;

interface

uses
  System.Classes,
  System.SysUtils,
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
  Question := GlobalContainer.Resolve<TQuestion>;
  with (TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject) do
  begin
    Question.ProductId := StrToIntDef(GetValue('ProductId').Value, -1);
    Question.UserId := StrToIntDef(GetValue('UserId').Value, -1);
    Question.Text := GetValue('Text').Value;
    Question.IsOpen := StrToIntDef(GetValue('IsOpen').Value, -1);
  end;
  GlobalContainer.Resolve<IQuestionRepository>.Insert(Question);
end;

procedure TQuestionResource.Update(const Value: TJSONValue);
var
  Question: TQuestion;
begin
  Question := GlobalContainer.Resolve<TQuestion>;
  with (TJSONObject.ParseJSONValue(Value.ToJSON) as TJSONObject) do
  begin
    Question.ProductId := StrToIntDef(GetValue('ProductId').Value, -1);
    Question.UserId := StrToIntDef(GetValue('UserId').Value, -1);
    Question.Text := GetValue('Text').Value;
    Question.IsOpen := StrToIntDef(GetValue('IsOpen').Value, -1);
  end;
  GlobalContainer.Resolve<IQuestionRepository>.Update(Question);
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
