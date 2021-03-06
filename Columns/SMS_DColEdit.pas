unit SMS_DColEdit;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, {AppTypes,} Dialogs,

  SMS_InspectorGrid, SMS_Consts, SMS_Columns;

type
  {
  TColumnTypes = record
    FieldName: String;  // 고정
    Title: String;      // 사용자가 변경가능
    Width: String;
    Align: String;
    Scale: String;
    UseThousandSep : Boolean;
    UserAsBool : Boolean;

    Alignment : TAlignment;
    ShowColorChange : Boolean;

    UseGradationEffect : Boolean;
    GradationMaxValue : Integer;
    GradationMinValue : Integer;

    UseMaxColor : Boolean;
    MaxValue : Integer;
    MaxColor : TColor;

    UseMinColor : Boolean;
    MinValue : Integer;
    MinColor : TColor;
  end;
  }
  TColEditDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    StaticFieldName: TStaticText;
    ColorDialog1: TColorDialog;
    PanelInspector: TPanel;
    procedure EditWidthKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    //procedure ButtonSelectMaxClick(Sender: TObject);
    //procedure ButtonSelectMinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    //
    FInspectorGrid : TInspectorGrid;
    //FColumnTypes : TColumnTypes;

    FEditColumn : TSColumnItem;
    FColumns : TColumns;
  public
    //function Open(aColumnTypes: TColumnTypes): TColumnTypes; overload;

    function Open(aColumn : TSColumnItem): Boolean; overload;

    property EditedColumn : TSColumnItem read FEditColumn;

  end;


//function SetColumns(aForm: TForm; aColumnTypes: TColumnTypes): TColumnTypes;

implementation

{$R *.DFM}


{
function SetColumns(aForm: TForm; aColumnTypes: TColumnTypes): TColumnTypes;
var
  aDlg : TColEditDialog;
begin
  aDlg:= TColEditDialog.Create(aForm);
  Result:= aDlg.Open(aColumnTypes);
end;
}

{ TColEditDialog }

(*
function TColEditDialog.Open(aColumnTypes: TColumnTypes): TColumnTypes;
//var
//  iValue : Integer;
//  aAlignment : Word;
begin
  // Init Setting

  //FColumnTypes := aColumnTypes;
  with aColumnTypes do
  begin
    StaticFieldName.Caption:= FieldName;
    EditTitle.Text:= Title;
    //EditWidth.Text:= Width;
    EditScale.Text:= Scale;
    CheckGradationEffect.Checked := UseGradationEffect;
    EditGradationMax.Text := IntToStr(GradationMaxValue);
    EditGradationMin.Text := IntToStr(GradationMinValue);
    CheckMaxColor.Checked := UseMaxColor;
    EditMaxValue.Text := IntToStr(MaxValue);
    EditMaxValue.Color := MaxColor;

    CheckMinColor.Checked := UseMinColor;
    EditMinValue.Text := IntToStr(MinValue);
    EditMinValue.Color := MinColor;


    FInspectorGrid.AddTextProperty('Precision', aColumnTypes.Scale);
    FInspectorGrid.AddBoolProperty('UseThousandSep', aColumnTypes.UseThousandSep);

    //iValue := Ord(aColumnTypes.Alignment);
    //ShowMessage(IntToStr(Integer(aColumnTypes.Alignment)));

    //aAlignment := Ord(aColumnTypes.Alignment);
    FInspectorGrid.AddEnumProperty('Alignment', AlignmentDescs, aColumnTypes.Alignment);

    //ShowMessage(IntToStr(sizeof(acolumnTYPES.Alignment)));
    //FInspectorGrid.AddEnumProperty2('Alignment', AlignmentDescs, @FColumnTypes.Alignment);
    FInspectorGrid.AddBoolProperty('show color change', ShowColorChange);
    FInspectorGrid.AddBoolProperty('UserAsBoo', aColumnTypes.UserAsBool)

  end;
  ShowModal;
  //.. Return Value
  if ModalResult = mrOK then
    //.. Check Validity
    with aColumnTypes do
    begin
      Title:= EditTitle.Text;
      //Width:= EditWidth.Text;
      //Scale:= EditScale.Text;
      UseGradationEffect := CheckGradationEffect.Checked;
      GradationMaxValue := StrToInt(EditGradationMax.Text);
      GradationMinValue := StrToInt(EditGradationMin.Text);
      //
      UseMaxColor := CheckMaxColor.Checked;
      MaxValue := StrToInt(EditMaxValue.Text);
      MaxColor := EditMaxValue.Color;

      UseMinColor := CheckMinColor.Checked;
      MinValue := StrToInt(EditMinValue.Text);
      MinColor := EditMinValue.Color;

      Alignment := FInspectorGrid.Values['Alignment'];
      ShowColorChange := FInspectorGrid.Values['show color change'];
      Scale := FInspectorGrid.Values['Precision'];
      UseThousandSep := FInspectorGrid.Values['UseThousandSep'];
      UserAsBool := FInspectorGrid.Values['UserAsBool'];


    end;
  Result := aColumnTypes;
end;
*)
procedure TColEditDialog.EditWidthKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
   #8,#13,#10,'-','0'..'9' :;
   else
     Key := #0;
  end;
