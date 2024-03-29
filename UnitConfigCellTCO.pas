unit UnitConfigCellTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  Buttons,
  ImgList;

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
    GroupBoxOrientation: TGroupBox;
    RadioButtonHG: TRadioButton;
    RadioButtonV: TRadioButton;
    RadioButtonHD: TRadioButton;
    GroupBoxImplantation: TGroupBox;
    RadioButtonG: TRadioButton;
    RadioButtonD: TRadioButton;
    EditAdrElement: TEdit;
    ButtonFond: TButton;
    ImagePaletteCC: TImage;
    RadioGroupSel: TRadioGroup;
    RadioButtonV180: TRadioButton;
    GroupBoxAction: TGroupBox;
    ListBoxAction: TListBox;
    EditParam1: TEdit;
    EditParam2: TEdit;
    Label3: TLabel;
    ImageListIcones: TImageList;
    BitBtnOk: TBitBtn;
    BitBtnAnnule: TBitBtn;
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
    procedure FormHide(Sender: TObject);
    procedure RadioButtonV180Click(Sender: TObject);
    procedure ListBoxActionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditParam1Change(Sender: TObject);
    procedure EditParam2Change(Sender: TObject);
    procedure ListBoxActionDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BitBtnAnnuleClick(Sender: TObject);
    procedure ListBoxActionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { D�clarations priv�es }
  public
  end;

const
  // liste des actions
  AcChangeTCO=1;
  AcAffSC=2;
  AcAffCDM=3;
  AcActSortie=4;
  AcStopTrains=5;
  AcMarche_Horloge=6;
  AcArret_horloge=7;
  AcInit_horloge=8;
  AcAff_horloge=9;


var
  FormConfCellTCO: TFormConfCellTCO;
  actualize,ConfCellTCO : boolean;
  IconeX,IconeY,ligneclicAction,XclicC,yClicC : integer;

procedure actualise(indexTCO : integer);

implementation

uses UnitPrinc,UnitAnalyseSegCDM,UnitConfigTCO,UnitTCO;

{$R *.dfm}

//https://codes-sources.commentcamarche.net/forum/affich-1015879-ajouter-un-icon-dans-un-listbox



// proc�dure qui met la bd � jour, et r�actualise la cellule, ce qui appelle "select elements"
procedure stocke_bd;
var x,y,act : integer;
begin
  act:=ligneclicAction+1;

  x:=XClicCell[IndexTCOCourant];
  y:=yClicCell[IndexTCOCourant];
  tco[IndexTCOCourant,X,Y].PiedFeu:=act;
  efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
  affiche_cellule(IndexTCOCourant,x,Y);
  actualise(indexTCOCourant);


  {case act of
  // affiche TCO
  ChangeTCO :
  begin
    x:=XClicCell[IndexTCOCourant];
    y:=yClicCell[IndexTCOCourant];
    tco[IndexTCOCourant,X,Y].PiedFeu:=ChangeTCO;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,Y);
    actualise(indexTCOCourant);
  end;
  // affiche SC
  AffSC : begin
        x:=XClicCell[IndexTCOCourant];
    y:=yClicCell[IndexTCOCourant];
    tco[IndexTCOCourant,X,Y].PiedFeu:=AffSC;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,Y);
    actualise(indexTCOCourant);
      end;
  // affiche CDM
  AffCDM : begin
    x:=XClicCell[IndexTCOCourant];
    y:=yClicCell[IndexTCOCourant];
    tco[IndexTCOCourant,X,Y].PiedFeu:=AffCDM;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,Y);
    actualise(indexTCOCourant);
  end;

  // activer sortie
  ActSortie :
  begin
    x:=XClicCell[IndexTCOCourant];
    y:=yClicCell[IndexTCOCourant];
    tco[IndexTCOCourant,x,y].PiedFeu:=ActSortie;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,y);
    actualise(indexTCOCourant);
  end;

  StopTrains : // Arret des trains
  begin
    x:=XClicCell[IndexTCOCourant];
    y:=yClicCell[IndexTCOCourant];
    tco[IndexTCOCourant,x,y].PiedFeu:=StopTrains;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,y);
    actualise(indexTCOCourant);
  end;

  Marche_Horloge : // d�marre horloge
    begin
    x:=XClicCell[IndexTCOCourant];
    y:=yClicCell[IndexTCOCourant];
    tco[IndexTCOCourant,x,y].PiedFeu:=Marche_Horloge;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,y);
    actualise(indexTCOCourant);
  end;

  end;  }

