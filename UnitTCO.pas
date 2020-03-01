unit UnitTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus;

type
  TFormTCO = class(TForm)
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
    Insrer1: TMenuItem;
    aiguillageG_PG: TMenuItem;
    Label1: TLabel;
    aiguillageD_PD: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageTCOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure aiguillageG_PGClick(Sender: TObject);
    procedure dessin_AigPG_AG(x,y : integer;couleur : Tcolor);
    procedure dessin_AigPD_AD(x,y : integer;couleur : Tcolor);
    procedure dessin_cbgd(x,y : integer;couleur : Tcolor);
    procedure dessin_cdbas(x,y : integer;couleur : Tcolor);
    procedure Entoure_cell(x,y : integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aiguillageD_PDClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;


var
  FormTCO: TFormTCO;
  Forminit : boolean;
  NbreCellX,NbreCellY,HtImageTCO,LargImageTCO,XclicCell,YclicCell : integer;
  LargeurCell,HauteurCell,Xclic,Yclic,XClicCellInserer,YClicCellInserer : integer;
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

// élément de voie horizontale
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
    r:=Rect(x1,y1+(HauteurCell div 2)-3,x1+LargeurCell,y1 + (HauteurCell div 2)+3);
    Brush.COlor:=ClRed;
    FillRect(r);
  end;
end;

// aiguillage pointe à gauche, aiguillage gauche
procedure TFormTCO.dessin_AigPG_AG(x,y : integer;couleur : Tcolor);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with ImageTCO.canvas do
  begin
    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=PmCopy;
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

// aiguillage pointe à droite, aiguillage droit
procedure TFormTCO.dessin_AigPD_AD(x,y : integer;couleur : Tcolor);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with ImageTCO.canvas do
  begin
    Brush.COlor:=couleur;
    Pen.Mode:=PmCopy;
    pen.color:=couleur;

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf

   
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    //brush.color:=clblue;
    x1:=x0+(largeurCell div 2); y1:=jy1;
    x2:=x0+3; y2:=y0;
    x3:=x0; y3:=y0+3;
    x4:=x0+(largeurCell div 2); y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4-1,y4-1)]);
    
  end;
end;

// courbe bas gauche vers droit
procedure TFormTCO.dessin_cbgd(x,y : integer;couleur : Tcolor);
var jy1,jy2,x0,y0,i,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with ImageTCO.canvas do
  begin
    Brush.COlor:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=PmCopy;
  
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

// courbe: droit vers bas  -\
procedure TFormTCO.dessin_cdbas(x,y : integer;couleur : Tcolor);
var jy1,jy2,x0,y0,i,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with ImageTCO.canvas do
  begin
    Brush.COlor:=Couleur;
    Pen.Mode:=PmCopy;
    pen.color:=Couleur;

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2) ;
    y1:=jy1;
    x2:=x0+LargeurCell;
    y2:=y0+HauteurCell-3;
    x3:=x0+LargeurCell -2;
    y3:=y0+HauteurCell;
    x4:=x0+(LargeurCell div 2);
    y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

  end;
end;

// transforme les branches en TCO
// à voir, trop compliqué. Il faudra dessiner son TCO soit meme
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
          
          if i<>0 then Textout(Xorg+2,Yorg+2,s);
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
  XclicCell:=1;
  YclicCell:=1;
  KeyPreview:=true; // valide les évènements clavier
 // grille;
 // Entoure_cell(XclicCell,YclicCell);
end;


procedure TFormTCO.Button1Click(Sender: TObject);
begin
  repaint;
end;

// clic gauche sur image
procedure TFormTCO.ImageTCOClick(Sender: TObject);
var  Position: TPoint;
begin
  Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
  
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  label1.caption:='clicContext';
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  Entoure_cell(XclicCellInserer,YclicCellInserer);
end;

procedure TformTCO.Entoure_cell(x,y : integer);
var r : Trect;
    x0,y0 : integer;
begin
  x0:=(x-1)*LargeurCell+1;
  y0:=(y-1)*HauteurCell+1;
  with ImageTCO.canvas do
  begin
    Pen.width:=3;
    Pen.Color:=clyellow;
    Brush.Color:=clBlack;
    Brush.Style:=bsSolid;
    Pen.Mode:=PmXor;
    r:=Rect(x0,y0,x0+largeurCell,y0+LargeurCell);
    Rectangle(r);
//    FillRect(r);
  end;

end;


procedure TFormTCO.FormActivate(Sender: TObject);
begin
  if not(Forminit) then
  begin
    FormInit:=true;
    grille;
    Entoure_cell(XclicCell,YclicCell);
  end;  
 {
  dessin_voie(3,3);
  dessin_voie(10,4);
  dessin_AigPG_AG(7,6,clyellow);
  dessin_AigPD_AD(12,6,clyellow);

  dessin_cbgd(8,5,clyellow);
  dessin_voie(9,5);dessin_voie(10,5);
  dessin_cdbas(11,5,clyellow); }
  //formprinc.Hide;
end;

// evt qui se produit quand on clic droit dans l'image
procedure TFormTCO.ImageTCOContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var  Position: TPoint;
begin
  // efface le carré pointeur
  Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
  
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  label1.caption:='clicContext';
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  Entoure_cell(XclicCellInserer,YclicCellInserer);
end;

// menu droit "clic aiguillage G PG"
procedure TFormTCO.aiguillageG_PGClick(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur 
  Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
  // dessine le dessin
  dessin_AigPG_AG(XClicCellInserer,YClicCellInserer,clyellow);
  // remet le carré pointeur
  Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
end;

// menu droit "clic aiguillage D PD"
procedure TFormTCO.aiguillageD_PDClick(Sender: TObject);
var  Position: TPoint;
begin
   // effacer le carré pointeur 
  Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
  // dessine le dessin
  dessin_AigPD_AD(XClicCellInserer,YClicCellInserer,clyellow);
  // remet le carré pointeur
  Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
end;



procedure TFormTCO.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  Entoure_cell(XclicCell,YclicCell);   
  case Key of
     VK_right : if XClicCell<NbreCellX then inc(XClicCell);
     VK_left  : if XClicCell>1 then dec(XClicCell);
     VK_down  : if YClicCell<NbreCellY then inc(YClicCell);
     VK_up    : if YClicCell>1 then dec(YClicCell);
  end;
  LabelX.caption:=IntToSTR(XClicCell);  
  LabelY.caption:=IntToSTR(YClicCell);
  Entoure_cell(XclicCell,YclicCell);   
end;

end.
