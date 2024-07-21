unit UnitModifAction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Spin , MMSystem;

type
  TFormModifAction = class(TForm)
    ButtonOk: TButton;
    ComboBoxActions: TComboBox;
    PageControlAct: TPageControl;
    TabSheetDecl: TTabSheet;
    TabSheetOp: TTabSheet;
    ListBoxDeclench: TListBox;
    GroupBoxDecl: TGroupBox;
    LabelAdresse: TLabel;
    LabelTrain: TLabel;
    EditAdr: TEdit;
    EditAdr2: TEdit;
    EditTrainDecl: TEdit;
    ComboBoxFamille: TComboBox;
    ListBoxOper: TListBox;
    Shape1: TShape;
    ListBoxOperations: TListBox;
    LabelDecl: TLabel;
    Label3: TLabel;
    GroupBoxParam: TGroupBox;
    ButtonAjouter: TButton;
    ButtonAppAction: TButton;
    Label2: TLabel;
    SpeedButtonSupprime: TSpeedButton;
    LabelEtat: TLabel;
    SpinEditEtat: TSpinEdit;
    SpinButton1: TSpinButton;
    Labelheure: TLabel;
    LabeledEditTrain: TLabeledEdit;
    OpenDialogSon: TOpenDialog;
    SpeedButtonCharger: TSpeedButton;
    SpeedButtonJoue: TSpeedButton;
    LabeledEditAdresse: TLabeledEdit;
    LabeledEditFonctionF: TLabeledEdit;
    CheckBoxRAZ: TCheckBox;
    Label5: TLabel;
    RichEditInf: TRichEdit;
    ButtonApplDecl: TButton;
    LabeledEditNomAct: TLabeledEdit;
    Label1: TLabel;
    ComboBoxAccComUSB: TComboBox;
    LabeledEditTempoF: TLabeledEdit;
    ImageIcone: TImage;
    LabelPeriph: TLabel;
    LabelInfo: TLabel;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    ListBoxCondTot: TListBox;
    Shape2: TShape;
    Label6: TLabel;
    ListBoxConditions: TListBox;
    GroupBox1: TGroupBox;
    ChampTrain: TLabeledEdit;
    Champ1: TLabeledEdit;
    Champ2: TLabeledEdit;
    ButtonAppCond: TButton;
    SpinEditHeure1: TSpinEdit;
    SpinEditMn1: TSpinEdit;
    SpinEditHeure2: TSpinEdit;
    SpinEditMn2: TSpinEdit;
    LabelHeureDebut: TLabel;
    LabelHeureFin: TLabel;
    SpinEditEtat2: TSpinEdit;
    LabelEtat2: TLabel;
    RadioEtatSignal: TRadioGroup;
    SpinEditEtatop: TSpinEdit;
    LabelEtatOp: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxOperDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxDeclenchDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBoxFamilleChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBoxActionsChange(Sender: TObject);
    procedure ListBoxOperationsDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ButtonAppActionClick(Sender: TObject);
    procedure ButtonAjouterClick(Sender: TObject);
    procedure SpeedButtonSupprimeClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure EditAdrChange(Sender: TObject);
    procedure EditAdr2Change(Sender: TObject);
    procedure SpinEditEtatChange(Sender: TObject);
    procedure EditTrainDeclChange(Sender: TObject);
    procedure ListBoxOperationsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LabeledEditAdresseChange(Sender: TObject);
    procedure LabeledEditFonctionFChange(Sender: TObject);
    procedure LabeledEditTrainChange(Sender: TObject);
    procedure SpeedButtonJoueClick(Sender: TObject);
    procedure SpeedButtonChargerClick(Sender: TObject);
    procedure CheckBoxRAZClick(Sender: TObject);
    procedure ButtonApplDeclClick(Sender: TObject);
    procedure LabeledEditNomActChange(Sender: TObject);
    procedure ComboBoxAccComUSBChange(Sender: TObject);
    procedure LabeledEditTempoFChange(Sender: TObject);
    procedure ListBoxOperationsDblClick(Sender: TObject);
    procedure ListBoxCondTotDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxConditionsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxConditionsDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ButtonAppCondClick(Sender: TObject);
    procedure Champ1Change(Sender: TObject);
    procedure Champ2Change(Sender: TObject);
    procedure SpinEditHeure1Change(Sender: TObject);
    procedure SpinEditMn1Change(Sender: TObject);
    procedure SpinEditHeure2Change(Sender: TObject);
    procedure SpinEditMn2Change(Sender: TObject);
    procedure ChampTrainChange(Sender: TObject);
    procedure SpinEditEtat2Change(Sender: TObject);
    procedure RadioEtatSignalClick(Sender: TObject);
    procedure SpinEditEtatopChange(Sender: TObject);
    procedure ListBoxOperationsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormModifAction: TFormModifAction;
  AffParam : boolean;
  ClicDeclenche,ClicAction,ClicCond,DeclencheurAffiche,OperationAffiche : integer;

function Info_action(i : integer) : string;

implementation

uses Unitprinc, UnitConfigCellTCO, UnitConfig;


{$R *.dfm}



procedure efface_tous_parametres;
begin
  with FormModifAction do
  begin
    RadioEtatSignal.Visible:=false;
    LabelAdresse.Visible:=false;
    SpinEditEtat.Visible:=false;
    EditAdr.visible:=false;
    LabelHeure.Visible:=false;
    EditAdr2.Visible:=false;
    LabelTrain.Visible:=false;
    EditTrainDecl.Visible:=false;
    LabelPeriph.Visible:=false;
    LabelEtat.Visible:=false;
    LabeledEditTempoF.Visible:=false;
    LabeledEditTrain.Visible:=false;
    SpeedButtonJoue.visible:=false;
    SpeedButtonCharger.visible:=false;
    LabeledEditFonctionF.Visible:=false;
    LabeledEditAdresse.Visible:=false;
    SpinEditEtatop.Visible:=false;
    checkBoxRaz.Visible:=false;
    GroupBoxParam.Visible:=true;
    labelEtatOp.Visible:=false;
    RichEditInf.clear;
    ComboBoxAccComUSB.visible:=false;
    Champ1.Visible:=false;
    Champ2.Visible:=false;
    LabelHeureDebut.Visible:=false;
    LabelHeureFin.Visible:=false;
    SpinEditHeure1.visible:=false;
    SpinEditMn1.visible:=false;
    SpinEditHeure2.visible:=false;
    SpinEditMn2.visible:=false;
    LabelEtat2.Visible:=false;
    SpinEditEtat2.Visible:=false;
    ChampTrain.Visible:=false;
  end;
end;