end;

// affiche les �lements de l'index dans la fenetre
procedure select_elements(indexTCO : integer);
var act : integer;
begin
  act:=ligneclicAction+1;

  with formConfCellTCO do
  case act of
    // afficher TCO
    AcChangeTCO :
    begin
      EditParam1.Visible:=true;
      EditParam1.Hint:='Num�ro du TCO � afficher';
      EditParam1.ShowHint:=true;
      EditParam2.Visible:=false;
      EditParam1.Text:=IntToSTR(tco[indexTCO,XclicC,YclicC].FeuOriente);
    end;
    // Afficher SC
    AcAffSC :
    begin
      EditParam1.Visible:=false;
      EditParam2.Visible:=false;
    end;
    // afficher CDM
    AcAffCDM :
    begin
      EditParam1.Visible:=false;
      EditParam2.Visible:=false;
    end;
    // activer sortie
    AcActSortie :
    begin
      EditParam1.Visible:=true; EditParam2.Visible:=true;
      EditParam1.Text:=intToSTR(tco[indexTCO,XclicC,YclicC].Adresse);
      EditParam2.Text:=intToSTR(tco[indexTCO,XclicC,YclicC].sortie);
      EditParam1.Hint:='Adresse de la sortie';
      EditParam1.ShowHint:=true;
      EditParam2.Hint:='Valeur de la sortie (0-1-2)';
      EditParam2.ShowHint:=true;
    end;
    // arret des trains
    AcStopTrains :
    begin
      EditParam1.Visible:=false; EditParam2.Visible:=false;
    end;
    // d�marrer horloge
    AcMarche_horloge :
    begin
      EditParam1.Visible:=false; EditParam2.Visible:=false;
    end;
    // arreter horloge
    AcArret_horloge :
    begin
      EditParam1.Visible:=false; EditParam2.Visible:=false;
    end;
    // initialiser horloge
    AcInit_horloge :
    begin
      EditParam1.Visible:=false;
      EditParam2.Visible:=false;
    end;
  end;
end;

// actualise le contenu de la fenetre et de la zone tco
procedure actualise(indexTCO : integer);
var Bimage,oriente,piedFeu,act : integer;
    s : string;
    ip : Timage;
    r : trect;
