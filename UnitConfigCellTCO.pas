unit UnitConfigCellTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UnitTCO, ExtCtrls;

type
  TFormConfCellTCO = class(TForm)
    ButtonOk: TButton;
    GroupBox1: TGroupBox;
    ComboRepr: TComboBox;
    Label1: TLabel;
    ButtonFonte: TButton;
    EditTexte: TEdit;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    EditTypeImage: TEdit;
    ImagePalette: TImage;
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
    procedure ButtonOkClick(Sender: TObject);
    procedure EditTypeImageKeyPress(Sender: TObject; var Key: Char);
    procedure EditAdrElementChange(Sender: TObject);
    procedure EditTexteChange(Sender: TObject);
    procedure ButtonFonteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboReprChange(Sender: TObject);
    procedure CheckPinvClick(Sender: TObject);
    procedure RadioButtonVClick(Sender: TObject);
    procedure RadioButtonHGClick(Sender: TObject);
    procedure RadioButtonHDClick(Sender: TObject);
    procedure RadioButtonGClick(Sender: TObject);
    procedure RadioButtonDClick(Sender: TObject);
    procedure EditAdrElementKeyPress(Sender: TObject; var Key: Char);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormConfCellTCO: TFormConfCellTCO;
  actualize : boolean;

procedure actualise;

implementation


uses UnitPrinc;

{$R *.dfm}

procedure actualise;
var Bimage : integer;
    oriente,piedFeu : integer;
begin
  actualize:=true;  // �vite les �v�nemebts parasites
  FormConfCellTCO.caption:='Propri�t�s de la cellule '+IntToSTR(XClicCell)+','+intToSTR(YClicCell);
  Bimage:=TCO[XClicCell,YClicCell].Bimage;
  formConfCellTCO.EditTypeImage.Text:=intToSTR(Bimage);

  if Bimage<30 then
  With formConfCellTCO.ImagePalette do
  begin
    Height:=FormTCO.ImagePalette1.Picture.Height;
    Width:=FormTCO.ImagePalette1.Picture.Width;
    Transparent:=false;
  end;

  if Bimage<>30 then
  with formConfCellTCO do
  begin
    RadioButtonV.Enabled:=false;
    RadioButtonHG.Enabled:=false;
    RadioButtonHD.Enabled:=false;
    RadioButtonG.Enabled:=false;
    RadioButtonD.Enabled:=false;
  end;

  with formConfCellTCO.ImagePalette.Picture do
  case Bimage of
  1: Assign(FormTCO.ImagePalette1.Picture);
  2: Assign(FormTCO.ImagePalette2.Picture);
  3: Assign(FormTCO.ImagePalette3.Picture);
  4: Assign(FormTCO.ImagePalette4.Picture);
  5: Assign(FormTCO.ImagePalette5.Picture);
  6: Assign(FormTCO.ImagePalette6.Picture);
  7: Assign(FormTCO.ImagePalette7.Picture);
  8: Assign(FormTCO.ImagePalette8.Picture);
  9: Assign(FormTCO.ImagePalette9.Picture);
 10: Assign(FormTCO.ImagePalette10.Picture);
 11: Assign(FormTCO.ImagePalette11.Picture);
 12: Assign(FormTCO.ImagePalette12.Picture);
 13: Assign(FormTCO.ImagePalette13.Picture);
 14: Assign(FormTCO.ImagePalette14.Picture);
 15: Assign(FormTCO.ImagePalette15.Picture);
 16: Assign(FormTCO.ImagePalette16.Picture);
 17: Assign(FormTCO.ImagePalette17.Picture);
 18: Assign(FormTCO.ImagePalette18.Picture);
 19: Assign(FormTCO.ImagePalette19.Picture);
 20: Assign(FormTCO.ImagePalette20.Picture);
 21: Assign(FormTCO.ImagePalette21.Picture);
 22: Assign(FormTCO.ImagePalette22.Picture);
 23: Assign(FormTCO.ImagePalette23.Picture);
 30: begin
       With formConfCellTCO.ImagePalette do
       begin
         Height:=FormTCO.ImagePalette30.Height;
         Width:=FormTCO.ImagePalette30.Width;

         Picture.Assign(FormTCO.ImagePalette30.Picture);
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
     end
   else
   begin
     with formConfCellTCO do
     begin
       ImagePalette.Picture:=nil;
       RadioButtonV.Enabled:=false;
       RadioButtonHG.Enabled:=false;
       RadioButtonHD.Enabled:=false;
       RadioButtonG.Enabled:=false;
       RadioButtonD.Enabled:=false;
     end;
   end;

  end;

  with formConfCellTCO do
  begin
    EditTexte.Text:=Tco[XClicCell,YClicCell].Texte;
    EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
    ComboRepr.ItemIndex:=tco[XClicCell,yClicCell].repr;
  end;
  actualize:=false;
end;

procedure TFormConfCellTCO.ButtonOkClick(Sender: TObject);
begin
  close;
end;

procedure TFormConfCellTCO.EditTypeImageKeyPress(Sender: TObject; var Key: Char);
var Bimage,erreur : integer;
begin
  if ord(Key)=VK_RETURN then
  begin
    Key:=#0; // �vite beeping
    Val(EditTypeImage.Text,Bimage,erreur);
    //Affiche('Keypressed / Bimage='+IntToSTR(bimage),clyellow);
    if (erreur<>0) or not(Bimage in[0..23,30]) then
    begin
      EditTypeImage.text:=intToSTR(tco[XClicCell,YClicCell].BImage);
      exit;
    end;
    TCO_modifie:=true;
    tco[XClicCell,YClicCell].Bimage:=Bimage;
    
    if not(selectionaffichee) then efface_entoure;
    affiche_cellule(XClicCell,YClicCell);
    formTCO.editTypeImage.Text:=editTypeImage.Text;
    actualise;
    if not(selectionaffichee) then _entoure_cell_clic;
  end;