procedure TFormModifAction.FormCreate(Sender: TObject);
var i,icone : integer;
begin
  ListBoxOper.Style:=lbOwnerDrawVariable;      // pour afficher des icones
  ListBoxDeclench.Style:=lbOwnerDrawVariable;
  ListBoxOperations.Style:=lbOwnerDrawVariable;
  ListBoxCondTot.Style:=lbOwnerDrawVariable;
  ListBoxConditions.Style:=lbOwnerDrawVariable;

  for i:=1 to NbreOperations do
  begin
    ListBoxOper.Items.Add(Format('%d%s', [i-1, operations[i].nom])); // valeur d'index de l'icone dans la ImagelistIcones
    ListBoxOper.itemHeight:=17; // 16 mini taille des éléments pour l'icone
  end;

  for i:=1 to NbreConditions do
  begin
    icone:=0;
    case i of
      CondVrai : icone:=iconeVrai;
      CondFaux : icone:=iconeFaux;
      CondVitTrain : icone:=IconeVitTrain;
      CondPosAcc : icone:=IconeAccessoire;
      condHorl : icone:=IconeLanceHorl;
      condTrainSig : icone:=IconeDeclSignal;
    end;
    ListBoxCondTot.Items.Add(Format('%d%s', [icone, Conditions[i].nom])); // valeur d'index de l'icone dans la ImagelistIcones
    ListBoxCondTot.itemHeight:=17; // 16 mini taille des éléments pour l'icone
  end;

  for i:=1 to NbreDeclencheurs do
  begin
    icone:=0;
    case i of
      DeclHorloge : icone:=iconeHorloge;
      DeclPeriph : icone:=iconePeriph;
      DeclAccessoire: icone:=IconeAccessoire;
      DeclDetAct: icone:=IconeDet;
      DeclZoneDet: icone:=IconeZoneDet;
      DeclDemarTrain : icone:=IconeDemarTrain;
      DeclArretTrain : icone:=IconeArretTrain;
      DeclSignal : icone:=IconeSignal;
    end;
    ListBoxDeclench.Items.Add(Format('%d%s', [icone, declencheurs[i].nom])); // valeur d'index de l'icone dans la ImagelistIcones
    ListBoxDeclench.itemHeight:=17;
  end;

  with ComboBoxFamille do
  begin
    items.Add('Tous');
    items.Add('Système');
    items.Add('Pilotage');
    items.Add('Trains');
    itemIndex:=0;
  end;

  ListBoxOperations.Hint:='Liste chronologique des opérations à effectuer'+#13+
                          'Double clic pour valider/dévalider une opération';

  Efface_tous_parametres;
  PageControlAct.ActivePage:=TabSheetDecl;
end;

procedure TFormModifAction.ListBoxOperDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i,erreur: Integer;
  ItemText: string;
