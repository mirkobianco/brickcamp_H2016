unit TestBrickCamp.Repository.Redis;

interface

uses
  TestFramework;

type
  //integration test
  TestTRedisEmployeeRepository = class(TTestCase)
  published
    procedure Connnect_Defaults_Fails;
  end;

implementation

{ TestTRedisEmployeeRepository }

procedure TestTRedisEmployeeRepository.Connnect_Defaults_Fails;
begin

end;

end.


