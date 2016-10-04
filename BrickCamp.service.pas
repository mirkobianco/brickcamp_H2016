unit BrickCamp.service;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  BrickCamp.service.impl,
  Spring.Container,
  Spring.Logging;

type
  TsrvBrickCamp = class(TService)
    procedure ServiceExecute(Sender: TService);
  private
    FService: TCbdService;
  public
    function GetServiceController: TServiceController; override;

    procedure Initialize;
  end;

var
  srvBrickCamp: TsrvBrickCamp;

implementation

uses
	BrickCamp.services;


{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvBrickCamp.Controller(CtrlCode);
end;

function TsrvBrickCamp.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvBrickCamp.Initialize;
begin
  try
    FService := TCbdService.Create;
    FService.Run;
  except
    on E: exception do
    begin
      CbLog.Error(E.Message);
      raise;
    end;
  end;
end;

procedure TsrvBrickCamp.ServiceExecute(Sender: TService);
begin
  Initialize;
end;

end.
