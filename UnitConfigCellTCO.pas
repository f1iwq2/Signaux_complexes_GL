unit UnitConfigCellTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  Buttons,
  ImgList, Grids;

type
  TFormConfCellTCO = class(TForm)
    GroupBox1: TGroupBox;
    ComboRepr: TComboBox;
    Label1: TLabel;
    ButtonFonte: TButton;
    EditTexteCCTCO: TEdit;
    GroupBoxEl: TGroupBox;
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
    LabelAction: TLabel;
    ImageListIcones: TImageList;
    BitBtnOk: TBitBtn;
    BitBtnAnnule: TBitBtn;
    GroupBoxCanton: TGroupBox;
    LabelNumC: TLabel;
    EditCanton: TEdit;
    LabelInfo: TLabel;
    CheckBoxEncadre: TCheckBox;
    RadioButtonGH: TRadioButton;
    RadioButtonDB: TRadioButton;
    RadioButtonDS: TRadioButton;
    ImageSens: TImage;
    ImageGD: TImage;
    ImageHB: TImage;
    Label4: TLabel;
    GroupBoxDet: TGroupBox;
    StringGridDet: TStringGrid;
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
    procedure EditCantonExit(Sender: TObject);
    procedure EditCantonChange(Sender: TObject);
    procedure CheckBoxEncadreClick(Sender: TObject);
    procedure RadioButtonGHClick(Sender: TObject);
    procedure RadioButtonDBClick(Sender: TObject);
    procedure RadioButtonDSClick(Sender: TObject);
  private
    { Déclarations privées }
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
  AcBouton_bistable=10;

var
  FormConfCellTCO: TFormConfCellTCO;
  actualize,ConfCellTCO : boolean;
  IconeX,IconeY,ligneclicAction,XclicC,yClicC : integer;

procedure actualise(indexTCO : integer);

implementation

uses UnitPrinc,UnitAnalyseSegCDM,UnitConfigTCO,UnitTCO,selection_train;

{$R *.dfm}

// procédure qui met la bd à jour, et réactualise la cellule, ce qui appelle "select elements"
procedure stocke_bd;
var Bim,x,y,act : integer;
begin
  x:=XClicCell[IndexTCOCourant];
  y:=yClicCell[IndexTCOCourant];
  Bim:=tco[IndexTCOCourant,x,y].BImage;
  if bim=Id_action then
  begin
    act:=ligneclicAction+1;
    tco[IndexTCOCourant,X,Y].PiedSignal:=act;
    efface_cellule(indexTCOCourant,PCanvasTCO[indexTCOcourant],x,y,pmcopy);
    affiche_cellule(IndexTCOCourant,x,Y);
    actualise(indexTCOCourant);
  end;
end;

// affiche les élements de l'index dans la fenetre
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
      EditParam1.Hint:='Numéro du TCO à afficher';
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
      EditParam2.Hint:='Valeur de la sortie'+#13+'0= nulle'+#13+intToSTR(const_devie)+'= dévié'+#13+intToSTR(const_droit)+'= droit';
      EditParam2.ShowHint:=true;
    end;
    // arret des trains
    AcStopTrains :
    begin
      EditParam1.Visible:=false; EditParam2.Visible:=false;
    end;
    // démarrer horloge
    AcMarche_horloge :
    begin
      EditParam1.Visible:=false; EditParam2.Visible:=false;
    end;
    // arreter horloge
    AcArret_horloge :
    begin
      EditParam1.Visible:=false;
      EditParam2.Visible:=false;
    end;
    // initialiser horloge
    AcInit_horloge :
    begin
      EditParam1.Visible:=false;
      EditParam2.Visible:=false;
    end;
    AcBouton_bistable :
    begin
      EditParam1.Visible:=true;
      EditParam1.Hint:='Numéro de bouton';
      EditParam1.Text:=intToSTR(tco[indexTCO,XclicC,YclicC].Adresse);
      EditParam2.Visible:=false;
    end;
  end;
end;