begin
  if (indexTCO=0) or (formConfCellTCO=nil) then exit;
  if affevt then affiche('FormConfigCellTCO actualise',clyellow);

  xclicC:=XclicCell[indexTCO];
  yclicC:=YclicCell[indexTCO];

  //with FormConfCellTCO.ImagePaletteCC.Picture.Bitmap do
  with FormConfCellTCO.ImagePaletteCC do
  begin
      // efface l'icone
      Picture.Bitmap.width:=iconeX;
      Picture.bitmap.height:=iconeY;
      // effacer l'icone
      r:=Rect(0,0,iconeX,iconeY);
      //with FormConfCellTCO.ImagePaletteCC.canvas do
      with Picture.Bitmap.Canvas do
      // with Picture.Bitmap.Canvas do
      begin
        Pen.Mode:=pmCopy;
        Pen.Width:=1;
        Pen.color:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].CouleurFond;
        Brush.Color:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].couleurFond;
        Brush.style:=bsSolid;
        fillRect(r);
      end;
  end;
  FormConfCellTCO.ImagePaletteCC.Repaint;
  Bimage:=tco[indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;

  if Bimage=Id_Action then
  begin
    with formConfCellTCO do
    begin
      GroupBoxOrientation.visible:=false;
      GroupBoxImplantation.visible:=false;
      with GroupBoxAction do
      begin
        visible:=true;
        left:=16;
        top:=152;
        width:=273;
        height:=145;
        act:=tco[indexTCO,XclicC,YclicC].PiedFeu;
        if (act<0) or (act-1>ListBoxAction.Count) then
        begin
          Affiche('Erreur 29 ',clred);
          exit;
        end;
        ListBoxAction.ItemIndex:=act-1;
        ligneclicAction:=act-1;
        select_elements(indexTCO);
      end;
    end;
  end
  else
  begin
    with formConfCellTCO do
    begin
      with GroupBoxOrientation do
      begin
        visible:=true;
        left:=8;
        top:=152;
      end;
      GroupBoxImplantation.visible:=true;
      GroupBoxAction.visible:=false;
    end;
  end;


  if (Bimage=1) or (Bimage=10) or (Bimage=11) or (Bimage=20) then
  begin
    if tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].buttoir<>0 then
    begin
      formConfCellTCO.EditAdrElement.enabled:=false;
      formTCO[indexTCO].EditAdrElement.enabled:=false;
      tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].Adresse:=0;
    end
    else
    begin
      formConfCellTCO.EditAdrElement.enabled:=true;
      formTCO[indexTCO].EditAdrElement.enabled:=true;
    end;
  end
  else
  begin
    formConfCellTCO.EditAdrElement.enabled:=true;
    formTCO[indexTCO].EditAdrElement.enabled:=true;
  end;

  if ConfCellTCO then // si la form confcelltco est affich�e
  begin
    // si aiguillage, mettre � jour l'option de pilotage inverse
    if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13) or
       (bimage=14) or (bimage=15) or (bimage=24) then
    begin
      // aiguillage invers�
      with FormConfCellTCO.CheckPinv do
      begin
        enabled:=true;
        checked:=TCO[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].inverse;
      end;
      FormTCO[indexTCO].CheckPinv.checked:=TCO[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].inverse;
      FormTCO[indexTCO].CheckPinv.enabled:=true ;
    end
    else
    begin
      FormTCO[indexTCO].CheckPinv.enabled:=false;
      FormConfCellTCO.checkPinv.enabled:=false;
    end;
  end;

  // si voie ou rien ou signal ou quai
  if (Bimage=1) or (Bimage=0) or (Bimage=Id_signal) or (Bimage=Id_Quai) then
  begin
    s:=Tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].Texte;
    with formTCO[indexTCO] do
    begin
      EditTexte.Text:=s;
      EditTexte.Visible:=true;
      ComboRepr.Enabled:=true;
    end;
  end
  else
  begin
    formTCO[indexTCO].EditTexte.Visible:=false;
    formTCO[indexTCO].comboRepr.Enabled:=false;
  end;

  s:=IntToSTR(XclicC)+','+intToSTR(yClicC);
  FormTCO[indexTCO].GroupBox1.Caption:='Configuration cellule '+s;
  XclicCellInserer:=XclicCell[indexTCO];
  YclicCellInserer:=YclicCell[indexTCO];
  FormTCO[indexTCO].EditAdrElement.Text:=IntToSTR(tco[indexTCO,XclicCellInserer,YclicCellInserer].Adresse);
  FormTCO[indexTCO].EdittypeImage.Text:=IntToSTR(BImage);
  FormTCO[indexTCO].ComboRepr.ItemIndex:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].repr;
  FormTCO[indexTCO].ShapeCoulFond.Brush.Color:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].CouleurFond;
  FormTCO[indexTCO].CheckPinv.Checked:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].inverse;

  s:='El='+intToSTR(tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].BImage);
  if tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].adresse<>0 then s:=s+' Adr='+intToSTR(tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].adresse);
  //hint:=s;


  if not(ConfCellTCO) then exit;
  actualize:=true;  // �vite les �v�nements parasites
  FormConfCellTCO.caption:='Propri�t�s de la cellule '+IntToSTR(XclicCell[indexTCO])+','+intToSTR(YclicCell[indexTCO])+' TCO '+intToSTR(IndexTCO);
  Bimage:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].Bimage;
  formConfCellTCO.EditTypeImage.Text:=intToSTR(Bimage);

  // si signal
  if Bimage=Id_signal then
  With formConfCellTCO.ImagePaletteCC do
  begin
    //Height:=FormTCO.ImagePalette1.Picture.Height;
    //Width:=FormTCO.ImagePalette1.Picture.Width;
    Transparent:=false;
  end;

  // si pas signal
  if Bimage<>Id_signal then
  with formConfCellTCO do
  begin
    RadioButtonV.Enabled:=false;
    RadioButtonV180.Enabled:=false;
    RadioButtonHG.Enabled:=false;
    RadioButtonHD.Enabled:=false;
    RadioButtonG.Enabled:=false;
    RadioButtonD.Enabled:=false;

    ImagePaletteCC.transparent:=false;
  end;

  // mettre l'image de la cellule cliqu�e dans l'icone de la fenetre de config cellule
  if Bimage=0 then
  begin
    with formConfCellTCO do
    begin
      RadioButtonV.Enabled:=false;
      RadioButtonV180.Enabled:=false;
      RadioButtonHG.Enabled:=false;
      RadioButtonHD.Enabled:=false;
      RadioButtonG.Enabled:=false;
      RadioButtonD.Enabled:=false;
    end;
  end

  else

  // Bimage non nulle
  begin
    ip:=formTCO[indexTCO].findComponent('ImagePalette'+intToSTR(Bimage)) as Timage;
    if ip=nil then exit;

    // affiche l'icone cliqu�e dans la fenetre -----------------------------------------------
    // pour que le stretchBlt soit visible, il faut mettre � jour la taille du bitmap
    with FormConfCellTCO.ImagePaletteCC.Picture.Bitmap do
    begin
      width:=iconeX;
      Height:=iconeY;
    end;

    StretchBlt(FormConfCellTCO.ImagePaletteCC.canvas.Handle,0,0,iconeX,iconeY,   // destination
               formTCO[indexTCO].ImageTCO.Canvas.Handle,(XclicCell[indexTCO]-1)*largeurCell[indexTCO] ,(YclicCell[indexTCO]-1)*Hauteurcell[indexTCO],largeurCell[indexTCO],Hauteurcell[indexTCO],srccopy);                 // source }

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
        RadioButtonV180.Enabled:=true;
        RadioButtonHG.Enabled:=true;
        RadioButtonHD.Enabled:=true;
        RadioButtonG.Enabled:=true;
        RadioButtonD.Enabled:=true;
        oriente:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].Feuoriente;
        case oriente of
        1: begin
          RadioButtonV.checked:=true;
          RadioButtonV180.checked:=false;
          RadioButtonHG.checked:=false;
          RadioButtonHD.checked:=false;
        end;
        2: begin
          RadioButtonV.checked:=false;
          RadioButtonV180.checked:=false;
          RadioButtonHG.checked:=true;
          RadioButtonHD.checked:=false;
        end;
        3: begin
          RadioButtonV.checked:=false;
          RadioButtonV180.checked:=false;
          RadioButtonHG.checked:=false;
          RadioButtonHD.checked:=true;
        end;
        4: begin
          RadioButtonV.checked:=false;
          RadioButtonV180.checked:=true;
          RadioButtonHG.checked:=false;
          RadioButtonHD.checked:=false;
        end;
        end;

        PiedFeu:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].PiedFeu;
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

  // aiguillage ou TJD
  if IsAigTCO(Bimage) then
    formConfCellTCO.checkPinv.Enabled:=true
    else formConfCellTCO.checkPinv.Enabled:=false;

  with formConfCellTCO do
  begin
    EditTexteCCTCO.Text:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].Texte;
    EditAdrElement.Text:=IntToSTR(tco[indexTCO,XclicCellInserer,YclicCellInserer].Adresse);
    ComboRepr.ItemIndex:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].repr;
  end;

  // Epaisseur ou pont
  FormConfCellTCO.RadioGroupSel.visible:=false;
  if (Bimage=21) or (Bimage=22) or (Bimage=23) or (Bimage=25) then
  begin
    FormConfCellTCO.RadioGroupSel.visible:=true;
    FormConfCellTCO.RadioGroupSel.Items[1]:='Pont';
  end ;

  // voie pouvant avoir un buttoir
  if (Bimage=1) or (Bimage=10) or (Bimage=11) or (Bimage=20) then
  begin
    FormConfCellTCO.RadioGroupSel.visible:=true;
    FormConfCellTCO.RadioGroupSel.Items[1]:='Buttoir';
  end;

  actualize:=false;
