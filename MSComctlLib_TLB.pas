unit MSComctlLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2012-03-28 ¿ÀÀü 9:21:52 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\SysWOW64\MSCOMCTL.OCX (1)
// LIBID: {831FDD16-0C5C-11D2-A9FC-0000F8754DA1}
// LCID: 0
// Helpfile: C:\Windows\SysWOW64\cmctl198.chm
// HelpString: Microsoft Windows Common Controls 6.0 (SP6)
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, DBOleCtl, Graphics, OleCtrls, OleServer, StdVCL, 
Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MSComctlLibMajorVersion = 2;
  MSComctlLibMinorVersion = 0;

  LIBID_MSComctlLib: TGUID = '{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}';

  IID_IVBDataObject: TGUID = '{2334D2B1-713E-11CF-8AE5-00AA00C00905}';
  CLASS_DataObject: TGUID = '{2334D2B2-713E-11CF-8AE5-00AA00C00905}';
  IID_IVBDataObjectFiles: TGUID = '{2334D2B3-713E-11CF-8AE5-00AA00C00905}';
  CLASS_DataObjectFiles: TGUID = '{2334D2B4-713E-11CF-8AE5-00AA00C00905}';
  IID_ITabStrip: TGUID = '{1EFB6594-857C-11D1-B16A-00C0F0283628}';
  DIID_ITabStripEvents: TGUID = '{1EFB6595-857C-11D1-B16A-00C0F0283628}';
  CLASS_TabStrip: TGUID = '{1EFB6596-857C-11D1-B16A-00C0F0283628}';
  IID_ITabs: TGUID = '{1EFB6597-857C-11D1-B16A-00C0F0283628}';
  CLASS_Tabs: TGUID = '{1EFB6598-857C-11D1-B16A-00C0F0283628}';
  IID_ITab: TGUID = '{1EFB6599-857C-11D1-B16A-00C0F0283628}';
  CLASS_Tab: TGUID = '{1EFB659A-857C-11D1-B16A-00C0F0283628}';
  IID_IToolbar: TGUID = '{66833FE4-8583-11D1-B16A-00C0F0283628}';
  DIID_IToolbarEvents: TGUID = '{66833FE5-8583-11D1-B16A-00C0F0283628}';
  CLASS_Toolbar: TGUID = '{66833FE6-8583-11D1-B16A-00C0F0283628}';
  IID_IButtons: TGUID = '{66833FE7-8583-11D1-B16A-00C0F0283628}';
  CLASS_Buttons: TGUID = '{66833FE8-8583-11D1-B16A-00C0F0283628}';
  IID_IButton: TGUID = '{66833FE9-8583-11D1-B16A-00C0F0283628}';
  CLASS_Button: TGUID = '{66833FEA-8583-11D1-B16A-00C0F0283628}';
  IID_IButtonMenus: TGUID = '{66833FEB-8583-11D1-B16A-00C0F0283628}';
  CLASS_ButtonMenus: TGUID = '{66833FEC-8583-11D1-B16A-00C0F0283628}';
  IID_IButtonMenu: TGUID = '{66833FED-8583-11D1-B16A-00C0F0283628}';
  CLASS_ButtonMenu: TGUID = '{66833FEE-8583-11D1-B16A-00C0F0283628}';
  IID_IStatusBar: TGUID = '{8E3867A1-8586-11D1-B16A-00C0F0283628}';
  DIID_IStatusBarEvents: TGUID = '{8E3867A2-8586-11D1-B16A-00C0F0283628}';
  CLASS_StatusBar: TGUID = '{8E3867A3-8586-11D1-B16A-00C0F0283628}';
  IID_IPanels: TGUID = '{8E3867A4-8586-11D1-B16A-00C0F0283628}';
  CLASS_Panels: TGUID = '{8E3867A5-8586-11D1-B16A-00C0F0283628}';
  IID_IPanel: TGUID = '{8E3867AA-8586-11D1-B16A-00C0F0283628}';
  CLASS_Panel: TGUID = '{8E3867AB-8586-11D1-B16A-00C0F0283628}';
  IID_IProgressBar: TGUID = '{35053A20-8589-11D1-B16A-00C0F0283628}';
  DIID_IProgressBarEvents: TGUID = '{35053A21-8589-11D1-B16A-00C0F0283628}';
  CLASS_ProgressBar: TGUID = '{35053A22-8589-11D1-B16A-00C0F0283628}';
  IID_ITreeView: TGUID = '{C74190B4-8589-11D1-B16A-00C0F0283628}';
  DIID_ITreeViewEvents: TGUID = '{C74190B5-8589-11D1-B16A-00C0F0283628}';
  CLASS_TreeView: TGUID = '{C74190B6-8589-11D1-B16A-00C0F0283628}';
  IID_INodes: TGUID = '{C74190B7-8589-11D1-B16A-00C0F0283628}';
  CLASS_Nodes: TGUID = '{0713E8C0-850A-101B-AFC0-4210102A8DA7}';
  IID_INode: TGUID = '{C74190B8-8589-11D1-B16A-00C0F0283628}';
  CLASS_Node: TGUID = '{C74190B9-8589-11D1-B16A-00C0F0283628}';
  IID_IListView: TGUID = '{BDD1F049-858B-11D1-B16A-00C0F0283628}';
  DIID_ListViewEvents: TGUID = '{BDD1F04A-858B-11D1-B16A-00C0F0283628}';
  CLASS_ListView: TGUID = '{BDD1F04B-858B-11D1-B16A-00C0F0283628}';
  IID_IListItems: TGUID = '{BDD1F04C-858B-11D1-B16A-00C0F0283628}';
  CLASS_ListItems: TGUID = '{BDD1F04D-858B-11D1-B16A-00C0F0283628}';
  IID_IListItem: TGUID = '{BDD1F04E-858B-11D1-B16A-00C0F0283628}';
  CLASS_ListItem: TGUID = '{BDD1F04F-858B-11D1-B16A-00C0F0283628}';
  IID_IColumnHeaders: TGUID = '{BDD1F050-858B-11D1-B16A-00C0F0283628}';
  CLASS_ColumnHeaders: TGUID = '{0713E8C6-850A-101B-AFC0-4210102A8DA7}';
  IID_IColumnHeader: TGUID = '{BDD1F051-858B-11D1-B16A-00C0F0283628}';
  CLASS_ColumnHeader: TGUID = '{BDD1F052-858B-11D1-B16A-00C0F0283628}';
  IID_IListSubItems: TGUID = '{BDD1F053-858B-11D1-B16A-00C0F0283628}';
  CLASS_ListSubItems: TGUID = '{BDD1F054-858B-11D1-B16A-00C0F0283628}';
  IID_IListSubItem: TGUID = '{BDD1F055-858B-11D1-B16A-00C0F0283628}';
  CLASS_ListSubItem: TGUID = '{BDD1F056-858B-11D1-B16A-00C0F0283628}';
  IID_IImageList: TGUID = '{2C247F21-8591-11D1-B16A-00C0F0283628}';
  DIID_ImageListEvents: TGUID = '{2C247F22-8591-11D1-B16A-00C0F0283628}';
  CLASS_ImageList: TGUID = '{2C247F23-8591-11D1-B16A-00C0F0283628}';
  IID_IImages: TGUID = '{2C247F24-8591-11D1-B16A-00C0F0283628}';
  CLASS_ListImages: TGUID = '{2C247F25-8591-11D1-B16A-00C0F0283628}';
  IID_IImage: TGUID = '{2C247F26-8591-11D1-B16A-00C0F0283628}';
  CLASS_ListImage: TGUID = '{2C247F27-8591-11D1-B16A-00C0F0283628}';
  IID_ISlider: TGUID = '{F08DF952-8592-11D1-B16A-00C0F0283628}';
  DIID_ISliderEvents: TGUID = '{F08DF953-8592-11D1-B16A-00C0F0283628}';
  CLASS_Slider: TGUID = '{F08DF954-8592-11D1-B16A-00C0F0283628}';
  IID_IControls: TGUID = '{C8A3DC00-8593-11D1-B16A-00C0F0283628}';
  CLASS_Controls: TGUID = '{C8A3DC01-8593-11D1-B16A-00C0F0283628}';
  IID_IComboItem: TGUID = '{DD9DA660-8594-11D1-B16A-00C0F0283628}';
  CLASS_ComboItem: TGUID = '{DD9DA661-8594-11D1-B16A-00C0F0283628}';
  IID_IComboItems: TGUID = '{DD9DA662-8594-11D1-B16A-00C0F0283628}';
  CLASS_ComboItems: TGUID = '{DD9DA663-8594-11D1-B16A-00C0F0283628}';
  IID_IImageCombo: TGUID = '{DD9DA664-8594-11D1-B16A-00C0F0283628}';
  DIID_DImageComboEvents: TGUID = '{DD9DA665-8594-11D1-B16A-00C0F0283628}';
  CLASS_ImageCombo: TGUID = '{DD9DA666-8594-11D1-B16A-00C0F0283628}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum BorderStyleConstants
type
  BorderStyleConstants = TOleEnum;
const
  ccNone = $00000000;
  ccFixedSingle = $00000001;

// Constants for enum MousePointerConstants
type
  MousePointerConstants = TOleEnum;
const
  ccDefault = $00000000;
  ccArrow = $00000001;
  ccCross = $00000002;
  ccIBeam = $00000003;
  ccIcon = $00000004;
  ccSize = $00000005;
  ccSizeNESW = $00000006;
  ccSizeNS = $00000007;
  ccSizeNWSE = $00000008;
  ccSizeEW = $00000009;
  ccUpArrow = $0000000A;
  ccHourglass = $0000000B;
  ccNoDrop = $0000000C;
  ccArrowHourglass = $0000000D;
  ccArrowQuestion = $0000000E;
  ccSizeAll = $0000000F;
  ccCustom = $00000063;

// Constants for enum AppearanceConstants
type
  AppearanceConstants = TOleEnum;
const
  ccFlat = $00000000;
  cc3D = $00000001;

// Constants for enum VB4AppearanceConstants
type
  VB4AppearanceConstants = TOleEnum;
const
  vbFlat = $00000000;
  vb3D = $00000001;

// Constants for enum ScrollingConstants
type
  ScrollingConstants = TOleEnum;
const
  ccScrollingStandard = $00000000;
  ccScrollingSmooth = $00000001;

// Constants for enum OrientationConstants
type
  OrientationConstants = TOleEnum;
const
  ccOrientationHorizontal = $00000000;
  ccOrientationVertical = $00000001;

// Constants for enum OLEDragConstants
type
  OLEDragConstants = TOleEnum;
const
  ccOLEDragManual = $00000000;
  ccOLEDragAutomatic = $00000001;

// Constants for enum OLEDropConstants
type
  OLEDropConstants = TOleEnum;
const
  ccOLEDropNone = $00000000;
  ccOLEDropManual = $00000001;

// Constants for enum DragOverConstants
type
  DragOverConstants = TOleEnum;
const
  ccEnter = $00000000;
  ccLeave = $00000001;
  ccOver = $00000002;

// Constants for enum ClipBoardConstants
type
  ClipBoardConstants = TOleEnum;
const
  ccCFText = $00000001;
  ccCFBitmap = $00000002;
  ccCFMetafile = $00000003;
  ccCFDIB = $00000008;
  ccCFPalette = $00000009;
  ccCFEMetafile = $0000000E;
  ccCFFiles = $0000000F;
  ccCFRTF = $FFFFBF01;

// Constants for enum OLEDropEffectConstants
type
  OLEDropEffectConstants = TOleEnum;
const
  ccOLEDropEffectNone = $00000000;
  ccOLEDropEffectCopy = $00000001;
  ccOLEDropEffectMove = $00000002;
  ccOLEDropEffectScroll = $80000000;

// Constants for enum ErrorConstants
type
  ErrorConstants = TOleEnum;
const
  ccInvalidProcedureCall = $00000005;
  ccOutOfMemory = $00000007;
  ccTypeMismatch = $0000000D;
  ccObjectVariableNotSet = $0000005B;
  ccInvalidPropertyValue = $0000017C;
  ccSetNotSupportedAtRuntime = $0000017E;
  ccSetNotSupported = $0000017F;
  ccSetNotPermitted = $00000183;
  ccGetNotSupported = $0000018A;
  ccInvalidPicture = $000001E1;
  ccInvalidObjectUse = $000001A9;
  ccWrongClipboardFormat = $000001CD;
  ccDataObjectLocked = $000002A0;
  ccExpectedAnArgument = $000002A1;
  ccRecursiveOleDrag = $000002A2;
  ccFormatNotByteArray = $000002A3;
  ccDataNotSetForFormat = $000002A4;
  ccIndexOutOfBounds = $00008B10;
  ccElemNotFound = $00008B11;
  ccNonUniqueKey = $00008B12;
  ccInvalidKey = $00008B13;
  ccElemNotPartOfCollection = $00008B15;
  ccCollectionChangedDuringEnum = $00008B16;
  ccWouldIntroduceCycle = $00008B1E;
  ccMissingRequiredArg = $00008B17;
  ccBadObjectReference = $00008B1A;
  ccCircularReference = $00008B74;
  ccCol1MustBeLeftAligned = $00008B14;
  ccReadOnlyIfHasImages = $00008B1B;
  ccImageListMustBeInitialized = $00008B1D;
  ccNotSameSize = $00008B1F;
  ccImageListLocked = $00008B21;
  ccMaxPanelsExceeded = $00008B20;
  ccMaxButtonsExceeded = $00008B23;
  ccInvalidSafeModeProcCall = $000002A8;

// Constants for enum TabWidthStyleConstants
type
  TabWidthStyleConstants = TOleEnum;
const
  tabJustified = $00000000;
  tabNonJustified = $00000001;
  tabFixed = $00000002;

// Constants for enum TabStyleConstants
type
  TabStyleConstants = TOleEnum;
const
  tabTabs = $00000000;
  tabButtons = $00000001;
  tabFlatButtons = $00000002;

// Constants for enum PlacementConstants
type
  PlacementConstants = TOleEnum;
const
  tabPlacementTop = $00000000;
  tabPlacementBottom = $00000001;
  tabPlacementLeft = $00000002;
  tabPlacementRight = $00000003;

// Constants for enum TabSelStyleConstants
type
  TabSelStyleConstants = TOleEnum;
const
  tabTabStandard = $00000000;
  tabTabOpposite = $00000001;

// Constants for enum ButtonStyleConstants
type
  ButtonStyleConstants = TOleEnum;
const
  tbrDefault = $00000000;
  tbrCheck = $00000001;
  tbrButtonGroup = $00000002;
  tbrSeparator = $00000003;
  tbrPlaceholder = $00000004;
  tbrDropdown = $00000005;

// Constants for enum ValueConstants
type
  ValueConstants = TOleEnum;
const
  tbrUnpressed = $00000000;
  tbrPressed = $00000001;

// Constants for enum ToolbarStyleConstants
type
  ToolbarStyleConstants = TOleEnum;
const
  tbrStandard = $00000000;
  tbrFlat = $00000001;

// Constants for enum ToolbarTextAlignConstants
type
  ToolbarTextAlignConstants = TOleEnum;
const
  tbrTextAlignBottom = $00000000;
  tbrTextAlignRight = $00000001;

// Constants for enum SbarStyleConstants
type
  SbarStyleConstants = TOleEnum;
const
  sbrNormal = $00000000;
  sbrSimple = $00000001;

// Constants for enum PanelAlignmentConstants
type
  PanelAlignmentConstants = TOleEnum;
const
  sbrLeft = $00000000;
  sbrCenter = $00000001;
  sbrRight = $00000002;

// Constants for enum PanelAutoSizeConstants
type
  PanelAutoSizeConstants = TOleEnum;
const
  sbrNoAutoSize = $00000000;
  sbrSpring = $00000001;
  sbrContents = $00000002;

// Constants for enum PanelBevelConstants
type
  PanelBevelConstants = TOleEnum;
const
  sbrNoBevel = $00000000;
  sbrInset = $00000001;
  sbrRaised = $00000002;

// Constants for enum PanelStyleConstants
type
  PanelStyleConstants = TOleEnum;
const
  sbrText = $00000000;
  sbrCaps = $00000001;
  sbrNum = $00000002;
  sbrIns = $00000003;
  sbrScrl = $00000004;
  sbrTime = $00000005;
  sbrDate = $00000006;
  sbrKana = $00000007;

// Constants for enum LabelEditConstants
type
  LabelEditConstants = TOleEnum;
const
  tvwAutomatic = $00000000;
  tvwManual = $00000001;

// Constants for enum TreeLineStyleConstants
type
  TreeLineStyleConstants = TOleEnum;
const
  tvwTreeLines = $00000000;
  tvwRootLines = $00000001;

// Constants for enum TreeStyleConstants
type
  TreeStyleConstants = TOleEnum;
const
  tvwTextOnly = $00000000;
  tvwPictureText = $00000001;
  tvwPlusMinusText = $00000002;
  tvwPlusPictureText = $00000003;
  tvwTreelinesText = $00000004;
  tvwTreelinesPictureText = $00000005;
  tvwTreelinesPlusMinusText = $00000006;
  tvwTreelinesPlusMinusPictureText = $00000007;

// Constants for enum TreeRelationshipConstants
type
  TreeRelationshipConstants = TOleEnum;
const
  tvwFirst = $00000000;
  tvwLast = $00000001;
  tvwNext = $00000002;
  tvwPrevious = $00000003;
  tvwChild = $00000004;

// Constants for enum ListTextBackgroundConstants
type
  ListTextBackgroundConstants = TOleEnum;
const
  lvwTransparent = $00000000;
  lvwOpaque = $00000001;

// Constants for enum ListArrangeConstants
type
  ListArrangeConstants = TOleEnum;
const
  lvwNone = $00000000;
  lvwAutoLeft = $00000001;
  lvwAutoTop = $00000002;

// Constants for enum ListPictureAlignmentConstants
type
  ListPictureAlignmentConstants = TOleEnum;
const
  lvwTopLeft = $00000000;
  lvwTopRight = $00000001;
  lvwBottomLeft = $00000002;
  lvwBottomRight = $00000003;
  lvwCenter = $00000004;
  lvwTile = $00000005;

// Constants for enum ListLabelEditConstants
type
  ListLabelEditConstants = TOleEnum;
const
  lvwAutomatic = $00000000;
  lvwManual = $00000001;

// Constants for enum ListSortOrderConstants
type
  ListSortOrderConstants = TOleEnum;
const
  lvwAscending = $00000000;
  lvwDescending = $00000001;

// Constants for enum ListViewConstants
type
  ListViewConstants = TOleEnum;
const
  lvwIcon = $00000000;
  lvwSmallIcon = $00000001;
  lvwList = $00000002;
  lvwReport = $00000003;

// Constants for enum ListColumnAlignmentConstants
type
  ListColumnAlignmentConstants = TOleEnum;
const
  lvwColumnLeft = $00000000;
  lvwColumnRight = $00000001;
  lvwColumnCenter = $00000002;

// Constants for enum ListFindItemWhereConstants
type
  ListFindItemWhereConstants = TOleEnum;
const
  lvwText = $00000000;
  lvwSubItem = $00000001;
  lvwTag = $00000002;

// Constants for enum ListFindItemHowConstants
type
  ListFindItemHowConstants = TOleEnum;
const
  lvwWhole = $00000000;
  lvwPartial = $00000001;

// Constants for enum ImageDrawConstants
type
  ImageDrawConstants = TOleEnum;
const
  imlNormal = $00000000;
  imlTransparent = $00000001;
  imlSelected = $00000002;
  imlFocus = $00000003;

// Constants for enum TickStyleConstants
type
  TickStyleConstants = TOleEnum;
const
  sldBottomRight = $00000000;
  sldTopLeft = $00000001;
  sldBoth = $00000002;
  sldNoTicks = $00000003;

// Constants for enum TextPositionConstants
type
  TextPositionConstants = TOleEnum;
const
  sldAboveLeft = $00000000;
  sldBelowRight = $00000001;

// Constants for enum ImageComboStyleConstants
type
  ImageComboStyleConstants = TOleEnum;
const
  ImgCboDropdownCombo = $00000000;
  ImgCboSimpleCombo = $00000001;
  ImgCboDropdownList = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IVBDataObject = interface;
  IVBDataObjectDisp = dispinterface;
  IVBDataObjectFiles = interface;
  IVBDataObjectFilesDisp = dispinterface;
  ITabStrip = interface;
  ITabStripDisp = dispinterface;
  ITabStripEvents = dispinterface;
  ITabs = interface;
  ITabsDisp = dispinterface;
  ITab = interface;
  ITabDisp = dispinterface;
  IToolbar = interface;
  IToolbarDisp = dispinterface;
  IToolbarEvents = dispinterface;
  IButtons = interface;
  IButtonsDisp = dispinterface;
  IButton = interface;
  IButtonDisp = dispinterface;
  IButtonMenus = interface;
  IButtonMenusDisp = dispinterface;
  IButtonMenu = interface;
  IButtonMenuDisp = dispinterface;
  IStatusBar = interface;
  IStatusBarDisp = dispinterface;
  IStatusBarEvents = dispinterface;
  IPanels = interface;
  IPanelsDisp = dispinterface;
  IPanel = interface;
  IPanelDisp = dispinterface;
  IProgressBar = interface;
  IProgressBarDisp = dispinterface;
  IProgressBarEvents = dispinterface;
  ITreeView = interface;
  ITreeViewDisp = dispinterface;
  ITreeViewEvents = dispinterface;
  INodes = interface;
  INodesDisp = dispinterface;
  INode = interface;
  INodeDisp = dispinterface;
  IListView = interface;
  IListViewDisp = dispinterface;
  ListViewEvents = dispinterface;
  IListItems = interface;
  IListItemsDisp = dispinterface;
  IListItem = interface;
  IListItemDisp = dispinterface;
  IColumnHeaders = interface;
  IColumnHeadersDisp = dispinterface;
  IColumnHeader = interface;
  IColumnHeaderDisp = dispinterface;
  IListSubItems = interface;
  IListSubItemsDisp = dispinterface;
  IListSubItem = interface;
  IListSubItemDisp = dispinterface;
  IImageList = interface;
  IImageListDisp = dispinterface;
  ImageListEvents = dispinterface;
  IImages = interface;
  IImagesDisp = dispinterface;
  IImage = interface;
  IImageDisp = dispinterface;
  ISlider = interface;
  ISliderDisp = dispinterface;
  ISliderEvents = dispinterface;
  IControls = interface;
  IControlsDisp = dispinterface;
  IComboItem = interface;
  IComboItemDisp = dispinterface;
  IComboItems = interface;
  IComboItemsDisp = dispinterface;
  IImageCombo = interface;
  IImageComboDisp = dispinterface;
  DImageComboEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DataObject = IVBDataObject;
  DataObjectFiles = IVBDataObjectFiles;
  TabStrip = ITabStrip;
  Tabs = ITabs;
  Tab = ITab;
  Toolbar = IToolbar;
  Buttons = IButtons;
  Button = IButton;
  ButtonMenus = IButtonMenus;
  ButtonMenu = IButtonMenu;
  StatusBar = IStatusBar;
  Panels = IPanels;
  Panel = IPanel;
  ProgressBar = IProgressBar;
  TreeView = ITreeView;
  Nodes = INodes;
  Node = INode;
  ListView = IListView;
  ListItems = IListItems;
  ListItem = IListItem;
  ColumnHeaders = IColumnHeaders;
  ColumnHeader = IColumnHeader;
  ListSubItems = IListSubItems;
  ListSubItem = IListSubItem;
  ImageList = IImageList;
  ListImages = IImages;
  ListImage = IImage;
  Slider = ISlider;
  Controls = IControls;
  ComboItem = IComboItem;
  ComboItems = IComboItems;
  ImageCombo = IImageCombo;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PSmallint1 = ^Smallint; {*}
  PWideString1 = ^WideString; {*}


