unit BrickCamp.RemoteInterface;

interface

uses
  Data.DB,
  Datasnap.DBClient;

type
  TBrickCampRemoteInterface = class
  public
    function LoginUser(const Name: string): Integer;
    function GetProductDataset: TClientDataset;
    function GetQuestionsForProduct(ProductId: Integer): TClientDataSet;
  end;

implementation

uses
  System.SysUtils,
  System.JSON,
  Data.Bind.EngExt, Data.Bind.Components, Data.Bind.ObjectScope,
  Data.Bind.GenData, IPPeerClient, REST.Client, MARS.Client.Client,
  REST.Response.Adapter, Data.Bind.DBScope, FireDAC.Stan.Intf, REST.Types,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FMX.Dialogs
  ;

const
  USERBASEURL: string = 'http://localhost:8080/rest/cb/user';
  PRODUCTBASEURL: string = 'http://localhost:8080/rest/cb/product';

  GET_USER_ONEBYNAME: string = '/getonebyname';

  GET_PRODUCT_GETLIST: string = '/getlist';

{ TBrickCampRemoteInterface }

function TBrickCampRemoteInterface.GetProductDataset: TClientDataset;
var
  RestClient: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  DataSetAdapter: TRESTResponseDataSetAdapter;
begin
  RestClient := TRESTClient.Create(PRODUCTBASEURL + GET_PRODUCT_GETLIST);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  DataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);
  Result := TClientDataSet.Create(nil);
  try
    Request.Client := RestClient;
    //Request.Resource := GET_USER_ONEBYNAME;
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
  RestClient := TRESTClient.Create(USERBASEURL + GET_USER_ONEBYNAME + '/' + Name);
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := RestClient;
    //Request.Resource := GET_USER_ONEBYNAME;
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

end.