end;


procedure TFormConfCellTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index,Bimage : integer;
begin
  if clicTCO or not(ConfCellTCO) or actualize then exit;
  if affevt then Affiche('TFormConfCellTCO.EditAdrElementChange',clyellow);
  clicTCO:=true;
  Bimage:=tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].BImage;
  if (Bimage=1) or (Bimage=10) or (Bimage=11) or (Bimage=20) then
  begin
    if tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].buttoir<>0 then
    begin
      EditAdrElement.Text:='';
      clicTCO:=false;
      exit;
    end;
  end;

  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;

  if Adr=0 then tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].repr:=2;

  tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].Adresse:=Adr;
  formTCO[indexTCOcourant].EditAdrElement.Text:=intToSTR(adr);

  clicTCO:=false;

  if tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].BImage=Id_signal then
  begin
    index:=Index_Signal(adr);
    if index=0 then exit
    else
      begin
       //Affiche('Feu '+intToSTR(Adr),clyellow);
       affiche_tco(indexTCOcourant);
     end;
  end;
  if not(selectionaffichee[indexTCOcourant]) then efface_entoure(indexTCOcourant);
  Affiche_cellule(indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]);
  if not(selectionaffichee[indexTCOcourant]) then _entoure_cell_clic(indexTCOcourant);

