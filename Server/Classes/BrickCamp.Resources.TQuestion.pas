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
    procedure Insert(const [BodyParam] Question: TQuestion);

    [PUT]
    procedure Update(const [BodyParam] Question: TQuestion);

    [DELETE, Path('/delete/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);

    [GET, Path('/getlistbyproduct/{Id}')]
    function GetListByProduct(const ProductId: Integer): TJSONArray;
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

procedure TQuestionResource.Insert(const Question: TQuestion);
begin
  GlobalContainer.Resolve<IQuestionRepository>.Insert(Question);
end;

procedure TQuestionResource.Update(const Question: TQuestion);
begin
  GlobalContainer.Resolve<IQuestionRepository>.Update(Question);
end;

function TQuestionResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IQuestionRepository>.GetList;
end;

function TQuestionResource.GetListByProduct(const ProductId: Integer): TJSONArray;
begin
  Result := GlobalContainer.Resolve<IQuestionRepository>.GetListByProduct(ProductId);
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TQuestionResource>;

end.
