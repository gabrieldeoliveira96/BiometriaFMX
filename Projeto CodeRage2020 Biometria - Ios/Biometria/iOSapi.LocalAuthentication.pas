unit iOSapi.LocalAuthentication;

interface

uses
    Macapi.ObjectiveC, iOSapi.Foundation;

const
  LAFwk = '/System/Library/Frameworks/LocalAuthentication.framework/LocalAuthentication';

type
  LAPolicy = (notUsed = 0, DeviceOwnerAuthenticationWithBiometrics = 1, DeviceOwnerAuthentication = 2);

  LAContextReply = procedure(success: Pointer; error: Pointer) of Object;

  LAContextClass = interface(NSObjectClass)
    ['{6AA41561-0BBC-495C-9ADE-CB38B5AB9305}']
  end;

  LAContext = interface(NSObject)
    ['{8F6B7D53-83A8-43D3-B6C2-116068C382CE}']
    function canEvaluatePolicy(policy: LAPolicy; error: NSError) : Boolean; overload; cdecl;
    procedure evaluatePolicy(policy: LAPolicy; localizedReason: NSString; reply: LAContextReply); cdecl;
  end;

  TLAContext = class(TOCGenericImport<LAContextClass, LAContext>)
  end;

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}
var
  LAModule: THandle;

initialization
  LAModule := dlopen(MarshaledAString(LAFwk), RTLD_LAZY);

finalization
  dlclose(LAModule);
{$ENDIF IOS}

end.