// actualise le contenu de la fenetre et de la zone tco par rapport à la cellule cliquée
procedure actualise(indexTCO : integer);
var i,j,ligne,Adr,Bimage,oriente,piedFeu,act,sens,IdCanton,x,y,xc,yc : integer;
    s : string;
    ip : Timage;
    r : trect;
    sauvConfcellTCO,H : boolean;
begin
  if (indexTCO=0) or (formConfCellTCO=nil) then exit;
  if affevt then affiche('FormConfigCellTCO actualise',clyellow);
  xclicC:=XclicCell[indexTCO];
  yclicC:=YclicCell[indexTCO];
   actualize:=true;        // évite les évènements parasites  
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
      Pen.color:=tco[indexTCO,XclicC,YclicC].CouleurFond;
      Brush.Color:=tco[indexTCO,XclicC,YclicC].couleurFond;
      Brush.style:=bsSolid;
      fillRect(r);
    end;
  end;
  FormConfCellTCO.ImagePaletteCC.Repaint;
  Bimage:=tco[indexTCO,XClicC,YClicC].Bimage;

  FormConfCellTCO.CheckBoxEncadre.visible:=Bimage=0;

  formConfCellTCO.GroupBox1.caption:='Texte';
  // -------------canton
  if isCanton(Bimage) then
  begin
    with formConfCellTCO do
    begin
      // ramener la coordonnée cliquée à l'origine du canton

      if isCantonH(Bimage) then
      //if (Bimage>=Id_cantonH) and (Bimage<=Id_cantonH+9) then
      begin
        H:=true;
        //xClicC:=xClicC-(Bimage-Id_cantonH);
      end;
      if isCantonV(Bimage) then
      //if (Bimage>=Id_cantonV) and (Bimage<=Id_cantonV+9) then
      begin
        H:=false;
        //yClicC:=yClicC-(Bimage-Id_cantonV);
      end;
      //XclicCell[indexTCO]:=XclicC;
      //YclicCell[indexTCO]:=YclicC;

      xc:=xClicC;yc:=yClicC;
      origine_canton(xc,yc);

      idCanton:=index_canton(indexTCO,xC,yC);

      GroupBoxOrientation.visible:=false;
      GroupBoxImplantation.visible:=false;
      GroupBoxAction.Visible:=false;
      GroupBoxDet.visible:=false;
      GroupBoxCanton.visible:=true;

      sens:=tco[indexTCO,xC,yC].SensCirc;
      with GroupBoxCanton do
      begin
        EditTypeImage.Enabled:=false;
        GroupBox1.caption:='Nom du canton';
      end;

      with RadioButtonGH do   // gauche ou haut
      begin
        if H then
        begin
          Caption:='Sens gauche';
          if sens=SensGauche then
          begin
            ImageSens.Picture:=FormSelTrain.ImageGauche.Picture;
            checked:=true;
          end
          else
          begin
            checked:=false;
          end;
        end
        else
        // vertical
        begin
          Caption:='Sens haut';
          if sens=SensHaut then
          begin
            ImageSens.Picture:=FormSelTrain.ImageHaut.Picture;
            checked:=true;
          end
          else
          begin
            checked:=false;
          end;
        end
      end;

      with RadioButtonDB do     // droit ou bas
      begin
        if H then
        begin
          Caption:='Sens droit';
          if sens=SensDroit then
          begin
            ImageSens.Picture:=FormSelTrain.ImageDroite.Picture;
            checked:=true;
          end
          else checked:=false;
        end
        else
        begin
          Caption:='Sens bas';
          if sens=SensBas then
          begin
            ImageSens.Picture:=FormSelTrain.ImageBas.Picture;
            checked:=true;
          end
          else checked:=false;
        end
      end;
      with RadioButtonDS do
      begin
        if Sens=0 then
        begin
          checked:=true;
          if H then
            ImageSens.Picture:=FormConfCellTCO.ImageGD.Picture
          else
            ImageSens.Picture:=FormConfCellTCO.ImageHB.Picture;
        end
        else checked:=false;
      end;
    end;
  end

  else

  // action ---------------------------
  if Bimage=Id_Action then
  begin
    with formConfCellTCO do
    begin
      EditTypeImage.Enabled:=true;
      GroupBoxOrientation.visible:=false;
      GroupBoxImplantation.visible:=false;
      GroupBoxCanton.Visible:=false;
      GroupBoxDet.visible:=false;
      GroupBoxAction.visible:=true;
      EditTypeImage.Enabled:=true;
      with GroupBoxAction do
      begin
        act:=tco[indexTCO,XclicC,YclicC].PiedSignal;
        if (act<0) or (act-1>ListBoxAction.Count) then
        begin
          Affiche('Erreur 29 ',clred);
          actualize:=false;
          exit;
        end;
        ListBoxAction.ItemIndex:=act-1;
        ligneclicAction:=act-1;
        select_elements(indexTCO);
      end;
    end;
  end

  else
  // si élément porteur d'un détecteur---------------------
  if (Bimage=1) or (Bimage=10) or (Bimage=11) or (Bimage=20) then
  begin
    // si buttoir
    if tco[indexTCO,XclicC,YclicC].buttoir<>0 then
    begin
      formConfCellTCO.EditAdrElement.enabled:=false;
      formTCO[indexTCO].EditAdrElement.enabled:=false;
      tco[indexTCO,XclicC,YclicC].Adresse:=0;
    end
    else
    // pas buttoir
    begin
      formConfCellTCO.EditAdrElement.enabled:=true;
      formTCO[indexTCO].EditAdrElement.enabled:=true;
    end;

    Adr:=tco[indexTCO,XClicC,YClicC].Adresse;

    With formConfCellTCO do
    begin
      GroupBoxOrientation.Visible:=false;
      GroupBoxImplantation.Visible:=false;
      GroupBoxCanton.Visible:=false;
      if Adr<>0 then GroupBoxDet.visible:=true else GroupBoxDet.visible:=false;
      GroupBoxAction.visible:=false;
    end;

    with formConfCellTCO.StringGridDet do
    begin
      for i:=0 to ColCount-1 do
        for j:=1 to RowCount-1 do
          Cells[i,j]:='';
      ligne:=1;
      for i:=1 to Ntrains do
      begin
        for j:=1 to NbDetArret do
        if (trains[i].DetecteurArret[j].detecteur=adr) and (adr<>0) then
        begin
          s:='';
          if trains[i].DetecteurArret[j].TPrec<>det then s:='A';
          s:=s+intToSTR(trains[i].DetecteurArret[j].Prec);
          cells[1,ligne]:=s;
          cells[2,ligne]:=intToSTR(trains[i].DetecteurArret[j].temps)+'s';
          cells[3,ligne]:=trains[i].nom_train;

          inc(ligne);
        end;
      end;
    end;
  end
  else

  // si signal
  if Bimage=Id_signal then
  With formConfCellTCO do
  begin
    GroupBoxOrientation.Visible:=true;
    GroupBoxImplantation.Visible:=true;
    GroupBoxCanton.Visible:=false;
    GroupBoxDet.visible:=false;
    GroupBoxAction.visible:=false;
  end

  else
  
  // rien
  begin
    formConfCellTCO.EditAdrElement.enabled:=true;
    formTCO[indexTCO].EditAdrElement.enabled:=true;
    with formConfCellTCO do
    begin
      CheckBoxEncadre.checked:=tco[indexTCO,XclicC,YclicC].Buttoir=1;

      EditTypeImage.Enabled:=true;
      GroupBoxOrientation.Visible:=false;
      GroupBoxImplantation.Visible:=false;
      GroupBoxCanton.Visible:=false;
      GroupBoxDet.visible:=false;
      GroupBoxAction.visible:=false;
    end;
  end;

  if ConfCellTCO then // si la form confcelltco est affichée
  begin
    // si aiguillage, mettre à jour l'option de pilotage inverse
    if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13) or
       (bimage=14) or (bimage=15) or (bimage=24) then
    begin
      // aiguillage inversé
      with FormConfCellTCO.CheckPinv do
      begin
        enabled:=true;
        checked:=TCO[indexTCO,XclicC,YclicC].inverse;
      end;
      FormTCO[indexTCO].CheckPinv.checked:=TCO[indexTCO,XclicC,YclicC].inverse;
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
    s:=Tco[indexTCO,XclicC,YclicC].Texte;
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
  sauvConfcellTCO:=ConfcellTCO;
  ConfCellTCO:=false;
  FormTCO[indexTCO].GroupBox1.Caption:='Configuration cellule '+s;
  XclicCellInserer:=XclicC;
  YclicCellInserer:=YclicC; 
  
  FormTCO[indexTCO].EditAdrElement.Text:=IntToSTR(tco[indexTCO,XclicCellInserer,YclicCellInserer].Adresse);
  FormTCO[indexTCO].EdittypeImage.Text:=IntToSTR(BImage);
  FormTCO[indexTCO].ComboRepr.ItemIndex:=tco[indexTCO,XclicC,YclicC].repr;
  FormTCO[indexTCO].ShapeCoulFond.Brush.Color:=tco[indexTCO,XclicC,YclicC].CouleurFond;
  FormTCO[indexTCO].CheckPinv.Checked:=tco[indextco,XclicC,YclicC].inverse;
  confCellTCO:=sauvConfcellTCO;
  s:='El='+intToSTR(tco[indexTCO,XclicC,YclicC].BImage);
  if tco[indexTCO,Xclic,Yclic].adresse<>0 then s:=s+' Adr='+intToSTR(tco[indexTCO,XclicC,YclicC].adresse);
  //hint:=s;

  if not(ConfCellTCO) then begin actualize:=false;exit;end;
  actualize:=true; 
  FormConfCellTCO.caption:='Propriétés de la cellule '+IntToSTR(XclicC)+','+intToSTR(YclicC)+' TCO '+intToSTR(IndexTCO);
  Bimage:=tco[indexTCO,XclicC,YclicC].Bimage;
  formConfCellTCO.EditTypeImage.Text:=intToSTR(Bimage);

  // mettre l'image de la cellule cliquée dans l'icone de la fenetre de config cellule
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
    if ip<>nil then
    begin
      // affiche l'icone cliquée dans la fenetre -----------------------------------------------
      // pour que le stretchBlt soit visible, il faut mettre à jour la taille du bitmap
      with FormConfCellTCO.ImagePaletteCC.Picture.Bitmap do
      begin
        width:=iconeX;
        Height:=iconeY;
      end;
      StretchBlt(FormConfCellTCO.ImagePaletteCC.canvas.Handle,0,0,iconeX,iconeY,   // destination
               formTCO[indexTCO].ImageTCO.Canvas.Handle,(XclicC-1)*largeurCell[indexTCO] ,(YclicC-1)*Hauteurcell[indexTCO],largeurCell[indexTCO],Hauteurcell[indexTCO],srccopy);                 // source }

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
          oriente:=tco[indexTCO,XclicC,YclicC].Feuoriente;
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

          PiedFeu:=tco[indexTCO,XclicC,YclicC].PiedSignal;
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
  end;

  // aiguillage ou TJD
  if IsAigTJDCroiTCO(Bimage) then
    formConfCellTCO.checkPinv.Enabled:=true
    else formConfCellTCO.checkPinv.Enabled:=false;

  with formConfCellTCO do
  begin
    if isCanton(Bimage) then
    begin
      if idcanton>0 then EditTexteCCTCO.Text:=canton[idcanton].nom;
    end
    else EditTexteCCTCO.Text:=tco[indexTCO,xclicC,yclicC].Texte;
    EditAdrElement.Text:=IntToSTR(tco[indexTCO,XclicCellInserer,YclicCellInserer].Adresse);
    ComboRepr.ItemIndex:=tco[indexTCO,XclicC,YclicC].repr;
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

  if isCanton(Bimage) then
  begin
    FormConfCellTCO.LabelNumC.visible:=true;
    if (Bimage=Id_cantonV) or (Bimage=Id_cantonH) then
    begin
      i:=index_canton(indexTCO,xclicC,yclicC);
      if i>0 then FormConfCellTCO.EditCanton.text:=intToSTR(canton[i].numero);
    end
    else                
    begin
      FormConfCellTCO.LabelNumC.caption:='Elément de canton';
      x:=xClicC;y:=yClicC;
      origine_canton(x,y);
      i:=tco[indexTCO,x,y].NumCanton;
      if i>0 then FormConfCellTCO.EditCanton.text:=intToSTR(i);
    end;
  end;

  actualize:=false;
