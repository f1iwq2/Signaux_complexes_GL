unit UnitConfigCellTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UnitTCO, ExtCtrls,
  Buttons;

type
  TFormConfCellTCO = class(TForm)
    GroupBox1: TGroupBox;
    ComboRepr: TComboBox;
    Label1: TLabel;
    ButtonFonte: TButton;
    EditTexteCCTCO: TEdit;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    EditTypeImage: TEdit;
    CheckPinv: TCheckBox;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    RadioButtonHG: TRadioButton;
    RadioButtonV: TRadioButton;
    RadioButtonHD: TRadioButton;
    GroupBox4: TGroupBox;
    RadioButtonG: TRadioButton;
    RadioButtonD: TRadioButton;
    EditAdrElement: TEdit;
    ButtonFond: TButton;
    BitBtnOk: TBitBtn;
    ImagePaletteCC: TImage;
    procedure EditAdrElementChange(Sender: TObject);
    procedure EditTexteCCTCOChange(Sender: TObject);
    procedure ButtonFonteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboReprChange(Sender: TObject);
    procedure CheckPinvClick(Sender: TObject);
    procedure RadioButtonVClick(Sender: TObject);
    procedure RadioButtonHGClick(Sender: TObject);
    procedure RadioButtonHDClick(Sender: TObject);
    procedure RadioButtonGClick(Sender: TObject);
    procedure RadioButtonDClick(Sender: TObject);
    procedure ButtonFondClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnOkClick(Sender: TObject);
    procedure EditTypeImageChange(Sender: TObject);
    procedure ImagePaletteCCMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormConfCellTCO: TFormConfCellTCO;
  actualize : boolean;
  IconeX,IconeY : integer;
  
procedure actualise;

implementation


uses UnitPrinc,UnitAnalyseSegCDM,
  UnitConfigTCO;

{$R *.dfm}

// actualise le contenu de la fenetre et de la zone tco
procedure actualise;
var Bimage,oriente,piedFeu : integer;
    s : string;
    ip : Timage;
    Bm : Tbitmap;
    r : trect;
