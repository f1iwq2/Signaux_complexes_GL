unit UnitClock;

{ FBitMap est le Bitmap d'arri�re plan et contient le tour de l'horloge
  il est cr�� au d�marrage.

  ABitMap contient les aiguilles

  DrawArrow dessine les aiguilles dans ABitmap:
   - le cr�e, dessine
   Abitmap.canvas.copyrect()
   - copie dans horloge : canvas.draw(0,0,ABitMap)

}
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,Math , UnitHorloge, StdCtrls, Buttons, ImgList, Menus;

const pisur180=pi/180;
      pisur360=pi/360;
      pisur30=pi/30;
      pisur6=pi/6;
type
   TFormClock = class(TForm)
    BitBtnMarHor: TBitBtn;
    ImageList24x24: TImageList;
    BitBtnArrHorl: TBitBtn;
    BitBtnInitHor: TBitBtn;
    ButtonParametres: TButton;
    PopupMenuH: TPopupMenu;
    TjsDev: TMenuItem;
    Dverrouiller1: TMenuItem;
    ButtonGH: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtnMarHrClick(Sender: TObject);
    procedure BitBtnArrHorlClick(Sender: TObject);
    procedure BitBtnInitHorClick(Sender: TObject);
    procedure ButtonParametresClick(Sender: TObject);
    procedure TjsVerClick(Sender: TObject);
    procedure Dverrouiller1Click(Sender: TObject);
    procedure ButtonGHClick(Sender: TObject);

  private
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
  end;

  TClock = class(TGraphicControl)
  private
    Ticker : TTimer;

    FBitMap : TBitMap;   // arri�re plan
    // Clock variables
    CenterPoint : TPoint; // Centre des aiguilles
    Radius : integer;     // rayon d'horloge
    LapStepW : integer;   // espacement des maqueurs minutes
    ShowSecond : boolean; // Affiche ou non l'aiguille des seondes
    FArrowColor : TColor; // couleur des aiguilles
    FFaceColor : TColor;  // Couleur d'horloge

    procedure SetFaceColor( Value : TColor);
    procedure SetArrowColor( Value : TColor);
    procedure SetShowSecond( Value : boolean);
    function HourAngle( Hou, Min : word) : real; // Hour arrow angle
    procedure CalcClockSettings;
    procedure DrawClockBkg; // Draw clock background on FBitMap

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure tickercall;
    procedure DrawArrows; // dessine les aiguilles

  published
    property Align;
    property Enabled;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property ClkArrowColor : TColor read FArrowColor write SetArrowColor default clBlack;
    property ClkFaceColor : TColor read FFaceColor write SetFaceColor default clBtnFace;
    property SecArrow : boolean read ShowSecond write SetShowSecond;
  end;

var  FormClock: TFormClock;
     clock : Tclock;
     FormClockInit,Verrouille : boolean;
     SecThick,MinThick,HouThick,DeltaFPCX,DeltaFPCY,largeurFC,hauteurFC,OffsetXFC,OffsetYFC : integer;

procedure affiche_horloge;
procedure calcul_pos_horloge;

implementation

uses UnitConfigCellTCO, UnitPrinc, UnitFicheHoraire;
{$R *.dfm}

const
  SecScale=1;     // longueur de l'aiguille des secondes
  MinScale=0.93;  // longueur de l'aiguille des minutes
  HouScale=0.60;  // longueur de l'aiguille des heures
  offsetx=20;     // d�calage x du bitmap l'horloge par rapport � la fenetre
  offsety=60;     // y

constructor TClock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FormClockInit:=false;
  // taille de l'horloge
  Width:=(AOwner as Tform).Width-offsetx;
  Height:=(AOwner as Tform).Height-offsety;

  FFaceColor:=clBtnFace;
  FArrowColor:=clBlack;
  ShowSecond:=true;

  // Cr�e le bitmap d'arri�re plan
  FBitMap:=TBitMap.Create;
  FBitMap.Width:=Width;
  FBitMap.Height:=Height;
