unit MSCommLib_TLB;

// ************************************************************************ //
// AVERTISSEMENT                                                                 
// -------                                                                    
// Les types déclarés dans ce fichier ont été générés à partir de données lues 
// depuis la bibliothèque de types. Si cette dernière (via une autre bibliothèque de types 
// s'y référant) est explicitement ou indirectement ré-importée, ou la commande "Rafraîchir"  
// de l'éditeur de bibliothèque de types est activée lors de la modification de la bibliothèque 
// de types, le contenu de ce fichier sera régénéré et toutes les modifications      
// manuellement apportées seront perdues.                                     
// ************************************************************************ //

// PASTLWTR : 1.2
// Fichier généré le 04/03/2024 11:09:38 depuis la bibliothèque de types ci-dessous.

// ************************************************************************  //
// Bibl. types : C:\Windows\SysWow64\mscomm32.ocx (1)
// LIBID: {648A5603-2C6E-101B-82B6-000000000014}
// LCID: 0
// Fichier d'aide : C:\Windows\SysWow64\COMM98.CHM
// Chaîne d'aide : Microsoft Comm Control 6.0
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // L'unité doit être compilée sans pointeur à type contrôlé. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;

// *********************************************************************//
// GUIDS déclarés dans la bibliothèque de types. Préfixes utilisés :
//   Bibliothèques de types : LIBID_xxxx
//   CoClasses              : CLASS_xxxx
//   DISPInterfaces         : DIID_xxxx
//   Non-DISP interfaces    : IID_xxxx
// *********************************************************************//
const
  // Versions majeure et mineure de la bibliothèque de types
  MSCommLibMajorVersion = 1;
  MSCommLibMinorVersion = 1;

  LIBID_MSCommLib: TGUID = '{648A5603-2C6E-101B-82B6-000000000014}';

  IID_IMSComm: TGUID = '{E6E17E90-DF38-11CF-8E74-00A0C90F26F8}';
  DIID_DMSCommEvents: TGUID = '{648A5602-2C6E-101B-82B6-000000000014}';
  CLASS_MSComm: TGUID = '{648A5600-2C6E-101B-82B6-000000000014}';

// *********************************************************************//
// Déclaration d'énumérations définies dans la bibliothèque de types
// *********************************************************************//
// Constantes pour enum HandshakingConstants
type
  HandshakingConstants = TOleEnum;
const
  NoHandshaking = $00000000;
  XonXoff = $00000001;
  RtsCts = $00000002;
  XonXoffAndRtsCts = $00000003;

// Constantes pour enum HandshakeConstants
type
  HandshakeConstants = TOleEnum;
const
  comNone = $00000000;
  comXOnXoff = $00000001;
  comRTS = $00000002;
  comRTSXOnXOff = $00000003;

// Constantes pour enum ErrorConstants
type
  ErrorConstants = TOleEnum;
const
  comInvalidPropertyValue = $0000017C;
  comGetNotSupported = $0000018A;
  comSetNotSupported = $0000017F;
  comPortInvalid = $00001F42;
  comPortAlreadyOpen = $00001F45;
  comPortOpen = $00001F40;
  comNoOpen = $00001F4C;
  comSetCommStateFailed = $00001F4F;
  comPortNotOpen = $00001F52;
  comReadError = $00001F54;
  comDCBError = $00001F55;
  comBreak = $000003E9;
  comCTSTO = $000003EA;
  comDSRTO = $000003EB;
  comFrame = $000003EC;
  comOverrun = $000003EE;
  comCDTO = $000003EF;
  comRxOver = $000003F0;
  comRxParity = $000003F1;
  comTxFull = $000003F2;
  comDCB = $000003F3;

// Constantes pour enum CommEventConstants
type
  CommEventConstants = TOleEnum;
const
  comEventBreak = $000003E9;
  comEventCTSTO = $000003EA;
  comEventDSRTO = $000003EB;
  comEventFrame = $000003EC;
  comEventOverrun = $000003EE;
  comEventCDTO = $000003EF;
  comEventRxOver = $000003F0;
  comEventRxParity = $000003F1;
  comEventTxFull = $000003F2;
  comEventDCB = $000003F3;

// Constantes pour enum OnCommConstants
type
  OnCommConstants = TOleEnum;
const
  comEvSend = $00000001;
  comEvReceive = $00000002;
  comEvCTS = $00000003;
  comEvDSR = $00000004;
  comEvCD = $00000005;
  comEvRing = $00000006;
  comEvEOF = $00000007;

// Constantes pour enum InputModeConstants
type
  InputModeConstants = TOleEnum;
const
  comInputModeText = $00000000;
  comInputModeBinary = $00000001;

type

