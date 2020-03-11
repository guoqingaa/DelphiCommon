unit SMS_StatusManager;

interface

uses
  Classes;

type
  TStatusObject = class
  protected
    FOnStatusChanged : TNotifyEvent;

    procedure ShowStatus;
  public
    function GetStatus(aList : TStrings) : Integer; virtual;

    property OnStatusChanged : TNotifyEvent read FOnStatusChanged write FOnStatusChanged;
  end;
  
implementation

procedure TStatusObject.ShowStatus;
begin
  if Assigned(FOnStatusChanged) then
  try
    FOnStatusChanged(Self);
  except
    // ignored
  end;
end;

function TStatusObject.GetStatus(aList : TStrings) : Integer;
begin
  Result := 0;
  // should be overrided by children
end;

end.