begin
  with ListBoxOper do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    formConfCellTCO.ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, i);
    Canvas.Textout(Rect.Left + formConfCellTCO.ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;

end;

procedure TFormModifAction.ListBoxDeclenchDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i,erreur: Integer;
  ItemText: string;
begin
  with ListBoxDeclench do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    formConfCellTCO.ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, i);
    Canvas.Textout(Rect.Left + formConfCellTCO.ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;
end;

procedure TFormModifAction.ListBoxOperationsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i,erreur: Integer;
  ItemText: string;
begin
  //Affiche('Evt ListBoxOperationsDrawItem',clyellow);
  with ListBoxOperations do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    formConfCellTCO.ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, i);
    Canvas.Textout(Rect.Left + formConfCellTCO.ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;

end;

procedure TFormModifAction.ComboBoxFamilleChange(Sender: TObject);
var i,n,famille : integer;
    s : string;
begin
  ListBoxOper.Clear;
  famille:=ComboBoxFamille.ItemIndex;  // famille=0=afficher tous

  for i:=1 to NbreOperations do
  begin
    if (operations[i].famille=famille) or (famille=0) then
    begin
      s:=operations[i].nom;
      n:=Index_Operation(s);
      ListBoxOper.Items.Add(Format('%d%s', [n-1, s])); // valeur d'index de l'icone dans la ImagelistIcones
    end;
  end;
end;

function Info_action(i : integer) : string;
var nop,op,top,decl : integer;
    r : double;
    s :string;
begin
  decl:=Tablo_Action[i].declencheur;
  s:='Le déclencheur ';
  case decl of
  DeclHorloge :
      s:=s+'horloge à '+format('%.2d',[Tablo_Action[i].heure])+'h'+format('%.2d',[Tablo_Action[i].minute]);
  DeclPeriph :
      s:=s+'périphérique : '+Tablo_Action[i].ordrePeriph;
  DeclAccessoire :
      s:=s+'accessoire '+intToSTR(Tablo_Action[i].adresse);
  DeclDetAct :
      begin
        s:=s+'détecteur/Actionneur '+intToSTR(Tablo_Action[i].adresse);
        s:=s+' par le train "'+Tablo_Action[i].trainDecl+'"';
      end;
  DeclZoneDet :
     s:=s+'Zone détection '+intToSTR(Tablo_Action[i].adresse)+' '+intToSTR(Tablo_Action[i].adresse2);
  DeclDemarTrain :
     s:=s+'démarrage du train '+Tablo_Action[i].trainDecl+' au seuil de '+intToSTR(Tablo_Action[i].adresse);
  DeclArretTrain :
     s:=s+'arrêt du train '+Tablo_Action[i].trainDecl+' au seuil de '+intToSTR(Tablo_Action[i].adresse);
  DeclSignal :
    begin
     s:=s+'changement du signal '+intToSTR(Tablo_Action[i].adresse);
     case Tablo_Action[i].etat of
       0 : s:=s+' sur ouverture';
       1 : s:=s+' sur voie libre';
       2 : s:=s+' sur ouverture restreinte';
       3 : s:=s+' sur fermeture';
     end;
   end;
  end;

  // conditions
  s:=s+#13;
  nop:=Tablo_Action[i].NbCond;
  for op:=1 to nop do
  begin
    s:=s+'condition ';
    top:=Tablo_Action[i].tabloCond[op].numcondition;
    case top of
    CondVrai : s:=s+'toujours vraie ';
    CondFaux : s:=s+'toujours fausse ';
    CondVitTrain : s:=s+'vitesse train '+Tablo_Action[i].tabloCond[op].train+' '+intToSTR(Tablo_Action[i].tabloCond[op].vitmini)+
                        ' '+intToSTR(Tablo_Action[i].tabloCond[op].vitMaxi);
    CondPosAcc : s:=s+' position d''accessoire '+intToSTR(Tablo_Action[i].tabloCond[op].accessoire)+' état '+intToSTR(Tablo_Action[i].tabloCond[op].etat);
    CondHorl : s:=s+' horloge '+intToSTR(Tablo_Action[i].tabloCond[op].HeureMin)+'h'+intToSTR(Tablo_Action[i].tabloCond[op].MinuteMin)+' à '+
                                 intToSTR(Tablo_Action[i].tabloCond[op].HeureMax)+'h'+intToSTR(Tablo_Action[i].tabloCond[op].MinuteMax)+' ';
    condTrainSig : s:=s+'train '+Tablo_Action[i].tabloCond[op].train+' arrêté au signal '+intToSTR(Tablo_Action[i].tabloCond[op].Adresse);
    end;
    s:=s+#13;
  end;

  nop:=Tablo_Action[i].NbOperations;

  if nop=0 then s:=s+'ne déclenche aucune opération'+#13;
  if nop=1 then s:=s+'déclenche 1 opération :'+#13;
  if nop>1 then s:=s+'déclenche '+intToSTR(nop)+' opérations :'+#13;

  s:=s+'--------------------'+#13;

  for op:=1 to nop do
  begin
    top:=Tablo_Action[i].tabloop[op].numoperation;
    case top of
      ActionAffTCO : s:=s+'Affiche TCO '+intToSTR(Tablo_Action[i].tabloop[op].NumTCO)+#13;
      ActionAffSC : s:=s+'Affiche signaux_complexes'+#13;
      ActionAffCDM : s:=s+'Affiche CDM rail'+#13;
      ActionAccessoire :
      begin
        s:=s+'Pilote l''accessoire '+intToSTR(Tablo_Action[i].tabloop[op].adresse)+
             ' à '+intToSTR(Tablo_Action[i].tabloop[op].etat);
        if Tablo_Action[i].tabloop[op].zero then s:=s+' impulsionnel'+#13 else s:=s+' maintenu'+#13;
      end;
      ActionArretTRains : s:=s+'Arrêt des trains'+#13;
      ActionLanceHorl : s:=s+'Lance l''horloge'+#13;
      ActionArretHorl : s:=s+'Arrête l''horloge'+#13;
      ActionInitHorl : s:=s+'Initialise l''horloge'+#13;
      ActionAffHorl : s:=s+'Affiche l''horloge'+#13;
      ActionVitesse : s:=s+'Modifie la vitesse du train '+Tablo_Action[i].tabloop[op].train+' à '+intToSTR(Tablo_Action[i].tabloop[op].vitesse)+#13;
      ActionCdePeriph : s:=s+'Pilote le périphérique '+intToSTR(Tablo_Action[i].tabloop[op].periph)+' chaîne : '+Tablo_Action[i].tabloop[op].chaine+#13;
      ActionFonctionF : s:=s+'Fonction F'+intToSTR(Tablo_Action[i].tabloop[op].fonctionF)+' train dest='+Tablo_Action[i].tabloop[op].train+#13;
      ActionSon : s:=s+'Son '+Tablo_Action[i].tabloop[op].train+#13;
      ActionTempo :
      begin
        nop:=Tablo_Action[i].tabloop[op].tempoF;
        r:=nop/10;
        s:=s+'Temporisation '+intToSTR(nop)+' ('+Format('%.1f', [r])+'s)'#13;
      end;
    end;
  end;
  result:=s;
end;



// affiche les champs en fonction de l'index du tablo actionneur et de l'index de l'action
procedure Aff_champs(index,IndexCond,IndexAction : integer);
var i,decl,act,cond,Nb,icone : integer;
    s : string;
begin
  if (index<1) then exit;
  if clicListe then exit;
  clicliste:=true;
  // Affiche('Aff_champs('+intToSTR(index)+','+intToSTR(indexAction)+')',clYellow);
  decl:=Tablo_Action[index].declencheur;
  formModifAction.ListBoxDeclench.ItemIndex:=decl-1;

  // comboboxActions
  s:=encode_actions(index);
  with formModifAction.ComboBoxActions do
  begin
    Items[index-1]:=s;
    ItemIndex:=index-1;
  end;

  with formconfig.ListBoxActions do
  begin
    items[index-1]:=s;
  end;

  s:=Info_action(ligneclicAct+1);
  with formConfig.RichEditInfo do
  begin
    clear;
    Lines.Add(s);
  end;

  FormModifAction.LabeledEditNomAct.Text:=Tablo_Action[index].NomAction;

  // ListBox opérations
  with FormModifAction.ListBoxOperations do
  begin
    clear;
    formConfig.ListBoxOperations.Clear;
    for i:=1 to Tablo_Action[index].NbOperations do
    begin
      act:=Tablo_Action[index].tabloOp[i].numoperation;
      if act<=NbreOperations then
      begin
        s:=operations[act].nom;
        if not(Tablo_Action[index].tabloOp[i].valide) then s:=s+' [dévalidé]';
        if act<1 then icone:=0  else icone:=act-1;

        items.Add(Format('%d%s', [icone, s])); // valeur d'index de l'icone dans la ImagelistIcones

        // listboxOperations de la formConfig
        formConfig.ListBoxOperations.Items.add(Format('%d%s', [act-1, s]));
        itemHeight:=17;
      end;
    end;
    if indexaction<>0 then itemIndex:=indexaction-1;
  end;



  // listbox conditions
  with FormModifAction.ListBoxConditions do
  begin
    clear;
    for i:=1 to Tablo_Action[index].NbCond do
    begin
      cond:=Tablo_Action[index].tabloCond[i].numcondition;
      s:=conditions[cond].nom;
      case cond of
        CondVrai : icone:=iconeVrai;
        CondFaux : icone:=iconeFaux;
        CondVitTrain : icone:=IconeVitTrain;
        CondPosAcc : icone:=IconeAccessoire;
        condHorl : icone:=IconeLanceHorl;
        condTrainSig : icone:=IconeDeclSignal;
      end;

      items.Add(Format('%d%s', [icone, s])); // valeur d'index de l'icone dans la ImagelistIcones

      itemHeight:=17;
    end;
    if indexCond<>0 then itemIndex:=indexCond-1;
  end;

  // listBoxActions de la formConfig
  FormConfig.ListBoxActions.Clear;
  for i:=1 to maxTablo_act do
  begin
    s:=encode_actions(i);
    formConfig.ListBoxActions.Items.add(s);
  end;


  efface_tous_parametres;

  // déclencheurs
  with FormModifAction do
  case decl of
  DeclHorloge :
    begin
      EditAdr.text:=intToSTR(Tablo_Action[index].heure);
      EditAdr2.text:=intToSTR(Tablo_Action[index].minute);
      LabelHeure.visible:=true;
      LabelAdresse.visible:=true;
      EditAdr.Visible:=true;
      LabelAdresse.Caption:='Heure';
      EditAdr.Hint:='Heure du déclencheur';
      EditAdr2.Hint:='Minute du déclencheur';
      EditAdr2.Visible:=true;
      LabelEtat.Visible:=false;
      SpinEditEtat.Visible:=false;
      LabelTrain.Visible:=false;
      EditTrainDecl.Visible:=false;
      RichEditInf.Lines.Add('Déclenchement par l''horloge');
      ImageIcone.Picture:=nil;
      formConfCellTCO.ImageListIcones.GetBitmap(IconeHorloge,ImageIcone.Picture.Bitmap);
      ImageIcone.repaint;
    end;
  DeclPeriph :
    begin
      EditTrainDecl.Text:=Tablo_Action[index].ordrePeriph;
      LabelHeure.visible:=false;
      LabelAdresse.visible:=false;
      EditAdr.Visible:=false;
      EditAdr2.Visible:=false;
      LabelEtat.Visible:=false;

      SpinEditEtat.Visible:=false;
      LabelTrain.Visible:=false;

      EditTrainDecl.Visible:=true;
      EditTrainDecl.Hint:='Chaîne ASCII';

      LabelTrain.visible:=true;
      LabelTrain.Caption:='Commande du périphérique';
      RichEditInf.Lines.Add('Déclenchement par chaîne ASCII depuis un périphérique COM/USB - Socket');

      ImageIcone.Picture:=nil;
      formConfCellTCO.ImageListIcones.GetBitmap(IconePeriph,ImageIcone.Picture.Bitmap);
      ImageIcone.repaint;
    end;
  DeclAccessoire :
    begin
      EditAdr.text:=intToSTR(Tablo_Action[index].adresse);

      with SpinEditEtat do
      begin
        text:=intToSTR(Tablo_Action[index].etat);
        MaxValue:=2;
        Hint:='Etat de l''accessoire'+#13+
              '0=nul'+#13+
              '1=dévié'+#13+
              '2=droit';
        ShowHint:=true;
        visible:=true;
      end;

      LabelHeure.visible:=false;
      LabelAdresse.caption:='Adresse';
      LabelAdresse.visible:=true;
      EditAdr.Hint:='Adresse de l''accessoire sur le bus';
      EditAdr.Visible:=true;
      EditAdr2.Visible:=false;

      LabelEtat.Visible:=true;

      LabelTrain.Visible:=false;
      EditTrainDecl.Visible:=false;
      RichEditInf.Lines.Add('Accessoire sur le bus DCC (aiguillage)');
      ImageIcone.Picture:=nil;
      formConfCellTCO.ImageListIcones.GetBitmap(IconeAccessoire,ImageIcone.Picture.Bitmap);
      ImageIcone.repaint;
    end;

  DeclDetAct :
    begin
      EditAdr.text:=intToSTR(Tablo_Action[index].adresse);
      EditTrainDecl.Visible:=true;
      EditTrainDecl.Text:=Tablo_Action[index].trainDecl;

      EdittrainDecl.Hint:='Train(s) déclencheur(s) séparés par des virgules pour lesquels la condition s''applique.'
               +#13+'Mettre X pour tous les trains.'+#13+'Déclenchement par actionneur uniquement';
      LabelAdresse.visible:=true;
      EditAdr.Visible:=true;
      EditAdr.Hint:='Adresse du détecteur sur le bus de rétrosignalisation '+#13+'ou de l''actionneur CDM';
      LabelHeure.visible:=false;
      EditAdr2.Visible:=false;
      LabelAdresse.Caption:='Adresse';
      LabelEtat.Visible:=true;

      with SpinEditEtat do
      begin
        text:=intToSTR(Tablo_Action[index].etat);
        MaxValue:=1;
        Hint:='Etat du détecteur/actionneur'+#13+
              '0=désactivé'+#13+
              '1=activé';
        ShowHint:=true;
        visible:=true;
      end;

      LabelTrain.Visible:=true;
      LabelTrain.Caption:='Train déclencheur';
      s:='Déclenchement par détecteur/actionneur suivant son état et un train, un groupe de trains ou tous les trains.'+#13;
      s:=s+'Le déclenchement par détecteur conditionné par un train n''est pas garanti, contrairement aux actionneurs.';
      RichEditInf.Lines.Add(s);

      ImageIcone.Picture:=nil;
      formConfCellTCO.ImageListIcones.GetBitmap(IconeDet,ImageIcone.Picture.Bitmap);
      ImageIcone.repaint;
    end;

   DeclZoneDet :
   begin
      EditAdr.text:=intToSTR(Tablo_Action[index].adresse);
      EditAdr2.text:=intToSTR(Tablo_Action[index].adresse2);

      EditTrainDecl.Text:=Tablo_Action[index].trainDecl;
      EditAdr.Hint:='Adresse1 de la zone de détection du déclencheur';
      EditAdr2.Hint:='Adresse2 de la zone de détection du déclencheur';
      LabelAdresse.visible:=true;
      EditAdr.Visible:=true;
      LabelHeure.visible:=false;
      EditAdr2.Visible:=true;
      LabelAdresse.Caption:='Adresse';
      LabelEtat.Visible:=true;

      EditTrainDecl.Visible:=true;
      EdittrainDecl.Hint:='Train(s) déclencheur(s) séparés par des virgules pour lesquels la condition s''applique.'
               +#13+'Mettre X pour tous les trains.'+#13+'Mode autonome uniquement';

      with SpinEditEtat do
      begin
        text:=intToSTR(Tablo_Action[index].etat);
        MaxValue:=1;
        Hint:='Etat de la zone de détection'+#13+
              '0=désactivé'+#13+
              '1=activé';
        ShowHint:=true;
        visible:=true;
      end;

      LabelTrain.Visible:=true;
      LabelTrain.Caption:='Train déclencheur';
      RichEditInf.Lines.Add('Déclenchement par zones de détections contigües suivant son état et un train, un groupe de trains ou tous les trains.');
      ImageIcone.Picture:=nil;
      formConfCellTCO.ImageListIcones.GetBitmap(IconeZoneDet,ImageIcone.Picture.Bitmap);
      ImageIcone.repaint;
   end;

   DeclDemarTrain :
   begin
     LabelTrain.visible:=true;
     EditTrainDecl.Visible:=true;
     LabelAdresse.Visible:=true;
     LabelAdresse.caption:='Seuil de vitesse';
     EditAdr.Visible:=true;

     EdittrainDecl.Hint:='Train déclencheur unique';

     EditADR.Hint:='Seuil de vitesse de démarrage du train ';
     EditTrainDecl.Text:=Tablo_Action[index].trainDecl;
     EditAdr.Text:=IntToSTR(Tablo_Action[index].adresse);
     RichEditInf.Lines.Add('Déclenchement par démarrage d''un train à un seuil donné');
     ImageIcone.Picture:=nil;
     formConfCellTCO.ImageListIcones.GetBitmap(IconeDemarTrain,ImageIcone.Picture.Bitmap);
     ImageIcone.repaint;
   end;

   DeclArretTrain :
   begin
     LabelTrain.visible:=true;
     EditTrainDecl.Visible:=true;
     LabelAdresse.Visible:=true;
     LabelAdresse.caption:='Seuil de vitesse';
     EdittrainDecl.Hint:='Train déclencheur unique';

     EditAdr.Visible:=true;
     EditADR.Hint:='Seuil de vitesse d''arrêt du train';
     EditTrainDecl.Text:=Tablo_Action[index].trainDecl;
     EditAdr.Text:=IntToSTR(Tablo_Action[index].adresse);
     RichEditInf.Lines.Add('Déclenchement par arrêt d''un train à un seuil donné');
     ImageIcone.Picture:=nil;
     formConfCellTCO.ImageListIcones.GetBitmap(IconeArretTrain,ImageIcone.Picture.Bitmap);
     ImageIcone.repaint;
   end;

   DeclSignal :
   begin
     LabelAdresse.Visible:=true;
     EditAdr.text:=intToSTR(Tablo_Action[index].adresse);
     RadioEtatSignal.ItemIndex:=Tablo_Action[index].Etat;
     LabelAdresse.Caption:='Adresse';
     EditAdr.Hint:='Adresse de base du signal';
     EditAdr.Visible:=true;
     RadioEtatSignal.Visible:=true;
     RadioEtatSignal.Left:=16;
     RadioEtatSignal.top:=64;
     RichEditInf.Lines.Add('Déclenchement par changement d''état d''un signal');
     ImageIcone.Picture:=nil;
     formConfCellTCO.ImageListIcones.GetBitmap(IconeSignal,ImageIcone.Picture.Bitmap);
     ImageIcone.repaint;
   end;
  end;

  // conditions
  if indexCond>0 then
  begin
    cond:=Tablo_Action[index].tablocond[indexCond].numcondition;
    with formModifAction do
    begin
      case cond of
        CondVitTrain :
        begin
          champ1.Text:=intToSTR(Tablo_Action[index].tabloCond[indexCond].vitmini);
          champ2.Text:=intToSTR(Tablo_Action[index].tabloCond[indexCond].vitmaxi);
          ChampTrain.text:=Tablo_Action[index].tabloCond[indexCond].train;
          Champ1.EditLabel.Caption:='Vitesse'+#13+'mini';
          Champ2.EditLabel.Caption:='Vitesse'+#13+'maxi';
          Champ1.Hint:='Vitesse minimale du train pour la condition';
          Champ2.Hint:='Vitesse minimale du train pour la condition';
          ChampTrain.Hint:='Nom du train unique pour la condition';
          champ1.Visible:=true;
          champ2.Visible:=true;
          ChampTrain.Visible:=true;
        end;
        CondPosAcc :
        begin
          champ1.Text:=intToSTR(Tablo_Action[index].tabloCond[indexCond].accessoire);
          Champ1.Hint:='Adresse DCC de l''accessoire pour la condition';
          SpinEditEtat2.Value:=Tablo_Action[index].tabloCond[indexCond].etat;
          SpinEditEtat2.visible:=true;
          SpinEditEtat2.hint:='Etat de l''accessoire'+#13+
              '0=nul'+#13+
              '1=dévié'+#13+
              '2=droit';
          Champ1.EditLabel.Caption:='Adresse'+#13+'acc';
          champ1.Visible:=true;
          labelEtat2.Visible:=true;
          SpinEditEtat2.visible:=true;
          SpinEditEtat2.MaxValue:=2;
        end;
        condHorl :
        begin
          SpinEditHeure1.Value:=Tablo_Action[index].tabloCond[indexCond].HeureMin;
          SpinEditmn1.Value:=Tablo_Action[index].tabloCond[indexCond].MinuteMin;
          SpinEditHeure2.Value:=Tablo_Action[index].tabloCond[indexCond].HeureMax;
          SpinEditmn2.Value:=Tablo_Action[index].tabloCond[indexCond].MinuteMax;

          SpinEditHeure1.visible:=true;
          SpinEditHeure2.visible:=true;
          SpinEditMn1.visible:=true;
          SpinEditMn2.visible:=true;
          LabelHeureDebut.Visible:=true;
          LabelHeureFin.Visible:=true;
        end;
        condTrainSig :
        begin
          champ1.Text:=intToSTR(Tablo_Action[index].tabloCond[indexCond].adresse);
          champ1.editLabel.Caption:='Adresse du signal';
          champTrain.Text:=Tablo_Action[index].tabloCond[indexCond].train;
          champ1.Visible:=true;
          champTrain.Visible:=true;
        end;
      end;
    end;
  end;


  Nb:=Tablo_Action[index].NbOperations;

  // si pas d'action sélectionnée et que la liste n'est pas nulle, sélectionner la première
  if (Nb>0) and (indexAction=0) then
  begin
    indexAction:=1;
    formModifAction.listBoxOperations.itemIndex:=indexaction;
    formModifAction.listBoxOperations.Selected[indexaction-1]:=true;
  end;

  if Nb>=indexAction then
  begin

    Act:=Tablo_Action[index].tabloop[indexAction].numoperation;

    with formModifAction do
    begin

      case Act of
      ActionAffTCO :
      begin
        LabeledEditAdresse.Visible:=true;
        LabeledEditAdresse.EditLabel.Caption:='TCO n°';
        LabeledEditAdresse.Text:=intToSTR(Tablo_Action[index].tabloop[indexAction].NumTCO);
      end;
      ActionAccessoire :
      begin
        LabeledEditAdresse.EditLabel.Caption:='Adresse';
        LabeledEditAdresse.visible:=true;
        SpinEditEtatop.Visible:=true;
        labelEtatOp.Visible:=true;
        SpinEditEtatop.MinValue:=0;
        SpinEditEtatop.MaxValue:=2;
        SpinEditEtatop.hint:='Etat de l''accessoire'+#13+
              '0=nul'+#13+
              '1=dévié'+#13+
              '2=droit';

        checkBoxRaz.Visible:=true;
        LabeledEditAdresse.Text:=intToSTR(Tablo_Action[index].tabloop[indexAction].adresse);
        SpinEditEtatop.Value:=Tablo_Action[index].tabloop[indexAction].etat;
        checkBoxRAZ.Checked:=Tablo_Action[index].tabloop[indexAction].zero;
      end;
      ActionVitesse :
      begin
        LabeledEditAdresse.EditLabel.Caption:='Vitesse';
        LabeledEditAdresse.visible:=true;
        LabeledEditTrain.Visible:=true;
        LabeledEditTrain.EditLabel.Caption:='Train destinataire';
        LabeledEditTrain.hint:='Nom unique du train';
        LabeledEditAdresse.Text:=intToSTR(Tablo_Action[index].tabloop[indexAction].vitesse);
        LabeledEditTrain.Text:=Tablo_Action[index].tabloop[indexAction].train;
      end;
      ActionCdePeriph :
      begin
        LabeledEditTrain.Visible:=true;
        ComboBoxAccComUSB.Visible:=true;
        LabelPeriph.Visible:=true;
        LabeledEditTrain.EditLabel.Caption:='Commande';
        LabeledEditTrain.Hint:='Commande Ascii';
        LabeledEditTrain.Text:=Tablo_Action[index].tabloop[indexAction].chaine;
        ComboBoxAccComUSB.itemIndex:=Tablo_Action[index].tabloop[indexAction].periph-1;
      end;
      ActionFonctionF :
      begin
        LabeledEditFonctionF.Visible:=true;
        LabeledEditTempoF.Visible:=true;
        LabeledEditTrain.EditLabel.Caption:='Train destinataire';
        LabeledEditFonctionF.EditLabel.Caption:='Fonction F';
        LabeledEditTrain.Visible:=true;
        LabeledEditTrain.hint:='Nom unique du train';
        LabeledEditFonctionF.Text:=intToSTR(Tablo_Action[index].tabloop[indexAction].fonctionF);
        LabeledEditTempoF.Text:=intToSTR(Tablo_Action[index].tabloop[indexAction].TempoF);
        LabeledEditTrain.Text:=Tablo_Action[index].tabloop[indexAction].train;
      end;
      ActionSon :
      begin
        LabeledEditTrain.Visible:=true;
        SpeedButtonJoue.Visible:=true;
        SpeedButtonCharger.Visible:=true;
        LabeledEditTrain.EditLabel.Caption:='Son';
        LabeledEditTrain.Hint:='fichier son';
        LabeledEditTrain.Text:=Tablo_Action[index].tabloop[indexAction].train;
      end;
      ActionTempo :
      begin
        LabeledEditTempoF.Visible:=true;
        LabeledEditTempoF.EditLabel.Caption:='Temporisation (x100 ms)';
        LabeledEditTempoF.Text:=intToSTR(Tablo_Action[index].tabloop[indexAction].TempoF);
      end;
    end;
    end;
  end;
  clicliste:=false;
end;

procedure TFormModifAction.ButtonOkClick(Sender: TObject);
begin
  Aff_champs(ligneclicAct+1,1,1);
  close;
end;


procedure TFormModifAction.FormActivate(Sender: TObject);
var i : integer;
    s : string;
begin

  ComboBoxActions.Clear;
  for i:=1 to maxTablo_act do
  begin
    s:=encode_actions(i);
    if s<>'' then ComboBoxActions.Items.Add(s);
  end;
  //ligneclicACt:=0;
  ComboBoxActions.ItemIndex:=ligneclicAct;
  LabelDecl.Caption:='Déclencheur de l''action n°'+intToSTR(ComboBoxactions.ItemIndex+1);
  Aff_champs(ligneclicAct+1,ClicCond+1,ClicAction+1);

  if OperationAffiche<>0 then
  begin
    PageControlAct.ActivePage:=TabSheetOp;
  end;
end;

procedure TFormModifAction.ComboBoxActionsChange(Sender: TObject);
begin
  ligneclicAct:=ComboBoxActions.ItemIndex;
  Aff_champs(ligneclicAct+1,0,0);
  LabelDecl.Caption:='Liste de déclencheurs de l''action n°'+intToSTR(ComboBoxactions.ItemIndex+1);
end;


procedure TFormModifAction.ButtonAppActionClick(Sender: TObject);
var indexSrc,IndexDest,i : integer;
    s : string;
begin
  indexSrc:=listboxOper.ItemIndex;
  IndexDest:=ListBoxOperations.Itemindex;
  if (indexSrc<0) or (ligneclicAct<0) then exit;


  s:=ListBoxOper.Items[indexSrc];
  i:=Index_Operation(s);

  if (IndexDest<0) then IndexDest:=0;
  Tablo_Action[ligneClicAct+1].TabloOp[IndexDest+1].numoperation:=i;

  listboxoperations.Items[indexDest]:=ListBoxOper.Items[indexSrc];

  clicAction:=ligneclicact;
  Aff_champs(ligneClicAct+1,1,indexDest+1);
end;

procedure TFormModifAction.ButtonAjouterClick(Sender: TObject);
var indexSrc,idBD,NbOp,NbCond,i : integer;
    s : string;
begin
  indexSrc:=listboxOper.ItemIndex;
  if indexSrc<0 then exit;

  s:=ListBoxOper.Items[IndexSrc];
  i:=index_operation(s);
  if i=0 then exit;

  idBD:=ligneClicAct+1;
  NbOp:=Tablo_Action[idBD].NbOperations;
  NbCond:=Tablo_Action[idBD].NbCond;
  inc(NbOp);
  Tablo_Action[idBD].NbOperations:=NbOp;
  Setlength(Tablo_Action[idBD].tabloOp,NbOp+1);
  // le nouveau numéro d'opération c'est l'index de la listboxOper
  Tablo_Action[idBD].tabloOp[NbOp].numoperation:=i;
  Tablo_Action[idBD].tabloOp[NbOp].valide:=true;

  Aff_champs(idbd,nbCond,Nbop);
  clicAction:=NbOp-1;
  ListBoxOperations.ItemIndex:=clicAction;

end;



procedure supprime_operation;
var i,indexSrc,idBD,NbOp,NumOp : integer;
    s : string;
begin
  indexSrc:=formModifaction.listboxOperations.ItemIndex;
  if indexSrc<0 then exit;

  idBD:=ligneClicAct+1;
  NbOp:=Tablo_Action[idBD].NbOperations;
  if NbOp<1 then exit;

  NumOp:=Tablo_Action[idBD].TabloOp[indexSrc+1].numoperation;
  s:='Voulez vous supprimer l''opération '+#13+operations[NumOp].Nom+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  // supprimer
  FormModifAction.listboxoperations.Items.Delete(indexSrc);
  for i:=IndexSrc+1 to NbOp-1 do
  begin
    Tablo_Action[idBD].TabloOp[i]:=Tablo_Action[idBD].TabloOp[i+1];
  end;

  dec(NbOp);
  Tablo_Action[idBD].NbOperations:=NbOp;
  Setlength(Tablo_Action[idBD].tabloOp,NbOp+1);

  Aff_champs(idBD,1,IndexSrc+1);
  exit;

  // réencoder la ligne
  s:=encode_actions(idBD);
  // maj combobox
  FormModifAction.ComboBoxActions.Items[idBD-1]:=s;
  FormModifAction.ComboBoxActions.ItemIndex:=idbd-1;
end;

procedure TFormModifAction.SpeedButtonSupprimeClick(Sender: TObject);
begin
  supprime_operation;
end;

procedure TFormModifAction.SpinButton1UpClick(Sender: TObject);
var i,indexSrc,idBD,idOp,no : integer;
    top : Toperation;
    s : string;
begin
 indexSrc:=listboxOperations.ItemIndex;
  if indexSrc<0 then exit;
  idBD:=ligneClicAct+1;
  idop:=indexSrc+1;


  if (indexSrc<1) then exit;
  top:=Tablo_Action[idBD].TabloOp[idOp-1];
  Tablo_Action[idBD].TabloOp[idOp-1]:=Tablo_Action[idBD].TabloOp[idOp];
  Tablo_Action[idBD].TabloOp[idOp]:=top;

  // réencoder la ligne
  s:=encode_actions(idBD);
  // maj combobox
  ComboBoxActions.Items[idBD-1]:=s;
  ComboBoxActions.ItemIndex:=idbd-1;

  // maj opérations
  with FormModifAction.ListBoxOperations do
  begin
    clear;
    for i:=1 to Tablo_Action[idBD].NbOperations do
    begin
      no:=Tablo_Action[idBD].tabloOp[i].numoperation;
      items.Add(Format('%d%s', [no-1, operations[no].nom])); // valeur d'index de l'icone dans la ImagelistIcones
      itemHeight:=17;
    end;
    ItemIndex:=indexSrc-1;
  end;

  //Affiche(intToSTR(ligneClicAct),clyellow);


end;

procedure TFormModifAction.SpinButton1DownClick(Sender: TObject);

var no,i,indexSrc,idBD,idOp : integer;
    top : Toperation;
    s : string;
begin
  indexSrc:=listboxOperations.ItemIndex;
  if indexSrc<0 then exit;
  idBD:=ligneClicAct+1;
  idop:=indexSrc+1;


  no:=Tablo_Action[idBD].NbOperations;

  if (indexSrc+1>=No) then exit;
  top:=Tablo_Action[idBD].TabloOp[idOp+1];
  Tablo_Action[idBD].TabloOp[idOp+1]:=Tablo_Action[idBD].TabloOp[idOp];
  Tablo_Action[idBD].TabloOp[idOp]:=top;


  // réencoder la ligne
  s:=encode_actions(idBD);
  // maj combobox
  ComboBoxActions.Items[idBD-1]:=s;
  ComboBoxActions.ItemIndex:=idbd-1;

  // maj opérations
  with FormModifAction.ListBoxOperations do
  begin
    clear;
    for i:=1 to Tablo_Action[idBD].NbOperations do
    begin
      no:=Tablo_Action[idBD].tabloOp[i].numoperation;
      items.Add(Format('%d%s', [no-1, operations[no].nom])); // valeur d'index de l'icone dans la ImagelistIcones
      itemHeight:=17;
    end;

    ItemIndex:=indexSrc+1;
  end;

  //Affiche(intToSTR(ligneClicAct),clyellow);


end;

procedure maj_combocactions(i : integer);
var s : string;
begin
  s:=encode_actions(i+1);
  with formModifAction do
  begin
    ComboBoxActions.Items[i]:=s;
    ComboBoxActions.ItemIndex:=ligneClicAct;
  end;
end;

procedure TFormModifAction.EditAdrChange(Sender: TObject);
var decl,index,i,erreur : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  index:=ligneclicAct+1;
  if affevt then Affiche('EditAdrChange',clyellow);

  decl:=Tablo_Action[ligneclicAct+1].declencheur;
  val(editAdr.Text,i,erreur);
  if (i<0) or (erreur<>0) then exit;

  if decl=DeclHorloge then
  begin
    if (i>23) then exit;
    Tablo_Action[index].heure:=i;
  end
  else Tablo_Action[index].adresse:=i;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.EditAdr2Change(Sender: TObject);
var decl,index,i,erreur : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  index:=ligneclicAct+1;

  decl:=Tablo_Action[ligneclicAct+1].declencheur;

  if (decl<>DeclZoneDet) and (decl<>DeclHorloge) then exit;

  val(editAdr2.Text,i,erreur);
  if (i<0) or (erreur<>0) then exit;

  if decl=DeclHorloge then
  begin
    if (i>59) then exit;
    Tablo_Action[index].minute:=i;
  end;
  if decl=DeclZoneDet then Tablo_Action[index].adresse2:=i;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.SpinEditEtatChange(Sender: TObject);
var decl,index,i,erreur : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  index:=ligneclicAct+1;

  decl:=Tablo_Action[ligneclicAct+1].declencheur;
  if (decl<>declAccessoire) and (decl<>DeclDetAct) and (decl<>DeclZoneDet) then exit;

  val(SpinEditEtat.Text,i,erreur);
  if (i<0) or (i>2) or (erreur<>0) then exit;
  Tablo_Action[index].etat:=i;

  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.EditTrainDeclChange(Sender: TObject);
var decl,index : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  if affevt then Affiche('EditTrainDeclChange',clyellow);
  index:=ligneclicAct+1;

  decl:=Tablo_Action[ligneclicAct+1].declencheur;
  if (decl<>declDetAct) and (decl<>DeclZoneDet) and (decl<>DeclPeriph) and
     (decl<>DeclDemarTrain) and (decl<>DeclArretTrain) then exit;

  if (decl=declDetAct) or (decl=DeclZoneDet) or (decl=DeclDemarTrain) or (decl=DeclArretTrain)
     then Tablo_Action[index].trainDecl:=EditTrainDecl.text;
  if decl=DeclPeriph then Tablo_Action[index].ordrePeriph:=EditTrainDecl.text;

  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.ListBoxOperationsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //Affiche('Clic ListBoxOperations',clyellow);
  ClicAction:=ListBoxOperations.itemindex;
  if ClicAction<0 then exit;
  Aff_champs(ligneclicAct+1,1,ClicAction+1);
end;


procedure TFormModifAction.LabeledEditAdresseChange(Sender: TObject);
var i,erreur,op : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  val(LabeledEditAdresse.Text,i,erreur);
  op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;
  case op of
    ActionAffTCO    : Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numTCO:=i;
    ActionAccessoire: Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].adresse:=i;
    ActionVitesse   : Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].vitesse:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.LabeledEditFonctionFChange(Sender: TObject);