// *********************************************************************//
// Interface: IVBDataObject
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2334D2B1-713E-11CF-8AE5-00AA00C00905}
// *********************************************************************//
  IVBDataObject = interface(IDispatch)
    ['{2334D2B1-713E-11CF-8AE5-00AA00C00905}']
    procedure Clear; safecall;
    function GetData(sFormat: Smallint): OleVariant; safecall;
    function GetFormat(sFormat: Smallint): WordBool; safecall;
    procedure SetData(vValue: OleVariant; vFormat: OleVariant); safecall;
    function Get_Files: IVBDataObjectFiles; safecall;
    property Files: IVBDataObjectFiles read Get_Files;
  end;

// *********************************************************************//
// DispIntf:  IVBDataObjectDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2334D2B1-713E-11CF-8AE5-00AA00C00905}
// *********************************************************************//
  IVBDataObjectDisp = dispinterface
    ['{2334D2B1-713E-11CF-8AE5-00AA00C00905}']
    procedure Clear; dispid 1;
    function GetData(sFormat: Smallint): OleVariant; dispid 2;
    function GetFormat(sFormat: Smallint): WordBool; dispid 3;
    procedure SetData(vValue: OleVariant; vFormat: OleVariant); dispid 4;
    property Files: IVBDataObjectFiles readonly dispid 5;
  end;

// *********************************************************************//
// Interface: IVBDataObjectFiles
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2334D2B3-713E-11CF-8AE5-00AA00C00905}
// *********************************************************************//
  IVBDataObjectFiles = interface(IDispatch)
    ['{2334D2B3-713E-11CF-8AE5-00AA00C00905}']
    function Get_Item(lIndex: Integer): WideString; safecall;
    function Get_Count: Integer; safecall;
    procedure Add(const bstrFilename: WideString; vIndex: OleVariant); safecall;
    procedure Clear; safecall;
    procedure Remove(vIndex: OleVariant); safecall;
    function _NewEnum: IUnknown; safecall;
    property Item[lIndex: Integer]: WideString read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IVBDataObjectFilesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2334D2B3-713E-11CF-8AE5-00AA00C00905}
// *********************************************************************//
  IVBDataObjectFilesDisp = dispinterface
    ['{2334D2B3-713E-11CF-8AE5-00AA00C00905}']
    property Item[lIndex: Integer]: WideString readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    procedure Add(const bstrFilename: WideString; vIndex: OleVariant); dispid 2;
    procedure Clear; dispid 3;
    procedure Remove(vIndex: OleVariant); dispid 4;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: ITabStrip
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1EFB6594-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITabStrip = interface(IDispatch)
    ['{1EFB6594-857C-11D1-B16A-00C0F0283628}']
    function Get_Tabs: ITabs; safecall;
    procedure _Set_Tabs(const ppTabs: ITabs); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure _Set_Font(const ppFontDisp: IFontDisp); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_MultiRow: WordBool; safecall;
    procedure Set_MultiRow(pbMultiRow: WordBool); safecall;
    function Get_Style: TabStyleConstants; safecall;
    procedure Set_Style(psStyle: TabStyleConstants); safecall;
    function Get_TabFixedWidth: Smallint; safecall;
    procedure Set_TabFixedWidth(psTabFixedWidth: Smallint); safecall;
    function Get_TabWidthStyle: TabWidthStyleConstants; safecall;
    procedure Set_TabWidthStyle(psTabWidthStyle: TabWidthStyleConstants); safecall;
    function Get_ClientTop: Single; safecall;
    procedure Set_ClientTop(pfClientTop: Single); safecall;
    function Get_ClientLeft: Single; safecall;
    procedure Set_ClientLeft(pfClientLeft: Single); safecall;
    function Get_ClientHeight: Single; safecall;
    procedure Set_ClientHeight(pfClientHeight: Single); safecall;
    function Get_ClientWidth: Single; safecall;
    procedure Set_ClientWidth(pfClientWidth: Single); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(psMousePointer: MousePointerConstants); safecall;
    function Get_ImageList: IDispatch; safecall;
    procedure Set_ImageList(const ppImageList: IDispatch); safecall;
    procedure _Set_ImageList(const ppImageList: IDispatch); safecall;
    function Get_TabFixedHeight: Smallint; safecall;
    procedure Set_TabFixedHeight(psTabFixedHeight: Smallint); safecall;
    function Get_ShowTips: WordBool; safecall;
    procedure Set_ShowTips(pbShowTips: WordBool); safecall;
    function Get_SelectedItem: ITab; safecall;
    procedure _Set_SelectedItem(const ppSelectedItem: ITab); safecall;
    procedure Set_SelectedItem(var ppSelectedItem: OleVariant); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    procedure Refresh; safecall;
    procedure OLEDrag; safecall;
    procedure AboutBox; safecall;
    function Get_HotTracking: WordBool; safecall;
    procedure Set_HotTracking(pbHotTracking: WordBool); safecall;
    function Get_MultiSelect: WordBool; safecall;
    procedure Set_MultiSelect(pbMultiSelect: WordBool); safecall;
    function Get_Placement: PlacementConstants; safecall;
    procedure Set_Placement(penumPlacement: PlacementConstants); safecall;
    function Get_Separators: WordBool; safecall;
    procedure Set_Separators(pbSeparators: WordBool); safecall;
    function Get_TabMinWidth: Single; safecall;
    procedure Set_TabMinWidth(pflTabMinWidth: Single); safecall;
    function Get_TabStyle: TabSelStyleConstants; safecall;
    procedure Set_TabStyle(penumTabStyle: TabSelStyleConstants); safecall;
    procedure DeselectAll; safecall;
    property Tabs: ITabs read Get_Tabs write _Set_Tabs;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MultiRow: WordBool read Get_MultiRow write Set_MultiRow;
    property Style: TabStyleConstants read Get_Style write Set_Style;
    property TabFixedWidth: Smallint read Get_TabFixedWidth write Set_TabFixedWidth;
    property TabWidthStyle: TabWidthStyleConstants read Get_TabWidthStyle write Set_TabWidthStyle;
    property ClientTop: Single read Get_ClientTop write Set_ClientTop;
    property ClientLeft: Single read Get_ClientLeft write Set_ClientLeft;
    property ClientHeight: Single read Get_ClientHeight write Set_ClientHeight;
    property ClientWidth: Single read Get_ClientWidth write Set_ClientWidth;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property ImageList: IDispatch read Get_ImageList write Set_ImageList;
    property TabFixedHeight: Smallint read Get_TabFixedHeight write Set_TabFixedHeight;
    property ShowTips: WordBool read Get_ShowTips write Set_ShowTips;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property HotTracking: WordBool read Get_HotTracking write Set_HotTracking;
    property MultiSelect: WordBool read Get_MultiSelect write Set_MultiSelect;
    property Placement: PlacementConstants read Get_Placement write Set_Placement;
    property Separators: WordBool read Get_Separators write Set_Separators;
    property TabMinWidth: Single read Get_TabMinWidth write Set_TabMinWidth;
    property TabStyle: TabSelStyleConstants read Get_TabStyle write Set_TabStyle;
  end;

// *********************************************************************//
// DispIntf:  ITabStripDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1EFB6594-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITabStripDisp = dispinterface
    ['{1EFB6594-857C-11D1-B16A-00C0F0283628}']
    property Tabs: ITabs dispid 4;
    property Enabled: WordBool dispid -514;
    property Font: IFontDisp dispid -512;
    property hWnd: OLE_HANDLE dispid -515;
    property MouseIcon: IPictureDisp dispid 5;
    property MultiRow: WordBool dispid 1;
    property Style: TabStyleConstants dispid 6;
    property TabFixedWidth: Smallint dispid 7;
    property TabWidthStyle: TabWidthStyleConstants dispid 8;
    property ClientTop: Single dispid 9;
    property ClientLeft: Single dispid 10;
    property ClientHeight: Single dispid 11;
    property ClientWidth: Single dispid 12;
    property MousePointer: MousePointerConstants dispid 2;
    property ImageList: IDispatch dispid 13;
    property TabFixedHeight: Smallint dispid 14;
    property ShowTips: WordBool dispid 3;
    function SelectedItem: ITab; dispid 15;
    property OLEDropMode: OLEDropConstants dispid 1551;
    procedure Refresh; dispid -550;
    procedure OLEDrag; dispid 1552;
    procedure AboutBox; dispid -552;
    property HotTracking: WordBool dispid 16;
    property MultiSelect: WordBool dispid 17;
    property Placement: PlacementConstants dispid 18;
    property Separators: WordBool dispid 19;
    property TabMinWidth: Single dispid 20;
    property TabStyle: TabSelStyleConstants dispid 21;
    procedure DeselectAll; dispid 22;
  end;

// *********************************************************************//
// DispIntf:  ITabStripEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {1EFB6595-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITabStripEvents = dispinterface
    ['{1EFB6595-857C-11D1-B16A-00C0F0283628}']
    procedure Click; dispid -600;
    procedure KeyDown(var KeyCode: Smallint; Shift: Smallint); dispid -602;
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
    procedure KeyUp(var KeyCode: Smallint; Shift: Smallint); dispid -604;
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure BeforeClick(var Cancel: Smallint); dispid 1;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
  end;

// *********************************************************************//
// Interface: ITabs
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1EFB6597-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITabs = interface(IDispatch)
    ['{1EFB6597-857C-11D1-B16A-00C0F0283628}']
    function Get_Count: Smallint; safecall;
    procedure Set_Count(psCount: Smallint); safecall;
    function Get_ControlDefault(var pvIndex: OleVariant): ITab; safecall;
    procedure _Set_ControlDefault(var pvIndex: OleVariant; const ppTab: ITab); safecall;
    function Get_Item(var pvIndex: OleVariant): ITab; safecall;
    procedure _Set_Item(var pvIndex: OleVariant; const ppTab: ITab); safecall;
    procedure Remove(var pvIndex: OleVariant); safecall;
    procedure Clear; safecall;
    function Add(var pvIndex: OleVariant; var pvKey: OleVariant; var pvCaption: OleVariant; 
                 var pvImage: OleVariant): ITab; safecall;
    function _NewEnum: IDispatch; safecall;
    property Count: Smallint read Get_Count write Set_Count;
    property ControlDefault[var pvIndex: OleVariant]: ITab read Get_ControlDefault; default;
    property Item[var pvIndex: OleVariant]: ITab read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  ITabsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1EFB6597-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITabsDisp = dispinterface
    ['{1EFB6597-857C-11D1-B16A-00C0F0283628}']
    property Count: Smallint dispid 1;
    property ControlDefault[var pvIndex: OleVariant]: ITab dispid 0; default;
    property Item[var pvIndex: OleVariant]: ITab dispid 2;
    procedure Remove(var pvIndex: OleVariant); dispid 3;
    procedure Clear; dispid 4;
    function Add(var pvIndex: OleVariant; var pvKey: OleVariant; var pvCaption: OleVariant; 
                 var pvImage: OleVariant): ITab; dispid 5;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: ITab
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1EFB6599-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITab = interface(IDispatch)
    ['{1EFB6599-857C-11D1-B16A-00C0F0283628}']
    function Get__ObjectDefault: WideString; safecall;
    procedure Set__ObjectDefault(const pbstrCaption: WideString); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pbstrCaption: WideString); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Index: Smallint; safecall;
    procedure Set_Index(psIndex: Smallint); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_ToolTipText: WideString; safecall;
    procedure Set_ToolTipText(const pbstrToolTipText: WideString); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(pfWidth: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(pfHeight: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(pfTop: Single); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(pfLeft: Single); safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(pbSelected: WordBool); safecall;
    function Get_Image: OleVariant; safecall;
    procedure Set_Image(pvImage: OleVariant); safecall;
    function Get_HighLighted: WordBool; safecall;
    procedure Set_HighLighted(pbHighLighted: WordBool); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    property _ObjectDefault: WideString read Get__ObjectDefault write Set__ObjectDefault;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Index: Smallint read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property ToolTipText: WideString read Get_ToolTipText write Set_ToolTipText;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property Top: Single read Get_Top write Set_Top;
    property Left: Single read Get_Left write Set_Left;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property Image: OleVariant read Get_Image write Set_Image;
    property HighLighted: WordBool read Get_HighLighted write Set_HighLighted;
  end;

// *********************************************************************//
// DispIntf:  ITabDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1EFB6599-857C-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITabDisp = dispinterface
    ['{1EFB6599-857C-11D1-B16A-00C0F0283628}']
    property _ObjectDefault: WideString dispid 0;
    property Caption: WideString dispid 2;
    property Tag: OleVariant dispid 1;
    property Index: Smallint dispid 3;
    property Key: WideString dispid 4;
    property ToolTipText: WideString dispid 5;
    property Width: Single dispid 6;
    property Height: Single dispid 7;
    property Top: Single dispid 8;
    property Left: Single dispid 9;
    property Selected: WordBool dispid 10;
    property Image: OleVariant dispid 11;
    property HighLighted: WordBool dispid 12;
  end;

// *********************************************************************//
// Interface: IToolbar
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FE4-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IToolbar = interface(IDispatch)
    ['{66833FE4-8583-11D1-B16A-00C0F0283628}']
    function Get_Appearance: AppearanceConstants; safecall;
    procedure Set_Appearance(pnAppearance: AppearanceConstants); safecall;
    function Get_AllowCustomize: WordBool; safecall;
    procedure Set_AllowCustomize(pbAllowCustomize: WordBool); safecall;
    function Get_Buttons: IButtons; safecall;
    procedure _Set_Buttons(const ppButtons: IButtons); safecall;
    function Get_Controls: IControls; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(psMousePointer: MousePointerConstants); safecall;
    function Get_ImageList: IDispatch; safecall;
    procedure Set_ImageList(const ppImageList: IDispatch); safecall;
    procedure _Set_ImageList(const ppImageList: IDispatch); safecall;
    function Get_ShowTips: WordBool; safecall;
    procedure Set_ShowTips(bShowTips: WordBool); safecall;
    function Get_BorderStyle: BorderStyleConstants; safecall;
    procedure Set_BorderStyle(psBorderStyle: BorderStyleConstants); safecall;
    function Get_Wrappable: WordBool; safecall;
    procedure Set_Wrappable(pbWrappable: WordBool); safecall;
    function Get_ButtonHeight: Single; safecall;
    procedure Set_ButtonHeight(pfButtonHeight: Single); safecall;
    function Get_ButtonWidth: Single; safecall;
    procedure Set_ButtonWidth(pfButtonWidth: Single); safecall;
    function Get_HelpContextID: Integer; safecall;
    procedure Set_HelpContextID(plHelpContextID: Integer); safecall;
    function Get_HelpFile: WideString; safecall;
    procedure Set_HelpFile(const pbstrHelpFile: WideString); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    procedure Refresh; safecall;
    procedure Customize; safecall;
    procedure SaveToolbar(const Key: WideString; const Subkey: WideString; const Value: WideString); safecall;
    procedure RestoreToolbar(const Key: WideString; const Subkey: WideString; 
                             const Value: WideString); safecall;
    procedure OLEDrag; safecall;
    procedure AboutBox; safecall;
    function Get_DisabledImageList: IDispatch; safecall;
    procedure Set_DisabledImageList(const ppDisabledImageList: IDispatch); safecall;
    procedure _Set_DisabledImageList(const ppDisabledImageList: IDispatch); safecall;
    function Get_HotImageList: IDispatch; safecall;
    procedure Set_HotImageList(const ppHotImageList: IDispatch); safecall;
    procedure _Set_HotImageList(const ppHotImageList: IDispatch); safecall;
    function Get_Style: ToolbarStyleConstants; safecall;
    procedure Set_Style(penumStyle: ToolbarStyleConstants); safecall;
    function Get_TextAlignment: ToolbarTextAlignConstants; safecall;
    procedure Set_TextAlignment(penumTextAlignment: ToolbarTextAlignConstants); safecall;
    property Appearance: AppearanceConstants read Get_Appearance write Set_Appearance;
    property AllowCustomize: WordBool read Get_AllowCustomize write Set_AllowCustomize;
    property Buttons: IButtons read Get_Buttons write _Set_Buttons;
    property Controls: IControls read Get_Controls;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property ImageList: IDispatch read Get_ImageList write Set_ImageList;
    property ShowTips: WordBool read Get_ShowTips write Set_ShowTips;
    property BorderStyle: BorderStyleConstants read Get_BorderStyle write Set_BorderStyle;
    property Wrappable: WordBool read Get_Wrappable write Set_Wrappable;
    property ButtonHeight: Single read Get_ButtonHeight write Set_ButtonHeight;
    property ButtonWidth: Single read Get_ButtonWidth write Set_ButtonWidth;
    property HelpContextID: Integer read Get_HelpContextID write Set_HelpContextID;
    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property DisabledImageList: IDispatch read Get_DisabledImageList write Set_DisabledImageList;
    property HotImageList: IDispatch read Get_HotImageList write Set_HotImageList;
    property Style: ToolbarStyleConstants read Get_Style write Set_Style;
    property TextAlignment: ToolbarTextAlignConstants read Get_TextAlignment write Set_TextAlignment;
  end;

// *********************************************************************//
// DispIntf:  IToolbarDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FE4-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IToolbarDisp = dispinterface
    ['{66833FE4-8583-11D1-B16A-00C0F0283628}']
    property Appearance: AppearanceConstants dispid -520;
    property AllowCustomize: WordBool dispid 2;
    property Buttons: IButtons dispid 3;
    property Controls: IControls readonly dispid 15;
    property Enabled: WordBool dispid -514;
    property hWnd: OLE_HANDLE dispid -515;
    property MouseIcon: IPictureDisp dispid 4;
    property MousePointer: MousePointerConstants dispid 1;
    property ImageList: IDispatch dispid 5;
    property ShowTips: WordBool dispid 6;
    property BorderStyle: BorderStyleConstants dispid -504;
    property Wrappable: WordBool dispid 7;
    property ButtonHeight: Single dispid 8;
    property ButtonWidth: Single dispid 9;
    property HelpContextID: Integer dispid 13;
    property HelpFile: WideString dispid 14;
    property OLEDropMode: OLEDropConstants dispid 1551;
    procedure Refresh; dispid -550;
    procedure Customize; dispid 10;
    procedure SaveToolbar(const Key: WideString; const Subkey: WideString; const Value: WideString); dispid 11;
    procedure RestoreToolbar(const Key: WideString; const Subkey: WideString; 
                             const Value: WideString); dispid 12;
    procedure OLEDrag; dispid 1552;
    procedure AboutBox; dispid -552;
    property DisabledImageList: IDispatch dispid 17;
    property HotImageList: IDispatch dispid 18;
    property Style: ToolbarStyleConstants dispid 16;
    property TextAlignment: ToolbarTextAlignConstants dispid 19;
  end;

// *********************************************************************//
// DispIntf:  IToolbarEvents
// Flags:     (4096) Dispatchable
// GUID:      {66833FE5-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IToolbarEvents = dispinterface
    ['{66833FE5-8583-11D1-B16A-00C0F0283628}']
    procedure ButtonClick(const Button: Button); dispid 1;
    procedure Change; dispid 2;
    procedure Click; dispid -600;
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure DblClick; dispid -601;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
    procedure ButtonMenuClick(const ButtonMenu: ButtonMenu); dispid 3;
    procedure ButtonDropDown(const Button: Button); dispid 4;
  end;

// *********************************************************************//
// Interface: IButtons
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FE7-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtons = interface(IDispatch)
    ['{66833FE7-8583-11D1-B16A-00C0F0283628}']
    function Get_Count: Smallint; safecall;
    procedure Set_Count(psCount: Smallint); safecall;
    function Get_ControlDefault(var Index: OleVariant): IButton; safecall;
    procedure _Set_ControlDefault(var Index: OleVariant; const ppButton: IButton); safecall;
    function Get_Item(var Index: OleVariant): IButton; safecall;
    procedure _Set_Item(var Index: OleVariant; const ppButton: IButton); safecall;
    procedure Remove(var Index: OleVariant); safecall;
    procedure Clear; safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Caption: OleVariant; 
                 var Style: OleVariant; var Image: OleVariant): IButton; safecall;
    function _NewEnum: IDispatch; safecall;
    property Count: Smallint read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IButton read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IButton read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IButtonsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FE7-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtonsDisp = dispinterface
    ['{66833FE7-8583-11D1-B16A-00C0F0283628}']
    property Count: Smallint dispid 1;
    property ControlDefault[var Index: OleVariant]: IButton dispid 0; default;
    property Item[var Index: OleVariant]: IButton dispid 2;
    procedure Remove(var Index: OleVariant); dispid 3;
    procedure Clear; dispid 4;
    function Add(var Index: OleVariant; var Key: OleVariant; var Caption: OleVariant; 
                 var Style: OleVariant; var Image: OleVariant): IButton; dispid 5;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: IButton
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FE9-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButton = interface(IDispatch)
    ['{66833FE9-8583-11D1-B16A-00C0F0283628}']
    function Get__ObjectDefault: WideString; safecall;
    procedure Set__ObjectDefault(const pbstr_ObjectDefault: WideString); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pbstrCaption: WideString); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Index: Smallint; safecall;
    procedure Set_Index(psIndex: Smallint); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_ToolTipText: WideString; safecall;
    procedure Set_ToolTipText(const pbstrToolTipText: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pbVisible: WordBool); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(pfWidth: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(pfHeight: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(pfTop: Single); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(pfLeft: Single); safecall;
    function Get_Value: ValueConstants; safecall;
    procedure Set_Value(psValue: ValueConstants); safecall;
    function Get_Style: ButtonStyleConstants; safecall;
    procedure Set_Style(psStyle: ButtonStyleConstants); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const pbstrDescription: WideString); safecall;
    function Get_Image: OleVariant; safecall;
    procedure Set_Image(pvImage: OleVariant); safecall;
    function Get_MixedState: WordBool; safecall;
    procedure Set_MixedState(pbMixedState: WordBool); safecall;
    function Get_ButtonMenus: IButtonMenus; safecall;
    procedure _Set_ButtonMenus(const ppButtonMenus: IButtonMenus); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    property _ObjectDefault: WideString read Get__ObjectDefault write Set__ObjectDefault;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Index: Smallint read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property ToolTipText: WideString read Get_ToolTipText write Set_ToolTipText;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property Top: Single read Get_Top write Set_Top;
    property Left: Single read Get_Left write Set_Left;
    property Value: ValueConstants read Get_Value write Set_Value;
    property Style: ButtonStyleConstants read Get_Style write Set_Style;
    property Description: WideString read Get_Description write Set_Description;
    property Image: OleVariant read Get_Image write Set_Image;
    property MixedState: WordBool read Get_MixedState write Set_MixedState;
    property ButtonMenus: IButtonMenus read Get_ButtonMenus write _Set_ButtonMenus;
  end;

// *********************************************************************//
// DispIntf:  IButtonDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FE9-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtonDisp = dispinterface
    ['{66833FE9-8583-11D1-B16A-00C0F0283628}']
    property _ObjectDefault: WideString dispid 0;
    property Caption: WideString dispid 2;
    property Tag: OleVariant dispid 1;
    property Enabled: WordBool dispid 3;
    property Index: Smallint dispid 4;
    property Key: WideString dispid 5;
    property ToolTipText: WideString dispid 6;
    property Visible: WordBool dispid 7;
    property Width: Single dispid 8;
    property Height: Single dispid 9;
    property Top: Single dispid 10;
    property Left: Single dispid 11;
    property Value: ValueConstants dispid 12;
    property Style: ButtonStyleConstants dispid 13;
    property Description: WideString dispid 14;
    property Image: OleVariant dispid 15;
    property MixedState: WordBool dispid 16;
    property ButtonMenus: IButtonMenus dispid 17;
  end;

// *********************************************************************//
// Interface: IButtonMenus
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FEB-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtonMenus = interface(IDispatch)
    ['{66833FEB-8583-11D1-B16A-00C0F0283628}']
    function Get_Count: Smallint; safecall;
    procedure Set_Count(psCount: Smallint); safecall;
    function Get_ControlDefault(var Index: OleVariant): IButtonMenu; safecall;
    procedure _Set_ControlDefault(var Index: OleVariant; const ppButtonMenu: IButtonMenu); safecall;
    function Get_Item(var Index: OleVariant): IButtonMenu; safecall;
    procedure _Set_Item(var Index: OleVariant; const ppButtonMenu: IButtonMenu); safecall;
    procedure Remove(var Index: OleVariant); safecall;
    procedure Clear; safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant): IButtonMenu; safecall;
    function _NewEnum: IDispatch; safecall;
    property Count: Smallint read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IButtonMenu read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IButtonMenu read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IButtonMenusDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FEB-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtonMenusDisp = dispinterface
    ['{66833FEB-8583-11D1-B16A-00C0F0283628}']
    property Count: Smallint dispid 1;
    property ControlDefault[var Index: OleVariant]: IButtonMenu dispid 0; default;
    property Item[var Index: OleVariant]: IButtonMenu dispid 2;
    procedure Remove(var Index: OleVariant); dispid 3;
    procedure Clear; dispid 4;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant): IButtonMenu; dispid 5;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: IButtonMenu
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FED-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtonMenu = interface(IDispatch)
    ['{66833FED-8583-11D1-B16A-00C0F0283628}']
    function Get__ObjectDefault: WideString; safecall;
    procedure Set__ObjectDefault(const pbstrObjectDefault: WideString); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Index: Smallint; safecall;
    procedure Set_Index(psIndex: Smallint); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Parent: IButton; safecall;
    procedure _Set_Parent(const ppParent: IButton); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pbVisible: WordBool); safecall;
    property _ObjectDefault: WideString read Get__ObjectDefault write Set__ObjectDefault;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Index: Smallint read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Parent: IButton read Get_Parent write _Set_Parent;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Text: WideString read Get_Text write Set_Text;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  IButtonMenuDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {66833FED-8583-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IButtonMenuDisp = dispinterface
    ['{66833FED-8583-11D1-B16A-00C0F0283628}']
    property _ObjectDefault: WideString dispid 0;
    property Enabled: WordBool dispid 1;
    property Index: Smallint dispid 2;
    property Key: WideString dispid 3;
    property Parent: IButton dispid 4;
    property Tag: OleVariant dispid 5;
    property Text: WideString dispid 6;
    property Visible: WordBool dispid 7;
  end;

// *********************************************************************//
// Interface: IStatusBar
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E3867A1-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IStatusBar = interface(IDispatch)
    ['{8E3867A1-8586-11D1-B16A-00C0F0283628}']
    function Get_SimpleText: WideString; safecall;
    procedure Set_SimpleText(const pbstrSimpleText: WideString); safecall;
    function Get_Style: SbarStyleConstants; safecall;
    procedure Set_Style(psStyle: SbarStyleConstants); safecall;
    function Get_Panels: IPanels; safecall;
    procedure _Set_Panels(const ppPanels: IPanels); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(psMousePointer: MousePointerConstants); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_ShowTips: WordBool; safecall;
    procedure Set_ShowTips(bShowTips: WordBool); safecall;
    function Get_PanelProperties: WideString; safecall;
    procedure Set_PanelProperties(const pbstrPanelProperties: WideString); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure _Set_Font(const ppFont: IFontDisp); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    procedure Refresh; safecall;
    procedure OLEDrag; safecall;
    procedure AboutBox; safecall;
    property SimpleText: WideString read Get_SimpleText write Set_SimpleText;
    property Style: SbarStyleConstants read Get_Style write Set_Style;
    property Panels: IPanels read Get_Panels write _Set_Panels;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property ShowTips: WordBool read Get_ShowTips write Set_ShowTips;
    property PanelProperties: WideString read Get_PanelProperties write Set_PanelProperties;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
  end;

// *********************************************************************//
// DispIntf:  IStatusBarDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E3867A1-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IStatusBarDisp = dispinterface
    ['{8E3867A1-8586-11D1-B16A-00C0F0283628}']
    property SimpleText: WideString dispid 1;
    property Style: SbarStyleConstants dispid 2;
    property Panels: IPanels dispid 3;
    property MousePointer: MousePointerConstants dispid 4;
    property MouseIcon: IPictureDisp dispid 5;
    property ShowTips: WordBool dispid 7;
    property PanelProperties: WideString dispid 6;
    property OLEDropMode: OLEDropConstants dispid 1551;
    property Enabled: WordBool dispid -514;
    property Font: IFontDisp dispid -512;
    property hWnd: OLE_HANDLE dispid -515;
    procedure Refresh; dispid -550;
    procedure OLEDrag; dispid 1552;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  IStatusBarEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {8E3867A2-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IStatusBarEvents = dispinterface
    ['{8E3867A2-8586-11D1-B16A-00C0F0283628}']
    procedure PanelClick(const Panel: Panel); dispid 1;
    procedure PanelDblClick(const Panel: Panel); dispid 2;
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure Click; dispid -600;
    procedure DblClick; dispid -601;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
  end;

// *********************************************************************//
// Interface: IPanels
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E3867A4-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IPanels = interface(IDispatch)
    ['{8E3867A4-8586-11D1-B16A-00C0F0283628}']
    function Get_Count: Smallint; safecall;
    procedure Set_Count(sCount: Smallint); safecall;
    function Get_ControlDefault(var Index: OleVariant): IPanel; safecall;
    procedure _Set_ControlDefault(var Index: OleVariant; const ppPanel: IPanel); safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Style: OleVariant; var Picture: OleVariant): IPanel; safecall;
    procedure Clear; safecall;
    function Get_Item(var Index: OleVariant): IPanel; safecall;
    procedure _Set_Item(var Index: OleVariant; const ppPanel: IPanel); safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IDispatch; safecall;
    property Count: Smallint read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IPanel read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IPanel read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IPanelsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E3867A4-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IPanelsDisp = dispinterface
    ['{8E3867A4-8586-11D1-B16A-00C0F0283628}']
    property Count: Smallint dispid 1;
    property ControlDefault[var Index: OleVariant]: IPanel dispid 0; default;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Style: OleVariant; var Picture: OleVariant): IPanel; dispid 2;
    procedure Clear; dispid 3;
    property Item[var Index: OleVariant]: IPanel dispid 4;
    procedure Remove(var Index: OleVariant); dispid 5;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: IPanel
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E3867AA-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IPanel = interface(IDispatch)
    ['{8E3867AA-8586-11D1-B16A-00C0F0283628}']
    function Get__ObjectDefault: WideString; safecall;
    procedure Set__ObjectDefault(const pbstrText: WideString); safecall;
    function Get_Alignment: PanelAlignmentConstants; safecall;
    procedure Set_Alignment(psAlignment: PanelAlignmentConstants); safecall;
    function Get_AutoSize: PanelAutoSizeConstants; safecall;
    procedure Set_AutoSize(psAutoSize: PanelAutoSizeConstants); safecall;
    function Get_Bevel: PanelBevelConstants; safecall;
    procedure Set_Bevel(psBevel: PanelBevelConstants); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Index: Smallint; safecall;
    procedure Set_Index(sIndex: Smallint); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(pfLeft: Single); safecall;
    function Get_MinWidth: Single; safecall;
    procedure Set_MinWidth(pfMinWidth: Single); safecall;
    function Get_Picture: IPictureDisp; safecall;
    procedure _Set_Picture(const ppPicture: IPictureDisp); safecall;
    function Get_Style: PanelStyleConstants; safecall;
    procedure Set_Style(psStyle: PanelStyleConstants); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_ToolTipText: WideString; safecall;
    procedure Set_ToolTipText(const pbstrToolTipText: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pbVisible: WordBool); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(pfWidth: Single); safecall;
    procedure Set_Picture(const ppPicture: IPictureDisp); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    property _ObjectDefault: WideString read Get__ObjectDefault write Set__ObjectDefault;
    property Alignment: PanelAlignmentConstants read Get_Alignment write Set_Alignment;
    property AutoSize: PanelAutoSizeConstants read Get_AutoSize write Set_AutoSize;
    property Bevel: PanelBevelConstants read Get_Bevel write Set_Bevel;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Index: Smallint read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Left: Single read Get_Left write Set_Left;
    property MinWidth: Single read Get_MinWidth write Set_MinWidth;
    property Picture: IPictureDisp read Get_Picture write Set_Picture;
    property Style: PanelStyleConstants read Get_Style write Set_Style;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Text: WideString read Get_Text write Set_Text;
    property ToolTipText: WideString read Get_ToolTipText write Set_ToolTipText;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Width: Single read Get_Width write Set_Width;
  end;

