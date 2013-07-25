program MySQLDumpInspector;

uses
  Forms,
  Principal in 'Principal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Inspector de archivos ''dump'' de MySQL';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