var i,erreur,op : integer;
begin
  if clicAction<0 then exit;
  if (ligneclicAct<0) or clicliste then exit;
  val(LabeledEditFonctionF.Text,i,erreur);
  op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;
  case op of
    ActionFonctionF  : Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].FonctionF:=i;
    ActionTempo : Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].TempoF:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.LabeledEditTrainChange(Sender: TObject);
var op : integer;
    s : string;
begin
  if (clicAction<0) or clicListe then exit;
  op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;
  if (op=ActionFonctionF) or (op=ActionVitesse) or (op=ActionSon) then
  begin
    s:=LabeledEditTrain.Text;
    if pos(',',s)<>0 then
    begin
      labelInfo.Caption:='Les noms de trains multiples ne sont pas autorisés ici';
      exit;
    end;
    labelInfo.Caption:='';
    Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].train:=s;
  end;
  if op=ActionCdePeriph then Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].chaine:=LabeledEditTrain.Text;
  maj_combocactions(ligneclicact);
end;

procedure TFormModifAction.SpeedButtonJoueClick(Sender: TObject);
begin
 if (ligneclicAct<0) then exit;
 if PlaySound(pchar(LabeledEditTrain.Text),0,SND_ASYNC)=false then labelInfo.Caption:='Erreur';
end;

procedure TFormModifAction.SpeedButtonChargerClick(Sender: TObject);
var s: string;
    op : integer;