end;


procedure TFormConfCellTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,Bimage,x,y : integer;
begin
  if clicTCO or not(ConfCellTCO) or actualize then exit;
  if affevt then Affiche('TFormConfCellTCO.EditAdrElementChange',clyellow);
  clicTCO:=true;
  x:=XclicCell[indexTCOcourant];
  y:=YclicCell[indexTCOcourant];

  Bimage:=tco[indexTCOcourant,x,y].BImage;
  if (Bimage=1) or (Bimage=10) or (Bimage=11) or (Bimage=20) then
  begin
    if tco[indexTCOcourant,x,y].buttoir<>0 then
    begin
      EditAdrElement.Text:='';
      clicTCO:=false;
      exit;
    end;
  end;

  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;

  if Adr=0 then tco[indexTCOcourant,x,y].repr:=2;

  tco[indexTCOcourant,x,y].Adresse:=Adr;
  formTCO[indexTCOcourant].EditAdrElement.Text:=intToSTR(adr);

  clicTCO:=false;

  if BImage=Id_signal then
  begin
   { index:=Index_Signal(adr);
    if index=0 then exit
    else }
      begin
       affiche_tco(indexTCOcourant);
     end;
  end;

  if (BImage=Id_action) and (ligneclicAction+1=ActionBoutonTCO) then
  begin
    //if not BoutonTCO[Adr].existe then
    begin
      boutonTCO[adr].idtco:=indexTCOCourant;
      boutonTCO[adr].x:=x;
      boutonTCO[adr].y:=y;
    end;
  end;

  if not(selectionaffichee[indexTCOcourant]) then efface_entoure(indexTCOcourant);
  Affiche_cellule(indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]);
  if not(selectionaffichee[indexTCOcourant]) then _entoure_cell_clic(indexTCOcourant);