begin
  Bm:=formConfCellTCO.imagepalettecc.Picture.Bitmap;
  Bimage:=tco[XClicCell,YClicCell].Bimage;
 
  if formConfCellTCOAff then
  begin
    // si aiguillage, mettre à jour l'option de pilotage inverse
    if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13)
       or (bimage=14) or (bimage=15) or (bimage=24) then
    begin

      // aiguillage inversé
      with FormConfCellTCO.CheckPinv do
      begin
        enabled:=true;
        checked:=TCO[XClicCell,YClicCell].inverse;
      end;
      FormTCO.CheckPinv.checked:=TCO[XClicCell,YClicCell].inverse;
      FormTCO.CheckPinv.enabled:=true ;
    end
    else
    begin
      FormTCO.CheckPinv.enabled:=false;
      FormConfCellTCO.checkPinv.enabled:=false;
    end;
  end;

    // si voie ou rien ou signal ou quai
    if (Bimage=1) or (Bimage=0) or (Bimage=Id_signal) or (Bimage=51) then
    begin
      s:=Tco[XClicCell,YClicCell].Texte;
      with formTCO do
      begin
        EditTexte.Text:=s;
        EditTexte.Visible:=true;
        ComboRepr.Enabled:=true;
      end;
    end
    else
    begin
      formTCO.EditTexte.Visible:=false;
      formTCO.comboRepr.Enabled:=false;
    end;

    s:=IntToSTR(XclicCell)+','+IntToSTR(YclicCell);
    FormTCO.LabelCoord.caption:=s;
    FormTCO.GroupBox1.Caption:='Configuration cellule '+s;
    XclicCellInserer:=XClicCell;
    YclicCellInserer:=YClicCell;
    FormTCO.EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
    FormTCO.EdittypeImage.Text:=IntToSTR(BImage);
    FormTCO.ComboRepr.ItemIndex:=tco[XClicCell,yClicCell].repr;
    FormTCO.ShapeCoulFond.Brush.Color:=tco[XClicCell,yClicCell].CouleurFond;

    s:='El='+intToSTR(tco[XClicCell,YClicCell].BImage);
    if tco[XClicCell,YClicCell].adresse<>0 then s:=s+' Adr='+intToSTR(tco[XClicCell,YClicCell].adresse);
    //hint:=s;


  if not(formConfCellTCOAff) then exit;
  actualize:=true;  // évite les évènements parasites
  FormConfCellTCO.caption:='Propriétés de la cellule '+IntToSTR(XClicCell)+','+intToSTR(YClicCell);
  Bimage:=TCO[XClicCell,YClicCell].Bimage;
  formConfCellTCO.EditTypeImage.Text:=intToSTR(Bimage);

  // si signal
  if Bimage=Id_signal then
  With formConfCellTCO.ImagePaletteCC do
  begin
    //Height:=FormTCO.ImagePalette1.Picture.Height;
    //ziziWidth:=FormTCO.ImagePalette1.Picture.Width;
    Transparent:=false;
  end;

  // si pas signal
  if Bimage<>Id_signal then
  with formConfCellTCO do
  begin
    RadioButtonV.Enabled:=false;
    RadioButtonHG.Enabled:=false;
    RadioButtonHD.Enabled:=false;
    RadioButtonG.Enabled:=false;
    RadioButtonD.Enabled:=false;
    ImagePaletteCC.transparent:=false;
  end;

  // mettre l'image de la cellule cliquée dans l'icone de la fenetre de config cellule
  if Bimage=0 then
  begin
    with FormConfCellTCO.ImagePaletteCC do
    begin
      r:=Rect(0,0,width,height);
      with canvas do
      begin
        // effacer l'icone
        Pen.Mode:=pmCopy;
        Pen.Width:=1;
        Pen.color:=tco[XClicCell,YClicCell].CouleurFond;
        Brush.Color:=tco[XClicCell,YClicCell].CouleurFond;
        Brush.style:=bsSolid;
        fillRect(r);
      end;
    end;

    with formConfCellTCO do
    begin
      RadioButtonV.Enabled:=false;
      RadioButtonHG.Enabled:=false;
      RadioButtonHD.Enabled:=false;
      RadioButtonG.Enabled:=false;
      RadioButtonD.Enabled:=false;
    end;
  end

  else

  // Bimage non nulle
  begin
    ip:=formTCO.findComponent('ImagePalette'+intToSTR(Bimage)) as Timage;
    if ip=nil then exit;

    // affiche l'icone cliquée dans la fenetre -----------------------------------------------
    // pour que le stretchBlt soit visible, il faut mettre à jour la taille du bitmap
    with FormConfCellTCO.ImagePaletteCC.Picture.Bitmap do
    begin
      width:=iconeX;
      Height:=iconeY;
    end;

    ip:=formTCO.findComponent('ImagePalette'+intToSTR(Bimage)) as Timage; // image source

    // destination masque avec mise à l'échelle
    StretchBlt(FormConfCellTCO.ImagePaletteCC.canvas.Handle,0,0,iconeX,iconeY,   
                ip.Canvas.Handle,0,0,ip.Width,ip.Height,srccopy);
    FormConfCellTCO.ImagePaletteCC.repaint;  // obligatoire sinon il ne s'affiche pas
    //-----------------------------------------------------------------------------------------
    
    if Bimage=Id_signal then
    begin     // signal
      With formConfCellTCO.ImagePaletteCC do
      begin
       // Height:=FormTCO.ImagePalette50.Height;
       // Width:=FormTCO.ImagePalette50.Width;
        //Picture.Assign(FormTCO.ImagePalette50.Picture);
        Picture.Bitmap.TransparentMode:=tmAuto;
        Picture.Bitmap.TransparentColor:=clblue;
        Transparent:=true;
      end;
      with formconfCellTCO do
      begin
        RadioButtonV.Enabled:=true;
        RadioButtonHG.Enabled:=true;
        RadioButtonHD.Enabled:=true;
        RadioButtonG.Enabled:=true;
        RadioButtonD.Enabled:=true;
        oriente:=tco[XClicCell,YClicCell].Feuoriente;
        if oriente=1 then
        begin
          RadioButtonV.checked:=true;
          RadioButtonHG.checked:=false;
          RadioButtonHD.checked:=false;
        end;
        if oriente=2 then
        begin
           RadioButtonV.checked:=false;
           RadioButtonHG.checked:=true;
           RadioButtonHD.checked:=false;
        end;
        if oriente=3 then
        begin
          RadioButtonV.checked:=false;
          RadioButtonHG.checked:=false;
          RadioButtonHD.checked:=true;
        end;

        PiedFeu:=tco[XClicCell,YClicCell].PiedFeu;
        if PiedFeu=1 then
        begin
          RadioButtonG.checked:=true;
          RadioButtonD.checked:=false;
        end;
        if PiedFeu=2 then
        begin
          RadioButtonG.checked:=false;
          RadioButtonD.checked:=true;
        end;
      end;
    end;
  end;

  // aiguillage
  if ((BImage=2) or (BImage=3) or (BImage=4) or (BImage=5) or (BImage=12) or (BImage=13) or (BImage=14) or
      (BImage=15) or (BImage=21) or (BImage=22) or (BImage>=24) ) and (Bimage<50) then
    formConfCellTCO.checkPinv.Enabled:=true
    else formConfCellTCO.checkPinv.Enabled:=false;

  with formConfCellTCO do
  begin
    EditTexteCCTCO.Text:=Tco[XClicCell,YClicCell].Texte;
    EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
    ComboRepr.ItemIndex:=tco[XClicCell,yClicCell].repr;
  end;
  actualize:=false;