begin
  if (ligneclicAct<0) or (clicAction<0) then exit;

  s:=GetCurrentDir;
  OpenDialogSon.InitialDir:=s;
  OpenDialogSon.DefaultExt:='wav';
  OpenDialogSon.Title:='Ouvrir un fichier son';
  OpenDialogSon.Filter:='Fichiers wav (*.wav)|*.wav|Tous fichiers (*.*)|*.*';
  if openDialogSon.Execute then
  begin
    s:=openDialogSon.FileName;
    LabeledEditTrain.Text:=s;
    op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;
    if op=ActionSon then Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].train:=s;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.CheckBoxRAZClick(Sender: TObject);
var op : integer;
begin
  if clicAction<0 then exit;
  op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;
  if (op=ActionAccessoire) then Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].zero:=CheckBoxRaz.Checked;
  maj_combocactions(ligneclicAct);
end;

// affiche les champs de l'actionneur PN en fonction de l'index du tableau
{
procedure aff_champs_PN(i : integer);
var erreur,j,v,periph : integer;
    trouve : boolean;
    s : string;
begin

  if affevt then affiche('Aff_champs_PN('+intToSTR(i)+')',clyellow);
  if i<1 then
  begin
    clicliste:=false;
    exit;
  end;
  //s:=Uppercase(formModifAction.ListBoxPN.items[i-1]);
  if s='' then
  begin
    clicliste:=false;
    exit;
  end;

  with formModifAction do
  begin
    LabelInfo.caption:='';
    raz_champs_pn;
  end;

  // actionneur passage à niveau
  if s[1]='(' then
  begin
    champs_type_pn;
    // trouver le numéro de périphérique
    v:=pos('PN(',s);
    delete(s,1,v+2);
    val(s,periph,erreur);
    {
    i:=0;
    repeat
      inc(i);
      trouve:=(Tablo_PN[i].AdresseFerme=adresse);
    until trouve or (i>NbrePN);
    if not(trouve) then exit;}
  {
    with formModifAction do
    begin
      RadioGroupActPN.itemindex:=Tablo_PN[i].TypeCde;

      if Tablo_PN[i].TypeCde=0 then champs_pn_act;
      if Tablo_PN[i].TypeCde=1 then champs_pn_comusbSockets;

      if Tablo_PN[i].Pulse=1 then trouve:=true else trouve:=false;
      CheckPnPulse.Checked:=trouve;

      // par actionneur
      if Tablo_PN[i].actionneur then
      begin
        RadioButtonSimple.Checked:=true;
        RadioButtonZone.Checked:=false;
        GroupBoxPNA.Visible:=true;
        GroupBoxPNZ.Visible:=false;
        EditV1F.text:=intToSTR(Tablo_PN[i].voie[1].ActFerme);
        EditV1O.text:=intToSTR(Tablo_PN[i].voie[1].ActOuvre);
        v:=Tablo_PN[i].nbvoies;
        if v>=2 then
        begin
          EditV2F.text:=intToSTR(Tablo_PN[i].voie[2].ActFerme);
          EditV2O.text:=intToSTR(Tablo_PN[i].voie[2].ActOuvre);
        end;
        if v>=3 then
        begin
          EditV3F.text:=intToSTR(Tablo_PN[i].voie[3].ActFerme);
          EditV3O.text:=intToSTR(Tablo_PN[i].voie[3].ActOuvre);
        end;
        if v>=4 then
        begin
          EditV4F.text:=intToSTR(Tablo_PN[i].voie[4].ActFerme);
          EditV4O.text:=intToSTR(Tablo_PN[i].voie[4].ActOuvre);
        end;
        if v>=5 then
        begin
          EditV5F.text:=intToSTR(Tablo_PN[i].voie[5].ActFerme);
          EditV5O.text:=intToSTR(Tablo_PN[i].voie[5].ActOuvre);
        end;

      end
      else
      begin
        // par zone de détecteurs
        RadioButtonSimple.Checked:=false;
        RadioButtonZone.Checked:=true;
        GroupBoxPNA.Visible:=false;
        GroupBoxPNZ.Visible:=true;
        v:=Tablo_PN[i].nbvoies;
        j:=Tablo_PN[i].voie[1].detZ1F;if j<>0 then
        begin
          EditZdet1V1F.text:=intToSTR(j);
          EditZdet2V1F.text:=intToSTR(Tablo_PN[i].voie[1].detZ2F);
          EditZdet1V1O.text:=intToSTR(Tablo_PN[i].voie[1].detZ1O);
          EditZdet2V1O.text:=intToSTR(Tablo_PN[i].voie[1].detZ2O);
          if v>=2 then
          begin
            EditZdet1V2F.text:=intToSTR(Tablo_PN[i].voie[2].detZ1F);
            EditZdet2V2F.text:=intToSTR(Tablo_PN[i].voie[2].detZ2F);
            EditZdet1V2O.text:=intToSTR(Tablo_PN[i].voie[2].detZ1O);
            EditZdet2V2O.text:=intToSTR(Tablo_PN[i].voie[2].detZ2O);
          end;
          if v>=3 then
          begin
            EditZdet1V3F.text:=intToSTR(Tablo_PN[i].voie[3].detZ1F);
            EditZdet2V3F.text:=intToSTR(Tablo_PN[i].voie[3].detZ2F);
            EditZdet1V3O.text:=intToSTR(Tablo_PN[i].voie[3].detZ1O);
            EditZdet2V3O.text:=intToSTR(Tablo_PN[i].voie[3].detZ2O);
          end;
          if v>=4 then
          begin
            EditZdet1V4F.text:=intToSTR(Tablo_PN[i].voie[4].detZ1F);
            EditZdet2V4F.text:=intToSTR(Tablo_PN[i].voie[4].detZ2F);
            EditZdet1V4O.text:=intToSTR(Tablo_PN[i].voie[4].detZ1O);
            EditZdet2V4O.text:=intToSTR(Tablo_PN[i].voie[4].detZ2O);
          end;
          if v>=5 then
          begin
            EditZdet1V5F.text:=intToSTR(Tablo_PN[i].voie[5].detZ1F);
            EditZdet2V5F.text:=intToSTR(Tablo_PN[i].voie[5].detZ2F);
            EditZdet1V5O.text:=intToSTR(Tablo_PN[i].voie[5].detZ1O);
            EditZdet2V5O.text:=intToSTR(Tablo_PN[i].voie[5].detZ2O);
          end;
        end;
      end;
    end;
  end;
  clicliste:=false;
end;
}


procedure TFormModifAction.ButtonApplDeclClick(Sender: TObject);
var i : integer;
begin
  ClicDeclenche:=ListBoxdeclench.itemindex;
  if clicDeclenche<0 then exit;
  i:=Clicdeclenche+1;
  Tablo_Action[ligneclicAct+1].declencheur:=i;
  Aff_champs(ligneclicAct+1,0,0);

end;

procedure TFormModifAction.LabeledEditNomActChange(Sender: TObject);
var index : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  index:=ligneclicAct+1;

  Tablo_Action[index].NomAction:=LabeledEditNomAct.text;

  Aff_champs(index,0,0);
end;



procedure TFormModifAction.ComboBoxAccComUSBChange(Sender: TObject);
var index : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  index:=ligneclicAct+1;
  if affevt then affiche('Evt ComboBox Change',clyellow);
  Tablo_Action[ligneClicAct+1].TabloOp[clicaction+1].periph:=formModifAction.ComboBoxAccComUSB.ItemIndex+1;
  Aff_champs(index,0,clicaction+1);
end;

procedure TFormModifAction.LabeledEditTempoFChange(Sender: TObject);
var i,erreur : integer;
begin
  if clicAction<0 then exit;
  if (ligneclicAct<0) or clicliste then exit;
  val(LabeledEditTempoF.Text,i,erreur);
  Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].TempoF:=i;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.ListBoxOperationsDblClick(Sender: TObject);
