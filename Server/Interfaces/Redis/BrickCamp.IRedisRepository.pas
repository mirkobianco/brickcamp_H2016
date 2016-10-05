unit BrickCamp.IRedisRepository;

interface

type
  IRedisRepository = interface
    ['{12C2DA6A-ADD0-4097-9FC5-115CCAA7797D}']
    function Connnect : Boolean;
    function SetValue(Keyname : String; Value : String) : Boolean;
    function GetValue(Keyname : String; var Value : String) : Boolean;
  end;

implementation

end.
