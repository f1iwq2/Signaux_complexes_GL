unit UnitTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus;

type
  TFormTCO = class(TForm)
    DrawGrid: TDrawGrid;
    Button1: TButton;
    LabelX: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelY: TLabel;
    ScrollBox: TScrollBox;
    ImageTCO: TImage;
    PopupMenu1: TPopupMenu;
    Position1: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure ImageTCOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;


var
  FormTCO: TFormTCO;
  NbreCellX,NbreCellY,HtImageTCO,LargImageTCO,XclicCell,YclicCell : integer;
  LargeurCell,HauteurCell,Xclic,Yclic : integer;
  tco : array[1..20,1..20] of Tbranche;

procedure construit_TCO;
procedure affiche_TCO;
  
implementation

{$R *.dfm}



procedure grille;
var x,y : integer;
    r : Trect;
begin
  HtImageTCO:=FormTCO.ImageTCO.Height;
  HtImageTCO:=FormTCO.ImageTCO.Height;
  LargImageTCO:=FormTCO.ImageTCO.Width;
  
  With FormTCO.ImageTCO.canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=clBlack;
    pen.color:=clyellow;
    r:=rect(1,1,LargImageTCO,HtImageTco);
    FillRect(r);
    

    pen.color:=$707070;
    for x:=1 to NbreCellx do
    begin
      moveto(x*LargeurCell,1);
      LineTo(x*LargeurCell,HtImageTCO);
    end;
    for y:=1 to NbreCelly do
    begin
      moveto(1,y*HauteurCell);
      LineTo(LargimageTCO,y*HauteurCell);
    end;
  end;
end;

procedure dessin_voie(x,y : integer);
var x1,y1 : integer;
    r : Trect;
begin
  with FormTCO.ImageTCO.Canvas do
  begin
    x1:=x*LargeurCell;
    y1:=y*HauteurCell;
  end;
  with formTCO.ImageTCO.canvas do
  begin
    r:=Rect(x1,y1+(HauteurCell div 2)-5,x1+LargeurCell,y1 + (HauteurCell div 2)+5);
    Brush.COlor:=ClRed;
    FillRect(r);
  end;
end;

// aiguillage pointe à gauche, monte gauche
procedure dessin_AigPGMG(x,y : integer;couleur : Tcolor);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=x*LargeurCell;
  y0:=y*HauteurCell;

  with formTCO.ImageTCO.canvas do
  begin
    Brush.COlor:=couleur;
    pen.color:=couleur;

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf

   
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    //brush.color:=clblue;
    x1:=x0+(largeurCell div 2);
    y1:=jy1;
    x2:=x0+largeurCell-3;
    y2:=y0;
    x3:=x0+largeurCell;
    y3:=y0+3;
    x4:=x0+(largeurCell div 2)+7;
    y4:=jy1;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3+2,y3-2),Point(x4+2,y4-2)]);
    
  end;
end;

// courbe bas gauche vers droit
procedure dessin_cbgd(x,y : integer;couleur : Tcolor);
var jy1,jy2,x0,y0,i,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=x*LargeurCell;
  y0:=y*HauteurCell;

  with formTCO.ImageTCO.canvas do
  begin
    Brush.COlor:=Couleur;
    pen.color:=Couleur;
  
    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0+(largeurCell div 2),jy1,x0+LargeurCell,jy2);   
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0;
    y1:=y0+HauteurCell-3;
    x2:=x0+(LargeurCell div 2) -0;
    y2:=jy1;
    x3:=x0+(LargeurCell div 2) +2;
    y3:=jy2;
    x4:=x0+3;
    y4:=y0+HauteurCell;
    Polygon([point(x1-2,y1+2),Point(x2,y2),Point(x3,y3),Point(x4-2,y4+2)]);
    
  end;
end;


