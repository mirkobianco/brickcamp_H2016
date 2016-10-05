unit BrickCamp.TClassMapper;

interface

uses
  System.Generics.Collections,
  System.Rtti,
  System.SysUtils,
  System.TypInfo;

type
  TMapKey = record
    Source: PTypeInfo;
    Target: PTypeInfo;
    class function Create<TSource, TTarget>( ): TMapKey; static;
  end;

  TMapper = class
  private
    FMappings: TDictionary<TMapKey, TFunc<TValue, TValue>>;
  public
    procedure Add<TSource, TTarget>( aConverter: TFunc<TSource, TTarget> ); overload;
    procedure Add<TSource, TTarget>( aConverter: TFunc<TSource, TTarget>; aReverter: TFunc<TTarget, TSource> ); overload;
  public
    constructor Create;
    destructor Destroy; override;

    function Map<TSource, TTarget>( const aSource: TSource ): TTarget; overload;
    procedure Map<TSource, TTarget>( const aSource: TSource; out aTarget: TTarget ); overload;
    function MapCollection<TSource, TTarget>( const aCollection: TEnumerable<TSource> ): TArray<TTarget>; overload;
    function MapCollection<TSource, TTarget>( const aCollection: array of TSource ): TArray<TTarget>; overload;
  end;

implementation

{ TMapper }

procedure TMapper.Add<TSource, TTarget>( aConverter: TFunc<TSource, TTarget> );
var
  lKey: TMapKey;
begin
  lKey := TMapKey.Create<TSource, TTarget>( );
  FMappings.Add( lKey,
    function( Source: TValue ): TValue
    begin
      Result := TValue.From<TTarget>( aConverter( Source.AsType<TSource>( ) ) );
    end );
end;

procedure TMapper.Add<TSource, TTarget>(
  aConverter: TFunc<TSource, TTarget>;
  aReverter : TFunc<TTarget, TSource> );
begin
  Add<TSource, TTarget>( aConverter );
  Add<TTarget, TSource>( aReverter );
end;

constructor TMapper.Create;
begin
  inherited;
  FMappings := TDictionary < TMapKey, TFunc < TValue, TValue >>.Create;
end;

destructor TMapper.Destroy;
begin
  FMappings.Free;
  inherited;
end;

function TMapper.Map<TSource, TTarget>( const aSource: TSource ): TTarget;
var
  lKey: TMapKey;
begin
  lKey   := TMapKey.Create<TSource, TTarget>( );
  Result := FMappings[ lKey ]( TValue.From<TSource>( aSource ) ).AsType<TTarget>( );
end;

procedure TMapper.Map<TSource, TTarget>(
  const aSource: TSource;
  out aTarget  : TTarget );
begin
  aTarget := Map<TSource, TTarget>( aSource );
end;

function TMapper.MapCollection<TSource, TTarget>( const aCollection: array of TSource ): TArray<TTarget>;
var
  lCollection: TList<TSource>;
begin
  lCollection := TList<TSource>.Create( );
  try
    lCollection.AddRange( aCollection );
    Result := MapCollection<TSource, TTarget>( lCollection );
  finally
    lCollection.Free;
  end;
end;

function TMapper.MapCollection<TSource, TTarget>( const aCollection: TEnumerable<TSource> ): TArray<TTarget>;
var
  lKey       : TMapKey;
  lMapHandler: TFunc<TValue, TValue>;
  lResult    : TList<TTarget>;
  lSourceItem: TSource;
begin
  lKey        := TMapKey.Create<TSource, TTarget>( );
  lMapHandler := FMappings[ lKey ];

  lResult := TList<TTarget>.Create;
  try
    for lSourceItem in aCollection do
      begin
        lResult.Add( lMapHandler( TValue.From<TSource>( lSourceItem ) ).AsType<TTarget>( ) );
      end;

    Result := lResult.ToArray( );
  finally
    lResult.Free;
  end;
end;

{ TMapKey }

class function TMapKey.Create<TSource, TTarget>: TMapKey;
begin
  Result.Source := TypeInfo( TSource );
  Result.Target := TypeInfo( TTarget );
end;

end.