end;


procedure TFormConfCellTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index : integer;
begin
  if clicTCO or not(formConfCellTCOAff) or actualize then exit;
  if affevt then Affiche('TFormConfCellTCO.EditAdrElementChange',clyellow);

  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;

  if Adr=0 then tco[XClicCell,YClicCell].repr:=2;

  tco[XClicCell,YClicCell].Adresse:=Adr;
  formTCO.EditAdrElement.Text:=intToSTR(adr);


  if tco[XClicCell,YClicCell].BImage=Id_signal then
  begin
    index:=Index_Signal(adr);
    if index=0 then exit
    else
      begin
       //Affiche('Feu '+intToSTR(Adr),clyellow);
       affiche_tco;
     end;
  end;
  if not(selectionaffichee) then efface_entoure;
  Affiche_cellule(XclicCell,YclicCell);
  if not(selectionaffichee) then _entoure_cell_clic;

end;

procedure TFormConfCellTCO.EditTexteCCTCOChange(Sender: TObject);
begin
  if clicTCO or not(formConfCellTCOAff) or actualize then exit;
  PCanvasTCO.Brush.Color:=clfond;

  if Tco[XClicCell,YClicCell].texte='' then
  begin
    Tco[XClicCell,YClicCell].CoulFonte:=clTexte;
    Tco[XClicCell,YClicCell].TailleFonte:=8;
  end;
  Tco[XClicCell,YClicCell].Texte:=EditTexteCCTCO.Text;
  if not(clicTCO) then TCO_modifie:=true;
  if not(selectionaffichee) then efface_entoure;
  affiche_texte(XClicCell,YClicCell);
  formTCO.EditTexte.Text:=EditTexteCCTCO.text;
  if not(selectionaffichee) then _entoure_cell_clic;
end;

procedure TFormConfCellTCO.ButtonFonteClick(Sender: TObject);
begin
  change_fonte;
end;