// *********************************************************************//
// DispIntf:  IPanelDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E3867AA-8586-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IPanelDisp = dispinterface
    ['{8E3867AA-8586-11D1-B16A-00C0F0283628}']
    property _ObjectDefault: WideString dispid 0;
    property Alignment: PanelAlignmentConstants dispid 1;
    property AutoSize: PanelAutoSizeConstants dispid 2;
    property Bevel: PanelBevelConstants dispid 3;
    property Enabled: WordBool dispid 4;
    property Index: Smallint dispid 5;
    property Key: WideString dispid 6;
    property Left: Single dispid 7;
    property MinWidth: Single dispid 8;
    property Picture: IPictureDisp dispid 9;
    property Style: PanelStyleConstants dispid 10;
    property Tag: OleVariant dispid 14;
    property Text: WideString dispid 11;
    property ToolTipText: WideString dispid 15;
    property Visible: WordBool dispid 12;
    property Width: Single dispid 13;
  end;

// *********************************************************************//
// Interface: IProgressBar
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {35053A20-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IProgressBar = interface(IDispatch)
    ['{35053A20-8589-11D1-B16A-00C0F0283628}']
    function Get_ControlDefault: Single; safecall;
    procedure Set_ControlDefault(pfValue: Single); safecall;
    function Get_Max: Single; safecall;
    procedure Set_Max(pfMax: Single); safecall;
    function Get_Min: Single; safecall;
    procedure Set_Min(pfMin: Single); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(pMousePointers: MousePointerConstants); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure _Set_MouseIcon(const ppPictureDisp: IPictureDisp); safecall;
    procedure Set_MouseIcon(const ppPictureDisp: IPictureDisp); safecall;
    function Get_Value: Single; safecall;
    procedure Set_Value(pfValue: Single); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    function Get_Appearance: AppearanceConstants; safecall;
    procedure Set_Appearance(penumAppearances: AppearanceConstants); safecall;
    function Get_BorderStyle: BorderStyleConstants; safecall;
    procedure Set_BorderStyle(penumBorderStyles: BorderStyleConstants); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(bEnabled: WordBool); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure OLEDrag; safecall;
    procedure AboutBox; safecall;
    function Get_Orientation: OrientationConstants; safecall;
    procedure Set_Orientation(penumOrientation: OrientationConstants); safecall;
    function Get_Scrolling: ScrollingConstants; safecall;
    procedure Set_Scrolling(penumScrolling: ScrollingConstants); safecall;
    procedure Refresh; safecall;
    property ControlDefault: Single read Get_ControlDefault write Set_ControlDefault;
    property Max: Single read Get_Max write Set_Max;
    property Min: Single read Get_Min write Set_Min;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property Value: Single read Get_Value write Set_Value;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property Appearance: AppearanceConstants read Get_Appearance write Set_Appearance;
    property BorderStyle: BorderStyleConstants read Get_BorderStyle write Set_BorderStyle;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property hWnd: OLE_HANDLE read Get_hWnd;
    property Orientation: OrientationConstants read Get_Orientation write Set_Orientation;
    property Scrolling: ScrollingConstants read Get_Scrolling write Set_Scrolling;
  end;

// *********************************************************************//
// DispIntf:  IProgressBarDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {35053A20-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IProgressBarDisp = dispinterface
    ['{35053A20-8589-11D1-B16A-00C0F0283628}']
    property ControlDefault: Single dispid 0;
    property Max: Single dispid 1;
    property Min: Single dispid 2;
    property MousePointer: MousePointerConstants dispid 3;
    property MouseIcon: IPictureDisp dispid 4;
    property Value: Single dispid 5;
    property OLEDropMode: OLEDropConstants dispid 1551;
    property Appearance: AppearanceConstants dispid -520;
    property BorderStyle: BorderStyleConstants dispid -504;
    property Enabled: WordBool dispid -514;
    property hWnd: OLE_HANDLE readonly dispid -515;
    procedure OLEDrag; dispid 1552;
    procedure AboutBox; dispid -552;
    property Orientation: OrientationConstants dispid 6;
    property Scrolling: ScrollingConstants dispid 7;
    procedure Refresh; dispid -550;
  end;

// *********************************************************************//
// DispIntf:  IProgressBarEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {35053A21-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IProgressBarEvents = dispinterface
    ['{35053A21-8589-11D1-B16A-00C0F0283628}']
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure Click; dispid -600;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
  end;

// *********************************************************************//
// Interface: ITreeView
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C74190B4-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITreeView = interface(IDispatch)
    ['{C74190B4-8589-11D1-B16A-00C0F0283628}']
    function Get_DropHighlight: INode; safecall;
    procedure _Set_DropHighlight(const ppNode: INode); safecall;
    procedure Set_DropHighlight(var ppNode: OleVariant); safecall;
    function Get_HideSelection: WordBool; safecall;
    procedure Set_HideSelection(pbHideSelection: WordBool); safecall;
    function Get_ImageList: IDispatch; safecall;
    procedure _Set_ImageList(const ppImageList: IDispatch); safecall;
    procedure Set_ImageList(const ppImageList: IDispatch); safecall;
    function Get_Indentation: Single; safecall;
    procedure Set_Indentation(pfIndentation: Single); safecall;
    function Get_LabelEdit: LabelEditConstants; safecall;
    procedure Set_LabelEdit(psLabelEdit: LabelEditConstants); safecall;
    function Get_LineStyle: TreeLineStyleConstants; safecall;
    procedure Set_LineStyle(psLineStyle: TreeLineStyleConstants); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(psMousePointer: MousePointerConstants); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_Nodes: INodes; safecall;
    procedure _Set_Nodes(const ppNode: INodes); safecall;
    function Get_PathSeparator: WideString; safecall;
    procedure Set_PathSeparator(const pbstrPathSeparator: WideString); safecall;
    function Get_SelectedItem: INode; safecall;
    procedure _Set_SelectedItem(const ppNode: INode); safecall;
    procedure Set_SelectedItem(var ppNode: OleVariant); safecall;
    function Get_Sorted: WordBool; safecall;
    procedure Set_Sorted(pbSorted: WordBool); safecall;
    function Get_Style: TreeStyleConstants; safecall;
    procedure Set_Style(psStyle: TreeStyleConstants); safecall;
    function Get_OLEDragMode: OLEDragConstants; safecall;
    procedure Set_OLEDragMode(psOLEDragMode: OLEDragConstants); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    function Get_Appearance: AppearanceConstants; safecall;
    procedure Set_Appearance(psAppearance: AppearanceConstants); safecall;
    function Get_BorderStyle: BorderStyleConstants; safecall;
    procedure Set_BorderStyle(psBorderStyle: BorderStyleConstants); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const ppFont: IFontDisp); safecall;
    procedure _Set_Font(const ppFont: IFontDisp); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    function HitTest(x: Single; y: Single): INode; safecall;
    function GetVisibleCount: Integer; safecall;
    procedure StartLabelEdit; safecall;
    procedure Refresh; safecall;
    procedure AboutBox; safecall;
    procedure OLEDrag; safecall;
    function Get_Checkboxes: WordBool; safecall;
    procedure Set_Checkboxes(pbCheckboxes: WordBool); safecall;
    function Get_FullRowSelect: WordBool; safecall;
    procedure Set_FullRowSelect(pbFullRowSelect: WordBool); safecall;
    function Get_HotTracking: WordBool; safecall;
    procedure Set_HotTracking(pbHotTracking: WordBool); safecall;
    function Get_Scroll: WordBool; safecall;
    procedure Set_Scroll(pbScroll: WordBool); safecall;
    function Get_SingleSel: WordBool; safecall;
    procedure Set_SingleSel(pbSingleSel: WordBool); safecall;
    property HideSelection: WordBool read Get_HideSelection write Set_HideSelection;
    property ImageList: IDispatch read Get_ImageList write Set_ImageList;
    property Indentation: Single read Get_Indentation write Set_Indentation;
    property LabelEdit: LabelEditConstants read Get_LabelEdit write Set_LabelEdit;
    property LineStyle: TreeLineStyleConstants read Get_LineStyle write Set_LineStyle;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property Nodes: INodes read Get_Nodes write _Set_Nodes;
    property PathSeparator: WideString read Get_PathSeparator write Set_PathSeparator;
    property Sorted: WordBool read Get_Sorted write Set_Sorted;
    property Style: TreeStyleConstants read Get_Style write Set_Style;
    property OLEDragMode: OLEDragConstants read Get_OLEDragMode write Set_OLEDragMode;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property Appearance: AppearanceConstants read Get_Appearance write Set_Appearance;
    property BorderStyle: BorderStyleConstants read Get_BorderStyle write Set_BorderStyle;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write Set_Font;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
    property Checkboxes: WordBool read Get_Checkboxes write Set_Checkboxes;
    property FullRowSelect: WordBool read Get_FullRowSelect write Set_FullRowSelect;
    property HotTracking: WordBool read Get_HotTracking write Set_HotTracking;
    property Scroll: WordBool read Get_Scroll write Set_Scroll;
    property SingleSel: WordBool read Get_SingleSel write Set_SingleSel;
  end;

// *********************************************************************//
// DispIntf:  ITreeViewDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C74190B4-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITreeViewDisp = dispinterface
    ['{C74190B4-8589-11D1-B16A-00C0F0283628}']
    function DropHighlight: INode; dispid 1;
    property HideSelection: WordBool dispid 2;
    property ImageList: IDispatch dispid 3;
    property Indentation: Single dispid 4;
    property LabelEdit: LabelEditConstants dispid 5;
    property LineStyle: TreeLineStyleConstants dispid 6;
    property MousePointer: MousePointerConstants dispid 7;
    property MouseIcon: IPictureDisp dispid 8;
    property Nodes: INodes dispid 9;
    property PathSeparator: WideString dispid 10;
    function SelectedItem: INode; dispid 11;
    property Sorted: WordBool dispid 12;
    property Style: TreeStyleConstants dispid 13;
    property OLEDragMode: OLEDragConstants dispid 1550;
    property OLEDropMode: OLEDropConstants dispid 1551;
    property Appearance: AppearanceConstants dispid -520;
    property BorderStyle: BorderStyleConstants dispid -504;
    property Enabled: WordBool dispid -514;
    property Font: IFontDisp dispid -512;
    property hWnd: OLE_HANDLE dispid -515;
    function HitTest(x: Single; y: Single): INode; dispid 14;
    function GetVisibleCount: Integer; dispid 15;
    procedure StartLabelEdit; dispid 16;
    procedure Refresh; dispid -550;
    procedure AboutBox; dispid -552;
    procedure OLEDrag; dispid 1552;
    property Checkboxes: WordBool dispid 17;
    property FullRowSelect: WordBool dispid 18;
    property HotTracking: WordBool dispid 19;
    property Scroll: WordBool dispid 20;
    property SingleSel: WordBool dispid 21;
  end;

// *********************************************************************//
// DispIntf:  ITreeViewEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {C74190B5-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ITreeViewEvents = dispinterface
    ['{C74190B5-8589-11D1-B16A-00C0F0283628}']
    procedure BeforeLabelEdit(var Cancel: Smallint); dispid 1;
    procedure AfterLabelEdit(var Cancel: Smallint; var NewString: WideString); dispid 2;
    procedure Collapse(const Node: Node); dispid 3;
    procedure Expand(const Node: Node); dispid 4;
    procedure NodeClick(const Node: Node); dispid 5;
    procedure KeyDown(var KeyCode: Smallint; Shift: Smallint); dispid -602;
    procedure KeyUp(var KeyCode: Smallint; Shift: Smallint); dispid -604;
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure Click; dispid -600;
    procedure DblClick; dispid -601;
    procedure NodeCheck(const Node: Node); dispid 6;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
  end;

// *********************************************************************//
// Interface: INodes
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C74190B7-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  INodes = interface(IDispatch)
    ['{C74190B7-8589-11D1-B16A-00C0F0283628}']
    function Get_Count: Smallint; safecall;
    procedure Set_Count(psCount: Smallint); safecall;
    function Get_ControlDefault(var Index: OleVariant): INode; safecall;
    procedure Set_ControlDefault(var Index: OleVariant; const ppNode: INode); safecall;
    function Add(var Relative: OleVariant; var Relationship: OleVariant; var Key: OleVariant; 
                 var Text: OleVariant; var Image: OleVariant; var SelectedImage: OleVariant): INode; safecall;
    procedure Clear; safecall;
    function Get_Item(var Index: OleVariant): INode; safecall;
    procedure Set_Item(var Index: OleVariant; const ppNode: INode); safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IDispatch; safecall;
    property Count: Smallint read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: INode read Get_ControlDefault write Set_ControlDefault; default;
    property Item[var Index: OleVariant]: INode read Get_Item write Set_Item;
  end;