// *********************************************************************//
// Déclaration Forward des types définis dans la bibliothèque de types
// *********************************************************************//
  IMSComm = interface;
  IMSCommDisp = dispinterface;
  DMSCommEvents = dispinterface;

// *********************************************************************//
// Déclaration de CoClasses définies dans la bibliothèque de types
// (REMARQUE: On affecte chaque CoClasse à son Interface par défaut)
// *********************************************************************//
  MSComm = IMSComm;


// *********************************************************************//
// Interface   : IMSComm
// Indicateurs : (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID        : {E6E17E90-DF38-11CF-8E74-00A0C90F26F8}
// *********************************************************************//
  IMSComm = interface(IDispatch)
    ['{E6E17E90-DF38-11CF-8E74-00A0C90F26F8}']
    procedure Set_CDHolding(pfCDHolding: WordBool); safecall;
    function Get_CDHolding: WordBool; safecall;
    procedure Set_CDTimeout(plCDTimeout: Integer); safecall;
    function Get_CDTimeout: Integer; safecall;
    procedure Set_CommID(plCommID: Integer); safecall;
    function Get_CommID: Integer; safecall;
    procedure Set_CommPort(psCommPort: Smallint); safecall;
    function Get_CommPort: Smallint; safecall;
    procedure Set__CommPort(psCommPort: Smallint); safecall;
    function Get__CommPort: Smallint; safecall;
    procedure Set_CTSHolding(pfCTSHolding: WordBool); safecall;
    function Get_CTSHolding: WordBool; safecall;
    procedure Set_CTSTimeout(plCTSTimeout: Integer); safecall;
    function Get_CTSTimeout: Integer; safecall;
    procedure Set_DSRHolding(pfDSRHolding: WordBool); safecall;
    function Get_DSRHolding: WordBool; safecall;
    procedure Set_DSRTimeout(plDSRTimeout: Integer); safecall;
    function Get_DSRTimeout: Integer; safecall;
    procedure Set_DTREnable(pfDTREnable: WordBool); safecall;
    function Get_DTREnable: WordBool; safecall;
    procedure Set_Handshaking(phandshake: HandshakeConstants); safecall;
    function Get_Handshaking: HandshakeConstants; safecall;
    procedure Set_InBufferSize(psInBufferSize: Smallint); safecall;
    function Get_InBufferSize: Smallint; safecall;
    procedure Set_InBufferCount(psInBufferCount: Smallint); safecall;
    function Get_InBufferCount: Smallint; safecall;
    procedure Set_Break(pfBreak: WordBool); safecall;
    function Get_Break: WordBool; safecall;
    procedure Set_InputLen(psInputLen: Smallint); safecall;
    function Get_InputLen: Smallint; safecall;
    procedure Set_Interval(plInterval: Integer); safecall;
    function Get_Interval: Integer; safecall;
    procedure Set_NullDiscard(pfNullDiscard: WordBool); safecall;
    function Get_NullDiscard: WordBool; safecall;
    procedure Set_OutBufferSize(psOutBufferSize: Smallint); safecall;
    function Get_OutBufferSize: Smallint; safecall;
    procedure Set_OutBufferCount(psOutBufferCount: Smallint); safecall;
    function Get_OutBufferCount: Smallint; safecall;
    procedure Set_ParityReplace(const pbstrParityReplace: WideString); safecall;
    function Get_ParityReplace: WideString; safecall;
    procedure Set_PortOpen(pfPortOpen: WordBool); safecall;
    function Get_PortOpen: WordBool; safecall;
    procedure Set_RThreshold(psRThreshold: Smallint); safecall;
    function Get_RThreshold: Smallint; safecall;
    procedure Set_RTSEnable(pfRTSEnable: WordBool); safecall;
    function Get_RTSEnable: WordBool; safecall;
    procedure Set_Settings(const pbstrSettings: WideString); safecall;
    function Get_Settings: WideString; safecall;
    procedure Set_SThreshold(psSThreshold: Smallint); safecall;
    function Get_SThreshold: Smallint; safecall;
    procedure Set_Output(pvarOutput: OleVariant); safecall;
    function Get_Output: OleVariant; safecall;
    procedure Set_Input(pvarInput: OleVariant); safecall;
    function Get_Input: OleVariant; safecall;
    procedure Set_CommEvent(psCommEvent: Smallint); safecall;
    function Get_CommEvent: Smallint; safecall;
    procedure Set_EOFEnable(pfEOFEnable: WordBool); safecall;
    function Get_EOFEnable: WordBool; safecall;
    procedure Set_InputMode(InputMode: InputModeConstants); safecall;
    function Get_InputMode: InputModeConstants; safecall;
    procedure AboutBox; stdcall;
    property CDHolding: WordBool read Get_CDHolding write Set_CDHolding;
    property CDTimeout: Integer read Get_CDTimeout write Set_CDTimeout;
    property CommID: Integer read Get_CommID write Set_CommID;
    property CommPort: Smallint read Get_CommPort write Set_CommPort;
    property _CommPort: Smallint read Get__CommPort write Set__CommPort;
    property CTSHolding: WordBool read Get_CTSHolding write Set_CTSHolding;
    property CTSTimeout: Integer read Get_CTSTimeout write Set_CTSTimeout;
    property DSRHolding: WordBool read Get_DSRHolding write Set_DSRHolding;
    property DSRTimeout: Integer read Get_DSRTimeout write Set_DSRTimeout;
    property DTREnable: WordBool read Get_DTREnable write Set_DTREnable;
    property Handshaking: HandshakeConstants read Get_Handshaking write Set_Handshaking;
    property InBufferSize: Smallint read Get_InBufferSize write Set_InBufferSize;
    property InBufferCount: Smallint read Get_InBufferCount write Set_InBufferCount;
    property Break: WordBool read Get_Break write Set_Break;
    property InputLen: Smallint read Get_InputLen write Set_InputLen;
    property Interval: Integer read Get_Interval write Set_Interval;
    property NullDiscard: WordBool read Get_NullDiscard write Set_NullDiscard;
    property OutBufferSize: Smallint read Get_OutBufferSize write Set_OutBufferSize;
    property OutBufferCount: Smallint read Get_OutBufferCount write Set_OutBufferCount;
    property ParityReplace: WideString read Get_ParityReplace write Set_ParityReplace;
    property PortOpen: WordBool read Get_PortOpen write Set_PortOpen;
    property RThreshold: Smallint read Get_RThreshold write Set_RThreshold;
    property RTSEnable: WordBool read Get_RTSEnable write Set_RTSEnable;
    property Settings: WideString read Get_Settings write Set_Settings;
    property SThreshold: Smallint read Get_SThreshold write Set_SThreshold;
    property Output: OleVariant read Get_Output write Set_Output;
    property Input: OleVariant read Get_Input write Set_Input;
    property CommEvent: Smallint read Get_CommEvent write Set_CommEvent;
    property EOFEnable: WordBool read Get_EOFEnable write Set_EOFEnable;
    property InputMode: InputModeConstants read Get_InputMode write Set_InputMode;
  end;