procedure TFormConfCellTCO.FormCreate(Sender: TObject);
begin
  // fenetre toujours dessus
  if affevt then Affiche('FormConfCellTCO create',clyellow);
  actualize:=false;
  formConfCellTCOAff:=true;
  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
  iconeX:=50;  // taille de l'icone
  iconeY:=50;
  
  // dessine les composants - non utilisé
  {
  i:=1;
  //Affiche('formconfcellTCO create',clYellow);
  begin
    for y:=1 to 5 do
    for x:=1 to 5 do
    begin
      if i<25 then
      begin
        image:=Timage.create(FormConfCellTCO);
        with image do
        begin
          Parent:=FormConfCellTCO;
          Name:='i'+IntToSTR(i);   // nom de l'image - sert à identifier le composant si on fait clic droit.

          ImageSRC:=findComponent('ImagePalette'+intToSTR(i)) as Timage;

          picture.Bitmap:=ImageSRC.picture.BitMap;
          width:=ImageSRC.Width;
          height:=ImageSRC.Height;
          Stretch:=true;
          Transparent:=false;
          picture.Bitmap.Transparentmode:=tmfixed;
          Top:=(y-1)*(height+3)+5;
          Left:=GroupBox2.Width+(x-1)*(41+3)+15;
        end;
        inc(i);
      end;
    end;
  end; }
//  FormConfCellTCO.ImagePaletteCC.OnMouseDown:=ImagePaletteCCMouseDown;
end;

procedure TFormConfCellTCO.ComboReprChange(Sender: TObject);
begin
  if clicTCO or not(formConfCellTCOAff) or actualize then exit;
  tco[XClicCell,YClicCell].Repr:=comborepr.ItemIndex;
  efface_entoure;SelectionAffichee:=false;
  FormTCO.ComboRepr.ItemIndex:=ComboRepr.ItemIndex;
  //affiche_cellule(XClicCell,yClicCell);
  affiche_tco;
end;

procedure TFormConfCellTCO.CheckPinvClick(Sender: TObject);
var Bimage : integer;
begin
  if (xClicCell=0) or (xClicCell>NbreCellX) or (yClicCell=0) or (yClicCell>NbreCelly) then exit;
  Bimage:=Tco[xClicCell,yClicCell].Bimage;
  if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13) or
     (bimage=14) or (bimage=15) or (bimage=24)
  then
  begin
       TCO[xClicCell,yClicCell].inverse:=CheckPinv.checked;
       formTCO.CheckPinv.checked:=CheckPinv.checked;
       TCO_modifie:=true;
  end;
end;

procedure TFormConfCellTCO.RadioButtonVClick(Sender: TObject);
begin
  Vertical;
end;

procedure TFormConfCellTCO.RadioButtonHGClick(Sender: TObject);
begin
  tourne90G;
end;

procedure TFormConfCellTCO.RadioButtonHDClick(Sender: TObject);
begin
  tourne90D;
end;

procedure TFormConfCellTCO.RadioButtonGClick(Sender: TObject);
begin
  signalG;
end;

procedure TFormConfCellTCO.RadioButtonDClick(Sender: TObject);
begin
  signalD;
end;

procedure TFormConfCellTCO.ButtonFondClick(Sender: TObject);
begin
  change_couleur_fond;
end;

procedure TFormConfCellTCO.FormActivate(Sender: TObject);
begin
  if affevt then Affiche('FormConfCellTCO activate',clyellow);
  if selectionaffichee then ButtonFond.caption:='Couleur de fond de la sélection'
  else ButtonFond.caption:='Couleur de fond de la cellule';
end;

procedure TFormConfCellTCO.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

procedure TFormConfCellTCO.BitBtnOkClick(Sender: TObject);
begin
  close
end;

// extraire les points de connexion de l'icone (de 0 à 7)
procedure extrait_connect(numero : integer;var connect1,connect2,connect3,connect4 : integer);
var i,j : integer;
begin
  connect1:=-1;connect2:=-1;connect3:=-1;connect4:=-1;
  j:=0;
  for i:=0 to 7 do
  begin
    if testBit(liaisons[numero],i) then
    begin
      case j of
      0 : connect1:=i;
      1 : connect2:=i;
      2 : connect3:=i;
      3 : connect4:=i;
      end;
      inc(j);
    end;
  end;
end;

