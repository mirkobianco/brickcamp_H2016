unit BrickCamp.Resources.TAnswer;

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
  BrickCamp.Repositories.IAnswer,
  BrickCamp.Resources.IAnswer,
  BrickCamp.Model.IAnswer,
  BrickCamp.Model.TAnswer;

type
  [Path('/answer'), Produces(TMediaType.APPLICATION_JSON_UTF8)]
  TAnswerResource = class(TInterfacedObject, IAnswerResurce)
  public
    [GET, Path('/getone/{Id}')]
    function GetOne(const [PathParam] Id: Integer): TAnswer;

    [GET, Path('/getlist/')]
    function GetList: TJSONArray;

    [POST]
    procedure Insert(const [BodyParam] Answer: TAnswer);

    [PUT]
    procedure Update(const [BodyParam] Answer: TAnswer);

    [DELETE, Path('/delete/{Id}')]
    procedure Delete(const [PathParam] Id: Integer);
  end;

implementation

{ THelloWorldResource }

function TAnswerResource.GetOne(const Id: Integer): TAnswer;
begin
  Result := GlobalContainer.Resolve<IAnswerRepository>.GetOne(Id);
end;

procedure TAnswerResource.Delete(const Id: Integer);
begin
  GlobalContainer.Resolve<IAnswerRepository>.Delete(Id);
end;

procedure TAnswerResource.Insert(const Answer: TAnswer);
begin
  GlobalContainer.Resolve<IAnswerRepository>.Insert(Answer);
end;

procedure TAnswerResource.Update(const Answer: TAnswer);
begin
  GlobalContainer.Resolve<IAnswerRepository>.Update(Answer);
end;

function TAnswerResource.GetList: TJSONArray;
begin
  result := GlobalContainer.Resolve<IAnswerRepository>.GetList;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TAnswerResource>;

end.
