unit SMS_Actions;

interface

uses
  Classes, SMS_DS;

type

  TSAction = class;

  TSActionExecuteEvent = procedure(Sender: TObject; Action: TSAction) of object;

  TSAction = class(TCommonCollectionItem)
  private
    FOnExecute: TSActionExecuteEvent;
  public
    Command : String;
    Command2 : String;
    Command3 : String;
    Command4 : String;
    //
    Tag : Integer;

    constructor Create(aColl: TCollection); override;

    property OnExecute : TSActionExecuteEvent read FOnExecute write FOnExecute;
  end;


implementation

{ TSAction }

constructor TSAction.Create(aColl: TCollection);
begin
  inherited Create(aColl);                                     

  Tag := 0;

end;

end.
