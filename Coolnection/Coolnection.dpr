program Coolnection;

uses
  System.StartUpCopy,
  FMX.Forms,
  HeaderFooterFormwithNavigation in 'HeaderFooterFormwithNavigation.pas' {mCoolnection},
  BrickCamp.RemoteInterface in 'BrickCamp.RemoteInterface.pas',
  BrickCamp.Model in '..\Model\BrickCamp.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmCoolnection, mCoolnection);
  Application.Run;
end.