// *********************************************************************//
// DispIntf :  IMSCommDisp
// Flags :     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID :      {E6E17E90-DF38-11CF-8E74-00A0C90F26F8}
// *********************************************************************//
  IMSCommDisp = dispinterface
    ['{E6E17E90-DF38-11CF-8E74-00A0C90F26F8}']
    property CDHolding: WordBool dispid 1;
    property CDTimeout: Integer dispid 2;
    property CommID: Integer dispid 3;
    property CommPort: Smallint dispid 4;
    property _CommPort: Smallint dispid 0;
    property CTSHolding: WordBool dispid 5;
    property CTSTimeout: Integer dispid 6;
    property DSRHolding: WordBool dispid 7;
    property DSRTimeout: Integer dispid 8;
    property DTREnable: WordBool dispid 9;
    property Handshaking: HandshakeConstants dispid 10;
    property InBufferSize: Smallint dispid 11;
    property InBufferCount: Smallint dispid 12;
    property Break: WordBool dispid 13;
    property InputLen: Smallint dispid 14;
    property Interval: Integer dispid 15;
    property NullDiscard: WordBool dispid 16;
    property OutBufferSize: Smallint dispid 17;
    property OutBufferCount: Smallint dispid 18;
    property ParityReplace: WideString dispid 19;
    property PortOpen: WordBool dispid 20;
    property RThreshold: Smallint dispid 21;
    property RTSEnable: WordBool dispid 22;
    property Settings: WideString dispid 23;
    property SThreshold: Smallint dispid 24;
    property Output: OleVariant dispid 25;
    property Input: OleVariant dispid 26;
    property CommEvent: Smallint dispid 27;
    property EOFEnable: WordBool dispid 28;
    property InputMode: InputModeConstants dispid 29;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf :  DMSCommEvents
// Flags :     (4112) Hidden Dispatchable
// GUID :      {648A5602-2C6E-101B-82B6-000000000014}
// *********************************************************************//
  DMSCommEvents = dispinterface
    ['{648A5602-2C6E-101B-82B6-000000000014}']
    procedure OnComm; dispid 1;
  end;