end;

procedure TFormConfCellTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index : integer;
begin
 //Affiche('Chgt adresse',clyellow);

  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;

  if Adr=0 then tco[XClicCell,YClicCell].repr:=2;

  tco[XClicCell,YClicCell].Adresse:=Adr;

  if tco[XClicCell,YClicCell].BImage=30 then
  begin
    index:=Index_feu(adr);
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

procedure TFormConfCellTCO.EditTexteChange(Sender: TObject);
begin
  PCanvasTCO.Brush.Color:=fond;

  if Tco[XClicCell,YClicCell].texte='' then
  begin
    Tco[XClicCell,YClicCell].CoulFonte:=clTexte;
    Tco[XClicCell,YClicCell].TailleFonte:=8;
  end;
  Tco[XClicCell,YClicCell].Texte:=EditTexte.Text;
  TCO_modifie:=true;
  if not(selectionaffichee) then efface_entoure;
  affiche_texte(XClicCell,YClicCell);
  formTCO.EditTexte.Text:=EditTexte.text;
  if not(selectionaffichee) then _entoure_cell_clic;
end;

procedure TFormConfCellTCO.ButtonFonteClick(Sender: TObject);
begin
  change_fonte;
end;

procedure TFormConfCellTCO.FormCreate(Sender: TObject);
var i,x,y : integer;
    image,imagesrc : Timage;
begin
  // fenetre toujours dessus
  actualize:=false;
  SetWindowPos(Handle, HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
  exit;

  // dessine les composants - non utilis�
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
          Name:='i'+IntToSTR(i);   // nom de l'image - sert � identifier le composant si on fait clic droit.
          case i of
          1 : ImageSRC:=FormTCO.ImagePalette1;
          2 : ImageSRC:=FormTCO.ImagePalette2;
          3 : ImageSRC:=FormTCO.ImagePalette3;
          4 : ImageSRC:=FormTCO.ImagePalette4;
          5 : ImageSRC:=FormTCO.ImagePalette5;
          6 : ImageSRC:=FormTCO.ImagePalette6;
          7 : ImageSRC:=FormTCO.ImagePalette7;
          8 : ImageSRC:=FormTCO.ImagePalette8;
          9 : ImageSRC:=FormTCO.ImagePalette9;
          10 : ImageSRC:=FormTCO.ImagePalette10;
          11 : ImageSRC:=FormTCO.ImagePalette11;
          12 : ImageSRC:=FormTCO.ImagePalette12;
          13 : ImageSRC:=FormTCO.ImagePalette13;
          14 : ImageSRC:=FormTCO.ImagePalette14;
          15 : ImageSRC:=FormTCO.ImagePalette15;
          16 : ImageSRC:=FormTCO.ImagePalette16;
          17 : ImageSRC:=FormTCO.ImagePalette17;
          18 : ImageSRC:=FormTCO.ImagePalette18;
          19 : ImageSRC:=FormTCO.ImagePalette19;
          20 : ImageSRC:=FormTCO.ImagePalette20;
          21 : ImageSRC:=FormTCO.ImagePalette21;
          22 : ImageSRC:=FormTCO.ImagePalette22;
          23 : ImageSRC:=FormTCO.ImagePalette23;
          24 : ImageSRC:=FormTCO.ImagePalette30;
          end;
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
  end;
end;



procedure TFormConfCellTCO.ComboReprChange(Sender: TObject);
begin
  tco[XClicCell,YClicCell].Repr:=comborepr.ItemIndex;
  efface_entoure;SelectionAffichee:=false;
  sourisclic:=false;
  FormTCO.ComboRepr.ItemIndex:=ComboRepr.ItemIndex;
  //affiche_cellule(XClicCell,yClicCell);
  affiche_tco;
end;

procedure TFormConfCellTCO.CheckPinvClick(Sender: TObject);
var Bimage : integer;
begin
  if (xClicCell=0) or (xClicCell>NbreCellX) or (yClicCell=0) or (yClicCell>NbreCelly) then exit;
  Bimage:=Tco[xClicCell,yClicCell].Bimage;
  if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13) 
     or (bimage=14) or (bimage=15) then
     begin
       TCO[xClicCell,yClicCell].inverse:=CheckPinv.checked;
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


procedure TFormConfCellTCO.EditAdrElementKeyPress(Sender: TObject; var Key: Char);
var Adr,erreur :  integer;
begin
  if ord(Key)=VK_RETURN then
  begin
    Key:=#0; // �vite beeping
    Val(EditAdrElement.Text,Adr,erreur);
    //Affiche('Keypressed / Bimage='+IntToSTR(bimage),clyellow);
    if (erreur<>0) then
    begin
      EditAdrElement.text:=intToSTR(tco[XClicCell,YClicCell].Adresse);
      exit;
    end;
    TCO_modifie:=true;
    tco[XClicCell,YClicCell].Adresse:=Adr;
    
    if not(selectionaffichee) then efface_entoure;
    affiche_cellule(XClicCell,YClicCell);
    formTCO.EditAdrElement.Text:=EditAdrElement.Text;
    actualise;
    if not(selectionaffichee) then _entoure_cell_clic;
  end;
end;

end.