procedure TFormConfCellTCO.EditTypeImageChange(Sender: TObject);
var Bimage,erreur : integer;
begin
  if clicTCO or not(formConfCellTCOAff) or actualize then exit;
  if affevt then Affiche('TCO evt editTypeImageKeyPress',clorange);
  Val(EditTypeImage.Text,Bimage,erreur);
  if (erreur<>0) or not(Bimage in[0..29,32..34,50,51]) then
  begin
    exit;
  end;
  TCO_modifie:=true;
  tco[XClicCell,YClicCell].Bimage:=Bimage;
  FormTCO.EditTypeImage.text:=intToSTR(BImage);
  actualise; // pour mise à jour de l'image de la fenetre FormConfCellTCO
  efface_entoure;
  Efface_Cellule(FormTCO.ImageTCO.Canvas,XClicCell,yClicCell,pmCopy);
  affiche_cellule(XClicCell,YClicCell);

end;

procedure copie_cellule;
begin
// affiche l'icone cliquée dans la fenetre -----------------------------------------------
    // pour que le stretchBlt soit visible, il faut mettre à jour la taille du bitmap
    with FormConfCellTCO.ImagePaletteCC.Picture.Bitmap do
    begin
      width:=iconeX;
      Height:=iconeY;
    end;

    // destination masque avec mise à l'échelle
    StretchBlt(FormConfCellTCO.ImagePaletteCC.canvas.Handle,0,0,iconeX,iconeY,   
                PcanvasTCO.Handle,(xClicCell-1)*largeurCell,(yClicCell-1)*hauteurCell,largeurCell,hauteurCell,srccopy);
    FormConfCellTCO.ImagePaletteCC.repaint;  // obligatoire sinon il ne s'affiche pas
end;

procedure TFormConfCellTCO.ImagePaletteCCMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var c,x0,y0,xc,yc,xf,yf,element,i,erreur,x1,y1,c1,c2,c3,c4 : integer;
begin
  x0:=0;       // x origine
  y0:=0;       // y origine
  yc:=y0+(iconeY div 2);  // y centre
  xc:=x0+(iconeX div 2);  // x centre
  xf:=x0+iconeX;          // x fin
  yf:=y0+iconeY;          // y fin

  //Affiche(IntToSTR(x)+' '+IntToSTR(y),clyellow);
  val(editTypeImage.text,element,erreur);
  
  if erreur<>0 then exit;

  extrait_connect(element,c1,c2,c3,c4);

  // scanner les 4 ports de connexion c1 c2 c3 c4
  for i:=1 to 4 do
  begin
    case i of
    1 : c:=c1;
    2 : c:=c2;
    3 : c:=c3;
    4 : c:=c4;
    end;
    if c<>-1 then
    begin
      case c of
      0 : begin x1:=x0;y1:=y0;end;
      1 : begin x1:=xc;y1:=y0;end;
      2 : begin x1:=xf;y1:=y0;end;
      3 : begin x1:=xf;y1:=yc;end;
      4 : begin x1:=xf;y1:=yf;end;
      5 : begin x1:=xc;y1:=yf;end;
      6 : begin x1:=x0;y1:=yf;end;
      7 : begin x1:=x0;y1:=yc;end;
      end;
      // x1,y1 désigne le permier point du segment
      if point_Sur_Segment(x,y,x1,y1,xc,yc) then
      begin
        if not(testbit(tco[xClicCell,yClicCell].epaisseurs,c)) then
        with ImagePaletteCC.Picture.Bitmap.Canvas  do
        begin
          efface_entoure;
          tco[xClicCell,yClicCell].epaisseurs:=setbit(tco[xClicCell,yClicCell].epaisseurs,c);
          efface_cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
          dessine_icone(PCanvasTCO,element,xClicCell,yClicCell,0);
          copie_cellule;
        end
        else
        with ImagePaletteCC.Picture.Bitmap.Canvas  do
        begin
          efface_entoure;
          tco[xClicCell,yClicCell].epaisseurs:=Razbit(tco[xClicCell,yClicCell].epaisseurs,c);
          efface_cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
          dessine_icone(PCanvasTCO,element,xClicCell,yClicCell,0);
          copie_cellule;
        end                                                
      end;

    end;
  end;

end;





begin
end.