end;

procedure TFormConfCellTCO.EditTexteCCTCOChange(Sender: TObject);
var i,El,x,y : integer;
begin
  if clicTCO or not(ConfCellTCO) or actualize then exit;
  if affevt then Affiche('EditTexteCCTCOChange',clyellow);
  PCanvasTCO[indexTCOCourant].Brush.Color:=clfond[indexTCOCourant];
  x:=XclicCell[indexTCOCourant];
  y:=YclicCell[indexTCOCourant];
  if tco[indexTCOCourant,x,y].texte='' then
  begin
    tco[indexTCOCourant,x,y].CoulFonte:=clTexte;
    tco[indexTCOCourant,x,y].TailleFonte:=8;
  end;

  if not(clicTCO) then TCO_modifie:=true;
  if not(selectionaffichee[indexTCOcourant]) then efface_entoure(indexTCOCourant);

  El:=Tco[indexTCOCourant,x,y].BImage;
  if isCanton(El) then
  begin
    i:=Index_canton(indexTCOCourant,x,y);
    if i=0 then exit;
    canton[i].nom:=EditTexteCCTCO.Text;
    Dessin_canton(indexTCOCourant,PcanvasTCO[indexTCOCourant],x,y,0);
  end
  else
  begin
    tco[indexTCOCourant,x,y].Texte:=EditTexteCCTCO.Text;
    affiche_texte(indexTCOCourant,x,y);
  end;

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
  //RadioButtonGH.Visible:=not(diffusion);
  //RadioButtonDB.Visible:=not(diffusion);
  //RadioButtonDS.Visible:=not(diffusion);
  width:=320;Height:=504;
  with GroupBoxDet do
  begin
    left:=16;
    top:=140;
    width:=273;
    height:=145;
  end;
  with GroupBoxOrientation do
  begin
    left:=8;
    top:=152;
  end;
  with GroupBoxAction do
  begin
    left:=16;
    top:=140;
    width:=273;
    height:=ListBoxAction.Height+60;;
  end;
  with GroupBoxCanton do
  begin
    left:=16;
    top:=140;
    width:=273;
    height:=130;
  end;
  LabelAction.top:=ListBoxAction.top+ListBoxAction.Height+10;
  EditParam1.Top:=ListBoxAction.top+ListBoxAction.Height+6;
  EditParam2.Top:=ListBoxAction.top+ListBoxAction.Height+6;

  With StringGridDet do
  begin
    Height:=GroupBoxDet.Height-20;
    Hint:='-';
    ShowHint:=true;
    ColCount:=5;    // nombre de colonnes
    RowCount:=21;
    Options := Options -[goEditing] ;
    ColWidths[0]:=0;      // colonne grise invisible
    ColWidths[1]:=round(40/RedFonte);     // Précédent
    ColWidths[2]:=round(35/RedFonte);     // tempe
    ColWidths[3]:=round(60/RedFonte);     // train
    ColWidths[4]:=round(105/RedFonte);     // icone train

    Cells[1,0]:='Précé.';
    Cells[2,0]:='Temps';
    Cells[3,0]:='Train';
    for i:=0 to RowCount-1 do
      RowHeights[i]:=20;
  end;

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

  if modesombre then
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;

  // une imagelist c'est 16x16 maxi
  with ListBoxAction do
  begin
    Font.Size:=round(8*RedFonte);
    Items.Add(Format('%d%s', [0, 'Afficher TCO'])); // valeur d'index de l'icone dans la ImagelistIcones
    itemHeight:=16;
    Items.Add(Format('%d%s', [1, 'Afficher Signaux Complexes']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [2, 'Afficher CDM Rail']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [3, 'Activer/désactiver sortie']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [4, 'Arrêter les trains']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [5, 'Démarrer l''horloge']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [6, 'Arrêter l''horloge']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [7, 'Initialiser l''horloge']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [8, 'Afficher l''horloge']));
    itemHeight:=16;
    Items.Add(Format('%d%s', [26, 'Bouton bistable']));
    itemHeight:=16;

    //height:=GroupBoxEl.Height-ListBoxAction.top;
  end;

  // calcul des éléments en fonction de la taille de GroupBoxEL à cause du dimensionnement enn % des textes windows
  width:=GroupBoxEL.Left+GroupBoxEL.Width+20;
  height:=BitBtnOk.Top+BitBtnOK.Height+50;
  GroupBoxCanton.top:=ButtonFond.Top+ButtonFond.Height+12;
  GroupBoxCanton.Height:=RadioButtonDS.Height+RadioButtonDS.Top+10;
  GroupBoxCanton.Width:=GroupBoxEL.Width-10;
  GroupBoxDet.top:=RadioGroupSEl.Height+RadioGroupSel.Top+10;
  GroupBoxDet.Width:=GroupBoxEL.Width-10;
  GroupBoxAction.top:=RadioGroupSEl.Height+RadioGroupSel.Top+5;
  GroupBoxAction.Width:=GroupBoxEL.Width-10;

  GroupBoxOrientation.top:=RadioGroupSEl.Height+RadioGroupSel.Top+10;
  GroupBoxOrientation.Width:=GroupBoxEL.Width-20;

  GroupBoxImplantation.top:=GroupBoxOrientation.Height+GroupBoxOrientation.Top+10;
  GroupBoxImplantation.Width:=GroupBoxEL.Width-20;

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
  if affevt then Affiche('CheckPinvClick',clyellow);
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
  if selectionaffichee[indexTCOcourant] then ButtonFond.caption:='Couleur de fond de la sélection'
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
  Affiche_TCO(indexTCOcourant);
  close;