procedure construit_TCO;
var x,y,i,j,Max,indexMax : integer;
begin
  // étape 0 Raz du TCO
  for y:=1 to 20 do
    for x:=1 to 20 do 
    begin
      TCO[x,y].Adresse:=0;
      TCO[x,y].Btype:=0;
    end;  

  //étape 1 trouver la branche la plus longue
  Max:=0;
  for i:=1 to  NbreBranches do
  begin
    j:=0;
    repeat
      inc(j);
    until BrancheN[i,j].Adresse=0;
    if j>Max then begin Max:=j-1;IndexMax:=i;end;
  end;
  Affiche('La branche la plus grande a pour index '+IntToSTR(IndexMax),clOrange);

  // stocker cette branche au milieu du TCO (en 5)
  for i:=1 to Max do
  begin
    TCO[i,5].Adresse:=BrancheN[IndexMax,i].Adresse;    
    TCO[i,5].Btype:=BrancheN[IndexMax,i].Btype;
  end;
  
  
end;

procedure Affiche_TCO ;
var i,j,x,y,xOrg,Yorg,btype : integer;
    s : string;
begin
  with formTCO.ImageTCO.Canvas do
  begin
    Brush.color:=ClBlack;
    font.color:=clWhite;
  end;
  for y:=1 to 10 do
    for x:=1 to 20 do
      begin
        i:=tco[x,y].Adresse;
        btype:=tco[x,y].Btype;
        with formTCO.ImageTCO.Canvas do
        begin
          Xorg:=(x-1)*LargeurCell;
          Yorg:=(y-1)*HauteurCell;

          s:=IntToSTR(i);
          if Btype=2 then s:='A'+s;
          if Btype=3 then s:='A'+s+'B';
          
          Textout(Xorg+2,Yorg+2,s);
        end;     
      end;    
end;


procedure TFormTCO.FormCreate(Sender: TObject);
begin
  
  caption:='TCO';
  NbreCellX:=20;
  NbreCellY:=10;
  LargeurCell:=35;
  HauteurCell:=35;
  //grille;
  // HtImageTCO:=ImageTCO.Height;

end;

// x y = numéro cellule
Procedure dessine(x,y : integer);
Var Xorg,Yorg : integer;
begin
  Xorg:=x*LargeurCell;
  Yorg:=y*HauteurCell;
  with FormTCO.DrawGrid.Canvas do
  begin
    Pen.width:=3;
    Pen.Color:=clyellow;
    Brush.Style:=bsSolid;
    MoveTo(xorg,yorg);LineTo(xorg+120,yorg+150)  ;
    Pen.Color:=clred;
    MoveTo(1,1);LineTo(120,160)  ;

  end;
  formTCO.refresh;

end;



procedure TFormTCO.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  s : string;
     aCanvas : Tcanvas;
begin
   exit;
  dessine(2,2);
 
  if (Acol=3) and (ARow=3) then with Sender as TDrawGrid do Canvas.Draw(Rect.left,Rect.Top,Formprinc.Image6Dir.picture.bitmap);

  if (Acol=2) and (Arow=1) then
  begin
    with Sender as TDrawGrid do
    begin
      //Canvas.Pen:=psSolid;
      With canvas do
      begin
        Pen.width:=3;
        Pen.Color:=clyellow;
        MoveTo(1,1);LineTo(150,150)  ;
      end;
    end;

  end;

end;



procedure TFormTCO.Button1Click(Sender: TObject);
begin
  grille;
  dessin_voie(3,3);
  dessin_voie(10,4);
  dessin_AigPGMG(7,6,clyellow);
end;


procedure TFormTCO.ImageTCOClick(Sender: TObject);
var  Position: TPoint;
begin
  GetCursorPos(Position);
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  
  
end;

procedure TFormTCO.FormActivate(Sender: TObject);
begin
  
  grille;
  dessin_voie(3,3);
  dessin_voie(10,4);
  dessin_AigPGMG(7,6,clyellow);
  dessin_cbgd(8,5,clyellow);
  
  formprinc.Hide;
end;

procedure TFormTCO.ImageTCOContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var  Position: TPoint;
begin
  GetCursorPos(Position);
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  
end;

end.
