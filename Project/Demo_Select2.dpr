program Demo_Select2;

uses
  FastMM4,
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  IWStart,
  uFormPageSelect2 in '..\Source\Page\uFormPageSelect2.pas' {FormPageSelect2: TIWAppForm},
  uServerController in '..\Source\Controller\uServerController.pas' {IWServerController: TIWServerControllerBase},
  uUserSession in '..\Source\Controller\uUserSession.pas' {IWUserSession: TIWUserSessionBase};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