// *********************************************************************//
// Déclaration de classe proxy de contrôle OLE
// Nom du contrôle      : TMSComm
// Chaîne d'aide        : Microsoft Comm Control 6.0
// Interface par défaut : IMSComm
// DISP Int. Déf. ?     : No
// Interface événements : DMSCommEvents
// TypeFlags            : (38) CanCreate Licensed Control
// *********************************************************************//
  TMSComm = class(TOleControl)
  private
    FOnComm: TNotifyEvent;
    FIntf: IMSComm;
    function  GetControlInterface: IMSComm;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    procedure Set_Output(pvarOutput: OleVariant);
    function Get_Output: OleVariant;
    procedure Set_Input(pvarInput: OleVariant);
    function Get_Input: OleVariant;
  public
    procedure AboutBox;
    property  ControlInterface: IMSComm read GetControlInterface;
    property  DefaultInterface: IMSComm read GetControlInterface;
    property CDTimeout: Integer index 2 read GetIntegerProp write SetIntegerProp;
    property _CommPort: Smallint index 0 read GetSmallintProp write SetSmallintProp;
    property CTSTimeout: Integer index 6 read GetIntegerProp write SetIntegerProp;
    property DSRTimeout: Integer index 8 read GetIntegerProp write SetIntegerProp;
    property Interval: Integer index 15 read GetIntegerProp write SetIntegerProp;
    property Output: OleVariant index 25 read GetOleVariantProp write SetOleVariantProp;
    property Input: OleVariant index 26 read GetOleVariantProp write SetOleVariantProp;
  published
    property Anchors;
    property CDHolding: WordBool index 1 read GetWordBoolProp write SetWordBoolProp stored False;
    property CommID: Integer index 3 read GetIntegerProp write SetIntegerProp stored False;
    property CommPort: Smallint index 4 read GetSmallintProp write SetSmallintProp stored False;
    property CTSHolding: WordBool index 5 read GetWordBoolProp write SetWordBoolProp stored False;
    property DSRHolding: WordBool index 7 read GetWordBoolProp write SetWordBoolProp stored False;
    property DTREnable: WordBool index 9 read GetWordBoolProp write SetWordBoolProp stored False;
    property Handshaking: TOleEnum index 10 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property InBufferSize: Smallint index 11 read GetSmallintProp write SetSmallintProp stored False;
    property InBufferCount: Smallint index 12 read GetSmallintProp write SetSmallintProp stored False;
    property Break: WordBool index 13 read GetWordBoolProp write SetWordBoolProp stored False;
    property InputLen: Smallint index 14 read GetSmallintProp write SetSmallintProp stored False;
    property NullDiscard: WordBool index 16 read GetWordBoolProp write SetWordBoolProp stored False;
    property OutBufferSize: Smallint index 17 read GetSmallintProp write SetSmallintProp stored False;
    property OutBufferCount: Smallint index 18 read GetSmallintProp write SetSmallintProp stored False;
    property ParityReplace: WideString index 19 read GetWideStringProp write SetWideStringProp stored False;
    property PortOpen: WordBool index 20 read GetWordBoolProp write SetWordBoolProp stored False;
    property RThreshold: Smallint index 21 read GetSmallintProp write SetSmallintProp stored False;
    property RTSEnable: WordBool index 22 read GetWordBoolProp write SetWordBoolProp stored False;
    property Settings: WideString index 23 read GetWideStringProp write SetWideStringProp stored False;
    property SThreshold: Smallint index 24 read GetSmallintProp write SetSmallintProp stored False;
    property CommEvent: Smallint index 27 read GetSmallintProp write SetSmallintProp stored False;
    property EOFEnable: WordBool index 28 read GetWordBoolProp write SetWordBoolProp stored False;
    property InputMode: TOleEnum index 29 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnComm: TNotifyEvent read FOnComm write FOnComm;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TMSComm.InitControlData;
const
  CEventDispIDs: array [0..0] of DWORD = (
    $00000001);
  CLicenseKey: array[0..19] of Word = ( $0043, $006F, $0070, $0079, $0072, $0069, $0067, $0068, $0074, $0020, $0028
    , $0063, $0029, $0020, $0031, $0039, $0039, $0034, $0020, $0000);
  CControlData: TControlData2 = (
    ClassID: '{648A5600-2C6E-101B-82B6-000000000014}';
    EventIID: '{648A5602-2C6E-101B-82B6-000000000014}';
    EventCount: 1;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnComm) - Cardinal(Self);
end;

procedure TMSComm.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IMSComm;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMSComm.GetControlInterface: IMSComm;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TMSComm.Set_Output(pvarOutput: OleVariant);
begin
  DefaultInterface.Set_Output(pvarOutput);
end;

function TMSComm.Get_Output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Output;
end;

procedure TMSComm.Set_Input(pvarInput: OleVariant);
begin
  DefaultInterface.Set_Input(pvarInput);
end;

function TMSComm.Get_Input: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Input;
end;

procedure TMSComm.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TMSComm]);
end;

end.
