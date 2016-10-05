unit BrickCamp.Model.IAnswer;

interface

uses
  Spring;

type
  IAnswer = interface(IInterface)
  ['{22C4E548-5FBE-47FE-9138-5A96FFE3DDE0}']
    function GetId: Integer;
    function GetQuestionId: Integer;
    function GetUserId: Integer;
    function GetText: string;
    function GetRankIndex: SmallInt;
    procedure SetQuestionId(const Value: Integer);
    procedure SetUserId(const Value: Integer);
    procedure SetText(const Value: string);
    procedure SetRankIndex(const Value: SmallInt);
  end;

implementation

end.
