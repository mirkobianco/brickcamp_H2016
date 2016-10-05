unit BrickCamp.RemoteInterface;

interface

uses
  System.JSON,
  Data.DB,
  Datasnap.DBClient,
  BrickCamp.Model;

type
  TBrickCampRemoteInterface = class
  public
    function GetDataset(const Resource: TResourceType): TClientDataset;
    function GetOne(const Resource: TResourceType): TJSONObject;
    procedure Delete(const Id: Integer);
    procedure Post(const Resource: TResourceType; const JSONObject: TJSONObject);
    procedure Put(const Resource: TResourceType; const JSONObject: TJSONObject);

    function LoginUser(const Name: string): Integer;

    function GetQuestionsByProduct(const ProductId: Integer): TClientDataSet;
    function GetAnswersByQuestion(const QuestionId: Integer): TClientDataSet;
  end;

implementation

uses
  System.SysUtils,
  Data.Bind.EngExt, Data.Bind.Components, Data.Bind.ObjectScope,
  Data.Bind.GenData, IPPeerClient, REST.Client, MARS.Client.Client,
  REST.Response.Adapter, Data.Bind.DBScope, FireDAC.Stan.Intf, REST.Types,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FMX.Dialogs
  ;

const
  BASEURL: string = 'http://localhost:8080/rest/cb';
{ TBrickCampRemoteInterface }

procedure TBrickCampRemoteInterface.Delete(const Id: Integer);
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[rQuestion] + DELETE_GENERIC + '/' + IntToStr(Id));
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmDELETE;
    Request.Execute;
  finally
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

function TBrickCampRemoteInterface.GetAnswersByQuestion(const QuestionId: Integer): TClientDataSet;
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  DataSetAdapter: TRESTResponseDataSetAdapter;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[rQuestion] + GET_ANSWER_GETLISTBYQUESTION + '/' + IntToStr(QuestionId));
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  DataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);
  Result := TClientDataSet.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmGET;
    DataSetAdapter.Response := Response;
    DataSetAdapter.Dataset := Result;
    Request.Execute;
  finally
    DataSetAdapter.Free;
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

function TBrickCampRemoteInterface.GetDataset(const Resource: TResourceType): TClientDataset;
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  DataSetAdapter: TRESTResponseDataSetAdapter;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[Resource] + GET_GENERIC_GETLIST);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  DataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);
  Result := TClientDataSet.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmGET;
    DataSetAdapter.Response := Response;
    DataSetAdapter.Dataset := Result;
    Request.Execute;
  finally
    DataSetAdapter.Free;
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

function TBrickCampRemoteInterface.GetOne(const Resource: TResourceType): TJSONObject;
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[Resource] + GET_GENERIC_GETONE);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmGET;
    Request.Execute;
    Result := TJSONObject.ParseJSONValue(Response.Content) as TJSONObject;
  finally
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

function TBrickCampRemoteInterface.GetQuestionsByProduct(const ProductId: Integer): TClientDataSet;
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  DataSetAdapter: TRESTResponseDataSetAdapter;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[rQuestion] + GET_QUESTION_GETLISTBYPRODUCT + '/' + IntToStr(ProductId));
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  DataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);
  Result := TClientDataSet.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmGET;
    DataSetAdapter.Response := Response;
    DataSetAdapter.Dataset := Result;
    Request.Execute;
  finally
    DataSetAdapter.Free;
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

function TBrickCampRemoteInterface.LoginUser(const Name: string): Integer;
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  JSONObject: TJSONObject;
begin
  Result := -1;
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[rUser] + GET_USER_ONEBYNAME + '/' + Name);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmGET;
    Request.Execute;
    JSONObject := JSONObject.ParseJSONValue(Response.Content) as TJSONObject;
    try
      if Assigned(JSONObject) then
        Result := StrToIntDef(JSONObject.GetValue('ID').Value, -1);
    finally
      JSONObject.Free;
    end;
  finally
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

procedure TBrickCampRemoteInterface.Post(const Resource: TResourceType; const JSONObject: TJSONObject);
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[Resource] + POST_GENERIC);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmPost;
    Request.Body.JSONWriter.WriteRaw(JSONObject.ToString);
    Request.Execute;
  finally
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

procedure TBrickCampRemoteInterface.Put(const Resource: TResourceType; const JSONObject: TJSONObject);
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
begin
  RestClient := TRESTClient.Create(BASEURL + RESOURCESTRINGS[Resource] + PUT_GENERIC);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := RestClient;
    Request.Response := Response;
    Request.Method := rmPut;
    Request.Body.JSONWriter.WriteRaw(JSONObject.ToString);
    Request.Execute;
  finally
    Response.Free;
    Request.Free;
    RestClient.Free;
  end;
end;

end.
