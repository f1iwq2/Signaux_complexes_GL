unit UnitConfigTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , UnitTCO, ExtCtrls, Menus;

type
  TFormConfigTCO = class(TForm)
    ButtonOK: TButton;
    Label1: TLabel;
    EditTailleCellX: TEdit;
    EditTailleCellY: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ButtonDessine: TButton;
    CheckDessineGrille: TCheckBox;
    EditNbCellX: TEdit;
    EditNbCellY: TEdit;
    LabelErreur: TLabel;
    ColorDialog1: TColorDialog;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    ImageAig: TImage;
    ImageFond: TImage;
    Label6: TLabel;
    ImageGrille: TImage;
    Label7: TLabel;
    ImageDetAct: TImage;
    Label8: TLabel;
    Memo1: TMemo;
    Label9: TLabel;
    Imagecanton: TImage;
    Label10: TLabel;
    ImageTexte: TImage;
    Label11: TLabel;
    Label12: TLabel;
    LabelMaxX: TLabel;
    LabelMaxY: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonDessineClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageAigClick(Sender: TObject);
    procedure ImageFondClick(Sender: TObject);
    procedure ImageGrilleClick(Sender: TObject);
    procedure ImageDetActClick(Sender: TObject);
    procedure ImagecantonClick(Sender: TObject);
    procedure ColorDialog1Show(Sender: TObject);
    procedure ImageTexteClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var  FormConfigTCO: TFormConfigTCO;
     AvecGrille : boolean;
     titre_couleur : string;
     
implementation

uses UnitPrinc ;


{$R *.dfm}

procedure icone_aig;
var r : Trect;
    x1,y1,x2,y2,x3,y3,x4,y4 : integer;
begin
      with FormConfigTCO.ImageAig do
      begin
        canvas.Pen.color:=fond;
        canvas.Brush.Color:=fond;
        canvas.Rectangle(0,0,Width,Height);

        canvas.pen.color:=clVoies;
        canvas.brush.color:=clvoies;
        // bande horizontale
        r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
        canvas.FillRect(r);

        x1:=(width div 2); y1:=(height div 2)-3;
        x2:=3; y2:=0;
        x3:=0; y3:=3;
        x4:=0+(width div 2)-1; y4:=(height div 2)+3-1;
        canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;

end;

procedure dessine_icones;
var r : Trect;
begin
  // 1
  icone_aig;
  // 2
  with formConfigTCO.ImageFond do
  begin
    canvas.Pen.color:=fond;
    canvas.Brush.Color:=fond;
    canvas.Rectangle(0,0,Width,Height);
  end;
  // 3
  with formConfigTCO.ImageGrille do
  begin
    canvas.Pen.color:=fond;
    canvas.Brush.Color:=fond;
    canvas.Rectangle(0,0,Width,Height);
    canvas.Pen.color:=ClGrille;
    canvas.moveto(0,5); canvas.LineTo(width,5);
    canvas.moveto(27,0); canvas.LineTo(27,Height);
  end;
  // 4 détecteur
  with formConfigTCO.ImageDetAct do
  begin
    canvas.Pen.color:=fond;
    canvas.Brush.Color:=fond;
    canvas.Rectangle(0,0,Width,Height);
    
    canvas.Brush.Color:=clAllume;
    canvas.pen.color:=clAllume;
    canvas.Pen.Mode:=pmCopy;
    r:=Rect(1,(height div 2)-6,width-1,(height div 2)+6);
    canvas.FillRect(r);
    
    canvas.pen.color:=clVoies;
    canvas.brush.color:=clVoies;
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);
  end;

  // 5 canton 
  with formCOnfigTCO.Imagecanton do
  begin
    canvas.Pen.color:=fond;
    canvas.Brush.Color:=fond;
    canvas.Rectangle(0,0,Width,Height);
    
   
    canvas.pen.color:=clAllume;
    canvas.brush.color:=clAllume;
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);
  end;

  //6 texte
  with formCOnfigTCO.ImageTexte do
  begin
    canvas.Pen.color:=fond;
    canvas.Brush.Color:=fond;
    canvas.Rectangle(0,0,Width,Height);
    canvas.Font.color:=clTexte;
    canvas.Pen.mode:=pmCopy;
    canvas.Textout(5,10,'Voie 1');
    
  end;


end;

function verif_config_TCO : boolean;  // renvoie true si ok
var erreur : integer;
    nokNbX,nokNbY,nokHt,nokLg : boolean;
