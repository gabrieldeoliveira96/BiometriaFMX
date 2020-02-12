program CodeRage2020_Ios;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  iOSapi.LocalAuthentication in 'Biometria\iOSapi.LocalAuthentication.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