begin
  if (clicAction<0) or (ligneclicAct<0) or clicliste then exit;
  Tablo_Action[ligneclicAct+1].tabloOp[clicaction+1].valide:=not(Tablo_Action[ligneclicAct+1].tabloOp[clicaction+1].valide);
  maj_combocactions(ligneclicAct);
end;



procedure TFormModifAction.ListBoxCondTotDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i,erreur: Integer;
  ItemText: string;
begin
  with ListBoxCondTot do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    formConfCellTCO.ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, i);
    Canvas.Textout(Rect.Left + formConfCellTCO.ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;
end;

procedure TFormModifAction.ListBoxConditionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //Affiche('Clic ListBoxOperations',clyellow);
  ClicCond:=ListBoxConditions.itemindex;
  if ClicCond<0 then exit;
  Aff_champs(ligneclicAct+1,ClicCond+1,ClicAction+1);
end;

procedure TFormModifAction.ListBoxConditionsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i,erreur: Integer;
  ItemText: string;
begin
  with ListBoxConditions do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    formConfCellTCO.ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, i);
    Canvas.Textout(Rect.Left + formConfCellTCO.ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;
end;

procedure TFormModifAction.ButtonAppCondClick(Sender: TObject);
var indexSrc,IndexDest,i : integer;
    s : string;
begin
  indexSrc:=listboxCondTot.ItemIndex;
  IndexDest:=ListBoxConditions.Itemindex;
  if (indexSrc<0) or (ligneclicAct<0) then exit;


  s:=ListBoxCondTot.Items[indexSrc];
  i:=Index_Condition(s);

  if (IndexDest<0) then IndexDest:=0;
  Tablo_Action[ligneClicAct+1].TabloCond[IndexDest+1].numCondition:=i;

  listboxConditions.Items[indexDest]:=ListBoxCondTot.Items[indexSrc];

  clicAction:=ligneclicact;
  Aff_champs(ligneClicAct+1,indexDest+1,0);

end;


procedure TFormModifAction.Champ1Change(Sender: TObject);
var cond,i,erreur : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  val(Champ1.Text,i,erreur);
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondVitTrain    : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].vitmini:=i;
    CondPosAcc      : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].accessoire:=i;
    CondTrainSig    : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].adresse:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.Champ2Change(Sender: TObject);