end;

procedure TFormConfCellTCO.EditTexteCCTCOChange(Sender: TObject);
begin
  if clicTCO or not(ConfCellTCO) or actualize then exit;
  PCanvasTCO[indexTCOCourant].Brush.Color:=clfond[indexTCOCourant];

  if tco[indexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].texte='' then
  begin
    tco[indexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].CoulFonte:=clTexte;
    tco[indexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].TailleFonte:=8;
  end;
  tco[indexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].Texte:=EditTexteCCTCO.Text;
  if not(clicTCO) then TCO_modifie:=true;
  if not(selectionaffichee[indexTCOcourant]) then efface_entoure(indexTCOCourant);
  affiche_texte(indexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]);
  formTCO[indexTCOCourant].EditTexte.Text:=EditTexteCCTCO.text;
  if not(selectionaffichee[indexTCOcourant]) then _entoure_cell_clic(indexTCOCourant);
end;

procedure TFormConfCellTCO.ButtonFonteClick(Sender: TObject);
begin
  change_fonte(indexTCOcourant);
end;

procedure TFormConfCellTCO.FormCreate(Sender: TObject);
var i : integer;
    c : tcomponent;
begin
  // fenetre toujours dessus
  position:=poMainFormCenter;
  if affevt then Affiche('FormConfCellTCO create',clLime);
  actualize:=false;
  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
  iconeX:=50;  // taille de l'icone
  iconeY:=50;
  ImagePaletteCC.Width:=iconeX;
  ImagePaletteCC.Height:=iconeY;
  RadioGroupSel.itemIndex:=0;

  if sombre then
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;

  // une imagelist c'est 24x24 maxi
  ListBoxAction.Items.Add(Format('%d%s', [0, 'Afficher TCO'])); // valeur d'index de l'icone dans la ImagelistIcones
  ListBoxAction.Items.Add(Format('%d%s', [1, 'Afficher Signaux Complexes']));
  ListBoxAction.Items.Add(Format('%d%s', [2, 'Afficher CDM Rail']));
  ListBoxAction.Items.Add(Format('%d%s', [3, 'Activer/d�sactiver sortie']));
  ListBoxAction.Items.Add(Format('%d%s', [4, 'Arr�ter les trains']));
  ListBoxAction.Items.Add(Format('%d%s', [5, 'D�marrer l''horloge']));
  ListBoxAction.Items.Add(Format('%d%s', [6, 'Arr�ter l''horloge']));
  ListBoxAction.Items.Add(Format('%d%s', [7, 'Initialiser l''horloge']));
  ListBoxAction.Items.Add(Format('%d%s', [8, 'Afficher l''horloge']));


  // dessine les composants - non utilis�
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
          Name:='i'+IntToSTR(i);   // nom de l'image - sert � identifier le composant si on fait clic droit.

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
  if clicTCO or not(ConfCellTCO) or actualize then exit;
  tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].Repr:=comborepr.ItemIndex;
  efface_entoure(indexTCOcourant);
  SelectionAffichee[indexTCOcourant]:=false;
  FormTCO[indexTCOcourant].ComboRepr.ItemIndex:=ComboRepr.ItemIndex;
  //affiche_cellule(XclicCell[indexTCO],YclicCell[indexTCO]);
  affiche_tco(indexTCOcourant);