end;

procedure TClock.SetFaceColor( Value : TColor);
begin FFaceColor:=Value; invalidate; end;

procedure TClock.SetArrowColor( Value : TColor);
begin FArrowColor := Value; invalidate; end;

procedure TClock.SetShowSecond( Value : boolean);
begin
  ShowSecond := Value;
  Invalidate;
end;

procedure TClock.Paint;
begin
  CalcClockSettings;
  DrawClockBkg;
  DrawArrows;
end;

destructor TClock.Destroy;
begin
  FBitMap.Free;
  Ticker.Free;
  inherited Destroy;
end;

function TClock.HourAngle( Hou, Min : word) : real;
begin
  HourAngle:=(Hou mod 12) * pisur6 + (Min*pisur360);
end;

procedure Tclock.TickerCall;
begin
  // ne rien faire pendant la cr�ation
  //if (csDesigning in ComponentState) or
  //Affiche('Ticker Call',clLime);
  if (formClock=nil) or not(FormclockInit) then exit;
  if not(assigned(formclock)) then exit;
  if not(ShowSecond) then exit;
  DrawArrows;
end;

// dessine les fl�ches dans A bitmap et le copie dans le canvas de l'horloge
procedure TClock.DrawArrows;
var
  ABitMap : TBitMap;
  sin,cos :extended;

  // Dessine les fl�ches dans le bitmap hors �cran
  procedure DrawArrow(Angle, Scale : real;AWidth : integer);
  var SR : real;
  begin
    with ABitMap.Canvas do
    begin
      Pen.Width:=AWidth;
      MoveTo(CenterPoint.X,CenterPoint.Y);
      SR:=Scale*Radius;
      sincos(Angle,sin,cos);
      LineTo(round(SR*sin)+ CenterPoint.X,
             round(-SR*cos)+ CenterPoint.Y);
    end;
  end;

begin
  // Cr�e le bitmap AbitMap hors �cran
  ABitMap:=TBitMap.Create;
  // dessine les aiguilles sur l'image hors �cran
  // Attributs du bitmap hors �cran
  ABitMap.Width:=Width;
  ABitMap.Height:=Height;

  // Copie l'image de fond du bitmap dans le bitmap hors �cran
  ABitMap.Canvas.CopyMode:=cmSrcCopy;
  ABitMap.Canvas.CopyRect(ABitMap.Canvas.ClipRect,FBitMap.Canvas,FBitMap.Canvas.ClipRect);
  // Dessine les nouvelles aiguilles dans le bitmap hors �cran
  if ShowSecond then
  begin
    ABitMap.Canvas.pen.Color:=$600000;      // bleu fonc�
    DrawArrow(seconde*pisur30,  SecScale, SecThick); // seconde
  end;
  ABitMap.Canvas.Pen.color:=ClkArrowColor;
  DrawArrow(minute*pisur30,MinScale, MinThick);   // minute
  DrawArrow(HourAngle(heure,minute),HouScale,HouThick);   // heure

  // copie le bitmap hors �cran dans l'horloge
  Canvas.CopyMode:=cmSrcCopy;
  Canvas.Draw(0,0,ABitMap);
  formclock.Caption:=format('%.2dh%.2d:%.2d',[heure,minute,seconde] );
  ABitMap.Free;
end;

procedure TClock.CalcClockSettings;
begin
  //Cr�er une nouvelle image de fond dans Fbitmap
  FBitMap.Free;
  FBitMap:=TBitMap.Create;
  FBitMap.Width:=Width;
  FBitMap.Height:=Height;
  // calcule le centre de l'horloge
  CenterPoint:=Point(Width div 2,Height div 2);
  // Calcule le rayon de l'horloge
  with CenterPoint do
    if x<=y then Radius:=x
    else Radius:=y;

  LapStepW:=Radius div 8;
  if LapStepW<6 then LapStepW:=6;

  dec(Radius,LapStepW+2);
end;