var cond,i,erreur : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  val(Champ2.Text,i,erreur);
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondVitTrain    : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].vitmaxi:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.SpinEditHeure1Change(Sender: TObject);
var cond,i : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  i:=SpinEditHeure1.Value;
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondHorl        : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].HeureMin:=i;
  end;
  maj_combocactions(ligneclicAct);
end;


procedure TFormModifAction.SpinEditMn1Change(Sender: TObject);
var cond,i : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  i:=SpinEditMn1.Value;
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondHorl        : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].MinuteMin:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.SpinEditHeure2Change(Sender: TObject);
var cond,i : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  i:=SpinEditHeure2.Value;
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondHorl        : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].HeureMax:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.SpinEditMn2Change(Sender: TObject);
var cond,i : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  i:=SpinEditMn2.Value;
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondHorl        : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].MinuteMax:=i;
  end;
  maj_combocactions(ligneclicAct);

end;

procedure TFormModifAction.ChampTrainChange(Sender: TObject);
var cond : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondVitTrain,CondTrainSig   : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].train:=ChampTrain.Text;
  end;
  maj_combocactions(ligneclicAct);

end;

procedure TFormModifAction.SpinEditEtat2Change(Sender: TObject);
var cond,i : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  i:=SpinEditEtat2.Value;
  cond:=Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].numcondition;
  case cond of
    CondPosAcc       : Tablo_Action[ligneclicact+1].tabloCond[cliccond+1].etat:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.RadioEtatSignalClick(Sender: TObject);