end;

procedure TColEditDialog.OKBtnClick(Sender: TObject);
begin
  //
  ModalResult:= mrOK;
end;

{
procedure TColEditDialog.ButtonSelectMaxClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
    EditMaxValue.Color := ColorDialog1.Color;
end;

procedure TColEditDialog.ButtonSelectMinClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
    EditMinValue.Color := ColorDialog1.Color;
end;
}
procedure TColEditDialog.FormCreate(Sender: TObject);
begin
  FInspectorGrid := TInspectorGrid.Create(PanelInspector);

  FColumns := TColumns.Create;
  FEditColumn := FColumns.AddColumnToView('edit', 100);
end;

procedure TColEditDialog.FormDestroy(Sender: TObject);
begin
  FColumns.Free;

  FInspectorGrid.Free;

end;

function TColEditDialog.Open(aColumn: TSColumnItem): Boolean;
begin
  FEditColumn.Assign(aColumn);
  //
  with FEditColumn do
  begin
    StaticFieldName.Caption:= FieldName;
    //EditTitle.Text:= Title;
    //
    //CheckGradationEffect.Checked := UseGradationEffect;
    //EditGradationMax.Text := IntToStr(GradationMaxValue);
    //EditGradationMin.Text := IntToStr(GradationMinValue);
    //CheckMaxColor.Checked := UseMaxColor;
    //EditMaxValue.Text := IntToStr(MaxValue);
    //EditMaxValue.Color := MaxColor;

    //CheckMinColor.Checked := UseMinColor;
    //EditMinValue.Text := IntToStr(MinValue);
    //EditMinValue.Color := MinColor;

    FInspectorGrid.AddTextProperty('Title', FEditColumn._Title);
    FInspectorGrid.AddIntProperty('Width', FEditColumn.Width);
    FInspectorGrid.AddIntProperty('Precision', FEditColumn.Scale);
    FInspectorGrid.AddEnumProperty('Alignment', AlignmentDescs, FEditColumn.Alignment);


    FInspectorGrid.AddBoolProperty('show color change', ShowColorChange);
    FInspectorGrid.AddBoolProperty('UseThousandSep', UseThousandSep);
    FInspectorGrid.AddBoolProperty('UserAsBool', UserAsBool);
    //
    FInspectorGrid.AddBoolProperty('Use ParentColor', UseParentColor);
    FInspectorGrid.AddColorProperty('BackColor', BackColor);
    //
    FInspectorGrid.AddGroupSeparator('Gradation');
    FInspectorGrid.AddBoolProperty('Use GradationEffect', UseGradationEffect);
    FInspectorGrid.AddIntProperty('Gradiation MaxValue', GradationMaxValue);
    FInspectorGrid.AddIntProperty('Gradiation MinValue', GradationMinValue);
    //FInspectorGrid.AddBoolProperty('Use MaxColor', UseMaxColor);
    FInspectorGrid.AddColorProperty('Gradiation MaxColor', GradationMaxColor);
    //FInspectorGrid.AddBoolProperty('Use MinColor', UseMinColor);
    FInspectorGrid.AddColorProperty('Gradiation MinColor', GradationMinColor);


    {
    GradiMax
    GradiMin
    CheckbmAXCOLOR
    EDITMAX  VALUE COLOR
    }
    FInspectorGrid.AutoSize();

  end;

  Result := ShowModal = mrOk;

  if Result then
    FInspectorGrid.ApplyProperties;

end;

end.