// Dessine le fond Fbitmap (le tour) de l'horloge sur FbitMap
procedure TClock.DrawClockBkg;

  // Dessine les tirets minute sur FBitMap
  procedure DrawMinSteps;
  const EpGd=2;       // epaisseurs des aiguilles
        LgGd=25;
        EpPt=1;
        LgPt=7;
  var
    ep,lg,OfsX : integer;
    Angle : word;
    SR : real;
    sin, cos : extended;
    x1,y1,x2,y2,x3,y3,x4,y4 : integer;
  begin
    OfsX := LapStepW DIV 2;
    Angle:=0;
    FBitMap.Canvas.Pen.color:=ClkArrowColor;
    Fbitmap.canvas.Brush.Color:=clkArrowColor;
    while Angle<360 do
    begin
      if Angle mod 15 = 0 then
      begin
        // grands marqueurs
        ep:=EpGd;
        lg:=LgGd;
      end
      else
      begin
        ep:=EpPt;
        lg:=LgPt;
      end;

      sr:=Radius + OfsX;
      sincos((Angle+Ep)*pisur180,sin,cos);
      x1:=round(sr*sin)+centerPoint.X; y1:=round(sr*cos)+centerPoint.y;

      sincos((Angle-Ep)*pisur180,sin,cos);
      x2:=round(sr*sin)+centerPoint.X; y2:=round(sr*cos)+centerPoint.y;

      // marqueurs des 3 heures
      if Angle=0 then   //6h
      begin
        inc(x2);
        x3:=x2;y3:=y2-lg;
        x4:=x1;y4:=y1-lg;
      end
      else
      if Angle=90 then //3h
      begin
        inc(y1);
        x3:=x2-lg;y3:=y2;
        x4:=x1-lg;y4:=y1;
      end
      else
      if Angle=180 then  //0h
      begin
        inc(x1);
        x3:=x2;y3:=y2+lg;
        x4:=x1;y4:=y1+lg;
      end
      else
      if Angle=270 then  //9h
      begin
        inc(y2);
        x3:=x2+lg;y3:=y2;
        x4:=x1+lg;y4:=y1;
      end
      else
      begin
        sr:=(Radius-lg) + OfsX;
        sincos((Angle-Ep)*pisur180,sin,cos);
        x3:=round(sr*sin)+centerPoint.X; y3:=round(sr*cos)+centerPoint.y;

        sincos((Angle+Ep)*pisur180,sin,cos);
        x4:=round(sr*sin)+centerPoint.X; y4:=round(sr*cos)+centerPoint.y;
      end;

      Fbitmap.canvas.polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

      inc(Angle,6);
    end;
  end; // DrawMinSteps

begin
  with FBitMap.Canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=ClkFaceColor;
    FillRect( ClipRect);
  end;
  DrawMinSteps;
end;

procedure calcul_pos_horloge;
begin
  if not assigned(formclock) or (formclock=nil) or fermeSC then exit;
  if LargeurFC<150 then
  begin
    LargeurFC:=250;
    HauteurFC:=250;
    formclock.width:=LargeurFC;
    formclock.height:=HauteurFC;
  end;

  OffsetYFC:=(formprinc.top+formPrinc.height)-FormClock.height-28;
  OffsetXFC:=(formprinc.left+formPrinc.width)-formClock.width;

  // �cart entre fenetre principale et clock
  DeltaFPCY:=OffsetYFC-formprinc.top;
  DeltaFPCX:=OffsetXFC-formprinc.left;

  formclock.top:=OffsetYFC;
  formclock.left:=OffsetXFC;

end;


procedure TFormClock.FormCreate(Sender: TObject);
var off : integer;
begin
  // inits
