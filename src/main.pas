unit Main;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ColorListings, CaptureFrm, LCLType,
  Codebot.System,
  Codebot.Unique,
  Codebot.Input.Hotkeys,
  Codebot.Graphics,
  Codebot.Graphics.Types,
  Codebot.Controls.Colors,
  Codebot.Controls.Scrolling;

{ TMainForm }

type
  TMainForm = class(TForm)
    ColorEdit: TEdit;
    ColorList: TDrawList;
    ColorShape: TShape;
    HuePicker: THuePicker;
    SaturationPicker: TSaturationPicker;
    SelectBox: TComboBox;
    EyeDropButton: TSpeedButton;
    MoveTimer: TTimer;
    procedure ColorEditDblClick(Sender: TObject);
    procedure ColorListDrawItem(Sender: TObject; Surface: ISurface;
      Index: Integer; Rect: TRectI; State: TDrawState);
    procedure ColorListSelectItem(Sender: TObject);
    procedure EyeDropButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HuePickerDblClick(Sender: TObject);
    procedure MoveTimerTimer(Sender: TObject);
    procedure SaturationPickerChange(Sender: TObject);
    procedure SaturationPickerDblClick(Sender: TObject);
    procedure SelectBoxChange(Sender: TObject);
  private
    procedure ActionClose;
    procedure ActionCapture;
    procedure ActionShow;
    function GetColorText: string;
  private
    FCanClose: Boolean;
    FColors: TColorList;
    FFont: IFont;
    FHtmlColor: Boolean;
    function DefaultPosition: TPointI;
    procedure UpdateValues;
    property ColorText: string read GetColorText;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

function OutOfBounds(Form: TForm): Boolean;
var
  X, Y: Integer;
begin
  X := Form.Left;
  Y := Form.Top;
  Result := (X < 2) or (X > Screen.Width - 2) or (Y < 2) or (Y > Screen.Height - 2);
end;

function TMainForm.DefaultPosition: TPointI;
begin
  Result.X := Screen.Width - Width - 24;
  Result.Y := 48;
end;

procedure TMainForm.ActionShow;
var
  P: TPointI;
begin
  if CaptureForm = nil then
  begin
    if Visible then
    begin
      if OutOfBounds(Self) then
      begin
        P := DefaultPosition;
        Left := P.X;
        Top := P.Y;
      end;
    end
    else
    begin
      FormStyle := fsSystemStayOnTop;
      Application.RestoreStayOnTop(True);
      Show;
      FormStyle := fsNormal;
    end;
  end;
end;

procedure TMainForm.MoveTimerTimer(Sender: TObject);
var
  P: TPointI;
begin
  case MoveTimer.Tag of
    0:
      begin;
        MoveTimer.Tag := 1;
        P := DefaultPosition;
        Left := P.X;
        Top := P.Y;
      end;
    1:
      begin;
        MoveTimer.Tag := 0;
        MoveTimer.Enabled := False;
        ActionCapture;
        FormStyle := fsSystemStayOnTop;
        Application.RestoreStayOnTop(True);
        Show;
        FormStyle := fsNormal;
      end;
  end;
end;

procedure TMainForm.ActionCapture;
var
  C: TColorB;
begin
  if CaptureForm <> nil then
    Exit;
  if Visible and OutOfBounds(Self) then
  begin
    Visible := False;
    MoveTimer.Enabled := True;
    Exit;
  end;
  FormStyle := fsSystemStayOnTop;
  Application.RestoreStayOnTop(True);
  if CaptureColor(C) then
  begin
    HuePicker.Hue := ColorToHue(C);
    SaturationPicker.ColorValue := C;
    Show;
  end;
  FormStyle := fsNormal;
end;

procedure TMainForm.ActionClose;
begin
  if CaptureForm <> nil then
    CaptureForm.ModalResult := mrCancel;
  FCanClose := True;
  Close;
end;

type
  TShapeHack = class(TShape) public property OnDblClick; end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  P: TPointI;