// *********************************************************************//
// DispIntf:  INodesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C74190B7-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  INodesDisp = dispinterface
    ['{C74190B7-8589-11D1-B16A-00C0F0283628}']
    property Count: Smallint dispid 1;
    property ControlDefault[var Index: OleVariant]: INode dispid 0; default;
    function Add(var Relative: OleVariant; var Relationship: OleVariant; var Key: OleVariant; 
                 var Text: OleVariant; var Image: OleVariant; var SelectedImage: OleVariant): INode; dispid 2;
    procedure Clear; dispid 3;
    property Item[var Index: OleVariant]: INode dispid 4;
    procedure Remove(var Index: OleVariant); dispid 5;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: INode
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C74190B8-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  INode = interface(IDispatch)
    ['{C74190B8-8589-11D1-B16A-00C0F0283628}']
    function Get__ObjectDefault: WideString; safecall;
    procedure Set__ObjectDefault(const pbstrText: WideString); safecall;
    function Get_Child: INode; safecall;
    procedure _Set_Child(const ppChild: INode); safecall;
    function Get_Children: Smallint; safecall;
    procedure Set_Children(psChildren: Smallint); safecall;
    function Get_Expanded: WordBool; safecall;
    procedure Set_Expanded(pbExpanded: WordBool); safecall;
    function Get_ExpandedImage: OleVariant; safecall;
    procedure Set_ExpandedImage(pExpandedImage: OleVariant); safecall;
    function Get_FirstSibling: INode; safecall;
    procedure _Set_FirstSibling(const ppFirstSibling: INode); safecall;
    function Get_FullPath: WideString; safecall;
    procedure Set_FullPath(const pbstrFullPath: WideString); safecall;
    function Get_Image: OleVariant; safecall;
    procedure Set_Image(pImage: OleVariant); safecall;
    function Get_Index: Smallint; safecall;
    procedure Set_Index(psIndex: Smallint); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_LastSibling: INode; safecall;
    procedure _Set_LastSibling(const ppLastSibling: INode); safecall;
    function Get_Next: INode; safecall;
    procedure _Set_Next(const ppNext: INode); safecall;
    function Get_Parent: INode; safecall;
    procedure _Set_Parent(const ppParent: INode); safecall;
    function Get_Previous: INode; safecall;
    procedure _Set_Previous(const ppPrevious: INode); safecall;
    function Get_Root: INode; safecall;
    procedure _Set_Root(const ppRoot: INode); safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(pbSelected: WordBool); safecall;
    function Get_SelectedImage: OleVariant; safecall;
    procedure Set_SelectedImage(pSelectedImage: OleVariant); safecall;
    function Get_Sorted: WordBool; safecall;
    procedure Set_Sorted(pbSorted: WordBool); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const bstrText: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pbVisible: WordBool); safecall;
    function CreateDragImage: IPictureDisp; safecall;
    function EnsureVisible: WordBool; safecall;
    function Get_BackColor: OLE_COLOR; safecall;
    procedure Set_BackColor(pocBackColor: OLE_COLOR); safecall;
    function Get_Bold: WordBool; safecall;
    procedure Set_Bold(pbBold: WordBool); safecall;
    function Get_Checked: WordBool; safecall;
    procedure Set_Checked(pbChecked: WordBool); safecall;
    function Get_ForeColor: OLE_COLOR; safecall;
    procedure Set_ForeColor(pocForeColor: OLE_COLOR); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    property _ObjectDefault: WideString read Get__ObjectDefault write Set__ObjectDefault;
    property Child: INode read Get_Child write _Set_Child;
    property Children: Smallint read Get_Children write Set_Children;
    property Expanded: WordBool read Get_Expanded write Set_Expanded;
    property ExpandedImage: OleVariant read Get_ExpandedImage write Set_ExpandedImage;
    property FirstSibling: INode read Get_FirstSibling write _Set_FirstSibling;
    property FullPath: WideString read Get_FullPath write Set_FullPath;
    property Image: OleVariant read Get_Image write Set_Image;
    property Index: Smallint read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property LastSibling: INode read Get_LastSibling write _Set_LastSibling;
    property Next: INode read Get_Next write _Set_Next;
    property Parent: INode read Get_Parent write _Set_Parent;
    property Previous: INode read Get_Previous write _Set_Previous;
    property Root: INode read Get_Root write _Set_Root;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property SelectedImage: OleVariant read Get_SelectedImage write Set_SelectedImage;
    property Sorted: WordBool read Get_Sorted write Set_Sorted;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Text: WideString read Get_Text write Set_Text;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property Bold: WordBool read Get_Bold write Set_Bold;
    property Checked: WordBool read Get_Checked write Set_Checked;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
  end;

// *********************************************************************//
// DispIntf:  INodeDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C74190B8-8589-11D1-B16A-00C0F0283628}
// *********************************************************************//
  INodeDisp = dispinterface
    ['{C74190B8-8589-11D1-B16A-00C0F0283628}']
    property _ObjectDefault: WideString dispid 0;
    property Child: INode dispid 1;
    property Children: Smallint dispid 2;
    property Expanded: WordBool dispid 3;
    property ExpandedImage: OleVariant dispid 4;
    property FirstSibling: INode dispid 5;
    property FullPath: WideString dispid 6;
    property Image: OleVariant dispid 7;
    property Index: Smallint dispid 8;
    property Key: WideString dispid 9;
    property LastSibling: INode dispid 10;
    property Next: INode dispid 11;
    property Parent: INode dispid 12;
    property Previous: INode dispid 13;
    property Root: INode dispid 14;
    property Selected: WordBool dispid 15;
    property SelectedImage: OleVariant dispid 16;
    property Sorted: WordBool dispid 17;
    property Tag: OleVariant dispid 18;
    property Text: WideString dispid 19;
    property Visible: WordBool dispid 20;
    function CreateDragImage: IPictureDisp; dispid 21;
    function EnsureVisible: WordBool; dispid 22;
    property BackColor: OLE_COLOR dispid 23;
    property Bold: WordBool dispid 24;
    property Checked: WordBool dispid 25;
    property ForeColor: OLE_COLOR dispid 26;
  end;

// *********************************************************************//
// Interface: IListView
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F049-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListView = interface(IDispatch)
    ['{BDD1F049-858B-11D1-B16A-00C0F0283628}']
    function Get_Arrange: ListArrangeConstants; safecall;
    procedure Set_Arrange(pArrange: ListArrangeConstants); safecall;
    function Get_ColumnHeaders: IColumnHeaders; safecall;
    procedure Set_ColumnHeaders(const ppIColumnHeaders: IColumnHeaders); safecall;
    function Get_DropHighlight: IListItem; safecall;
    procedure _Set_DropHighlight(const ppIListItem: IListItem); safecall;
    procedure Set_DropHighlight(var ppIListItem: OleVariant); safecall;
    function Get_HideColumnHeaders: WordBool; safecall;
    procedure Set_HideColumnHeaders(pfHide: WordBool); safecall;
    function Get_HideSelection: WordBool; safecall;
    procedure Set_HideSelection(pfHide: WordBool); safecall;
    function Get_Icons: IDispatch; safecall;
    procedure _Set_Icons(const ppIcons: IDispatch); safecall;
    procedure Set_Icons(const ppIcons: IDispatch); safecall;
    function Get_ListItems: IListItems; safecall;
    procedure Set_ListItems(const ppListItems: IListItems); safecall;
    function Get_LabelEdit: ListLabelEditConstants; safecall;
    procedure Set_LabelEdit(pRet: ListLabelEditConstants); safecall;
    function Get_LabelWrap: WordBool; safecall;
    procedure Set_LabelWrap(pfOn: WordBool); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(pnIndex: MousePointerConstants); safecall;
    function Get_MultiSelect: WordBool; safecall;
    procedure Set_MultiSelect(pfOn: WordBool); safecall;
    function Get_SelectedItem: IListItem; safecall;
    procedure _Set_SelectedItem(const ppListItem: IListItem); safecall;
    procedure Set_SelectedItem(var ppListItem: OleVariant); safecall;
    function Get_SmallIcons: IDispatch; safecall;
    procedure _Set_SmallIcons(const ppImageList: IDispatch); safecall;
    procedure Set_SmallIcons(const ppImageList: IDispatch); safecall;
    function Get_Sorted: WordBool; safecall;
    procedure Set_Sorted(pfOn: WordBool); safecall;
    function Get_SortKey: Smallint; safecall;
    procedure Set_SortKey(psKey: Smallint); safecall;
    function Get_SortOrder: ListSortOrderConstants; safecall;
    procedure Set_SortOrder(pOrder: ListSortOrderConstants); safecall;
    function Get_View: ListViewConstants; safecall;
    procedure Set_View(pnView: ListViewConstants); safecall;
    function Get_OLEDragMode: OLEDragConstants; safecall;
    procedure Set_OLEDragMode(psOLEDragMode: OLEDragConstants); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    function Get_Appearance: AppearanceConstants; safecall;
    procedure Set_Appearance(pnAppearance: AppearanceConstants); safecall;
    function Get_BackColor: OLE_COLOR; safecall;
    procedure Set_BackColor(pcrBack: OLE_COLOR); safecall;
    function Get_BorderStyle: BorderStyleConstants; safecall;
    procedure Set_BorderStyle(pnStyle: BorderStyleConstants); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pfEnabled: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure _Set_Font(const ppFontDisp: IFontDisp); safecall;
    function Get_ForeColor: OLE_COLOR; safecall;
    procedure Set_ForeColor(pcrFore: OLE_COLOR); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    function FindItem(const sz: WideString; var Where: OleVariant; var Index: OleVariant; 
                      var fPartial: OleVariant): IListItem; safecall;
    function GetFirstVisible: IListItem; safecall;
    function HitTest(x: Single; y: Single): IListItem; safecall;
    procedure StartLabelEdit; safecall;
    procedure OLEDrag; safecall;
    procedure Refresh; stdcall;
    procedure AboutBox; stdcall;
    function Get_AllowColumnReorder: WordBool; safecall;
    procedure Set_AllowColumnReorder(pfAllowColumnReorder: WordBool); safecall;
    function Get_Checkboxes: WordBool; safecall;
    procedure Set_Checkboxes(pfCheckboxes: WordBool); safecall;
    function Get_FlatScrollBar: WordBool; safecall;
    procedure Set_FlatScrollBar(pfFlatScrollBar: WordBool); safecall;
    function Get_FullRowSelect: WordBool; safecall;
    procedure Set_FullRowSelect(pfFullRowSelect: WordBool); safecall;
    function Get_GridLines: WordBool; safecall;
    procedure Set_GridLines(pfGridLines: WordBool); safecall;
    function Get_HotTracking: WordBool; safecall;
    procedure Set_HotTracking(pfHotTracking: WordBool); safecall;
    function Get_HoverSelection: WordBool; safecall;
    procedure Set_HoverSelection(pfHoverSelection: WordBool); safecall;
    function Get_Picture: IPictureDisp; safecall;
    procedure Set_Picture(const ppPictureDisp: IPictureDisp); safecall;
    procedure _Set_Picture(const ppPictureDisp: IPictureDisp); safecall;
    function Get_PictureAlignment: ListPictureAlignmentConstants; safecall;
    procedure Set_PictureAlignment(psAlignment: ListPictureAlignmentConstants); safecall;
    function Get_ColumnHeaderIcons: IDispatch; safecall;
    procedure _Set_ColumnHeaderIcons(const ppImageList: IDispatch); safecall;
    procedure Set_ColumnHeaderIcons(const ppImageList: IDispatch); safecall;
    function Get_TextBackground: ListTextBackgroundConstants; safecall;
    procedure Set_TextBackground(penumTextBackground: ListTextBackgroundConstants); safecall;
    property Arrange: ListArrangeConstants read Get_Arrange write Set_Arrange;
    property ColumnHeaders: IColumnHeaders read Get_ColumnHeaders write Set_ColumnHeaders;
    property HideColumnHeaders: WordBool read Get_HideColumnHeaders write Set_HideColumnHeaders;
    property HideSelection: WordBool read Get_HideSelection write Set_HideSelection;
    property Icons: IDispatch read Get_Icons write Set_Icons;
    property ListItems: IListItems read Get_ListItems write Set_ListItems;
    property LabelEdit: ListLabelEditConstants read Get_LabelEdit write Set_LabelEdit;
    property LabelWrap: WordBool read Get_LabelWrap write Set_LabelWrap;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property MultiSelect: WordBool read Get_MultiSelect write Set_MultiSelect;
    property SmallIcons: IDispatch read Get_SmallIcons write Set_SmallIcons;
    property Sorted: WordBool read Get_Sorted write Set_Sorted;
    property SortKey: Smallint read Get_SortKey write Set_SortKey;
    property SortOrder: ListSortOrderConstants read Get_SortOrder write Set_SortOrder;
    property View: ListViewConstants read Get_View write Set_View;
    property OLEDragMode: OLEDragConstants read Get_OLEDragMode write Set_OLEDragMode;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property Appearance: AppearanceConstants read Get_Appearance write Set_Appearance;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BorderStyle: BorderStyleConstants read Get_BorderStyle write Set_BorderStyle;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
    property AllowColumnReorder: WordBool read Get_AllowColumnReorder write Set_AllowColumnReorder;
    property Checkboxes: WordBool read Get_Checkboxes write Set_Checkboxes;
    property FlatScrollBar: WordBool read Get_FlatScrollBar write Set_FlatScrollBar;
    property FullRowSelect: WordBool read Get_FullRowSelect write Set_FullRowSelect;
    property GridLines: WordBool read Get_GridLines write Set_GridLines;
    property HotTracking: WordBool read Get_HotTracking write Set_HotTracking;
    property HoverSelection: WordBool read Get_HoverSelection write Set_HoverSelection;
    property Picture: IPictureDisp read Get_Picture write Set_Picture;
    property PictureAlignment: ListPictureAlignmentConstants read Get_PictureAlignment write Set_PictureAlignment;
    property ColumnHeaderIcons: IDispatch read Get_ColumnHeaderIcons write Set_ColumnHeaderIcons;
    property TextBackground: ListTextBackgroundConstants read Get_TextBackground write Set_TextBackground;
  end;

// *********************************************************************//
// DispIntf:  IListViewDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F049-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListViewDisp = dispinterface
    ['{BDD1F049-858B-11D1-B16A-00C0F0283628}']
    property Arrange: ListArrangeConstants dispid 1;
    property ColumnHeaders: IColumnHeaders dispid 2;
    function DropHighlight: IListItem; dispid 3;
    property HideColumnHeaders: WordBool dispid 4;
    property HideSelection: WordBool dispid 5;
    property Icons: IDispatch dispid 6;
    property ListItems: IListItems dispid 7;
    property LabelEdit: ListLabelEditConstants dispid 8;
    property LabelWrap: WordBool dispid 9;
    property MouseIcon: IPictureDisp dispid 10;
    property MousePointer: MousePointerConstants dispid 11;
    property MultiSelect: WordBool dispid 12;
    function SelectedItem: IListItem; dispid 13;
    property SmallIcons: IDispatch dispid 14;
    property Sorted: WordBool dispid 15;
    property SortKey: Smallint dispid 16;
    property SortOrder: ListSortOrderConstants dispid 17;
    property View: ListViewConstants dispid 18;
    property OLEDragMode: OLEDragConstants dispid 1550;
    property OLEDropMode: OLEDropConstants dispid 1551;
    property Appearance: AppearanceConstants dispid -520;
    property BackColor: OLE_COLOR dispid -501;
    property BorderStyle: BorderStyleConstants dispid -504;
    property Enabled: WordBool dispid -514;
    property Font: IFontDisp dispid -512;
    property ForeColor: OLE_COLOR dispid -513;
    property hWnd: OLE_HANDLE dispid -515;
    function FindItem(const sz: WideString; var Where: OleVariant; var Index: OleVariant; 
                      var fPartial: OleVariant): IListItem; dispid 19;
    function GetFirstVisible: IListItem; dispid 20;
    function HitTest(x: Single; y: Single): IListItem; dispid 21;
    procedure StartLabelEdit; dispid 22;
    procedure OLEDrag; dispid 1552;
    procedure Refresh; dispid -550;
    procedure AboutBox; dispid -552;
    property AllowColumnReorder: WordBool dispid 23;
    property Checkboxes: WordBool dispid 24;
    property FlatScrollBar: WordBool dispid 25;
    property FullRowSelect: WordBool dispid 26;
    property GridLines: WordBool dispid 27;
    property HotTracking: WordBool dispid 28;
    property HoverSelection: WordBool dispid 29;
    property Picture: IPictureDisp dispid 31;
    property PictureAlignment: ListPictureAlignmentConstants dispid 30;
    property ColumnHeaderIcons: IDispatch dispid 32;
    property TextBackground: ListTextBackgroundConstants dispid 33;
  end;

// *********************************************************************//
// DispIntf:  ListViewEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {BDD1F04A-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ListViewEvents = dispinterface
    ['{BDD1F04A-858B-11D1-B16A-00C0F0283628}']
    procedure BeforeLabelEdit(var Cancel: Smallint); dispid 1;
    procedure AfterLabelEdit(var Cancel: Smallint; var NewString: WideString); dispid 2;
    procedure ColumnClick(const ColumnHeader: ColumnHeader); dispid 3;
    procedure ItemClick(const Item: ListItem); dispid 4;
    procedure KeyDown(var KeyCode: Smallint; Shift: Smallint); dispid -602;
    procedure KeyUp(var KeyCode: Smallint; Shift: Smallint); dispid -604;
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure Click; dispid -600;
    procedure DblClick; dispid -601;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
    procedure ItemCheck(const Item: ListItem); dispid 5;
  end;

// *********************************************************************//
// Interface: IListItems
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F04C-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListItems = interface(IDispatch)
    ['{BDD1F04C-858B-11D1-B16A-00C0F0283628}']
    function Get_Count: Integer; safecall;
    procedure Set_Count(plCount: Integer); safecall;
    function Get_ControlDefault(var Index: OleVariant): IListItem; safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Icon: OleVariant; var SmallIcon: OleVariant): IListItem; safecall;
    procedure Clear; safecall;
    function Get_Item(var Index: OleVariant): IListItem; safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IUnknown; safecall;
    property Count: Integer read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IListItem read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IListItem read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IListItemsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F04C-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListItemsDisp = dispinterface
    ['{BDD1F04C-858B-11D1-B16A-00C0F0283628}']
    property Count: Integer dispid 1;
    property ControlDefault[var Index: OleVariant]: IListItem readonly dispid 0; default;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Icon: OleVariant; var SmallIcon: OleVariant): IListItem; dispid 2;
    procedure Clear; dispid 3;
    property Item[var Index: OleVariant]: IListItem readonly dispid 4;
    procedure Remove(var Index: OleVariant); dispid 5;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: IListItem
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F04E-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListItem = interface(IDispatch)
    ['{BDD1F04E-858B-11D1-B16A-00C0F0283628}']
    function Get_Default: WideString; safecall;
    procedure Set_Default(const pbstrText: WideString); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_Ghosted: WordBool; safecall;
    procedure Set_Ghosted(pfOn: WordBool); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(pflHeight: Single); safecall;
    function Get_Icon: OleVariant; safecall;
    procedure Set_Icon(pnIndex: OleVariant); safecall;
    function Get_Index: Integer; safecall;
    procedure Set_Index(plIndex: Integer); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(pflLeft: Single); safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(pfOn: WordBool); safecall;
    function Get_SmallIcon: OleVariant; safecall;
    procedure Set_SmallIcon(pnIndex: OleVariant); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(pflTop: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(pflWidth: Single); safecall;
    function Get_SubItems(Index: Smallint): WideString; safecall;
    procedure Set_SubItems(Index: Smallint; const pbstrItem: WideString); safecall;
    function CreateDragImage: IPictureDisp; safecall;
    function EnsureVisible: WordBool; safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    function Get_ListSubItems: IListSubItems; safecall;
    procedure Set_ListSubItems(const ppSubItems: IListSubItems); safecall;
    function Get_Checked: WordBool; safecall;
    procedure Set_Checked(pfChecked: WordBool); safecall;
    function Get_ForeColor: OLE_COLOR; safecall;
    procedure Set_ForeColor(pcrFore: OLE_COLOR); safecall;
    function Get_ToolTipText: WideString; safecall;
    procedure Set_ToolTipText(const pbstrToolTipText: WideString); safecall;
    function Get_Bold: WordBool; safecall;
    procedure Set_Bold(pfBold: WordBool); safecall;
    property Default: WideString read Get_Default write Set_Default;
    property Text: WideString read Get_Text write Set_Text;
    property Ghosted: WordBool read Get_Ghosted write Set_Ghosted;
    property Height: Single read Get_Height write Set_Height;
    property Icon: OleVariant read Get_Icon write Set_Icon;
    property Index: Integer read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Left: Single read Get_Left write Set_Left;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property SmallIcon: OleVariant read Get_SmallIcon write Set_SmallIcon;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property SubItems[Index: Smallint]: WideString read Get_SubItems write Set_SubItems;
    property ListSubItems: IListSubItems read Get_ListSubItems write Set_ListSubItems;
    property Checked: WordBool read Get_Checked write Set_Checked;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property ToolTipText: WideString read Get_ToolTipText write Set_ToolTipText;
    property Bold: WordBool read Get_Bold write Set_Bold;
  end;

// *********************************************************************//
// DispIntf:  IListItemDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F04E-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListItemDisp = dispinterface
    ['{BDD1F04E-858B-11D1-B16A-00C0F0283628}']
    property Default: WideString dispid 0;
    property Text: WideString dispid 10;
    property Ghosted: WordBool dispid 1;
    property Height: Single dispid 2;
    property Icon: OleVariant dispid 3;
    property Index: Integer dispid 4;
    property Key: WideString dispid 5;
    property Left: Single dispid 6;
    property Selected: WordBool dispid 7;
    property SmallIcon: OleVariant dispid 8;
    property Tag: OleVariant dispid 9;
    property Top: Single dispid 11;
    property Width: Single dispid 12;
    property SubItems[Index: Smallint]: WideString dispid 13;
    function CreateDragImage: IPictureDisp; dispid 14;
    function EnsureVisible: WordBool; dispid 15;
    property ListSubItems: IListSubItems dispid 16;
    property Checked: WordBool dispid 17;
    property ForeColor: OLE_COLOR dispid -513;
    property ToolTipText: WideString dispid 18;
    property Bold: WordBool dispid 19;
  end;

// *********************************************************************//
// Interface: IColumnHeaders
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F050-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IColumnHeaders = interface(IDispatch)
    ['{BDD1F050-858B-11D1-B16A-00C0F0283628}']
    function Get_Count: Integer; safecall;
    procedure Set_Count(plCount: Integer); safecall;
    function Get_ControlDefault(var Index: OleVariant): IColumnHeader; safecall;
    function Add_PreVB98(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                         var Width: OleVariant; var Alignment: OleVariant): IColumnHeader; safecall;
    procedure Clear; safecall;
    function Get_Item(var Index: OleVariant): IColumnHeader; safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IUnknown; safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Width: OleVariant; var Alignment: OleVariant; var Icon: OleVariant): IColumnHeader; safecall;
    property Count: Integer read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IColumnHeader read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IColumnHeader read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IColumnHeadersDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F050-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IColumnHeadersDisp = dispinterface
    ['{BDD1F050-858B-11D1-B16A-00C0F0283628}']
    property Count: Integer dispid 1;
    property ControlDefault[var Index: OleVariant]: IColumnHeader readonly dispid 0; default;
    function Add_PreVB98(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                         var Width: OleVariant; var Alignment: OleVariant): IColumnHeader; dispid 2;
    procedure Clear; dispid 3;
    property Item[var Index: OleVariant]: IColumnHeader readonly dispid 4;
    procedure Remove(var Index: OleVariant); dispid 5;
    function _NewEnum: IUnknown; dispid -4;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Width: OleVariant; var Alignment: OleVariant; var Icon: OleVariant): IColumnHeader; dispid 6;
  end;

