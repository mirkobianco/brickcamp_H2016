unit BrickCamp.translationsSynchronizer.impl;

interface

uses
  BrickCamp.translationsSynchronizer.interf,
  BrickCamp.settings.interf,
  Spring.Logging,
  Spring.Container,
  Spring.Container.Common, BrickCamp.db.interf;

type
  TCbdTransSynchronizer = class(TInterfacedObject, ITranslationSynchronizer)
  private
    [Inject]
    FSettings: IBrickCampSettings;
    [Inject]
    FDb: IBrickCampDb;

    procedure LoadTranslationFromDB;
  public
    procedure Synchronize;

    function GetSecondsInterval: Cardinal;
  end;

implementation

uses
  BrickCamp.services, Spring.Collections, BrickCamp.Employee.Model, Spring.Persistence.Criteria.Properties;

{ TCbdTransSynchronizer }

function TCbdTransSynchronizer.GetSecondsInterval: Cardinal;
begin
  result := 9;
end;

procedure TCbdTransSynchronizer.LoadTranslationFromDB;
var
  FEmployees: IList<TEmployee>;
  Status: Prop;
begin
  Status := Prop.Create('EMP_NO');

  FEmployees := FDb.GetSession.FindWhere<TEmployee>(Status = 2);
  CbLog.Info('Loaded %d', [FEmployees.Count]);
  CbLog.Info('translation %s', [FEmployees.Last.FirstName + ' ' + FEmployees.Last.LastName]);
end;

procedure TCbdTransSynchronizer.Synchronize;
begin
  CbLog.Info('Synchronization started.');
  CbLog.Text(FSettings.GetDBStringConnection);
  LoadTranslationFromDB;
end;

end.
