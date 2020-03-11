unit SMS_DTextEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TTextEditor = class(TForm)
    MemoText: TMemo;
    Panel1: TPanel;
    ButtonOK: TButton;
    Cancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TextEditor: TTextEditor;

implementation

{$R *.dfm}

end.
