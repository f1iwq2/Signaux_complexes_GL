unit UnitInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFormInfo = class(TForm)
    Timerinfo: TTimer;
    LabelInfo: TLabel;
    procedure TimerinfoTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormInfo: TFormInfo;
  TickInfo : integer;

implementation

{$R *.dfm}

procedure TFormInfo.TimerinfoTimer(Sender: TObject);
begin
  if TickInfo>0 then
  begin
    dec(TickInfo);
    if TickInfo=0 then close;
  end;
end;

procedure TFormInfo.FormActivate(Sender: TObject);
begin
  TickInfo:=5;
end;

procedure TFormInfo.FormCreate(Sender: TObject);
begin
  labelInfo.Width:=formInfo.Width-20;
end;

end.