// *********************************************************************//
// Interface: IColumnHeader
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F051-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IColumnHeader = interface(IDispatch)
    ['{BDD1F051-858B-11D1-B16A-00C0F0283628}']
    function Get_Default: WideString; safecall;
    procedure Set_Default(const pbstrText: WideString); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_Alignment: ListColumnAlignmentConstants; safecall;
    procedure Set_Alignment(pnAlignment: ListColumnAlignmentConstants); safecall;
    function Get_Index: Integer; safecall;
    procedure Set_Index(plIndex: Integer); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(pflLeft: Single); safecall;
    function Get_SubItemIndex: Smallint; safecall;
    procedure Set_SubItemIndex(psIndex: Smallint); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(pflWidth: Single); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    function Get_Icon: OleVariant; safecall;
    procedure Set_Icon(pnIndex: OleVariant); safecall;
    function Get_Position: Smallint; safecall;
    procedure Set_Position(piPosition: Smallint); safecall;
    property Default: WideString read Get_Default write Set_Default;
    property Text: WideString read Get_Text write Set_Text;
    property Alignment: ListColumnAlignmentConstants read Get_Alignment write Set_Alignment;
    property Index: Integer read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Left: Single read Get_Left write Set_Left;
    property SubItemIndex: Smallint read Get_SubItemIndex write Set_SubItemIndex;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Width: Single read Get_Width write Set_Width;
    property Icon: OleVariant read Get_Icon write Set_Icon;
    property Position: Smallint read Get_Position write Set_Position;
  end;

// *********************************************************************//
// DispIntf:  IColumnHeaderDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F051-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IColumnHeaderDisp = dispinterface
    ['{BDD1F051-858B-11D1-B16A-00C0F0283628}']
    property Default: WideString dispid 0;
    property Text: WideString dispid 7;
    property Alignment: ListColumnAlignmentConstants dispid 1;
    property Index: Integer dispid 2;
    property Key: WideString dispid 3;
    property Left: Single dispid 4;
    property SubItemIndex: Smallint dispid 5;
    property Tag: OleVariant dispid 6;
    property Width: Single dispid 8;
    property Icon: OleVariant dispid 9;
    property Position: Smallint dispid 10;
  end;

// *********************************************************************//
// Interface: IListSubItems
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F053-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListSubItems = interface(IDispatch)
    ['{BDD1F053-858B-11D1-B16A-00C0F0283628}']
    function Get_Count: Integer; safecall;
    procedure Set_Count(plCount: Integer); safecall;
    function Get_ControlDefault(var Index: OleVariant): IListSubItem; safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var ReportIcon: OleVariant; var ToolTipText: OleVariant): IListSubItem; safecall;
    procedure Clear; safecall;
    function Get_Item(var Index: OleVariant): IListSubItem; safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IUnknown; safecall;
    property Count: Integer read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IListSubItem read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IListSubItem read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IListSubItemsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F053-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListSubItemsDisp = dispinterface
    ['{BDD1F053-858B-11D1-B16A-00C0F0283628}']
    property Count: Integer dispid 1;
    property ControlDefault[var Index: OleVariant]: IListSubItem readonly dispid 0; default;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var ReportIcon: OleVariant; var ToolTipText: OleVariant): IListSubItem; dispid 2;
    procedure Clear; dispid 3;
    property Item[var Index: OleVariant]: IListSubItem readonly dispid 4;
    procedure Remove(var Index: OleVariant); dispid 5;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: IListSubItem
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F055-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListSubItem = interface(IDispatch)
    ['{BDD1F055-858B-11D1-B16A-00C0F0283628}']
    function Get_Default: WideString; safecall;
    procedure Set_Default(const pbstrText: WideString); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_ForeColor: OLE_COLOR; safecall;
    procedure Set_ForeColor(pcrFore: OLE_COLOR); safecall;
    function Get_Bold: WordBool; safecall;
    procedure Set_Bold(pfBold: WordBool); safecall;
    function Get_ReportIcon: OleVariant; safecall;
    procedure Set_ReportIcon(pnIndex: OleVariant); safecall;
    function Get_ToolTipText: WideString; safecall;
    procedure Set_ToolTipText(const pbstrToolTipText: WideString); safecall;
    function Get_Index: Integer; safecall;
    procedure Set_Index(plIndex: Integer); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    property Default: WideString read Get_Default write Set_Default;
    property Text: WideString read Get_Text write Set_Text;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property Bold: WordBool read Get_Bold write Set_Bold;
    property ReportIcon: OleVariant read Get_ReportIcon write Set_ReportIcon;
    property ToolTipText: WideString read Get_ToolTipText write Set_ToolTipText;
    property Index: Integer read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Tag: OleVariant read Get_Tag write Set_Tag;
  end;

// *********************************************************************//
// DispIntf:  IListSubItemDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDD1F055-858B-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IListSubItemDisp = dispinterface
    ['{BDD1F055-858B-11D1-B16A-00C0F0283628}']
    property Default: WideString dispid 0;
    property Text: WideString dispid 1;
    property ForeColor: OLE_COLOR dispid -513;
    property Bold: WordBool dispid 2;
    property ReportIcon: OleVariant dispid 4;
    property ToolTipText: WideString dispid 5;
    property Index: Integer dispid 6;
    property Key: WideString dispid 7;
    property Tag: OleVariant dispid 8;
  end;

// *********************************************************************//
// Interface: IImageList
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C247F21-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImageList = interface(IDispatch)
    ['{2C247F21-8591-11D1-B16A-00C0F0283628}']
    function Get_ImageHeight: Smallint; safecall;
    procedure Set_ImageHeight(psImageHeight: Smallint); safecall;
    function Get_ImageWidth: Smallint; safecall;
    procedure Set_ImageWidth(psImageWidth: Smallint); safecall;
    function Get_MaskColor: OLE_COLOR; safecall;
    procedure Set_MaskColor(pclrMaskColor: OLE_COLOR); safecall;
    function Get_UseMaskColor: WordBool; safecall;
    procedure Set_UseMaskColor(pbState: WordBool); safecall;
    function Get_ListImages: IImages; safecall;
    procedure _Set_ListImages(const ppListImages: IImages); safecall;
    function Get_hImageList: OLE_HANDLE; safecall;
    procedure Set_hImageList(phImageList: OLE_HANDLE); safecall;
    function Get_BackColor: OLE_COLOR; safecall;
    procedure Set_BackColor(pclrBackColor: OLE_COLOR); safecall;
    function Overlay(var Key1: OleVariant; var Key2: OleVariant): IPictureDisp; safecall;
    procedure AboutBox; safecall;
    property ImageHeight: Smallint read Get_ImageHeight write Set_ImageHeight;
    property ImageWidth: Smallint read Get_ImageWidth write Set_ImageWidth;
    property MaskColor: OLE_COLOR read Get_MaskColor write Set_MaskColor;
    property UseMaskColor: WordBool read Get_UseMaskColor write Set_UseMaskColor;
    property ListImages: IImages read Get_ListImages write _Set_ListImages;
    property hImageList: OLE_HANDLE read Get_hImageList write Set_hImageList;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
  end;

// *********************************************************************//
// DispIntf:  IImageListDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C247F21-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImageListDisp = dispinterface
    ['{2C247F21-8591-11D1-B16A-00C0F0283628}']
    property ImageHeight: Smallint dispid 1;
    property ImageWidth: Smallint dispid 2;
    property MaskColor: OLE_COLOR dispid 3;
    property UseMaskColor: WordBool dispid 7;
    property ListImages: IImages dispid 4;
    property hImageList: OLE_HANDLE dispid 5;
    property BackColor: OLE_COLOR dispid -501;
    function Overlay(var Key1: OleVariant; var Key2: OleVariant): IPictureDisp; dispid 6;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  ImageListEvents
// Flags:     (4096) Dispatchable
// GUID:      {2C247F22-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ImageListEvents = dispinterface
    ['{2C247F22-8591-11D1-B16A-00C0F0283628}']
  end;

// *********************************************************************//
// Interface: IImages
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C247F24-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImages = interface(IDispatch)
    ['{2C247F24-8591-11D1-B16A-00C0F0283628}']
    function Get_Count: Smallint; safecall;
    procedure Set_Count(psCount: Smallint); safecall;
    function Get_ControlDefault(var Index: OleVariant): IImage; safecall;
    procedure _Set_ControlDefault(var Index: OleVariant; const ppListImage: IImage); safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Picture: OleVariant): IImage; safecall;
    procedure Clear; safecall;
    function Get_Item(var Index: OleVariant): IImage; safecall;
    procedure _Set_Item(var Index: OleVariant; const Item: IImage); safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IDispatch; safecall;
    property Count: Smallint read Get_Count write Set_Count;
    property ControlDefault[var Index: OleVariant]: IImage read Get_ControlDefault; default;
    property Item[var Index: OleVariant]: IImage read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IImagesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C247F24-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImagesDisp = dispinterface
    ['{2C247F24-8591-11D1-B16A-00C0F0283628}']
    property Count: Smallint dispid 1;
    property ControlDefault[var Index: OleVariant]: IImage dispid 0; default;
    function Add(var Index: OleVariant; var Key: OleVariant; var Picture: OleVariant): IImage; dispid 2;
    procedure Clear; dispid 3;
    property Item[var Index: OleVariant]: IImage dispid 4;
    procedure Remove(var Index: OleVariant); dispid 5;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: IImage
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C247F26-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImage = interface(IDispatch)
    ['{2C247F26-8591-11D1-B16A-00C0F0283628}']
    function Get_Index: Smallint; safecall;
    procedure Set_Index(psIndex: Smallint); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    function Get_Picture: IPictureDisp; safecall;
    procedure _Set_Picture(const ppPictureDisp: IPictureDisp); safecall;
    procedure Draw(hDC: OLE_HANDLE; var x: OleVariant; var y: OleVariant; var Style: OleVariant); safecall;
    function ExtractIcon: IPictureDisp; safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    property Index: Smallint read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Picture: IPictureDisp read Get_Picture write _Set_Picture;
  end;

// *********************************************************************//
// DispIntf:  IImageDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C247F26-8591-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImageDisp = dispinterface
    ['{2C247F26-8591-11D1-B16A-00C0F0283628}']
    property Index: Smallint dispid 1;
    property Key: WideString dispid 2;
    property Tag: OleVariant dispid 6;
    property Picture: IPictureDisp dispid 3;
    procedure Draw(hDC: OLE_HANDLE; var x: OleVariant; var y: OleVariant; var Style: OleVariant); dispid 4;
    function ExtractIcon: IPictureDisp; dispid 5;
  end;

// *********************************************************************//
// Interface: ISlider
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F08DF952-8592-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ISlider = interface(IDispatch)
    ['{F08DF952-8592-11D1-B16A-00C0F0283628}']
    function Get__Value: Integer; safecall;
    procedure Set__Value(plValue: Integer); safecall;
    function Get_LargeChange: Integer; safecall;
    procedure Set_LargeChange(plLargeChange: Integer); safecall;
    function Get_SmallChange: Integer; safecall;
    procedure Set_SmallChange(plSmallChange: Integer); safecall;
    function Get_Max: Integer; safecall;
    procedure Set_Max(plMax: Integer); safecall;
    function Get_Min: Integer; safecall;
    procedure Set_Min(plMin: Integer); safecall;
    function Get_Orientation: OrientationConstants; safecall;
    procedure Set_Orientation(pOrientation: OrientationConstants); safecall;
    function Get_SelectRange: WordBool; safecall;
    procedure Set_SelectRange(pbSelectRange: WordBool); safecall;
    function Get_SelStart: Integer; safecall;
    procedure Set_SelStart(plSelStart: Integer); safecall;
    function Get_SelLength: Integer; safecall;
    procedure Set_SelLength(plSelLength: Integer); safecall;
    function Get_TickStyle: TickStyleConstants; safecall;
    procedure Set_TickStyle(pTickStyle: TickStyleConstants); safecall;
    function Get_TickFrequency: Integer; safecall;
    procedure Set_TickFrequency(plTickFrequency: Integer); safecall;
    function Get_Value: Integer; safecall;
    procedure Set_Value(plValue: Integer); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(psMousePointer: MousePointerConstants); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    function Get_BorderStyle: BorderStyleConstants; safecall;
    procedure Set_BorderStyle(psBorderStyle: BorderStyleConstants); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    procedure Refresh; stdcall;
    procedure ClearSel; stdcall;
    procedure DoClick; stdcall;
    function Get_GetNumTicks: Integer; safecall;
    procedure OLEDrag; safecall;
    procedure AboutBox; stdcall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_TextPosition: TextPositionConstants; safecall;
    procedure Set_TextPosition(penumTextPosition: TextPositionConstants); safecall;
    property _Value: Integer read Get__Value write Set__Value;
    property LargeChange: Integer read Get_LargeChange write Set_LargeChange;
    property SmallChange: Integer read Get_SmallChange write Set_SmallChange;
    property Max: Integer read Get_Max write Set_Max;
    property Min: Integer read Get_Min write Set_Min;
    property Orientation: OrientationConstants read Get_Orientation write Set_Orientation;
    property SelectRange: WordBool read Get_SelectRange write Set_SelectRange;
    property SelStart: Integer read Get_SelStart write Set_SelStart;
    property SelLength: Integer read Get_SelLength write Set_SelLength;
    property TickStyle: TickStyleConstants read Get_TickStyle write Set_TickStyle;
    property TickFrequency: Integer read Get_TickFrequency write Set_TickFrequency;
    property Value: Integer read Get_Value write Set_Value;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
    property BorderStyle: BorderStyleConstants read Get_BorderStyle write Set_BorderStyle;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property GetNumTicks: Integer read Get_GetNumTicks;
    property Text: WideString read Get_Text write Set_Text;
    property TextPosition: TextPositionConstants read Get_TextPosition write Set_TextPosition;
  end;

// *********************************************************************//
// DispIntf:  ISliderDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F08DF952-8592-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ISliderDisp = dispinterface
    ['{F08DF952-8592-11D1-B16A-00C0F0283628}']
    property _Value: Integer dispid 0;
    property LargeChange: Integer dispid 1;
    property SmallChange: Integer dispid 2;
    property Max: Integer dispid 3;
    property Min: Integer dispid 4;
    property Orientation: OrientationConstants dispid 5;
    property SelectRange: WordBool dispid 6;
    property SelStart: Integer dispid 7;
    property SelLength: Integer dispid 8;
    property TickStyle: TickStyleConstants dispid 9;
    property TickFrequency: Integer dispid 10;
    property Value: Integer dispid 11;
    property MouseIcon: IPictureDisp dispid 12;
    property MousePointer: MousePointerConstants dispid 13;
    property Enabled: WordBool dispid -514;
    property hWnd: OLE_HANDLE dispid -515;
    property BorderStyle: BorderStyleConstants dispid -504;
    property OLEDropMode: OLEDropConstants dispid 1551;
    procedure Refresh; dispid -550;
    procedure ClearSel; dispid 14;
    procedure DoClick; dispid -551;
    property GetNumTicks: Integer readonly dispid 15;
    procedure OLEDrag; dispid 1552;
    procedure AboutBox; dispid -552;
    property Text: WideString dispid 16;
    property TextPosition: TextPositionConstants dispid 17;
  end;

// *********************************************************************//
// DispIntf:  ISliderEvents
// Flags:     (4096) Dispatchable
// GUID:      {F08DF953-8592-11D1-B16A-00C0F0283628}
// *********************************************************************//
  ISliderEvents = dispinterface
    ['{F08DF953-8592-11D1-B16A-00C0F0283628}']
    procedure Click; dispid -600;
    procedure KeyDown(var KeyCode: Smallint; Shift: Smallint); dispid -602;
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
    procedure KeyUp(var KeyCode: Smallint; Shift: Smallint); dispid -604;
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -605;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -606;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: OLE_XPOS_PIXELS; y: OLE_YPOS_PIXELS); dispid -607;
    procedure Scroll; dispid 1;
    procedure Change; dispid 2;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
  end;

// *********************************************************************//
// Interface: IControls
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C8A3DC00-8593-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IControls = interface(IDispatch)
    ['{C8A3DC00-8593-11D1-B16A-00C0F0283628}']
    function Get_Count: Integer; safecall;
    function Get_Item(Index: Integer): IDispatch; safecall;
    function _NewEnum: IUnknown; safecall;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IDispatch read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IControlsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C8A3DC00-8593-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IControlsDisp = dispinterface
    ['{C8A3DC00-8593-11D1-B16A-00C0F0283628}']
    property Count: Integer readonly dispid 1;
    property Item[Index: Integer]: IDispatch readonly dispid 0; default;
    function _NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: IComboItem
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DD9DA660-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IComboItem = interface(IDispatch)
    ['{DD9DA660-8594-11D1-B16A-00C0F0283628}']
    function Get__ObjectDefault: WideString; safecall;
    procedure Set__ObjectDefault(const pbstrText: WideString); safecall;
    function Get_Image: OleVariant; safecall;
    procedure Set_Image(pvImage: OleVariant); safecall;
    function Get_Indentation: Smallint; safecall;
    procedure Set_Indentation(psIndent: Smallint); safecall;
    function Get_Index: Integer; safecall;
    procedure Set_Index(plIndex: Integer); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pbstrKey: WideString); safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(pbSelected: WordBool); safecall;
    function Get_SelImage: OleVariant; safecall;
    procedure Set_SelImage(pvImage: OleVariant); safecall;
    function Get_Tag: OleVariant; safecall;
    procedure Set_Tag(pvTag: OleVariant); safecall;
    procedure _Set_Tag(pvTag: OleVariant); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    property _ObjectDefault: WideString read Get__ObjectDefault write Set__ObjectDefault;
    property Image: OleVariant read Get_Image write Set_Image;
    property Indentation: Smallint read Get_Indentation write Set_Indentation;
    property Index: Integer read Get_Index write Set_Index;
    property Key: WideString read Get_Key write Set_Key;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property SelImage: OleVariant read Get_SelImage write Set_SelImage;
    property Tag: OleVariant read Get_Tag write Set_Tag;
    property Text: WideString read Get_Text write Set_Text;
  end;

// *********************************************************************//
// DispIntf:  IComboItemDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DD9DA660-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IComboItemDisp = dispinterface
    ['{DD9DA660-8594-11D1-B16A-00C0F0283628}']
    property _ObjectDefault: WideString dispid 0;
    property Image: OleVariant dispid 2;
    property Indentation: Smallint dispid 5;
    property Index: Integer dispid 6;
    property Key: WideString dispid 8;
    property Selected: WordBool dispid 13;
    property SelImage: OleVariant dispid 15;
    property Tag: OleVariant dispid 21;
    property Text: WideString dispid 23;
  end;

// *********************************************************************//
// Interface: IComboItems
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DD9DA662-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IComboItems = interface(IDispatch)
    ['{DD9DA662-8594-11D1-B16A-00C0F0283628}']
    function Get__CollectionDefault(var Index: OleVariant): IComboItem; safecall;
    procedure Set__CollectionDefault(var Index: OleVariant; const ppComboItem: IComboItem); safecall;
    function Get_Count: Integer; safecall;
    procedure Set_Count(plCount: Integer); safecall;
    function Get_Item(var Index: OleVariant): IComboItem; safecall;
    procedure Set_Item(var Index: OleVariant; const ppComboItem: IComboItem); safecall;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Image: OleVariant; var SelImage: OleVariant; var Indentation: OleVariant): IComboItem; safecall;
    procedure Clear; safecall;
    procedure Remove(var Index: OleVariant); safecall;
    function _NewEnum: IDispatch; safecall;
    property _CollectionDefault[var Index: OleVariant]: IComboItem read Get__CollectionDefault write Set__CollectionDefault; default;
    property Count: Integer read Get_Count write Set_Count;
    property Item[var Index: OleVariant]: IComboItem read Get_Item write Set_Item;
  end;

// *********************************************************************//
// DispIntf:  IComboItemsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DD9DA662-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IComboItemsDisp = dispinterface
    ['{DD9DA662-8594-11D1-B16A-00C0F0283628}']
    property _CollectionDefault[var Index: OleVariant]: IComboItem dispid 0; default;
    property Count: Integer dispid 27;
    property Item[var Index: OleVariant]: IComboItem dispid 28;
    function Add(var Index: OleVariant; var Key: OleVariant; var Text: OleVariant; 
                 var Image: OleVariant; var SelImage: OleVariant; var Indentation: OleVariant): IComboItem; dispid 25;
    procedure Clear; dispid 26;
    procedure Remove(var Index: OleVariant); dispid 29;
    function _NewEnum: IDispatch; dispid -4;
  end;

// *********************************************************************//
// Interface: IImageCombo
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DD9DA664-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImageCombo = interface(IDispatch)
    ['{DD9DA664-8594-11D1-B16A-00C0F0283628}']
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstrText: WideString); safecall;
    function Get_BackColor: OLE_COLOR; safecall;
    procedure Set_BackColor(pocBackColor: OLE_COLOR); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pbEnabled: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const ppFont: IFontDisp); safecall;
    procedure _Set_Font(const ppFont: IFontDisp); safecall;
    function Get_ForeColor: OLE_COLOR; safecall;
    procedure Set_ForeColor(pocForeColor: OLE_COLOR); safecall;
    function Get_hWnd: OLE_HANDLE; safecall;
    procedure Set_hWnd(phWnd: OLE_HANDLE); safecall;
    function Get_ImageList: IDispatch; safecall;
    procedure _Set_ImageList(const ppImageList: IDispatch); safecall;
    procedure Set_ImageList(const ppImageList: IDispatch); safecall;
    function Get_Indentation: Smallint; safecall;
    procedure Set_Indentation(psIndent: Smallint); safecall;
    function Get_ComboItems: IComboItems; safecall;
    procedure _Set_ComboItems(const ppComboItems: IComboItems); safecall;
    function Get_Locked: WordBool; safecall;
    procedure Set_Locked(pbLocked: WordBool); safecall;
    function Get_MouseIcon: IPictureDisp; safecall;
    procedure Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    procedure _Set_MouseIcon(const ppMouseIcon: IPictureDisp); safecall;
    function Get_MousePointer: MousePointerConstants; safecall;
    procedure Set_MousePointer(penumMousePointer: MousePointerConstants); safecall;
    function Get_OLEDragMode: OLEDragConstants; safecall;
    procedure Set_OLEDragMode(psOLEDragMode: OLEDragConstants); safecall;
    function Get_OLEDropMode: OLEDropConstants; safecall;
    procedure Set_OLEDropMode(psOLEDropMode: OLEDropConstants); safecall;
    function Get_SelectedItem: IComboItem; safecall;
    procedure _Set_SelectedItem(const ppIComboItem: IComboItem); safecall;
    procedure Set_SelectedItem(var ppIComboItem: OleVariant); safecall;
    function Get_SelLength: Integer; safecall;
    procedure Set_SelLength(plSelLength: Integer); safecall;
    function Get_SelStart: Integer; safecall;
    procedure Set_SelStart(plSelStart: Integer); safecall;
    function Get_SelText: WideString; safecall;
    procedure Set_SelText(const pbstrText: WideString); safecall;
    function Get_Style: ImageComboStyleConstants; safecall;
    procedure Set_Style(penumStyle: ImageComboStyleConstants); safecall;
    function Get_UsePathSep: WordBool; safecall;
    procedure Set_UsePathSep(pbUsePathSep: WordBool); safecall;
    procedure AboutBox; safecall;
    function GetFirstVisible: IComboItem; safecall;
    procedure Refresh; safecall;
    procedure OLEDrag; safecall;
    property Text: WideString read Get_Text write Set_Text;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write Set_Font;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property hWnd: OLE_HANDLE read Get_hWnd write Set_hWnd;
    property ImageList: IDispatch read Get_ImageList write Set_ImageList;
    property Indentation: Smallint read Get_Indentation write Set_Indentation;
    property ComboItems: IComboItems read Get_ComboItems write _Set_ComboItems;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: MousePointerConstants read Get_MousePointer write Set_MousePointer;
    property OLEDragMode: OLEDragConstants read Get_OLEDragMode write Set_OLEDragMode;
    property OLEDropMode: OLEDropConstants read Get_OLEDropMode write Set_OLEDropMode;
    property SelLength: Integer read Get_SelLength write Set_SelLength;
    property SelStart: Integer read Get_SelStart write Set_SelStart;
    property SelText: WideString read Get_SelText write Set_SelText;
    property Style: ImageComboStyleConstants read Get_Style write Set_Style;
    property UsePathSep: WordBool read Get_UsePathSep write Set_UsePathSep;
  end;