begin
  with formConfigTCO do
  begin
    Val(EditNbCellX.Text,NbreCellX,erreur);
    nokNbX:=erreur<>0;
    if nokNbX then LabelErreur.caption:='Erreur nombre de cellules X';
    nokNbX:=(NbreCellX<20) or (NbreCellX>MaxCellX);
    if nokNbX then LabelErreur.caption:='Erreur: nombre de cellules X: mini=20 maxi='+IntToSTR(MaxCellX);

    Val(EditNbCellY.Text,NbreCellY,erreur);
    nokNbY:=erreur<>0;
    if nokNbY then LabelErreur.caption:='Erreur: nombre de cellules Y';
    nokNbY:=nokNbY or (NbreCellY<10) or (NbreCellY>MaxCellY);
    if nokNbY then LabelErreur.caption:='Erreur: nombre de cellules Y: mini=10 maxi='+IntToSTR(MaxCellY);

    Val(EditTailleCellX.Text,LargeurCell,erreur);
    nokLg:=erreur<>0;
    if nokLg then LabelErreur.caption:='Erreur largeur de cellules';
    nokLg:=nokLg or (LargeurCell<20) or (LargeurCell>50)  ;
    if nokLg then LabelErreur.caption:='Erreur: Tailles des cellules - largeur cellules mini=20 maxi=50';
  
    Val(EditTailleCellY.Text,HauteurCell,erreur);
    nokHt:=erreur<>0;
    if nokHt then LabelErreur.caption:='Erreur hauteur de cellules';
    nokHt:=nokHt or (HauteurCell<20) or (HauteurCell>50)  ;
    if nokHt then LabelErreur.caption:='Erreur: Tailles des cellules - hauteur cellules mini=20 maxi=50';

    AvecGrille:=checkDessineGrille.Checked;
  end;
  verif_config_TCO:=not(nokNbX or nokNbY or nokHt or nokLg);
  NbCellulesTCO:=NbreCellX*NbreCellY;
end;

procedure TFormConfigTCO.ButtonOKClick(Sender: TObject);
var i : integer;   
    
begin
  if verif_config_TCO then
  begin
    with formTCO do
    begin
      ImageTCO.Width:=LargeurCell*NbreCellX;
      ImageTCO.Height:=HauteurCell*NbreCellY;
    end;  
    AvecGrille:=checkDessineGrille.Checked;
    formTCO.affiche_TCO;
    LabelErreur.caption:='';
    close;
  end; 
end;

procedure TFormConfigTCO.ButtonDessineClick(Sender: TObject);
var i,erreur : integer;
    r : Trect;
    c : tCanvas;
begin
  if verif_config_TCO then
  begin
    with formTCO do
    begin
      ImageTCO.Width:=LargeurCell*NbreCellX;
      ImageTCO.Height:=HauteurCell*NbreCellY;
    end;  
    formTCO.affiche_TCO;
  end;  
end;


procedure TFormConfigTCO.FormActivate(Sender: TObject);
begin
  EditTailleCellX.Text:=IntToSTR(LargeurCell);
  EditTailleCellY.Text:=IntToSTR(HauteurCell);
  EditNbCellX.Text:=IntToSTR(NbreCellX);
  EditNbCellY.Text:=IntToSTR(NbreCellY);
  checkDessineGrille.Checked:=AvecGrille;
  labelMaxX.caption:='Max='+intToSTR(MaxCellX);
  labelMaxY.caption:='Max='+intToSTR(MaxCellY);
  dessine_icones;
end;


procedure TFormConfigTCO.ImageAigClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur des voies';
  if ColorDialog1.execute then
  begin
    clVoies:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end; 
end;

procedure TFormConfigTCO.ImageFondClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de fond';
  if ColorDialog1.execute then
  begin
    fond:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImageGrilleClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de la grille';
  if ColorDialog1.execute then
  begin
    ClGrille:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end; 
end;

procedure TFormConfigTCO.ImageDetActClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de détecteur activé';
  if ColorDialog1.execute then
  begin
    ClAllume:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end; 
end;

procedure TFormConfigTCO.ImagecantonClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de canton activé';
  if ColorDialog1.execute then
  begin
    ClAllume:=ColorDialog1.Color;
    dessine_icones;
  end; 
end;

procedure TFormConfigTCO.ImageTexteClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du texte';
  if ColorDialog1.execute then
  begin
    ClTexte:=ColorDialog1.Color;
    dessine_icones;
  end; 
end;


// change le titre de la fenêtre de choix des couleurs à son ouverture
procedure TFormConfigTCO.ColorDialog1Show(Sender: TObject);
begin
   SetWindowText(ColorDialog1.Handle,pchar(titre_couleur));
end;




end.
