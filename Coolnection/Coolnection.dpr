program Coolnection;

uses
  System.StartUpCopy,
  FMX.Forms,
  HeaderFooterFormwithNavigation in 'HeaderFooterFormwithNavigation.pas' {mCoolnection};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmCoolnection, mCoolnection);
  Application.Run;
end.