//  Affiche('FormClock create',clYellow);
  if formClock<>nil then
  begin
    SetWindowPos(FormClock.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NoMove or SWP_NoSize);
    Verrouille:=true;

    clock:=tClock.Create(formClock);
    clock.Parent:=formclock;

    clock.CalcClockSettings;
    clock.DrawClockBkg;
    clock.ClkFaceColor:=$e0e0e0;
    clock.ClkArrowColor:=clBlack;

    off:=36;
    {$IF CompilerVersion >= 28.0}
    off:=40;
    {$IFEND}

    ImageList24x24.GetBitmap(0,BitBtnMarHor.Glyph);
    with BitBtnMarHor do
    begin
      Height:=26;
      Width:=26;
      Top:=formClock.Height-BitBtnMarHor.Height-off;
    end;

    ImageList24x24.GetBitmap(1,BitBtnArrHorl.Glyph);
    with BitBtnArrHorl do
    begin
      Height:=26;
      Width:=26;
      Top:=formClock.Height-BitBtnMarHor.Height-off;
    end;

    ImageList24x24.GetBitmap(2,BitBtnInitHor.Glyph);
    with BitBtnInitHor do
    begin
      Height:=26;
      Width:=26;
      Top:=formClock.Height-BitBtnMarHor.Height-off;
    end;

    with ButtonParametres do
    begin
      Height:=26;
      Width:=26;
      Top:=formClock.Height-BitBtnMarHor.Height-off;
    end;

    with ButtonGH do
    begin
      Height:=26;
      Width:=26;
      Top:=formClock.Height-BitBtnMarHor.Height-off;
    end;

    color:=clock.ClkFaceColor;
    SecThick:=2;   MinThick:=10;
    HouThick:=12;

    FormClockInit:=true;
  end;
end;

// fixer les valeurs maxi et mini de la taille de la fenetre
procedure TFormClock.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var  MinMaxInfo : PMinMaxInfo;
begin
  inherited;
  MinMaxInfo:=Message.MinMaxInfo;
  MinMaxInfo^.ptMaxTrackSize.X:=400; // Maximum Width
  MinMaxInfo^.ptMaxTrackSize.Y:=400; // Maximum Height
  MinMaxInfo^.ptMinTrackSize.X:=150; // Minimum Width
  MinMaxInfo^.ptMinTrackSize.Y:=150; // Minimum Height
end;

procedure TFormClock.FormResize(Sender: TObject);
begin
  if (csDesigning in ComponentState) or (formClock=nil) or not(FormClockInit) then exit;
  clock.Width:=formClock.Width-offsetx;
  clock.Height:=formClock.Height-offsety;
  HouThick:=round(12*width/250);
  MinThick:=round(10*width/250);
  SecThick:=round(2*width/250);
end;

procedure TFormClock.BitBtnMarHrClick(Sender: TObject);
begin
  Demarre_horloge;
end;

procedure TFormClock.BitBtnArrHorlClick(Sender: TObject);
begin
  horloge:=false;
end;

procedure TFormClock.BitBtnInitHorClick(Sender: TObject);
begin
  init_horloge;
end;

procedure TFormClock.ButtonParametresClick(Sender: TObject);
begin
  if formHorloge<>nil then formHorloge.showModal;
end;

procedure TFormClock.TjsVerClick(Sender: TObject);
begin
  SetWindowPos(Handle,HWND_TOPMOST, 0, 0, 0, 0,SWP_NoMove or SWP_NoSize);
  // le checked ne fonctionne pas sous D7, fonctionne sous D12.
  TjsDev.Checked:=true;
  Dverrouiller1.Checked:=false;
  Verrouille:=true;
end;

procedure TFormClock.Dverrouiller1Click(Sender: TObject);
begin
  SetWindowPos(Handle,HWND_NOTOPMOST, 0, 0, 0, 0,SWP_NoMove or SWP_NoSize);
  TjsDev.Checked:=false;
  Dverrouiller1.Checked:=true;
  Verrouille:=false;
end;


procedure affiche_horloge;
begin
  if (formClock<>nil) then
  begin
    FormClock.Show;
    formClock.BringToFront;
  end;
end;


procedure TFormClock.ButtonGHClick(Sender: TObject);
begin
  formFicheHoraire.showModal;
end;


end.

