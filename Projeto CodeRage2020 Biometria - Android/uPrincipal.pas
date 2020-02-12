unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.StdCtrls, FMX.Effects, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, Android.KeyguardManager;

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
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.imgBiometriaClick(Sender: TObject);
var
 Android:TEventResultClass;

begin

  Android:= TEventResultClass.Create(self);
  if Android.DeviceSecure then
    Android.StartActivityKeyGuard;

end;

end.