end;

procedure TFormConfCellTCO.CheckPinvClick(Sender: TObject);
var Bimage : integer;
begin
  if (XclicCell[indexTCOcourant]=0) or (XclicCell[indexTCOcourant]>NbreCellX[indexTCOcourant]) or (YclicCell[indexTCOcourant]=0) or (YclicCell[indexTCOcourant]>NbreCelly[indexTCOcourant]) then exit;
  Bimage:=tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].Bimage;
  if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13) or
     (bimage=14) or (bimage=15) or (bimage=24)
  then
  begin
    tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].inverse:=CheckPinv.checked;
    formTCO[indexTCOcourant].CheckPinv.checked:=CheckPinv.checked;
    TCO_modifie:=true;
  end;
end;

procedure TFormConfCellTCO.RadioButtonVClick(Sender: TObject);
begin
  Vertical(indexTCOcourant);
end;

procedure TFormConfCellTCO.RadioButtonV180Click(Sender: TObject);
begin
  Vertical180(indexTCOCourant);
end;

procedure TFormConfCellTCO.RadioButtonHGClick(Sender: TObject);
begin
  tourne90G(indexTCOcourant);
end;

procedure TFormConfCellTCO.RadioButtonHDClick(Sender: TObject);
begin
  tourne90D(indexTCOcourant);
end;

procedure TFormConfCellTCO.RadioButtonGClick(Sender: TObject);
begin
  signalG(indexTCOcourant);
end;

procedure TFormConfCellTCO.RadioButtonDClick(Sender: TObject);
begin
  signalD(indexTCOcourant);
end;

procedure TFormConfCellTCO.ButtonFondClick(Sender: TObject);
begin
  change_couleur_fond(indexTCOcourant);
end;

procedure TFormConfCellTCO.FormActivate(Sender: TObject);
begin
  if indexTCOcourant=0 then exit;
  if affevt then Affiche('FormConfCellTCO activate',clLime);
  if selectionaffichee[indexTCOcourant] then ButtonFond.caption:='Couleur de fond de la s�lection'
  else ButtonFond.caption:='Couleur de fond de la cellule';
  ConfCellTCO:=true;
end;

procedure TFormConfCellTCO.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

procedure TFormConfCellTCO.BitBtnOkClick(Sender: TObject);
begin
  if affevt then Affiche('BitBtnOk',clyellow);
  stocke_bd;
  ConfCellTCO:=false;
  close;
end;

procedure TFormConfCellTCO.BitBtnAnnuleClick(Sender: TObject);
begin
  ConfCellTCO:=false;
  close;
end;

// extraire les 4 points de connexion de l'icone (de 0 � 7)
// il y a au maximum 4 points de connexion de la voie sur une TJD/S ou un croisement.
// Un aiguillage a 3 points de connexion
// un �l�ment de voie a 2 points de connexion.
// Si un �l�ment de connexion n'existe pas, il a la valeur -1.
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
  if clicTCO or not(ConfCellTCO) or actualize or (IndexTCOCourant=0) then exit;
  if affevt then Affiche('TCO evt editTypeImageKeyPress',clorange);
  Val(EditTypeImage.Text,Bimage,erreur);
  if (erreur<>0) or not(Bimage in[0..29,32..34,50,51]) then exit;
  TCO_modifie:=true;
  tco[IndexTCOCourant,XclicCell[IndexTCOCourant],YclicCell[IndexTCOCourant]].Bimage:=Bimage;
  FormTCO[IndexTCOCourant].EditTypeImage.text:=intToSTR(BImage);
  actualise(IndexTCOCourant); // pour mise � jour de l'image de la fenetre FormConfCellTCO
  efface_entoure(IndexTCOCourant);
  Efface_Cellule(IndexTCOCourant,FormTCO[IndexTCOCourant].ImageTCO.Canvas,XclicCell[IndexTCOCourant],YclicCell[IndexTCOCourant],pmCopy);
  affiche_cellule(IndexTCOCourant,XclicCell[IndexTCOCourant],YclicCell[IndexTCOCourant]);