var index : integer;
begin
 if (ligneclicAct<0) or clicliste then exit;
  index:=ligneclicAct+1;
  if affevt then Affiche('EditAdrChange',clyellow);

  Tablo_Action[index].etat:=RadioEtatSignal.ItemIndex;

  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.SpinEditEtatopChange(Sender: TObject);
var i,op : integer;
begin
  if (ligneclicAct<0) or clicliste then exit;
  i:=SpinEditEtatop.Value;
  op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;
  case op of
    ActionAccessoire  : Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].etat:=i;
  end;
  maj_combocactions(ligneclicAct);
end;

procedure TFormModifAction.ListBoxOperationsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var nb : integer;
begin
  nb:=Tablo_Action[ligneclicAct+1].NbOperations;
  if (nb<1) or clicliste then exit;
  if key=VK_delete then supprime_operation;

  exit;  // interfére,ce avec montée baisse
  if ord(Key)=VK_UP then
  begin
    clicListe:=true;
    //with FormModifAction.ListBoxOperations.Items do
    begin
      if clicAction>0 then
      begin
        dec(clicaction);
        Aff_champs(ligneclicAct+1,ClicCond+1,ClicAction+1);
        Formconfig.ListBoxactions.Itemindex:=clicaction;
      end;
    end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    //if clicListe then exit;
    clicListe:=true;
    //with Formconfig.ListBoxactions.Items do
    begin
      if clicaction<nb-1 then
      begin
        inc(clicaction);
        Aff_champs(ligneclicAct+1,ClicCond+1,ClicAction+1);
        Formconfig.ListBoxactions.Itemindex:=clicaction;
      end;
    end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then
  begin
    ListBoxOperations.SelectAll;
  end;

  clicListe:=false;
end;



end.
