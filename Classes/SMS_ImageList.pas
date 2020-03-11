unit SMS_ImageList;

interface

uses
  SysUtils, Controls, Menus, Graphics, Classes, SMS_DS, Globals,
  SMS_Files, Buttons;

type

  TImageItem = class(TCommonCollectionItem)
  end;

  TAppImageList = class
  private
    FImageList: TImageList;
    FImages : TCollection;
    FResDir: String;
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure AutoLoad(aPopupMenu : TPopupMenu);
    procedure LoadImages;
    procedure AutoLoadButtons(aList: array of TComponent);
    //
    property ResDir : String read FResDir write FResDir;
  end;


var

  gAppImageList : TAppImageList;

implementation



{ TAppImageList }

procedure TAppImageList.AutoLoad(aPopupMenu: TPopupMenu);
var
  i, k : Integer;
  aImage : TCommonCollectionItem;
  aMenu : TMenuItem;

    procedure SetImageIndex(aTargetMenu: TMenuItem; stCaption: String);
    var
      m : Integer;
    begin
      //
      for m := 0 to FImages.Count-1 do
      begin
        aImage := FImages.Items[m] as TImageItem;
        //
        if Pos(UpperCase(aImage.KeyByString), UpperCase(aTargetMenu.Caption)) > 0 then
        begin
          aTargetMenu.ImageIndex := m;
          Break;
        end;
      end;
      //
    end;

begin
  if FImageList = nil then Exit;
  //
  aPopupMenu.Images := FImageList;
  //
  for i := 0 to aPopupMenu.Items.Count-1 do
  begin
    aMenu := aPopupMenu.Items[i];
    aMenu.ImageIndex := -1;
    SetImageIndex(aMenu, aMenu.Caption);
    //
    for k := 0 to aMenu.Count-1 do
      SetImageIndex(aMenu.Items[k], aMenu.Items[k].Caption);
    //

    {
    for j := 0 to FImages.Count-1 do
    begin
      aImage := FImages.Items[j] as TImageItem;
      //
      if Pos(UpperCase(aImage.KeyByString), UpperCase(aMenu.Caption)) > 0 then
      begin
        aMenu.ImageIndex := j;
        Break;
      end;
    end;
    }
  end;

end;

procedure TAppImageList.AutoLoadButtons(aList: array of TComponent);
var
  i, j : Integer;
  aImage : TCommonCollectionItem;
  aButton : TSpeedButton;
begin
  if Length(aList) = 0 then Exit;
  //
  for i := 0 to Length(aList)-1 do
  begin
    if not (aList[i] is TSpeedButton) then continue;
    //
    aButton := TSpeedButton(aList[i]);
    //
    for j := 0 to FImages.Count-1 do
    begin
      aImage := FImages.Items[j] as TImageItem;
      if Pos(UpperCase(aImage.KeyByString), UpperCase(aButton.Name)) > 0 then
      begin
        FImageList.GetBitmap(j, aButton.Glyph);
        aButton.Caption := '';
        //
        Break;
      end;
    end;
    //
  end;

end;

constructor TAppImageList.Create;
begin
  FImages := TCommonCollection.Create(TImageItem);
  //
  FImageList := TImageList.Create(nil);

end;

destructor TAppImageList.Destroy;
begin
  FImageList.Free;
  FImages.Free;

  inherited;
end;

procedure TAppImageList.LoadImages;
var
  i : Integer;
  aFiles : TStringList;
  aBitmap : TBitmap;
  aImage : TImageItem;
begin
  if not DirectoryExists(FResDir{gResDir + IMAGE_DIR}) then Exit;
  //
  aFiles := TStringList.Create;
  aBitmap := TBitmap.Create;
  try
    GetFilesInDirectory(FResDir{gResDir + IMAGE_DIR}, 'bmp', aFiles);
    //
    for i := 0 to aFiles.Count-1 do
    begin
      aBitmap.LoadFromFile(aFiles[i]);
      FImageList.Add(aBitmap, nil);
      aImage := FImages.Add as TImageItem;
      aImage.KeyByString := ChangeFileExt(ExtractFileName(aFiles[i]), '');
    end;
  finally
    aBitmap.Free;
    aFiles.Free;
  end;


end;


initialization
  gAppImageList := TAppImageList.Create;

finalization
  gAppImageList.Free;

end.
