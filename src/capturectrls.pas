unit CaptureCtrls;

{$mode delphi}

interface

uses
  Classes, SysUtils, Graphics, Controls, types, LCLType,
  Codebot.System,
  Codebot.Graphics.Types;

{ TCaptureZoom }

type
  TCaptureZoom = class(TGraphicControl)
  private
    FBitmap: TBitmap;
    FPick: TColor;
  protected
    class function GetControlClassDefaultSize: TSize; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ZoomTo(X, Y: Integer; Bitmap: TBitmap);
    property Pick: TColor read FPick;
  end;

implementation

{ TCaptureZoom }

class function TCaptureZoom.GetControlClassDefaultSize: TSize;
begin
  Result.cx := 128;
  Result.cy := 128;
end;

constructor TCaptureZoom.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := GetControlClassDefaultSize.cx;
  Height := GetControlClassDefaultSize.cx;
  FBitmap := TBitmap.Create;
end;

destructor TCaptureZoom.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TCaptureZoom.Paint;
var
  X, Y: Integer;
begin
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(ClientRect);
  Canvas.Draw(0, 0, FBitmap);
  Canvas.Pen.Color := clBlack;
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(0, Width - 1);
  Canvas.LineTo(Height - 1, Width - 1);
  Canvas.LineTo(Height - 1, 0);
  Canvas.LineTo(0, 0);
  Canvas.Pen.Color := clRed;
  X := Width div 2 - 2;
  Y := Height div 2 - 2;
  Canvas.MoveTo(X, Y);
  Canvas.LineTo(X + 4, Y);
  Canvas.LineTo(X + 4, Y + 4);
  Canvas.LineTo(X, Y + 4);
  Canvas.LineTo(X, Y);
  Canvas.Brush.Color := FPick;
  X := Width;
  Y := Height;
  Canvas.FillRect(1, Y - 24, X - 1, Y - 1);
end;

procedure TCaptureZoom.ZoomTo(X, Y: Integer; Bitmap: TBitmap);
var
  S, D: TRectI;
begin
  S := ClientRect;
  D := S;
  S.Width := S.Width div 4;
  S.Height := S.Height div 4;
  S.Center(X, Y);
  FBitmap.SetSize(Width, Height);
  FBitmap.Canvas.Brush.Color := clBlack;
  FBitmap.Canvas.CopyRect(D, Bitmap.Canvas, S);
  FPick := FBitmap.Canvas.Pixels[FBitmap.Width div 2, FBitmap.Height div 2];
  Invalidate;
end;

end.

