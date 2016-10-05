unit BrickCamp.Common.JsonContract;
// this too via Sir Rufo.
interface

type
  TJsonContractBase = class abstract
  protected
    procedure DisposeObjectArray<T: class>( var arr: TArray<T> );
    class function _FromJson( const aJsonStr: string ): TObject; overload;
    class procedure _FromJson( aResult: TObject; const aJsonStr: string ); overload;
  public
    function ToJson( ): string; virtual;
    function ToKey( ): string; virtual;abstract;
  end;

implementation

uses
  System.Sysutils,
  System.JSON,
  REST.JSON;

{ TJsonContractBase }

procedure TJsonContractBase.DisposeObjectArray<T>( var arr: TArray<T> );
var
  I: Integer;
begin
  for I := low( arr ) to high( arr ) do
    FreeAndNil( arr[ I ] );
  SetLength( arr, 0 );
end;

class function TJsonContractBase._FromJson( const aJsonStr: string ): TObject;
begin
  Result := Self.Create;
  try
    _FromJson( Result, aJsonStr );
  except
    Result.Free;
    raise;
  end;
end;

class procedure TJsonContractBase._FromJson( aResult: TObject; const aJsonStr: string );
var
  lJson: TJsonObject;
begin
  lJson := TJsonObject.ParseJSONValue( aJsonStr ) as TJsonObject;
  try
    TJson.JsonToObject( aResult, lJson );
  finally
    lJson.Free;
  end;
end;

function TJsonContractBase.ToJson: string;
begin
  Result := TJson.ObjectToJsonString( Self );
end;

end.

