program colormix;

{$mode delphi}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Main, CaptureFrm, CaptureCtrls, ColorListings,
  Codebot.System,
  Codebot.Graphics.Extras,
  Codebot.Unique
  { you can add units after this };

{$R *.res}
{$R picker.res}

procedure ProcessCommands;
begin
  if SwitchExists('close') then
    UniqueInstance.SendMessage('close')
  else if SwitchExists('capture') then
    UniqueInstance.SendMessage('capture')
  else
    UniqueInstance.SendMessage('show');
end;

begin
  if UniqueInstance(37001).Original then
  begin
    if SwitchExists('close') then
      Exit;
    RequireDerivedFormResource := True;
    Application.Initialize;
    LoadCursor('picker', UserCursor);
    Application.CreateForm(TMainForm, MainForm);
    Application.Run;
  end
  else
    ProcessCommands;
end.