end;

// copie la cellule cliqu�e du TCO pour la mettre dans la imagePaletteCC
procedure copie_cellule(index : integer);
begin
  // affiche l'icone cliqu�e dans la fenetre -----------------------------------------------
  // pour que le stretchBlt soit visible, il faut mettre � jour la taille du bitmap
  with FormConfCellTCO.ImagePaletteCC.Picture.Bitmap do
  begin
    width:=iconeX;
    Height:=iconeY;
  end;

  // destination masque avec mise � l'�chelle
  StretchBlt(FormConfCellTCO.ImagePaletteCC.canvas.Handle,0,0,iconeX,iconeY,
             PcanvasTCO[index].Handle,(XclicCell[index]-1)*largeurCell[index],(YclicCell[index]-1)*hauteurCell[index],largeurCell[index],hauteurCell[index],srccopy);
  FormConfCellTCO.ImagePaletteCC.repaint;  // obligatoire sinon il ne s'affiche pas
end;

procedure TFormConfCellTCO.ImagePaletteCCMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var c,x0,y0,xc,yc,xf,yf,element,i,j,erreur,x1,y1,c1,c2,c3,c4 : integer;
    crois,IconeBut : boolean;
begin
  x0:=0;       // x origine
  y0:=0;       // y origine
  yc:=y0+(iconeY div 2);  // y centre
  xc:=x0+(iconeX div 2);  // x centre
  xf:=x0+iconeX;          // x fin
  yf:=y0+iconeY;          // y fin
  XclicC:=XclicCell[indexTCOCourant];
  YclicC:=YclicCell[indexTCOCourant];

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
      // x1,y1 d�signe le permier point du segment
      if point_Sur_Segment(x,y,x1,y1,xc,yc) then
      begin
        iconeBut:=(Element=1) or (Element=10) or (Element=11) or (Element=20); // icones pouvant afficher un buttoir
        crois:=(element=21) or (element=22) or (element=23) or (element=25) ;

        // traitement des �paisseurs :  mode �paisseur
        if (not(iconeBut) and not(crois) or (IconeBut and (FormConfCellTCO.RadioGroupSel.Itemindex=0)) ) or
           (crois and (FormConfCellTCO.RadioGroupSel.Itemindex=0))
        then
        begin
          efface_entoure(IndexTCOCourant);
          if not(testbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs,c)) then
            // mise � 1 du bit si pas croisement et s�lection sur �paisseurs
            begin
              // si �l�ment � 2 connexions, allumer les deux bits
              case Element of
                1 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$88;
                6 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$09;
                7 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$84;
                8 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$90;
                9 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$48;
               10 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$44;
               11 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$11;
               16 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$21;
               17 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$24;
               18 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$42;
               19 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$14;
               20 : tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=$22;
              else
                tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=setbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs,c);
              end;
            end
          else
            begin
              // si �l�ment � 2 connexions, razer les deux bits
              if (Element=1) or (Element=6) or (Element=7) or (Element=8) or (Element=9) or (Element=10) or
                 (Element=11) or (Element=16) or (Element=17) or (Element=18) or (Element=19) or (Element=20) then
                  tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=0
              else
                tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=Razbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs,c);
            end;
        end;

        // traitement des buttoirs :  mode buttoir support� par les �l�ments 1 10 11 20
        if  ((element=1) or (element=10) or (element=11) or (element=20)) and (FormConfCellTCO.RadioGroupSel.Itemindex=1) then
        begin
          efface_entoure(IndexTCOCourant);
          if not(testbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].buttoir,c)) then
          begin
            // mise � 1 du bit si pas buttoir et s�lection sur buttoir
            tco[IndexTCOCourant,XclicC,YclicC].buttoir:=0;
            tco[IndexTCOCourant,XclicC,YclicC].buttoir:=setbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].buttoir,c)
          end
          else
          begin
            tco[IndexTCOCourant,XclicC,YclicC].buttoir:=0;
          end;
        end;

        // traitement des ponts : croisement et mode croisement
        if crois and (FormConfCellTCO.RadioGroupSel.Itemindex=1) then
        begin
          efface_entoure(IndexTCOCourant);
          // si pas croisement et s�lection sur �paisseurs
          if not(testbit(tco[IndexTCOCourant,XclicC,YclicC].pont,c)) then
          begin
            tco[IndexTCOCourant,XclicC,YclicC].pont:=0;  // raz de tous les autres
            tco[IndexTCOCourant,XclicC,YclicC].pont:=setbit(tco[IndexTCOCourant,Xclic,Yclic].pont,c);
          end
          else
            begin
              // la raz du bit c doit mettre � 0 le bit oppos� aussi
              tco[IndexTCOCourant,XclicC,YclicC].pont:=Razbit(tco[IndexTCOCourant,Xclic,Yclic].pont,c);
              case c of
                0 : j:=4;
                1 : j:=5;
                2 : j:=6;
                3 : j:=7;
                4 : j:=0;
                5 : j:=1;
                6 : j:=2;
                7 : j:=3;
              end;
              tco[IndexTCOCourant,XclicC,YclicC].pont:=Razbit(tco[IndexTCOCourant,XclicC,YclicC].pont,j);
            end;
        end;
        efface_cellule(IndexTCOCourant,PCanvasTCO[IndexTCOCourant],XclicC,YclicC,PmCopy);
        dessine_icone(IndexTCOCourant,PCanvasTCO[IndexTCOCourant],element,XclicC,YclicC,0);
        copie_cellule(IndexTCOCourant);
       end;
    end;
  end;
