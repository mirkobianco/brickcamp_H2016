unit BrickCamp.MARS.Writers.Employee;

interface

uses
  Classes, SysUtils, Rtti

  , MARS.Core.Attributes
  , MARS.Core.Declarations
  , MARS.Core.MediaType
  , MARS.Core.MessageBodyWriter,
  MARS.Core.MessageBodyWriters
  ;

type
  [Produces(TMediaType.APPLICATION_JSON)]
  TEmployeeWriter = class(TInterfacedObject, IMessageBodyWriter)
    procedure WriteTo(const AValue: TValue;
                      const AAttributes: TAttributeArray;
                            AMediaType: TMediaType;
                            AResponseHeaders: TStrings;
                            AOutputStream: TStream);
  end;

implementation

procedure RegisterWriters;
begin
  //TMARSMessageBodyRegistry.Instance.RegisterWriter<IEmployee>(TEmployeeWriter);
end;

{ TEmployeeWriter }

procedure TEmployeeWriter.WriteTo(const AValue: TValue;
                                  const AAttributes: TAttributeArray;
                                        AMediaType: TMediaType;
                                        AResponseHeaders: TStrings;
                                        AOutputStream: TStream);
var
  ObjectWriter: TObjectWriter;
begin
  ObjectWriter := TObjectWriter.Create;
  ObjectWriter.Free;
end;

initialization
  RegisterWriters;

end.