end;

procedure TFormConfCellTCO.BitBtnAnnuleClick(Sender: TObject);
begin
  ConfCellTCO:=false;
  close;
end;

// extraire les 4 points de connexion de l'icone (de 0 à 7)
// il y a au maximum 4 points de connexion de la voie sur une TJD/S ou un croisement.
// Un aiguillage a 3 points de connexion
// un élément de voie a 2 points de connexion.
// Si un élément de connexion n'existe pas, il a la valeur -1.
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
  actualise(IndexTCOCourant); // pour mise à jour de l'image de la fenetre FormConfCellTCO
  efface_entoure(IndexTCOCourant);
  Efface_Cellule(IndexTCOCourant,FormTCO[IndexTCOCourant].ImageTCO.Canvas,XclicCell[IndexTCOCourant],YclicCell[IndexTCOCourant],pmCopy);
  affiche_cellule(IndexTCOCourant,XclicCell[IndexTCOCourant],YclicCell[IndexTCOCourant]);

end;

// copie la cellule cliquée du TCO pour la mettre dans la imagePaletteCC
procedure copie_cellule(index : integer);
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
      // x1,y1 désigne le permier point du segment
      if point_Sur_Segment(x,y,x1,y1,xc,yc) then
      begin
        iconeBut:=(Element=1) or (Element=10) or (Element=11) or (Element=20); // icones pouvant afficher un buttoir
        crois:=(element=21) or (element=22) or (element=23) or (element=25) ;

        // traitement des épaisseurs :  mode épaisseur
        if (not(iconeBut) and not(crois) or (IconeBut and (FormConfCellTCO.RadioGroupSel.Itemindex=0)) ) or
           (crois and (FormConfCellTCO.RadioGroupSel.Itemindex=0))
        then
        begin
          efface_entoure(IndexTCOCourant);
          if not(testbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs,c)) then
            // mise à 1 du bit si pas croisement et sélection sur épaisseurs
            begin
              // si élément à 2 connexions, allumer les deux bits
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
              // si élément à 2 connexions, razer les deux bits
              if (Element=1) or (Element=6) or (Element=7) or (Element=8) or (Element=9) or (Element=10) or
                 (Element=11) or (Element=16) or (Element=17) or (Element=18) or (Element=19) or (Element=20) then
                  tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=0
              else
                tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs:=Razbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].epaisseurs,c);
            end;
        end;

        // traitement des buttoirs :  mode buttoir supporté par les éléments 1 10 11 20
        if ((element=1) or (element=10) or (element=11) or (element=20)) and (FormConfCellTCO.RadioGroupSel.Itemindex=1) then
        begin
          efface_entoure(IndexTCOCourant);
          if not(testbit(tco[IndexTCOCourant,XclicCell[indexTCOCourant],YclicCell[indexTCOCourant]].buttoir,c)) then
          begin
            // mise à 1 du bit si pas buttoir et sélection sur buttoir
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
          // si pas croisement et sélection sur épaisseurs
          if not(testbit(tco[IndexTCOCourant,XclicC,YclicC].pont,c)) then
          begin
            tco[IndexTCOCourant,XclicC,YclicC].pont:=0;  // raz de tous les autres
            tco[IndexTCOCourant,XclicC,YclicC].pont:=setbit(tco[IndexTCOCourant,Xclic,Yclic].pont,c);
          end
          else
            begin
              // la raz du bit c doit mettre à 0 le bit opposé aussi
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

  // bouton
  AcBouton_bistable :
  begin
    if clicTCO then exit;
    val(EditParam1.Text,i,erreur);
    if erreur<>0 then exit;
    if (i>100) or (i<1) then begin i:=1; EditParam1.Text:='1';end;
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