end;



procedure TFormConfCellTCO.FormHide(Sender: TObject);
begin
  if affevt then Affiche('FormFoncCellTCO hide',clyellow);
  ConfCellTCO:=false;
end;



procedure TFormConfCellTCO.ListBoxActionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if affevt then Affiche('TFormConfCellTCO.ListBoxActionMouseDown',clyellow);
  ligneclicAction:=listBoxAction.ItemIndex;
  select_elements(indexTCOCourant);
end;

procedure TFormConfCellTCO.ListBoxActionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if affevt then Affiche('TFormConfCellTCO.ListBoxActionKeyDown',clyellow);
  if (ord(Key)=VK_UP) and (ligneclicAction>0) then
  begin
    dec(ligneclicAction);
    select_elements(indexTCOCourant);
  end;
  if (ord(Key)=VK_DOWN) and (ligneclicAction<7) then
  begin
    inc(ligneclicAction);
    select_elements(indexTCOCourant);
  end;
end;


procedure TFormConfCellTCO.EditParam1Change(Sender: TObject);
var i,erreur,act : integer;
begin
  act:=ligneclicAction+1;
  case act of
  AcChangeTCO : // afficher TCO n
  begin
    if clicTCO then exit;

    val(EditParam1.Text,i,erreur);
    if erreur<>0 then exit;
    if (i>NbreTCO) or (i<1) then
    begin
      EditParam1.Text:=intToSTR(NbreTCO);
      i:=NbreTCO;
    end;
    tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].FeuOriente:=i;
    Affiche_cellule(IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]);
  end;


  //sortie
  AcActSortie :
  begin
    if clicTCO then exit;
    val(EditParam1.Text,i,erreur);
    if erreur<>0 then exit;
    tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].adresse:=i;
    Affiche_cellule(IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]);
  end;

  end;

end;

procedure TFormConfCellTCO.EditParam2Change(Sender: TObject);
var i,erreur,act : integer;
begin
  if clicTCO then exit;

  act:=ligneclicAction+1;

  case act of
  AcActSortie :
  begin
    val(EditParam2.Text,i,erreur);
    if erreur<>0 then exit;
    tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].sortie:=i;
    Affiche_cellule(IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]);
  end;


  end;
end;


// dessine les icones et le texte dans la listbox
procedure TFormConfCellTCO.ListBoxActionDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  IcoIndex: Integer;
  ItemText: string;
begin
  with ListBoxAction do
  begin
    IcoIndex:=StrToIntDef(Items[Index][1], 0);
    ItemText:=Items[Index];
    Delete(ItemText,1,1);
    Canvas.Fillrect(Rect);
    ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, IcoIndex);
    Canvas.Textout(Rect.Left + ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;
end;






end.


