unit BrickCamp.JsonUser;

interface
uses
  System.Sysutils,
  BrickCamp.Common.JsonContract;

type
  TJsonUser = class(TJsonContractBase)
  private
    [ JSONName( 'name' ) ]
    FName: string;
    [ JSONName( 'Id' ) ]
    FId: Integer;
  public
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;

    class function FromJson( const JsonStr: string ): TJsonUser;
    function ToKey( ): string; override;
  end;

implementation

{ TJsonUser }

class function TJsonUser.FromJson(const JsonStr: string): TJsonUser;
begin
  result := _FromJson(JsonStr) as TJsonUser;
end;

function TJsonUser.ToKey: string;
begin
  Result := ClassName + IntToStr(Id);
end;

end.