// dessine les icones et le texte dans la listboxAction
procedure TFormConfCellTCO.ListBoxActionDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i,erreur : Integer;
  ItemText: string;
begin
  with ListBoxAction do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    ImageListIcones.Draw(Canvas,Rect.Left,Rect.Top,i);
    Canvas.Textout(Rect.Left+ImageListIcones.Width+2, Rect.Top, ItemText);
  end;
end;

procedure TFormConfCellTCO.EditCantonExit(Sender: TObject);
var NumC,i,erreur :integer;
   trouve : boolean;
begin
  val(editcanton.Text,NumC,erreur);
  if erreur<>0 then exit;
  i:=1;
  repeat
    trouve:=canton[i].numero=NumC;
    inc(i);
  until trouve or (i>nCantons);
  if trouve then
  begin
    LabelInfo.caption:='Le canton '+intToSTR(NumC)+' existe déja';
    exit;
  end;
  LabelInfo.caption:='';

  erreur:=index_canton(indexTCOcourant,xclicC,yclicC);
  canton[erreur].numero:=NumC;
end;

procedure TFormConfCellTCO.EditCantonChange(Sender: TObject);
var x,y,NumC,i,erreur :integer;
   trouve : boolean;
begin
  val(editcanton.Text,NumC,erreur);
  if erreur<>0 then exit;
  i:=1;
  repeat
    trouve:=canton[i].numero=NumC;
    inc(i);
  until trouve or (i>nCantons);
  if trouve then
  begin
    LabelInfo.caption:='Le canton '+intToSTR(NumC)+' existe déja';
    exit;
  end;
  LabelInfo.caption:='';

  erreur:=index_canton(indexTCOcourant,xclicC,yclicC);
  canton[erreur].numero:=NumC;
  x:=canton[erreur].x;
  y:=canton[erreur].y;
  TCO[indexTCOCourant,x,y].NumCanton:=NumC;   // mettre à jour le numéro de canton