// *********************************************************************//
// DispIntf:  IImageComboDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DD9DA664-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  IImageComboDisp = dispinterface
    ['{DD9DA664-8594-11D1-B16A-00C0F0283628}']
    property Text: WideString dispid -517;
    property BackColor: OLE_COLOR dispid -501;
    property Enabled: WordBool dispid -514;
    property Font: IFontDisp dispid -512;
    property ForeColor: OLE_COLOR dispid -513;
    property hWnd: OLE_HANDLE dispid -515;
    property ImageList: IDispatch dispid 3;
    property Indentation: Smallint dispid 4;
    property ComboItems: IComboItems dispid 7;
    property Locked: WordBool dispid 9;
    property MouseIcon: IPictureDisp dispid 10;
    property MousePointer: MousePointerConstants dispid 11;
    property OLEDragMode: OLEDragConstants dispid 1550;
    property OLEDropMode: OLEDropConstants dispid 1551;
    function SelectedItem: IComboItem; dispid 14;
    property SelLength: Integer dispid 16;
    property SelStart: Integer dispid 17;
    property SelText: WideString dispid 18;
    property Style: ImageComboStyleConstants dispid 20;
    property UsePathSep: WordBool dispid 24;
    procedure AboutBox; dispid -552;
    function GetFirstVisible: IComboItem; dispid 30;
    procedure Refresh; dispid -550;
    procedure OLEDrag; dispid 1552;
  end;

// *********************************************************************//
// DispIntf:  DImageComboEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {DD9DA665-8594-11D1-B16A-00C0F0283628}
// *********************************************************************//
  DImageComboEvents = dispinterface
    ['{DD9DA665-8594-11D1-B16A-00C0F0283628}']
    procedure Change; dispid 1;
    procedure Dropdown; dispid 2;
    procedure Click; dispid -600;
    procedure KeyDown(KeyCode: Smallint; Shift: Smallint); dispid -602;
    procedure KeyUp(KeyCode: Smallint; Shift: Smallint); dispid -604;
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
    procedure OLEStartDrag(var Data: DataObject; var AllowedEffects: Integer); dispid 1550;
    procedure OLEGiveFeedback(var Effect: Integer; var DefaultCursors: WordBool); dispid 1551;
    procedure OLESetData(var Data: DataObject; var DataFormat: Smallint); dispid 1552;
    procedure OLECompleteDrag(var Effect: Integer); dispid 1553;
    procedure OLEDragOver(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single; var State: Smallint); dispid 1554;
    procedure OLEDragDrop(var Data: DataObject; var Effect: Integer; var Button: Smallint; 
                          var Shift: Smallint; var x: Single; var y: Single); dispid 1555;
  end;

// *********************************************************************//
// The Class CoDataObject provides a Create and CreateRemote method to          
// create instances of the default interface IVBDataObject exposed by              
// the CoClass DataObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataObject = class
    class function Create: IVBDataObject;
    class function CreateRemote(const MachineName: string): IVBDataObject;
  end;

// *********************************************************************//
// The Class CoDataObjectFiles provides a Create and CreateRemote method to          
// create instances of the default interface IVBDataObjectFiles exposed by              
// the CoClass DataObjectFiles. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataObjectFiles = class
    class function Create: IVBDataObjectFiles;
    class function CreateRemote(const MachineName: string): IVBDataObjectFiles;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TTabStrip
// Help String      : Microsoft TabStrip Control
// Default Interface: ITabStrip
// Def. Intf. DISP? : No
// Event   Interface: ITabStripEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TTabStripBeforeClick = procedure(ASender: TObject; var Cancel: Smallint) of object;
  TTabStripOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                      var AllowedEffects: Integer) of object;
  TTabStripOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                         var DefaultCursors: WordBool) of object;
  TTabStripOLESetData = procedure(ASender: TObject; var Data: DataObject; var DataFormat: Smallint) of object;
  TTabStripOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TTabStripOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                     var Button: Smallint; var Shift: Smallint; 
                                                     var x: Single; var y: Single; 
                                                     var State: Smallint) of object;
  TTabStripOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                     var Button: Smallint; var Shift: Smallint; 
                                                     var x: Single; var y: Single) of object;

  TTabStrip = class(TOleControl)
  private
    FOnBeforeClick: TTabStripBeforeClick;
    FOnOLEStartDrag: TTabStripOLEStartDrag;
    FOnOLEGiveFeedback: TTabStripOLEGiveFeedback;
    FOnOLESetData: TTabStripOLESetData;
    FOnOLECompleteDrag: TTabStripOLECompleteDrag;
    FOnOLEDragOver: TTabStripOLEDragOver;
    FOnOLEDragDrop: TTabStripOLEDragDrop;
    FIntf: ITabStrip;
    function  GetControlInterface: ITabStrip;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_Tabs: ITabs;
    procedure _Set_Tabs(const ppTabs: ITabs);
    function Get_ImageList: IDispatch;
    procedure Set_ImageList(const ppImageList: IDispatch);
    procedure _Set_ImageList(const ppImageList: IDispatch);
    function Get_SelectedItem: ITab;
    procedure _Set_SelectedItem(const ppSelectedItem: ITab);
  public
    procedure Refresh;
    procedure OLEDrag;
    procedure AboutBox;
    procedure DeselectAll;
    property  ControlInterface: ITabStrip read GetControlInterface;
    property  DefaultInterface: ITabStrip read GetControlInterface;
    property Tabs: ITabs read Get_Tabs write _Set_Tabs;
    property Font: TFont index -512 read GetTFontProp write _SetTFontProp;
    property ImageList: IDispatch index 13 read GetIDispatchProp write SetIDispatchProp;
  published
    property Anchors;
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnKeyUp;
    property  OnKeyPress;
    property  OnKeyDown;
    property  OnClick;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property MouseIcon: TPicture index 5 read GetTPictureProp write SetTPictureProp stored False;
    property MultiRow: WordBool index 1 read GetWordBoolProp write SetWordBoolProp stored False;
    property Style: TOleEnum index 6 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property TabFixedWidth: Smallint index 7 read GetSmallintProp write SetSmallintProp stored False;
    property TabWidthStyle: TOleEnum index 8 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ClientTop: Single index 9 read GetSingleProp write SetSingleProp stored False;
    property ClientLeft: Single index 10 read GetSingleProp write SetSingleProp stored False;
    property ClientHeight: Single index 11 read GetSingleProp write SetSingleProp stored False;
    property ClientWidth: Single index 12 read GetSingleProp write SetSingleProp stored False;
    property MousePointer: TOleEnum index 2 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property TabFixedHeight: Smallint index 14 read GetSmallintProp write SetSmallintProp stored False;
    property ShowTips: WordBool index 3 read GetWordBoolProp write SetWordBoolProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property HotTracking: WordBool index 16 read GetWordBoolProp write SetWordBoolProp stored False;
    property MultiSelect: WordBool index 17 read GetWordBoolProp write SetWordBoolProp stored False;
    property Placement: TOleEnum index 18 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Separators: WordBool index 19 read GetWordBoolProp write SetWordBoolProp stored False;
    property TabMinWidth: Single index 20 read GetSingleProp write SetSingleProp stored False;
    property TabStyle: TOleEnum index 21 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnBeforeClick: TTabStripBeforeClick read FOnBeforeClick write FOnBeforeClick;
    property OnOLEStartDrag: TTabStripOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TTabStripOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TTabStripOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TTabStripOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TTabStripOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TTabStripOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
  end;

// *********************************************************************//
// The Class CoTabs provides a Create and CreateRemote method to          
// create instances of the default interface ITabs exposed by              
// the CoClass Tabs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTabs = class
    class function Create: ITabs;
    class function CreateRemote(const MachineName: string): ITabs;
  end;

// *********************************************************************//
// The Class CoTab provides a Create and CreateRemote method to          
// create instances of the default interface ITab exposed by              
// the CoClass Tab. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTab = class
    class function Create: ITab;
    class function CreateRemote(const MachineName: string): ITab;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMSToolbar
// Help String      : Microsoft Toolbar Control
// Default Interface: IToolbar
// Def. Intf. DISP? : No
// Event   Interface: IToolbarEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSToolbarButtonClick = procedure(ASender: TObject; const Button: Button) of object;
  TMSToolbarOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                       var AllowedEffects: Integer) of object;
  TMSToolbarOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                          var DefaultCursors: WordBool) of object;
  TMSToolbarOLESetData = procedure(ASender: TObject; var Data: DataObject; var DataFormat: Smallint) of object;
  TMSToolbarOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TMSToolbarOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                      var Button: Smallint; var Shift: Smallint; 
                                                      var x: Single; var y: Single; 
                                                      var State: Smallint) of object;
  TMSToolbarOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                      var Button: Smallint; var Shift: Smallint; 
                                                      var x: Single; var y: Single) of object;
  TMSToolbarButtonMenuClick = procedure(ASender: TObject; const ButtonMenu: ButtonMenu) of object;
  TMSToolbarButtonDropDown = procedure(ASender: TObject; const Button: Button) of object;

  TMSToolbar = class(TOleControl)
  private
    FOnButtonClick: TMSToolbarButtonClick;
    FOnChange: TNotifyEvent;
    FOnOLEStartDrag: TMSToolbarOLEStartDrag;
    FOnOLEGiveFeedback: TMSToolbarOLEGiveFeedback;
    FOnOLESetData: TMSToolbarOLESetData;
    FOnOLECompleteDrag: TMSToolbarOLECompleteDrag;
    FOnOLEDragOver: TMSToolbarOLEDragOver;
    FOnOLEDragDrop: TMSToolbarOLEDragDrop;
    FOnButtonMenuClick: TMSToolbarButtonMenuClick;
    FOnButtonDropDown: TMSToolbarButtonDropDown;
    FIntf: IToolbar;
    function  GetControlInterface: IToolbar;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_Buttons: IButtons;
    procedure _Set_Buttons(const ppButtons: IButtons);
    function Get_Controls: IControls;
    function Get_ImageList: IDispatch;
    procedure Set_ImageList(const ppImageList: IDispatch);
    procedure _Set_ImageList(const ppImageList: IDispatch);
    function Get_DisabledImageList: IDispatch;
    procedure Set_DisabledImageList(const ppDisabledImageList: IDispatch);
    procedure _Set_DisabledImageList(const ppDisabledImageList: IDispatch);
    function Get_HotImageList: IDispatch;
    procedure Set_HotImageList(const ppHotImageList: IDispatch);
    procedure _Set_HotImageList(const ppHotImageList: IDispatch);
  public
    procedure Refresh;
    procedure Customize;
    procedure SaveToolbar(const Key: WideString; const Subkey: WideString; const Value: WideString);
    procedure RestoreToolbar(const Key: WideString; const Subkey: WideString; 
                             const Value: WideString);
    procedure OLEDrag;
    procedure AboutBox;
    property  ControlInterface: IToolbar read GetControlInterface;
    property  DefaultInterface: IToolbar read GetControlInterface;
    property Buttons: IButtons read Get_Buttons write _Set_Buttons;
    property Controls: IControls read Get_Controls;
    property ImageList: IDispatch index 5 read GetIDispatchProp write SetIDispatchProp;
    property DisabledImageList: IDispatch index 17 read GetIDispatchProp write SetIDispatchProp;
    property HotImageList: IDispatch index 18 read GetIDispatchProp write SetIDispatchProp;
  published
    property Anchors;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnDblClick;
    property  OnClick;
    property Appearance: TOleEnum index -520 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property AllowCustomize: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property MouseIcon: TPicture index 4 read GetTPictureProp write SetTPictureProp stored False;
    property MousePointer: TOleEnum index 1 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ShowTips: WordBool index 6 read GetWordBoolProp write SetWordBoolProp stored False;
    property BorderStyle: TOleEnum index -504 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Wrappable: WordBool index 7 read GetWordBoolProp write SetWordBoolProp stored False;
    property ButtonHeight: Single index 8 read GetSingleProp write SetSingleProp stored False;
    property ButtonWidth: Single index 9 read GetSingleProp write SetSingleProp stored False;
    property HelpContextID: Integer index 13 read GetIntegerProp write SetIntegerProp stored False;
    property HelpFile: WideString index 14 read GetWideStringProp write SetWideStringProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Style: TOleEnum index 16 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property TextAlignment: TOleEnum index 19 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnButtonClick: TMSToolbarButtonClick read FOnButtonClick write FOnButtonClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnOLEStartDrag: TMSToolbarOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TMSToolbarOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TMSToolbarOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TMSToolbarOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TMSToolbarOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TMSToolbarOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
    property OnButtonMenuClick: TMSToolbarButtonMenuClick read FOnButtonMenuClick write FOnButtonMenuClick;
    property OnButtonDropDown: TMSToolbarButtonDropDown read FOnButtonDropDown write FOnButtonDropDown;
  end;

// *********************************************************************//
// The Class CoButtons provides a Create and CreateRemote method to          
// create instances of the default interface IButtons exposed by              
// the CoClass Buttons. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButtons = class
    class function Create: IButtons;
    class function CreateRemote(const MachineName: string): IButtons;
  end;

// *********************************************************************//
// The Class CoButton provides a Create and CreateRemote method to          
// create instances of the default interface IButton exposed by              
// the CoClass Button. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButton = class
    class function Create: IButton;
    class function CreateRemote(const MachineName: string): IButton;
  end;

// *********************************************************************//
// The Class CoButtonMenus provides a Create and CreateRemote method to          
// create instances of the default interface IButtonMenus exposed by              
// the CoClass ButtonMenus. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButtonMenus = class
    class function Create: IButtonMenus;
    class function CreateRemote(const MachineName: string): IButtonMenus;
  end;

// *********************************************************************//
// The Class CoButtonMenu provides a Create and CreateRemote method to          
// create instances of the default interface IButtonMenu exposed by              
// the CoClass ButtonMenu. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButtonMenu = class
    class function Create: IButtonMenu;
    class function CreateRemote(const MachineName: string): IButtonMenu;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMSStatusBar
// Help String      : Microsoft StatusBar Control
// Default Interface: IStatusBar
// Def. Intf. DISP? : No
// Event   Interface: IStatusBarEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSStatusBarPanelClick = procedure(ASender: TObject; const Panel: Panel) of object;
  TMSStatusBarPanelDblClick = procedure(ASender: TObject; const Panel: Panel) of object;
  TMSStatusBarOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                         var AllowedEffects: Integer) of object;
  TMSStatusBarOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                            var DefaultCursors: WordBool) of object;
  TMSStatusBarOLESetData = procedure(ASender: TObject; var Data: DataObject; 
                                                       var DataFormat: Smallint) of object;
  TMSStatusBarOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TMSStatusBarOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                        var Button: Smallint; var Shift: Smallint; 
                                                        var x: Single; var y: Single; 
                                                        var State: Smallint) of object;
  TMSStatusBarOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                        var Button: Smallint; var Shift: Smallint; 
                                                        var x: Single; var y: Single) of object;

  TMSStatusBar = class(TOleControl)
  private
    FOnPanelClick: TMSStatusBarPanelClick;
    FOnPanelDblClick: TMSStatusBarPanelDblClick;
    FOnOLEStartDrag: TMSStatusBarOLEStartDrag;
    FOnOLEGiveFeedback: TMSStatusBarOLEGiveFeedback;
    FOnOLESetData: TMSStatusBarOLESetData;
    FOnOLECompleteDrag: TMSStatusBarOLECompleteDrag;
    FOnOLEDragOver: TMSStatusBarOLEDragOver;
    FOnOLEDragDrop: TMSStatusBarOLEDragDrop;
    FIntf: IStatusBar;
    function  GetControlInterface: IStatusBar;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_Panels: IPanels;
    procedure _Set_Panels(const ppPanels: IPanels);
  public
    procedure Refresh;
    procedure OLEDrag;
    procedure AboutBox;
    property  ControlInterface: IStatusBar read GetControlInterface;
    property  DefaultInterface: IStatusBar read GetControlInterface;
    property Panels: IPanels read Get_Panels write _Set_Panels;
    property PanelProperties: WideString index 6 read GetWideStringProp write SetWideStringProp;
    property Font: TFont index -512 read GetTFontProp write _SetTFontProp;
  published
    property Anchors;
    property  ParentFont;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnDblClick;
    property  OnClick;
    property SimpleText: WideString index 1 read GetWideStringProp write SetWideStringProp stored False;
    property Style: TOleEnum index 2 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MousePointer: TOleEnum index 4 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MouseIcon: TPicture index 5 read GetTPictureProp write SetTPictureProp stored False;
    property ShowTips: WordBool index 7 read GetWordBoolProp write SetWordBoolProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property OnPanelClick: TMSStatusBarPanelClick read FOnPanelClick write FOnPanelClick;
    property OnPanelDblClick: TMSStatusBarPanelDblClick read FOnPanelDblClick write FOnPanelDblClick;
    property OnOLEStartDrag: TMSStatusBarOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TMSStatusBarOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TMSStatusBarOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TMSStatusBarOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TMSStatusBarOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TMSStatusBarOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
  end;

// *********************************************************************//
// The Class CoPanels provides a Create and CreateRemote method to          
// create instances of the default interface IPanels exposed by              
// the CoClass Panels. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPanels = class
    class function Create: IPanels;
    class function CreateRemote(const MachineName: string): IPanels;
  end;

// *********************************************************************//
// The Class CoPanel provides a Create and CreateRemote method to          
// create instances of the default interface IPanel exposed by              
// the CoClass Panel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPanel = class
    class function Create: IPanel;
    class function CreateRemote(const MachineName: string): IPanel;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMSProgressBar
// Help String      : Microsoft ProgressBar Control
// Default Interface: IProgressBar
// Def. Intf. DISP? : No
// Event   Interface: IProgressBarEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSProgressBarOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                           var AllowedEffects: Integer) of object;
  TMSProgressBarOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                              var DefaultCursors: WordBool) of object;
  TMSProgressBarOLESetData = procedure(ASender: TObject; var Data: DataObject; 
                                                         var DataFormat: Smallint) of object;
  TMSProgressBarOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TMSProgressBarOLEDragOver = procedure(ASender: TObject; var Data: DataObject; 
                                                          var Effect: Integer; 
                                                          var Button: Smallint; 
                                                          var Shift: Smallint; var x: Single; 
                                                          var y: Single; var State: Smallint) of object;
  TMSProgressBarOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; 
                                                          var Effect: Integer; 
                                                          var Button: Smallint; 
                                                          var Shift: Smallint; var x: Single; 
                                                          var y: Single) of object;

  TMSProgressBar = class(TOleControl)
  private
    FOnOLEStartDrag: TMSProgressBarOLEStartDrag;
    FOnOLEGiveFeedback: TMSProgressBarOLEGiveFeedback;
    FOnOLESetData: TMSProgressBarOLESetData;
    FOnOLECompleteDrag: TMSProgressBarOLECompleteDrag;
    FOnOLEDragOver: TMSProgressBarOLEDragOver;
    FOnOLEDragDrop: TMSProgressBarOLEDragDrop;
    FIntf: IProgressBar;
    function  GetControlInterface: IProgressBar;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure OLEDrag;
    procedure AboutBox;
    procedure Refresh;
    property  ControlInterface: IProgressBar read GetControlInterface;
    property  DefaultInterface: IProgressBar read GetControlInterface;
    property ControlDefault: Single index 0 read GetSingleProp write SetSingleProp;
    property hWnd: Integer index -515 read GetIntegerProp;
  published
    property Anchors;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnClick;
    property Max: Single index 1 read GetSingleProp write SetSingleProp stored False;
    property Min: Single index 2 read GetSingleProp write SetSingleProp stored False;
    property MousePointer: TOleEnum index 3 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MouseIcon: TPicture index 4 read GetTPictureProp write SetTPictureProp stored False;
    property Value: Single index 5 read GetSingleProp write SetSingleProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Appearance: TOleEnum index -520 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index -504 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property Orientation: TOleEnum index 6 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Scrolling: TOleEnum index 7 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnOLEStartDrag: TMSProgressBarOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TMSProgressBarOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TMSProgressBarOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TMSProgressBarOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TMSProgressBarOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TMSProgressBarOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMSTreeView
// Help String      : Displays a hierarchical list of Node objects, each of which consists of a label and an optional bitmap.
// Default Interface: ITreeView
// Def. Intf. DISP? : No
// Event   Interface: ITreeViewEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSTreeViewBeforeLabelEdit = procedure(ASender: TObject; var Cancel: Smallint) of object;
  TMSTreeViewAfterLabelEdit = procedure(ASender: TObject; var Cancel: Smallint; 
                                                          var NewString: WideString) of object;
  TMSTreeViewCollapse = procedure(ASender: TObject; const Node: Node) of object;
  TMSTreeViewExpand = procedure(ASender: TObject; const Node: Node) of object;
  TMSTreeViewNodeClick = procedure(ASender: TObject; const Node: Node) of object;
  TMSTreeViewNodeCheck = procedure(ASender: TObject; const Node: Node) of object;
  TMSTreeViewOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                        var AllowedEffects: Integer) of object;
  TMSTreeViewOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                           var DefaultCursors: WordBool) of object;
  TMSTreeViewOLESetData = procedure(ASender: TObject; var Data: DataObject; var DataFormat: Smallint) of object;
  TMSTreeViewOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TMSTreeViewOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                       var Button: Smallint; var Shift: Smallint; 
                                                       var x: Single; var y: Single; 
                                                       var State: Smallint) of object;
  TMSTreeViewOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                       var Button: Smallint; var Shift: Smallint; 
                                                       var x: Single; var y: Single) of object;

  TMSTreeView = class(TOleControl)
  private
    FOnBeforeLabelEdit: TMSTreeViewBeforeLabelEdit;
    FOnAfterLabelEdit: TMSTreeViewAfterLabelEdit;
    FOnCollapse: TMSTreeViewCollapse;
    FOnExpand: TMSTreeViewExpand;
    FOnNodeClick: TMSTreeViewNodeClick;
    FOnNodeCheck: TMSTreeViewNodeCheck;
    FOnOLEStartDrag: TMSTreeViewOLEStartDrag;
    FOnOLEGiveFeedback: TMSTreeViewOLEGiveFeedback;
    FOnOLESetData: TMSTreeViewOLESetData;
    FOnOLECompleteDrag: TMSTreeViewOLECompleteDrag;
    FOnOLEDragOver: TMSTreeViewOLEDragOver;
    FOnOLEDragDrop: TMSTreeViewOLEDragDrop;
    FIntf: ITreeView;
    function  GetControlInterface: ITreeView;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_DropHighlight: INode;
    procedure _Set_DropHighlight(const ppNode: INode);
    function Get_ImageList: IDispatch;
    procedure _Set_ImageList(const ppImageList: IDispatch);
    procedure Set_ImageList(const ppImageList: IDispatch);
    function Get_Nodes: INodes;
    procedure _Set_Nodes(const ppNode: INodes);
    function Get_SelectedItem: INode;
    procedure _Set_SelectedItem(const ppNode: INode);
  public
    function HitTest(x: Single; y: Single): INode;
    function GetVisibleCount: Integer;
    procedure StartLabelEdit;
    procedure Refresh;
    procedure AboutBox;
    procedure OLEDrag;
    property  ControlInterface: ITreeView read GetControlInterface;
    property  DefaultInterface: ITreeView read GetControlInterface;
    property ImageList: IDispatch index 3 read GetIDispatchProp write SetIDispatchProp;
    property Nodes: INodes read Get_Nodes write _Set_Nodes;
  published
    property Anchors;
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnKeyUp;
    property  OnKeyPress;
    property  OnKeyDown;
    property  OnDblClick;
    property  OnClick;
    property HideSelection: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property Indentation: Single index 4 read GetSingleProp write SetSingleProp stored False;
    property LabelEdit: TOleEnum index 5 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LineStyle: TOleEnum index 6 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MousePointer: TOleEnum index 7 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MouseIcon: TPicture index 8 read GetTPictureProp write SetTPictureProp stored False;
    property PathSeparator: WideString index 10 read GetWideStringProp write SetWideStringProp stored False;
    property Sorted: WordBool index 12 read GetWordBoolProp write SetWordBoolProp stored False;
    property Style: TOleEnum index 13 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDragMode: TOleEnum index 1550 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Appearance: TOleEnum index -520 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index -504 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property Checkboxes: WordBool index 17 read GetWordBoolProp write SetWordBoolProp stored False;
    property FullRowSelect: WordBool index 18 read GetWordBoolProp write SetWordBoolProp stored False;
    property HotTracking: WordBool index 19 read GetWordBoolProp write SetWordBoolProp stored False;
    property Scroll: WordBool index 20 read GetWordBoolProp write SetWordBoolProp stored False;
    property SingleSel: WordBool index 21 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnBeforeLabelEdit: TMSTreeViewBeforeLabelEdit read FOnBeforeLabelEdit write FOnBeforeLabelEdit;
    property OnAfterLabelEdit: TMSTreeViewAfterLabelEdit read FOnAfterLabelEdit write FOnAfterLabelEdit;
    property OnCollapse: TMSTreeViewCollapse read FOnCollapse write FOnCollapse;
    property OnExpand: TMSTreeViewExpand read FOnExpand write FOnExpand;
    property OnNodeClick: TMSTreeViewNodeClick read FOnNodeClick write FOnNodeClick;
    property OnNodeCheck: TMSTreeViewNodeCheck read FOnNodeCheck write FOnNodeCheck;
    property OnOLEStartDrag: TMSTreeViewOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TMSTreeViewOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TMSTreeViewOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TMSTreeViewOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TMSTreeViewOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TMSTreeViewOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
  end;

// *********************************************************************//
// The Class CoNodes provides a Create and CreateRemote method to          
// create instances of the default interface INodes exposed by              
// the CoClass Nodes. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNodes = class
    class function Create: INodes;
    class function CreateRemote(const MachineName: string): INodes;
  end;

// *********************************************************************//
// The Class CoNode provides a Create and CreateRemote method to          
// create instances of the default interface INode exposed by              
// the CoClass Node. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNode = class
    class function Create: INode;
    class function CreateRemote(const MachineName: string): INode;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMSListView
// Help String      : Displays a collection of ListItems such as files or folders.
// Default Interface: IListView
// Def. Intf. DISP? : No
// Event   Interface: ListViewEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSListViewBeforeLabelEdit = procedure(ASender: TObject; var Cancel: Smallint) of object;
  TMSListViewAfterLabelEdit = procedure(ASender: TObject; var Cancel: Smallint; 
                                                          var NewString: WideString) of object;
  TMSListViewColumnClick = procedure(ASender: TObject; const ColumnHeader: ColumnHeader) of object;
  TMSListViewItemClick = procedure(ASender: TObject; const Item: ListItem) of object;
  TMSListViewOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                        var AllowedEffects: Integer) of object;
  TMSListViewOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                           var DefaultCursors: WordBool) of object;
  TMSListViewOLESetData = procedure(ASender: TObject; var Data: DataObject; var DataFormat: Smallint) of object;
  TMSListViewOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TMSListViewOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                       var Button: Smallint; var Shift: Smallint; 
                                                       var x: Single; var y: Single; 
                                                       var State: Smallint) of object;
  TMSListViewOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                       var Button: Smallint; var Shift: Smallint; 
                                                       var x: Single; var y: Single) of object;
  TMSListViewItemCheck = procedure(ASender: TObject; const Item: ListItem) of object;

  TMSListView = class(TOleControl)
  private
    FOnBeforeLabelEdit: TMSListViewBeforeLabelEdit;
    FOnAfterLabelEdit: TMSListViewAfterLabelEdit;
    FOnColumnClick: TMSListViewColumnClick;
    FOnItemClick: TMSListViewItemClick;
    FOnOLEStartDrag: TMSListViewOLEStartDrag;
    FOnOLEGiveFeedback: TMSListViewOLEGiveFeedback;
    FOnOLESetData: TMSListViewOLESetData;
    FOnOLECompleteDrag: TMSListViewOLECompleteDrag;
    FOnOLEDragOver: TMSListViewOLEDragOver;
    FOnOLEDragDrop: TMSListViewOLEDragDrop;
    FOnItemCheck: TMSListViewItemCheck;
    FIntf: IListView;
    function  GetControlInterface: IListView;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ColumnHeaders: IColumnHeaders;
    procedure Set_ColumnHeaders(const ppIColumnHeaders: IColumnHeaders);
    function Get_DropHighlight: IListItem;
    procedure _Set_DropHighlight(const ppIListItem: IListItem);
    function Get_Icons: IDispatch;
    procedure _Set_Icons(const ppIcons: IDispatch);
    procedure Set_Icons(const ppIcons: IDispatch);
    function Get_ListItems: IListItems;
    procedure Set_ListItems(const ppListItems: IListItems);
    function Get_SelectedItem: IListItem;
    procedure _Set_SelectedItem(const ppListItem: IListItem);
    function Get_SmallIcons: IDispatch;
    procedure _Set_SmallIcons(const ppImageList: IDispatch);
    procedure Set_SmallIcons(const ppImageList: IDispatch);
    function Get_ColumnHeaderIcons: IDispatch;
    procedure _Set_ColumnHeaderIcons(const ppImageList: IDispatch);
    procedure Set_ColumnHeaderIcons(const ppImageList: IDispatch);
  public
    function FindItem(const sz: WideString): IListItem; overload;
    function FindItem(const sz: WideString; var Where: OleVariant): IListItem; overload;
    function FindItem(const sz: WideString; var Where: OleVariant; var Index: OleVariant): IListItem; overload;
    function FindItem(const sz: WideString; var Where: OleVariant; var Index: OleVariant; 
                      var fPartial: OleVariant): IListItem; overload;
    function GetFirstVisible: IListItem;
    function HitTest(x: Single; y: Single): IListItem;
    procedure StartLabelEdit;
    procedure OLEDrag;
    procedure Refresh;
    procedure AboutBox;
    property  ControlInterface: IListView read GetControlInterface;
    property  DefaultInterface: IListView read GetControlInterface;
    property Icons: IDispatch index 6 read GetIDispatchProp write SetIDispatchProp;
    property SmallIcons: IDispatch index 14 read GetIDispatchProp write SetIDispatchProp;
    property Font: TFont index -512 read GetTFontProp write _SetTFontProp;
    property ColumnHeaderIcons: IDispatch index 32 read GetIDispatchProp write SetIDispatchProp;
  published
    property Anchors;
    property  ParentColor;
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnKeyUp;
    property  OnKeyPress;
    property  OnKeyDown;
    property  OnDblClick;
    property  OnClick;
    property Arrange: TOleEnum index 1 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ColumnHeaders: IColumnHeaders read Get_ColumnHeaders write Set_ColumnHeaders stored False;
    property HideColumnHeaders: WordBool index 4 read GetWordBoolProp write SetWordBoolProp stored False;
    property HideSelection: WordBool index 5 read GetWordBoolProp write SetWordBoolProp stored False;
    property ListItems: IListItems read Get_ListItems write Set_ListItems stored False;
    property LabelEdit: TOleEnum index 8 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LabelWrap: WordBool index 9 read GetWordBoolProp write SetWordBoolProp stored False;
    property MouseIcon: TPicture index 10 read GetTPictureProp write SetTPictureProp stored False;
    property MousePointer: TOleEnum index 11 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MultiSelect: WordBool index 12 read GetWordBoolProp write SetWordBoolProp stored False;
    property Sorted: WordBool index 15 read GetWordBoolProp write SetWordBoolProp stored False;
    property SortKey: Smallint index 16 read GetSmallintProp write SetSmallintProp stored False;
    property SortOrder: TOleEnum index 17 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property View: TOleEnum index 18 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDragMode: TOleEnum index 1550 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Appearance: TOleEnum index -520 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BackColor: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property BorderStyle: TOleEnum index -504 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property ForeColor: TColor index -513 read GetTColorProp write SetTColorProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property AllowColumnReorder: WordBool index 23 read GetWordBoolProp write SetWordBoolProp stored False;
    property Checkboxes: WordBool index 24 read GetWordBoolProp write SetWordBoolProp stored False;
    property FlatScrollBar: WordBool index 25 read GetWordBoolProp write SetWordBoolProp stored False;
    property FullRowSelect: WordBool index 26 read GetWordBoolProp write SetWordBoolProp stored False;
    property GridLines: WordBool index 27 read GetWordBoolProp write SetWordBoolProp stored False;
    property HotTracking: WordBool index 28 read GetWordBoolProp write SetWordBoolProp stored False;
    property HoverSelection: WordBool index 29 read GetWordBoolProp write SetWordBoolProp stored False;
    property Picture: TPicture index 31 read GetTPictureProp write SetTPictureProp stored False;
    property PictureAlignment: TOleEnum index 30 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property TextBackground: TOleEnum index 33 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnBeforeLabelEdit: TMSListViewBeforeLabelEdit read FOnBeforeLabelEdit write FOnBeforeLabelEdit;
    property OnAfterLabelEdit: TMSListViewAfterLabelEdit read FOnAfterLabelEdit write FOnAfterLabelEdit;
    property OnColumnClick: TMSListViewColumnClick read FOnColumnClick write FOnColumnClick;
    property OnItemClick: TMSListViewItemClick read FOnItemClick write FOnItemClick;
    property OnOLEStartDrag: TMSListViewOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TMSListViewOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TMSListViewOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TMSListViewOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TMSListViewOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TMSListViewOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
    property OnItemCheck: TMSListViewItemCheck read FOnItemCheck write FOnItemCheck;
  end;

// *********************************************************************//
// The Class CoListItems provides a Create and CreateRemote method to          
// create instances of the default interface IListItems exposed by              
// the CoClass ListItems. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListItems = class
    class function Create: IListItems;
    class function CreateRemote(const MachineName: string): IListItems;
  end;

// *********************************************************************//
// The Class CoListItem provides a Create and CreateRemote method to          
// create instances of the default interface IListItem exposed by              
// the CoClass ListItem. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListItem = class
    class function Create: IListItem;
    class function CreateRemote(const MachineName: string): IListItem;
  end;

// *********************************************************************//
// The Class CoColumnHeaders provides a Create and CreateRemote method to          
// create instances of the default interface IColumnHeaders exposed by              
// the CoClass ColumnHeaders. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoColumnHeaders = class
    class function Create: IColumnHeaders;
    class function CreateRemote(const MachineName: string): IColumnHeaders;
  end;

// *********************************************************************//
// The Class CoColumnHeader provides a Create and CreateRemote method to          
// create instances of the default interface IColumnHeader exposed by              
// the CoClass ColumnHeader. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoColumnHeader = class
    class function Create: IColumnHeader;
    class function CreateRemote(const MachineName: string): IColumnHeader;
  end;

// *********************************************************************//
// The Class CoListSubItems provides a Create and CreateRemote method to          
// create instances of the default interface IListSubItems exposed by              
// the CoClass ListSubItems. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListSubItems = class
    class function Create: IListSubItems;
    class function CreateRemote(const MachineName: string): IListSubItems;
  end;

// *********************************************************************//
// The Class CoListSubItem provides a Create and CreateRemote method to          
// create instances of the default interface IListSubItem exposed by              
// the CoClass ListSubItem. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListSubItem = class
    class function Create: IListSubItem;
    class function CreateRemote(const MachineName: string): IListSubItem;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMSImageList
// Help String      : Contains a collection of ListImage objects, each of which can be referred to by its index or key
// Default Interface: IImageList
// Def. Intf. DISP? : No
// Event   Interface: ImageListEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSImageList = class(TOleControl)
  private
    FIntf: IImageList;
    function  GetControlInterface: IImageList;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ListImages: IImages;
    procedure _Set_ListImages(const ppListImages: IImages);
  public
    function Overlay(var Key1: OleVariant; var Key2: OleVariant): IPictureDisp;
    procedure AboutBox;
    property  ControlInterface: IImageList read GetControlInterface;
    property  DefaultInterface: IImageList read GetControlInterface;
    property ListImages: IImages read Get_ListImages write _Set_ListImages;
  published
    property Anchors;
    property ImageHeight: Smallint index 1 read GetSmallintProp write SetSmallintProp stored False;
    property ImageWidth: Smallint index 2 read GetSmallintProp write SetSmallintProp stored False;
    property MaskColor: TColor index 3 read GetTColorProp write SetTColorProp stored False;
    property UseMaskColor: WordBool index 7 read GetWordBoolProp write SetWordBoolProp stored False;
    property hImageList: Integer index 5 read GetIntegerProp write SetIntegerProp stored False;
    property BackColor: TColor index -501 read GetTColorProp write SetTColorProp stored False;
  end;

// *********************************************************************//
// The Class CoListImages provides a Create and CreateRemote method to          
// create instances of the default interface IImages exposed by              
// the CoClass ListImages. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListImages = class
    class function Create: IImages;
    class function CreateRemote(const MachineName: string): IImages;
  end;

// *********************************************************************//
// The Class CoListImage provides a Create and CreateRemote method to          
// create instances of the default interface IImage exposed by              
// the CoClass ListImage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListImage = class
    class function Create: IImage;
    class function CreateRemote(const MachineName: string): IImage;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TSlider
// Help String      : A calibrated control with a slider for setting or selecting values.
// Default Interface: ISlider
// Def. Intf. DISP? : No
// Event   Interface: ISliderEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TSliderOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                    var AllowedEffects: Integer) of object;
  TSliderOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                       var DefaultCursors: WordBool) of object;
  TSliderOLESetData = procedure(ASender: TObject; var Data: DataObject; var DataFormat: Smallint) of object;
  TSliderOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TSliderOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                   var Button: Smallint; var Shift: Smallint; 
                                                   var x: Single; var y: Single; var State: Smallint) of object;
  TSliderOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                   var Button: Smallint; var Shift: Smallint; 
                                                   var x: Single; var y: Single) of object;

  TSlider = class(TOleControl)
  private
    FOnScroll: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnOLEStartDrag: TSliderOLEStartDrag;
    FOnOLEGiveFeedback: TSliderOLEGiveFeedback;
    FOnOLESetData: TSliderOLESetData;
    FOnOLECompleteDrag: TSliderOLECompleteDrag;
    FOnOLEDragOver: TSliderOLEDragOver;
    FOnOLEDragDrop: TSliderOLEDragDrop;
    FIntf: ISlider;
    function  GetControlInterface: ISlider;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure Refresh;
    procedure ClearSel;
    procedure DoClick;
    procedure OLEDrag;
    procedure AboutBox;
    property  ControlInterface: ISlider read GetControlInterface;
    property  DefaultInterface: ISlider read GetControlInterface;
    property _Value: Integer index 0 read GetIntegerProp write SetIntegerProp;
    property GetNumTicks: Integer index 15 read GetIntegerProp;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseDown;
    property  OnKeyUp;
    property  OnKeyPress;
    property  OnKeyDown;
    property  OnClick;
    property LargeChange: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
    property SmallChange: Integer index 2 read GetIntegerProp write SetIntegerProp stored False;
    property Max: Integer index 3 read GetIntegerProp write SetIntegerProp stored False;
    property Min: Integer index 4 read GetIntegerProp write SetIntegerProp stored False;
    property Orientation: TOleEnum index 5 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property SelectRange: WordBool index 6 read GetWordBoolProp write SetWordBoolProp stored False;
    property SelStart: Integer index 7 read GetIntegerProp write SetIntegerProp stored False;
    property SelLength: Integer index 8 read GetIntegerProp write SetIntegerProp stored False;
    property TickStyle: TOleEnum index 9 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property TickFrequency: Integer index 10 read GetIntegerProp write SetIntegerProp stored False;
    property Value: Integer index 11 read GetIntegerProp write SetIntegerProp stored False;
    property MouseIcon: TPicture index 12 read GetTPictureProp write SetTPictureProp stored False;
    property MousePointer: TOleEnum index 13 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property BorderStyle: TOleEnum index -504 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Text: WideString index 16 read GetWideStringProp write SetWideStringProp stored False;
    property TextPosition: TOleEnum index 17 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnOLEStartDrag: TSliderOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TSliderOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TSliderOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TSliderOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TSliderOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TSliderOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
  end;

// *********************************************************************//
// The Class CoControls provides a Create and CreateRemote method to          
// create instances of the default interface IControls exposed by              
// the CoClass Controls. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoControls = class
    class function Create: IControls;
    class function CreateRemote(const MachineName: string): IControls;
  end;

// *********************************************************************//
// The Class CoComboItem provides a Create and CreateRemote method to          
// create instances of the default interface IComboItem exposed by              
// the CoClass ComboItem. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComboItem = class
    class function Create: IComboItem;
    class function CreateRemote(const MachineName: string): IComboItem;
  end;

// *********************************************************************//
// The Class CoComboItems provides a Create and CreateRemote method to          
// create instances of the default interface IComboItems exposed by              
// the CoClass ComboItems. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComboItems = class
    class function Create: IComboItems;
    class function CreateRemote(const MachineName: string): IComboItems;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TImageCombo
// Help String      : Microsoft ImageComboBox Control
// Default Interface: IImageCombo
// Def. Intf. DISP? : No
// Event   Interface: DImageComboEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TImageComboOLEStartDrag = procedure(ASender: TObject; var Data: DataObject; 
                                                        var AllowedEffects: Integer) of object;
  TImageComboOLEGiveFeedback = procedure(ASender: TObject; var Effect: Integer; 
                                                           var DefaultCursors: WordBool) of object;
  TImageComboOLESetData = procedure(ASender: TObject; var Data: DataObject; var DataFormat: Smallint) of object;
  TImageComboOLECompleteDrag = procedure(ASender: TObject; var Effect: Integer) of object;
  TImageComboOLEDragOver = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                       var Button: Smallint; var Shift: Smallint; 
                                                       var x: Single; var y: Single; 
                                                       var State: Smallint) of object;
  TImageComboOLEDragDrop = procedure(ASender: TObject; var Data: DataObject; var Effect: Integer; 
                                                       var Button: Smallint; var Shift: Smallint; 
                                                       var x: Single; var y: Single) of object;

  TImageCombo = class(TDBOleControl)
  private
    FOnChange: TNotifyEvent;
    FOnDropdown: TNotifyEvent;
    FOnOLEStartDrag: TImageComboOLEStartDrag;
    FOnOLEGiveFeedback: TImageComboOLEGiveFeedback;
    FOnOLESetData: TImageComboOLESetData;
    FOnOLECompleteDrag: TImageComboOLECompleteDrag;
    FOnOLEDragOver: TImageComboOLEDragOver;
    FOnOLEDragDrop: TImageComboOLEDragDrop;
    FIntf: IImageCombo;
    function  GetControlInterface: IImageCombo;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ImageList: IDispatch;
    procedure _Set_ImageList(const ppImageList: IDispatch);
    procedure Set_ImageList(const ppImageList: IDispatch);
    function Get_ComboItems: IComboItems;
    procedure _Set_ComboItems(const ppComboItems: IComboItems);
    function Get_SelectedItem: IComboItem;
    procedure _Set_SelectedItem(const ppIComboItem: IComboItem);
  public
    procedure AboutBox;
    function GetFirstVisible: IComboItem;
    procedure Refresh;
    procedure OLEDrag;
    property  ControlInterface: IImageCombo read GetControlInterface;
    property  DefaultInterface: IImageCombo read GetControlInterface;
    property ImageList: IDispatch index 3 read GetIDispatchProp write SetIDispatchProp;
    property ComboItems: IComboItems read Get_ComboItems write _Set_ComboItems;
  published
    property Anchors;
    property  ParentColor;
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnKeyUp;
    property  OnKeyPress;
    property  OnKeyDown;
    property  OnClick;
    property Text: WideString index -517 read GetWideStringProp write SetWideStringProp stored False;
    property BackColor: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property ForeColor: TColor index -513 read GetTColorProp write SetTColorProp stored False;
    property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    property Indentation: Smallint index 4 read GetSmallintProp write SetSmallintProp stored False;
    property Locked: WordBool index 9 read GetWordBoolProp write SetWordBoolProp stored False;
    property MouseIcon: TPicture index 10 read GetTPictureProp write SetTPictureProp stored False;
    property MousePointer: TOleEnum index 11 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDragMode: TOleEnum index 1550 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OLEDropMode: TOleEnum index 1551 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property SelLength: Integer index 16 read GetIntegerProp write SetIntegerProp stored False;
    property SelStart: Integer index 17 read GetIntegerProp write SetIntegerProp stored False;
    property SelText: WideString index 18 read GetWideStringProp write SetWideStringProp stored False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDropdown: TNotifyEvent read FOnDropdown write FOnDropdown;
    property OnOLEStartDrag: TImageComboOLEStartDrag read FOnOLEStartDrag write FOnOLEStartDrag;
    property OnOLEGiveFeedback: TImageComboOLEGiveFeedback read FOnOLEGiveFeedback write FOnOLEGiveFeedback;
    property OnOLESetData: TImageComboOLESetData read FOnOLESetData write FOnOLESetData;
    property OnOLECompleteDrag: TImageComboOLECompleteDrag read FOnOLECompleteDrag write FOnOLECompleteDrag;
    property OnOLEDragOver: TImageComboOLEDragOver read FOnOLEDragOver write FOnOLEDragOver;
    property OnOLEDragDrop: TImageComboOLEDragDrop read FOnOLEDragDrop write FOnOLEDragDrop;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoDataObject.Create: IVBDataObject;
begin
  Result := CreateComObject(CLASS_DataObject) as IVBDataObject;
end;

class function CoDataObject.CreateRemote(const MachineName: string): IVBDataObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataObject) as IVBDataObject;
end;

class function CoDataObjectFiles.Create: IVBDataObjectFiles;
begin
  Result := CreateComObject(CLASS_DataObjectFiles) as IVBDataObjectFiles;
end;

class function CoDataObjectFiles.CreateRemote(const MachineName: string): IVBDataObjectFiles;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataObjectFiles) as IVBDataObjectFiles;
end;

