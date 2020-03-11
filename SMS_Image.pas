unit SMS_Image;

interface

uses
  SysUtils, Graphics, jpeg, Types, Windows, Forms;

//-- capture screen
function CaptureScreen(const stFile : String): Boolean;

implementation

function CaptureScreen(const stFile : String): Boolean;
var
  aBitmap : Graphics.TBitmap;
  aRect : TRect;
  aDC : HDC;
  aCanvas : TCanvas;
  aJPEG : TJPEGImage;
begin
  Result := False;

  try
    try
      aBitmap := Graphics.TBitmap.Create;
      aBitmap.Width := Screen.Width;
      aBitmap.Height := Screen.Height;

      aRect := Rect(0, 0, Screen.Width, Screen.Height);
      aDC := GetWindowDC(GetDeskTopWindow);
      aCanvas := TCanvas.Create;
      aCanvas.Handle := aDC;

      aBitmap.Canvas.CopyRect(aRect, aCanvas, aRect);
      aJPEG := TJPEGImage.Create;
      aJPEG.Assign(aBitmap);
      aJPEG.SaveToFile(stFile);

      Result := True;
    except
      //
    end;
  finally
    try
      aBitmap.Free;
      aJPEG.Free;
      ReleaseDC(GetDeskTopWindow, aDC);
      aCanvas.Free;
    except
      //...
    end;
  end;
end;

end.
