unit SMS_Apps;

interface

uses
  Controls;

function TraceSource(aObj : TObject) : String;


implementation


function TraceSource(aObj : TObject) : String;
  var
    aControl : TControl;
  begin
    if aObj = nil then
      Result := 'Not Identified'
    else
    begin
      Result := aObj.ClassName;
      if aObj is TControl then
      begin
        aControl := aObj as TControl;
        Result := Result + '(' + aControl.Name + ')';
        if aControl.Parent <> nil then
          Result := Result + '@' + TraceSource(aControl.Parent)
      end;
    end;
  end;

end.
