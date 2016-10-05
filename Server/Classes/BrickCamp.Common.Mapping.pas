unit BrickCamp.Common.Mapping;
//as per a stack entry by Sir Rufo. Its as per as I have done it c# and ruby
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
    procedure Add<TSource, TTarget>( Converter: TFunc<TSource, TTarget> ); overload;
    procedure Add<TSource, TTarget>( Converter: TFunc<TSource, TTarget>; Reverter: TFunc<TTarget, TSource> ); overload;
  public
    constructor Create;
    destructor Destroy; override;

    function MapCollection<TSource, TTarget>( const Collection: TEnumerable<TSource> ): TArray<TTarget>; overload;
    function MapCollection<TSource, TTarget>( const Collection: array of TSource ): TArray<TTarget>; overload;
    function Map<TSource, TTarget>( const Source: TSource ): TTarget; overload;
    procedure Map<TSource, TTarget>( const Source: TSource; out Target: TTarget ); overload;
  end;

implementation

{ TMapper }

procedure TMapper.Add<TSource, TTarget>( Converter: TFunc<TSource, TTarget> );
var
  lKey: TMapKey;
begin
  lKey := TMapKey.Create<TSource, TTarget>( );
  FMappings.Add( lKey,
    function( Source: TValue ): TValue
    begin
      Result := TValue.From<TTarget>( Converter( Source.AsType<TSource>( ) ) );
    end );
end;

procedure TMapper.Add<TSource, TTarget>(
  Converter: TFunc<TSource, TTarget>;
  Reverter : TFunc<TTarget, TSource> );
begin
  Add<TSource, TTarget>( Converter );
  Add<TTarget, TSource>( Reverter );
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

function TMapper.Map<TSource, TTarget>( const Source: TSource ): TTarget;
var
  Key: TMapKey;
  Value : TValue;
begin
  Key   := TMapKey.Create<TSource, TTarget>( );
  Value := TValue.From<TSource>( Source );
  Result := FMappings[ Key ]( Value ).AsType<TTarget>( );
end;

procedure TMapper.Map<TSource, TTarget>(
  const Source: TSource;
  out Target  : TTarget );
begin
  Target := Map<TSource, TTarget>( Source );
end;

function TMapper.MapCollection<TSource, TTarget>( const Collection: array of TSource ): TArray<TTarget>;
var
  TempCollection: TList<TSource>;
begin
  TempCollection := TList<TSource>.Create( );
  try
    TempCollection.AddRange( Collection );
    Result := MapCollection<TSource, TTarget>( TempCollection );
  finally
    TempCollection.Free;
  end;
end;

function TMapper.MapCollection<TSource, TTarget>( const Collection: TEnumerable<TSource> ): TArray<TTarget>;
var
  Key       : TMapKey;
  MapHandler: TFunc<TValue, TValue>;
  ListOfTarget : TList<TTarget>;
  SourceItem: TSource;
begin
  Key        := TMapKey.Create<TSource, TTarget>( );
  MapHandler := FMappings[ Key ];

  ListOfTarget := TList<TTarget>.Create;
  try
    for SourceItem in Collection do
      begin
        ListOfTarget.Add( MapHandler( TValue.From<TSource>( SourceItem ) ).AsType<TTarget>( ) );
      end;

    Result := ListOfTarget.ToArray( );
  finally
    ListOfTarget.Free;
  end;
end;

{ TMapKey }

class function TMapKey.Create<TSource, TTarget>: TMapKey;
begin
  Result.Source := TypeInfo( TSource );
  Result.Target := TypeInfo( TTarget );
end;

end.

