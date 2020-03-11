unit XPrintData;

interface

type
  TXPrintConfig = record
    FitInPage : Boolean;

    TitleMargin : Double;

    LeftMargin : Double; // in cm
    TopMargin : Double;
    RightMargin : Double;
    BottomMargin : Double;
    UseColor : Boolean;
  end;

implementation

end.
