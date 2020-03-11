unit SMS_Controls;

interface

uses
  StdCtrls, ExtCtrls, Controls;

const
  AlignDescs : array[TAlign] of String =
    ('None', 'Top', 'Bottom', 'Left', 'Right', 'Client', 'Custom');


type

  TSMSPanel = class(TPanel)

  end;

{
  type
  TSCheckBox = class(TCheckBox)
  public
    Data : TObject;
    DataInt : Integer;
  end;
}


implementation

end.
