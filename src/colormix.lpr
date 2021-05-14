program colormix;

{$mode delphi}

uses
  Codebot.System,
  Interfaces, // this includes the LCL widgetset
  Forms, Main, CaptureFrm, CaptureCtrls, ColorListings,
  Codebot.Graphics
  { you can add units after this };

{$R *.res}
{$R picker.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  LoadCursor('picker', UserCursor);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