procedure TTabStrip.InitControlData;
const
  CEventDispIDs: array [0..6] of DWORD = (
    $00000001, $0000060E, $0000060F, $00000610, $00000611, $00000612,
    $00000613);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CTPictureIDs: array [0..0] of DWORD = (
    $00000005);
  CControlData: TControlData2 = (
    ClassID: '{1EFB6596-857C-11D1-B16A-00C0F0283628}';
    EventIID: '{1EFB6595-857C-11D1-B16A-00C0F0283628}';
    EventCount: 7;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $0000000C;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnBeforeClick) - Cardinal(Self);
end;

procedure TTabStrip.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ITabStrip;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TTabStrip.GetControlInterface: ITabStrip;
begin
  CreateControl;
  Result := FIntf;
end;

function TTabStrip.Get_Tabs: ITabs;
begin
    Result := DefaultInterface.Tabs;
end;

procedure TTabStrip._Set_Tabs(const ppTabs: ITabs);
  { Warning: The property Tabs has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Tabs := ppTabs;
end;

function TTabStrip.Get_ImageList: IDispatch;
begin
    Result := DefaultInterface.ImageList;
end;

procedure TTabStrip.Set_ImageList(const ppImageList: IDispatch);
begin
  DefaultInterface.Set_ImageList(ppImageList);
end;

procedure TTabStrip._Set_ImageList(const ppImageList: IDispatch);
  { Warning: The property ImageList has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ImageList := ppImageList;
end;

function TTabStrip.Get_SelectedItem: ITab;
begin
  Result := DefaultInterface.Get_SelectedItem;
end;

procedure TTabStrip._Set_SelectedItem(const ppSelectedItem: ITab);
  { Warning: The property SelectedItem has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SelectedItem := ppSelectedItem;
end;

procedure TTabStrip.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TTabStrip.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure TTabStrip.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TTabStrip.DeselectAll;
begin
  DefaultInterface.DeselectAll;
end;

class function CoTabs.Create: ITabs;
begin
  Result := CreateComObject(CLASS_Tabs) as ITabs;
end;

class function CoTabs.CreateRemote(const MachineName: string): ITabs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Tabs) as ITabs;
end;

class function CoTab.Create: ITab;
begin
  Result := CreateComObject(CLASS_Tab) as ITab;
end;

class function CoTab.CreateRemote(const MachineName: string): ITab;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Tab) as ITab;
end;

procedure TMSToolbar.InitControlData;
const
  CEventDispIDs: array [0..9] of DWORD = (
    $00000001, $00000002, $0000060E, $0000060F, $00000610, $00000611,
    $00000612, $00000613, $00000003, $00000004);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTPictureIDs: array [0..0] of DWORD = (
    $00000004);
  CControlData: TControlData2 = (
    ClassID: '{66833FE6-8583-11D1-B16A-00C0F0283628}';
    EventIID: '{66833FE5-8583-11D1-B16A-00C0F0283628}';
    EventCount: 10;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $00000008;
    Version: 401;
    FontCount: 0;
    FontIDs: nil;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnButtonClick) - Cardinal(Self);
end;

procedure TMSToolbar.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IToolbar;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSToolbar.GetControlInterface: IToolbar;
begin
  CreateControl;
  Result := FIntf;
end;

function TMSToolbar.Get_Buttons: IButtons;
begin
    Result := DefaultInterface.Buttons;
end;

procedure TMSToolbar._Set_Buttons(const ppButtons: IButtons);
  { Warning: The property Buttons has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Buttons := ppButtons;
end;

function TMSToolbar.Get_Controls: IControls;
begin
    Result := DefaultInterface.Controls;
end;

function TMSToolbar.Get_ImageList: IDispatch;
begin
    Result := DefaultInterface.ImageList;
end;

procedure TMSToolbar.Set_ImageList(const ppImageList: IDispatch);
begin
  DefaultInterface.Set_ImageList(ppImageList);
end;

procedure TMSToolbar._Set_ImageList(const ppImageList: IDispatch);
  { Warning: The property ImageList has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ImageList := ppImageList;
end;

function TMSToolbar.Get_DisabledImageList: IDispatch;
begin
    Result := DefaultInterface.DisabledImageList;
end;

procedure TMSToolbar.Set_DisabledImageList(const ppDisabledImageList: IDispatch);
begin
  DefaultInterface.Set_DisabledImageList(ppDisabledImageList);
end;

procedure TMSToolbar._Set_DisabledImageList(const ppDisabledImageList: IDispatch);
  { Warning: The property DisabledImageList has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DisabledImageList := ppDisabledImageList;
end;

function TMSToolbar.Get_HotImageList: IDispatch;
begin
    Result := DefaultInterface.HotImageList;
end;

procedure TMSToolbar.Set_HotImageList(const ppHotImageList: IDispatch);
begin
  DefaultInterface.Set_HotImageList(ppHotImageList);
end;

procedure TMSToolbar._Set_HotImageList(const ppHotImageList: IDispatch);
  { Warning: The property HotImageList has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.HotImageList := ppHotImageList;
end;

procedure TMSToolbar.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TMSToolbar.Customize;
begin
  DefaultInterface.Customize;
end;

procedure TMSToolbar.SaveToolbar(const Key: WideString; const Subkey: WideString; 
                                 const Value: WideString);
begin
  DefaultInterface.SaveToolbar(Key, Subkey, Value);
end;

procedure TMSToolbar.RestoreToolbar(const Key: WideString; const Subkey: WideString; 
                                    const Value: WideString);
begin
  DefaultInterface.RestoreToolbar(Key, Subkey, Value);
end;

procedure TMSToolbar.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure TMSToolbar.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoButtons.Create: IButtons;
begin
  Result := CreateComObject(CLASS_Buttons) as IButtons;
end;

class function CoButtons.CreateRemote(const MachineName: string): IButtons;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Buttons) as IButtons;
end;

class function CoButton.Create: IButton;
begin
  Result := CreateComObject(CLASS_Button) as IButton;
end;

class function CoButton.CreateRemote(const MachineName: string): IButton;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Button) as IButton;
end;

class function CoButtonMenus.Create: IButtonMenus;
begin
  Result := CreateComObject(CLASS_ButtonMenus) as IButtonMenus;
end;

class function CoButtonMenus.CreateRemote(const MachineName: string): IButtonMenus;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ButtonMenus) as IButtonMenus;
end;

class function CoButtonMenu.Create: IButtonMenu;
begin
  Result := CreateComObject(CLASS_ButtonMenu) as IButtonMenu;
end;

class function CoButtonMenu.CreateRemote(const MachineName: string): IButtonMenu;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ButtonMenu) as IButtonMenu;
end;

procedure TMSStatusBar.InitControlData;
const
  CEventDispIDs: array [0..7] of DWORD = (
    $00000001, $00000002, $0000060E, $0000060F, $00000610, $00000611,
    $00000612, $00000613);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CTPictureIDs: array [0..0] of DWORD = (
    $00000005);
  CControlData: TControlData2 = (
    ClassID: '{8E3867A3-8586-11D1-B16A-00C0F0283628}';
    EventIID: '{8E3867A2-8586-11D1-B16A-00C0F0283628}';
    EventCount: 8;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $0000000C;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnPanelClick) - Cardinal(Self);
end;

procedure TMSStatusBar.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IStatusBar;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSStatusBar.GetControlInterface: IStatusBar;
begin
  CreateControl;
  Result := FIntf;
end;

function TMSStatusBar.Get_Panels: IPanels;
begin
    Result := DefaultInterface.Panels;
end;

procedure TMSStatusBar._Set_Panels(const ppPanels: IPanels);
  { Warning: The property Panels has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Panels := ppPanels;
end;

procedure TMSStatusBar.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TMSStatusBar.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure TMSStatusBar.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoPanels.Create: IPanels;
begin
  Result := CreateComObject(CLASS_Panels) as IPanels;
end;

class function CoPanels.CreateRemote(const MachineName: string): IPanels;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Panels) as IPanels;
end;

class function CoPanel.Create: IPanel;
begin
  Result := CreateComObject(CLASS_Panel) as IPanel;
end;

class function CoPanel.CreateRemote(const MachineName: string): IPanel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Panel) as IPanel;
end;

procedure TMSProgressBar.InitControlData;
const
  CEventDispIDs: array [0..5] of DWORD = (
    $0000060E, $0000060F, $00000610, $00000611, $00000612, $00000613);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTPictureIDs: array [0..0] of DWORD = (
    $00000004);
  CControlData: TControlData2 = (
    ClassID: '{35053A22-8589-11D1-B16A-00C0F0283628}';
    EventIID: '{35053A21-8589-11D1-B16A-00C0F0283628}';
    EventCount: 6;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $00000008;
    Version: 401;
    FontCount: 0;
    FontIDs: nil;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnOLEStartDrag) - Cardinal(Self);
end;

procedure TMSProgressBar.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IProgressBar;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSProgressBar.GetControlInterface: IProgressBar;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TMSProgressBar.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure TMSProgressBar.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TMSProgressBar.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TMSTreeView.InitControlData;
const
  CEventDispIDs: array [0..11] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006,
    $0000060E, $0000060F, $00000610, $00000611, $00000612, $00000613);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CTPictureIDs: array [0..0] of DWORD = (
    $00000008);
  CControlData: TControlData2 = (
    ClassID: '{C74190B6-8589-11D1-B16A-00C0F0283628}';
    EventIID: '{C74190B5-8589-11D1-B16A-00C0F0283628}';
    EventCount: 12;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $0000000C;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnBeforeLabelEdit) - Cardinal(Self);
end;

procedure TMSTreeView.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ITreeView;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSTreeView.GetControlInterface: ITreeView;
begin
  CreateControl;
  Result := FIntf;
end;

function TMSTreeView.Get_DropHighlight: INode;
begin
  Result := DefaultInterface.Get_DropHighlight;
end;

procedure TMSTreeView._Set_DropHighlight(const ppNode: INode);
  { Warning: The property DropHighlight has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DropHighlight := ppNode;
end;

function TMSTreeView.Get_ImageList: IDispatch;
begin
    Result := DefaultInterface.ImageList;
end;

procedure TMSTreeView._Set_ImageList(const ppImageList: IDispatch);
  { Warning: The property ImageList has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ImageList := ppImageList;
end;

procedure TMSTreeView.Set_ImageList(const ppImageList: IDispatch);
begin
  DefaultInterface.Set_ImageList(ppImageList);
end;

function TMSTreeView.Get_Nodes: INodes;
begin
    Result := DefaultInterface.Nodes;
end;

procedure TMSTreeView._Set_Nodes(const ppNode: INodes);
  { Warning: The property Nodes has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Nodes := ppNode;
end;

function TMSTreeView.Get_SelectedItem: INode;
begin
  Result := DefaultInterface.Get_SelectedItem;
end;

procedure TMSTreeView._Set_SelectedItem(const ppNode: INode);
  { Warning: The property SelectedItem has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SelectedItem := ppNode;
end;

function TMSTreeView.HitTest(x: Single; y: Single): INode;
begin
  Result := DefaultInterface.HitTest(x, y);
end;

function TMSTreeView.GetVisibleCount: Integer;
begin
  Result := DefaultInterface.GetVisibleCount;
end;

procedure TMSTreeView.StartLabelEdit;
begin
  DefaultInterface.StartLabelEdit;
end;

procedure TMSTreeView.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TMSTreeView.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TMSTreeView.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

class function CoNodes.Create: INodes;
begin
  Result := CreateComObject(CLASS_Nodes) as INodes;
end;

class function CoNodes.CreateRemote(const MachineName: string): INodes;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Nodes) as INodes;
end;

class function CoNode.Create: INode;
begin
  Result := CreateComObject(CLASS_Node) as INode;
end;

class function CoNode.CreateRemote(const MachineName: string): INode;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Node) as INode;
end;

procedure TMSListView.InitControlData;
const
  CEventDispIDs: array [0..10] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $0000060E, $0000060F,
    $00000610, $00000611, $00000612, $00000613, $00000005);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CTPictureIDs: array [0..1] of DWORD = (
    $0000000A, $0000001F);
  CControlData: TControlData2 = (
    ClassID: '{BDD1F04B-858B-11D1-B16A-00C0F0283628}';
    EventIID: '{BDD1F04A-858B-11D1-B16A-00C0F0283628}';
    EventCount: 11;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $0000000F;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs;
    PictureCount: 2;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnBeforeLabelEdit) - Cardinal(Self);
end;

procedure TMSListView.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IListView;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSListView.GetControlInterface: IListView;
begin
  CreateControl;
  Result := FIntf;
end;

function TMSListView.Get_ColumnHeaders: IColumnHeaders;
begin
    Result := DefaultInterface.ColumnHeaders;
end;

procedure TMSListView.Set_ColumnHeaders(const ppIColumnHeaders: IColumnHeaders);
begin
  DefaultInterface.Set_ColumnHeaders(ppIColumnHeaders);
end;

function TMSListView.Get_DropHighlight: IListItem;
begin
  Result := DefaultInterface.Get_DropHighlight;
end;

procedure TMSListView._Set_DropHighlight(const ppIListItem: IListItem);
  { Warning: The property DropHighlight has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DropHighlight := ppIListItem;
end;

function TMSListView.Get_Icons: IDispatch;
begin
    Result := DefaultInterface.Icons;
end;

procedure TMSListView._Set_Icons(const ppIcons: IDispatch);
  { Warning: The property Icons has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Icons := ppIcons;
end;

procedure TMSListView.Set_Icons(const ppIcons: IDispatch);
begin
  DefaultInterface.Set_Icons(ppIcons);
end;

function TMSListView.Get_ListItems: IListItems;
begin
    Result := DefaultInterface.ListItems;
end;

procedure TMSListView.Set_ListItems(const ppListItems: IListItems);
begin
  DefaultInterface.Set_ListItems(ppListItems);
end;

function TMSListView.Get_SelectedItem: IListItem;
begin
  Result := DefaultInterface.Get_SelectedItem;
end;

procedure TMSListView._Set_SelectedItem(const ppListItem: IListItem);
  { Warning: The property SelectedItem has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SelectedItem := ppListItem;
end;

function TMSListView.Get_SmallIcons: IDispatch;
begin
    Result := DefaultInterface.SmallIcons;
end;

procedure TMSListView._Set_SmallIcons(const ppImageList: IDispatch);
  { Warning: The property SmallIcons has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SmallIcons := ppImageList;
end;

procedure TMSListView.Set_SmallIcons(const ppImageList: IDispatch);
begin
  DefaultInterface.Set_SmallIcons(ppImageList);
end;

function TMSListView.Get_ColumnHeaderIcons: IDispatch;
begin
    Result := DefaultInterface.ColumnHeaderIcons;
end;

procedure TMSListView._Set_ColumnHeaderIcons(const ppImageList: IDispatch);
  { Warning: The property ColumnHeaderIcons has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ColumnHeaderIcons := ppImageList;
end;

procedure TMSListView.Set_ColumnHeaderIcons(const ppImageList: IDispatch);
begin
  DefaultInterface.Set_ColumnHeaderIcons(ppImageList);
end;

function TMSListView.FindItem(const sz: WideString): IListItem;
begin
  Result := DefaultInterface.FindItem(sz, EmptyParam, EmptyParam, EmptyParam);
end;

function TMSListView.FindItem(const sz: WideString; var Where: OleVariant): IListItem;
begin
  Result := DefaultInterface.FindItem(sz, Where, EmptyParam, EmptyParam);
end;

function TMSListView.FindItem(const sz: WideString; var Where: OleVariant; var Index: OleVariant): IListItem;
begin
  Result := DefaultInterface.FindItem(sz, Where, Index, EmptyParam);
end;

function TMSListView.FindItem(const sz: WideString; var Where: OleVariant; var Index: OleVariant; 
                              var fPartial: OleVariant): IListItem;
begin
  Result := DefaultInterface.FindItem(sz, Where, Index, fPartial);
end;

function TMSListView.GetFirstVisible: IListItem;
begin
  Result := DefaultInterface.GetFirstVisible;
end;

function TMSListView.HitTest(x: Single; y: Single): IListItem;
begin
  Result := DefaultInterface.HitTest(x, y);
end;

procedure TMSListView.StartLabelEdit;
begin
  DefaultInterface.StartLabelEdit;
end;

procedure TMSListView.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure TMSListView.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TMSListView.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoListItems.Create: IListItems;
begin
  Result := CreateComObject(CLASS_ListItems) as IListItems;
end;

class function CoListItems.CreateRemote(const MachineName: string): IListItems;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListItems) as IListItems;
end;

class function CoListItem.Create: IListItem;
begin
  Result := CreateComObject(CLASS_ListItem) as IListItem;
end;

class function CoListItem.CreateRemote(const MachineName: string): IListItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListItem) as IListItem;
end;

class function CoColumnHeaders.Create: IColumnHeaders;
begin
  Result := CreateComObject(CLASS_ColumnHeaders) as IColumnHeaders;
end;

class function CoColumnHeaders.CreateRemote(const MachineName: string): IColumnHeaders;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ColumnHeaders) as IColumnHeaders;
end;

class function CoColumnHeader.Create: IColumnHeader;
begin
  Result := CreateComObject(CLASS_ColumnHeader) as IColumnHeader;
end;

class function CoColumnHeader.CreateRemote(const MachineName: string): IColumnHeader;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ColumnHeader) as IColumnHeader;
end;

class function CoListSubItems.Create: IListSubItems;
begin
  Result := CreateComObject(CLASS_ListSubItems) as IListSubItems;
end;

class function CoListSubItems.CreateRemote(const MachineName: string): IListSubItems;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListSubItems) as IListSubItems;
end;

class function CoListSubItem.Create: IListSubItem;
begin
  Result := CreateComObject(CLASS_ListSubItem) as IListSubItem;
end;

class function CoListSubItem.CreateRemote(const MachineName: string): IListSubItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListSubItem) as IListSubItem;
end;

procedure TMSImageList.InitControlData;
const
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CControlData: TControlData2 = (
    ClassID: '{2C247F23-8591-11D1-B16A-00C0F0283628}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: @CLicenseKey;
    Flags: $00000001;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TMSImageList.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IImageList;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSImageList.GetControlInterface: IImageList;
begin
  CreateControl;
  Result := FIntf;
end;

function TMSImageList.Get_ListImages: IImages;
begin
    Result := DefaultInterface.ListImages;
end;

procedure TMSImageList._Set_ListImages(const ppListImages: IImages);
  { Warning: The property ListImages has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ListImages := ppListImages;
end;

function TMSImageList.Overlay(var Key1: OleVariant; var Key2: OleVariant): IPictureDisp;
begin
  Result := DefaultInterface.Overlay(Key1, Key2);
end;

procedure TMSImageList.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoListImages.Create: IImages;
begin
  Result := CreateComObject(CLASS_ListImages) as IImages;
end;

class function CoListImages.CreateRemote(const MachineName: string): IImages;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListImages) as IImages;
end;

class function CoListImage.Create: IImage;
begin
  Result := CreateComObject(CLASS_ListImage) as IImage;
end;

class function CoListImage.CreateRemote(const MachineName: string): IImage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListImage) as IImage;
end;

procedure TSlider.InitControlData;
const
  CEventDispIDs: array [0..7] of DWORD = (
    $00000001, $00000002, $0000060E, $0000060F, $00000610, $00000611,
    $00000612, $00000613);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTPictureIDs: array [0..0] of DWORD = (
    $0000000C);
  CControlData: TControlData2 = (
    ClassID: '{F08DF954-8592-11D1-B16A-00C0F0283628}';
    EventIID: '{F08DF953-8592-11D1-B16A-00C0F0283628}';
    EventCount: 8;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $00000008;
    Version: 401;
    FontCount: 0;
    FontIDs: nil;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnScroll) - Cardinal(Self);
end;

procedure TSlider.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ISlider;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TSlider.GetControlInterface: ISlider;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TSlider.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TSlider.ClearSel;
begin
  DefaultInterface.ClearSel;
end;

procedure TSlider.DoClick;
begin
  DefaultInterface.DoClick;
end;

procedure TSlider.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure TSlider.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoControls.Create: IControls;
begin
  Result := CreateComObject(CLASS_Controls) as IControls;
end;

class function CoControls.CreateRemote(const MachineName: string): IControls;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Controls) as IControls;
end;

class function CoComboItem.Create: IComboItem;
begin
  Result := CreateComObject(CLASS_ComboItem) as IComboItem;
end;

class function CoComboItem.CreateRemote(const MachineName: string): IComboItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ComboItem) as IComboItem;
end;

class function CoComboItems.Create: IComboItems;
begin
  Result := CreateComObject(CLASS_ComboItems) as IComboItems;
end;

class function CoComboItems.CreateRemote(const MachineName: string): IComboItems;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ComboItems) as IComboItems;
end;

procedure TImageCombo.InitControlData;
const
  CEventDispIDs: array [0..7] of DWORD = (
    $00000001, $00000002, $0000060E, $0000060F, $00000610, $00000611,
    $00000612, $00000613);
  CLicenseKey: array[0..36] of Word = ( $0039, $0033, $0036, $0038, $0032, $0036, $0035, $0045, $002D, $0038, $0035
    , $0046, $0045, $002D, $0031, $0031, $0064, $0031, $002D, $0038, $0042
    , $0045, $0033, $002D, $0030, $0030, $0030, $0030, $0046, $0038, $0037
    , $0035, $0034, $0044, $0041, $0031, $0000);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CTPictureIDs: array [0..0] of DWORD = (
    $0000000A);
  CControlData: TControlData2 = (
    ClassID: '{DD9DA666-8594-11D1-B16A-00C0F0283628}';
    EventIID: '{DD9DA665-8594-11D1-B16A-00C0F0283628}';
    EventCount: 8;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $0000002F;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs;
    PictureCount: 1;
    PictureIDs: @CTPictureIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnChange) - Cardinal(Self);
end;

procedure TImageCombo.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IImageCombo;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TImageCombo.GetControlInterface: IImageCombo;
begin
  CreateControl;
  Result := FIntf;
end;

function TImageCombo.Get_ImageList: IDispatch;
begin
    Result := DefaultInterface.ImageList;
end;

procedure TImageCombo._Set_ImageList(const ppImageList: IDispatch);
  { Warning: The property ImageList has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ImageList := ppImageList;
end;

procedure TImageCombo.Set_ImageList(const ppImageList: IDispatch);
begin
  DefaultInterface.Set_ImageList(ppImageList);
end;

function TImageCombo.Get_ComboItems: IComboItems;
begin
    Result := DefaultInterface.ComboItems;
end;

procedure TImageCombo._Set_ComboItems(const ppComboItems: IComboItems);
  { Warning: The property ComboItems has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ComboItems := ppComboItems;
end;

function TImageCombo.Get_SelectedItem: IComboItem;
begin
  Result := DefaultInterface.Get_SelectedItem;
end;

procedure TImageCombo._Set_SelectedItem(const ppIComboItem: IComboItem);
  { Warning: The property SelectedItem has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SelectedItem := ppIComboItem;
end;

procedure TImageCombo.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TImageCombo.GetFirstVisible: IComboItem;
begin
  Result := DefaultInterface.GetFirstVisible;
end;

procedure TImageCombo.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TImageCombo.OLEDrag;
begin
  DefaultInterface.OLEDrag;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TTabStrip, TMSToolbar, TMSStatusBar, TMSProgressBar, 
    TMSTreeView, TMSListView, TMSImageList, TSlider, TImageCombo]);
end;

end.