begin
  FHtmlColor := True;
  ClientWidth := ColorList.Left + ColorList.Width + 8;
  ClientHeight := ColorShape.Top + ColorShape.Height + 8;
  P := DefaultPosition;
  Left := P.X;
  Top := P.Y;
  TShapeHack(Pointer(ColorShape)).OnDblClick := ColorEditDblClick;
  BuildCommonColors(FColors);
  FFont := NewFont(Font);
  FFont.Quality := fqCleartype;
  ColorList.Count := FColors.Length;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  OnShow := nil;
  ColorEdit.Top := ColorShape.Top + (ColorShape.Height - ColorEdit.Height) div 2;
  SelectBox.Top := ColorShape.Top + (ColorShape.Height - SelectBox.Height) div 2;
end;
procedure TMainForm.ColorEditDblClick(Sender: TObject);
begin
  FHtmlColor := not FHtmlColor;
  ColorEdit.Text := ColorText;
end;

procedure TMainForm.ColorListDrawItem(Sender: TObject; Surface: ISurface;
  Index: Integer; Rect: TRectI; State: TDrawState);
var
  R: TRectI;
  C: TColorB;
begin
  FillRectState(Surface, Rect, State);
  R := Rect;
  R.Inflate(-3, -3);
  R.Right := 32;
  C := FColors[Index].Color;
  Surface.FillRect(NewBrush(C), R);
  Surface.StrokeRect(NewPen(C.Darken(0.5)), R);
  R := Rect;
  R.Left := 34;
  Surface.TextOut(FFont, FColors[Index].Name, R, drLeft);
end;

procedure TMainForm.ColorListSelectItem(Sender: TObject);
var
  C: TColorB;
begin
  if ColorList.ItemIndex > -1 then
  begin
    C := FColors[ColorList.ItemIndex].Color;
    HuePicker.Hue := ColorToHue(C);
    SaturationPicker.ColorValue := C;
  end;
end;

procedure TMainForm.EyeDropButtonClick(Sender: TObject);
begin
  ActionCapture;
end;

procedure TMainForm.HuePickerDblClick(Sender: TObject);
begin
  if HuePicker.Style = hsLinear then
  begin
    HuePicker.Style := hsRadial;
    HuePicker.SetBounds(8, 8, 200, 200);
    SaturationPicker.SetBounds(24, 24, 168, 168);
  end
  else
  begin
    HuePicker.Style := hsLinear;
    HuePicker.SetBounds(8, 192, 200, 16);
    SaturationPicker.SetBounds(8, 8, 200, 184);
  end;
end;

procedure TMainForm.SaturationPickerDblClick(Sender: TObject);
begin
  if SaturationPicker.Style = ssSaturate then
    SaturationPicker.Style := ssDesaturate
  else
    SaturationPicker.Style := ssSaturate;
end;

procedure TMainForm.SelectBoxChange(Sender: TObject);
begin
  if SelectBox.ItemIndex = 0 then
    BuildCommonColors(FColors)
  else
    BuildSystemColors(FColors);
  ColorList.Count := FColors.Length;
end;

function TMainForm.GetColorText: string;
var
  A, B: TColorB;
  Name: string;
  I: Integer;
begin
  A := ColorShape.Brush.Color;
  if FHtmlColor then
    Result := '#%.2x%.2x%.2x'.Format([A.Red, A.Green, A.Blue])
  else
  begin
    Name := '';
    for I := 0 to FColors.Length - 1 do
    begin
      B := FColors[I].Color;
      if A = B then
      begin
        Name := FColors[I].LazName;
        Break;
      end;
    end;
    if Name <> '' then
      Result := Name
    else
      Result := 'TColor($%.2x%.2x%.2x)'.Format([A.Blue, A.Green, A.Red]);
  end;
end;

procedure TMainForm.UpdateValues;
var
  C: TColorB;
begin
  C := SaturationPicker.ColorValue;
  ColorShape.Brush.Color := C.Color;
  ColorEdit.Text := ColorText;
end;

procedure TMainForm.SaturationPickerChange(Sender: TObject);
begin
  UpdateValues;
end;

end.

