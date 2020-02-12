unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.StdCtrls, FMX.Effects, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  Macapi.Helpers, iOSapi.Foundation;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItemLogin: TTabItem;
    TabItemPrincipal: TTabItem;
    Layout1: TLayout;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    Label1: TLabel;
    Layout5: TLayout;
    Image2: TImage;
    Layout6: TLayout;
    imgBiometria: TImage;
    ListView1: TListView;
    procedure imgBiometriaClick(Sender: TObject);
  private
    { Private declarations }
    function TryTouchID: Boolean;
    procedure TouchIDReply(success: Pointer; error: Pointer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses iOSapi.LocalAuthentication;

function TForm1.TryTouchID: Boolean;
var
  Context: LAContext;
  canEvaluate: Boolean;
begin
  Result := false;
  TThread.Synchronize(nil,
    procedure
    begin
      try
        Context := TLAContext.Alloc;
        Context := TLAContext.Wrap(Context.init);

        canEvaluate := Context.canEvaluatePolicy
          (LAPolicy.DeviceOwnerAuthenticationWithBiometrics, nil);
        if canEvaluate then
        begin

          Context.evaluatePolicy
            (LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
            StrToNSSTR('Mensagem LocalAuthentication'), TouchIDReply);
        end;
      finally
        Context.release;
      end;
    end);

end;


procedure TForm1.imgBiometriaClick(Sender: TObject);
begin

  TThread.CreateAnonymousThread(
  procedure
  begin

    TThread.Synchronize(Tthread.CurrentThread,
    procedure
    begin
      TryTouchID;
    end);

  end).Start;

end;

procedure TForm1.TouchIDReply(success: Pointer; error: Pointer);
var
  E: NSError;
begin
  if Assigned(success) then
  begin
    TThread.Synchronize(nil,
      procedure
      begin
        ShowMessage('Valido');
      end);
  end
  else
  begin
    TThread.Synchronize(nil,
      procedure
      begin
        ShowMessage('Invalido');
      end);
  end;
end;


end.