end;

procedure TFormConfCellTCO.RadioButtonGHClick(Sender: TObject);
var idc,x,y,sens : integer;
    H : boolean;
begin
  Idc:=index_canton(indexTCOcourant,xclicC,yclicC);
  //Affiche('IDC='+intToSTR(idc),clYellow);
  x:=canton[Idc].x;
  y:=canton[Idc].y;
  H:=IsCantonH(IndexTCOCourant,x,y);
  if H then
  begin
    ImageSens.Picture:=FormSelTrain.ImageGauche.Picture;
    sens:=SensGauche;
  end
  else
  begin
    ImageSens.Picture:=FormSelTrain.ImageHaut.Picture;
    sens:=SensHaut;
  end;
  TCO[indexTCOCourant,x,y].SensCirc:=Sens;
  canton[Idc].SensCirc:=sens;
end;

procedure TFormConfCellTCO.RadioButtonDBClick(Sender: TObject);
var idc,x,y,sens : integer;
    H : boolean;
begin
  Idc:=index_canton(indexTCOcourant,xclicC,yclicC);
  x:=canton[Idc].x;
  y:=canton[Idc].y;
  H:=IsCantonH(IndexTCOCourant,x,y);
  if H then
  begin
    ImageSens.Picture:=FormSelTrain.ImageDroite.Picture;
    sens:=SensDroit
  end
  else
  begin
    ImageSens.Picture:=FormSelTrain.ImageBas.Picture;
    sens:=SensBas;
  end;
  TCO[indexTCOCourant,x,y].SensCirc:=Sens;
  canton[Idc].SensCirc:=sens;
