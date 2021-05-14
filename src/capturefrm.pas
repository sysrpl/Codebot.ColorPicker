unit CaptureFrm;

{$mode delphi}
{$WARN 5024 off : Parameter "$1" not used}

interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLIntf, LCLType, ExtCtrls, CaptureCtrls,
  Codebot.System,
  Codebot.Graphics,
  Codebot.Controls.Extras,
  Codebot.Graphics.Types; //Codebot.Graphics.Extras;

{ TCaptureForm }

type
  TCaptureForm = class(TForm)
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    FBitmap: TBitmap;
    FZoom: TCaptureZoom;
    function GetPick: TColorB;
    property Pick: TColorB read GetPick;
  end;

const
  UserCursor = 1;

var
  CaptureForm: TCaptureForm;

function CaptureColor(out C: TColorB): Boolean;

implementation

{$R *.lfm}

{ TCaptureForm }

function CaptureColor(out C: TColorB): Boolean;
begin
  C := clBlack;
  Result := False;
  if CaptureForm <> nil then
    Exit;
  CaptureForm := TCaptureForm.Create(Application);
  try
    Result := CaptureForm.ShowModal = mrOK;
    if Result then
      C := CaptureForm.Pick;
  finally
    CaptureForm.Free;
    CaptureForm := nil;
  end;
end;

procedure TCaptureForm.FormCreate(Sender: TObject);
begin
  Left := 0;
  Top := 0;
  Cursor := UserCursor;
  FBitmap := TBitmap.Create;
  CaptureScreen(FBitmap);
  FZoom := TCaptureZoom.Create(Self);
  FZoom.Top := 10;
  FZoom.Left := FBitmap.Width - FZoom.Width - 10;
  FZoom.Parent := Self;
  with Mouse.CursorPos do
    FZoom.ZoomTo(X, Y, FBitmap);
  FZoom.Top := FBitmap.Height - FZoom.Height - 10;
end;

procedure TCaptureForm.FormDestroy(Sender: TObject);
begin
  FBitmap.Free;
end;

procedure TCaptureForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TCaptureForm.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TCaptureForm.FormShow(Sender: TObject);
begin
  WindowState := wsFullScreen;
end;

procedure TCaptureForm.FormClick(Sender: TObject);
begin
  OnMouseMove := nil;
  ModalResult := mrOk;
end;

procedure TCaptureForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  FZoom.ZoomTo(X, Y, FBitmap);
  if (X > FZoom.Left - 50) and (Y < 10 + FZoom.Height + 50) then
    FZoom.Top := FBitmap.Height - FZoom.Height - 10
  else if (X > FZoom.Left - 50) and (Y > FZoom.Top - 50) then
    FZoom.Top := 10;
end;

procedure TCaptureForm.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0, 0, FBitmap);
end;

function TCaptureForm.GetPick: TColorB;
begin
  Result := FZoom.Pick;
end;

end.

