unit BrickCamp.translationsSynchronizer.interf;

interface

type
  ITranslationSynchronizer = interface
  ['{855C643E-40CE-467A-893A-F9B40913F5B5}']
    procedure Synchronize;

    function GetSecondsInterval: Cardinal;
  end;

implementation

end.