end;

procedure TFormConfCellTCO.RadioButtonDSClick(Sender: TObject);
var idc,x,y: integer;
    h : boolean;
begin
  Idc:=index_canton(indexTCOcourant,xclicC,yclicC);
  if Idc<1 then exit;
  x:=canton[Idc].x;
  y:=canton[Idc].y;
  H:=IsCantonH(IndexTCOCourant,x,y);
  if H then
    ImageSens.Picture:=ImageGD.Picture
  else
    ImageSens.Picture:=ImageHB.Picture;
  TCO[indexTCOCourant,x,y].SensCirc:=0;
  canton[Idc].SensCirc:=0;
end;

procedure TFormConfCellTCO.CheckBoxEncadreClick(Sender: TObject);
var i : integer;
begin
  if clicTCO or not(ConfCellTCO) or actualize then exit;
  if checkBoxEncadre.Checked then i:=1 else i:=0;
  tco[indexTCOcourant,XclicCell[indexTCOcourant],YclicCell[indexTCOcourant]].Buttoir:=i;
  efface_entoure(indexTCOcourant);
  SelectionAffichee[indexTCOcourant]:=false;
  //affiche_cellule(XclicCell[indexTCO],YclicCell[indexTCO]);
  affiche_tco(indexTCOcourant);
end;



end.


