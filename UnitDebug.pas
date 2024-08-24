unit UnitDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , ComCtrls, Menus, unitconfig;

type
  TFormDebug = class(TForm)
    SaveDialog: TSaveDialog;
    PopupMenuRE: TPopupMenu;
    copier1: TMenuItem;
    PopupMenuRD: TPopupMenu;
    Copier2: TMenuItem;
    ScrollBoxDebug: TScrollBox;
    RichDebug: TRichEdit;
    ButtonRazTout: TButton;
    ButtonCop: TButton;
    ButtonAffEvtChrono: TButton;
    ButtonCherche: TButton;
    ButtonEcrLog: TButton;
    ButtonRazTampon: TButton;
    ButtonRazLog: TButton;
    MemoEvtDet: TRichEdit;
    GroupBox5: TGroupBox;
    EditSimuDet: TEdit;
    ButtonSimuDet0: TButton;
    ButtonSimuDet1: TButton;
    ButtonSimuAct0: TButton;
    ButtonSimuAct1: TButton;
    GroupBox6: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    EditAdresse: TEdit;
    EditSortie: TEdit;
    Button1: TButton;
    Button0: TButton;
    GroupBoxPrim: TGroupBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    ButtonSigSuiv: TButton;
    ButtonCanSuivSig: TButton;
    EditSigSuiv: TEdit;
    ButtonCP: TButton;
    Button2: TButton;
    GroupBox4: TGroupBox;
    ButtonDetSuiv: TButton;
    EditPrec: TEdit;
    EditActuel: TEdit;
    ButtonElSuiv: TButton;
    GroupBox2: TGroupBox;
    CheckAffSig: TCheckBox;
    CheckBoxEvtDetAig: TCheckBox;
    CheckBoxTraceLIste: TCheckBox;
    CheckTrame: TCheckBox;
    CheckBoxAffFD: TCheckBox;
    CheckBoxAffDebDecSig: TCheckBox;
    EditDebugSignal: TEdit;
    CheckBoxTiers: TCheckBox;
    CheckBox1: TCheckBox;
    CheckDebugTCO: TCheckBox;
    CheckDetSIg: TCheckBox;
    CheckBoxPrinc: TCheckBox;
    LabelTitreDebug: TLabel;
    Label1: TLabel;
    EditNivDebug: TEdit;
    ButtonAigDevie: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonEcrLogClick(Sender: TObject);
    procedure EditNivDebugKeyPress(Sender: TObject; var Key: Char);
    procedure CheckAffSigClick(Sender: TObject);
    procedure ButtonRazTamponClick(Sender: TObject);
    procedure ButtonChercheClick(Sender: TObject);
    procedure ButtonAffEvtChronoClick(Sender: TObject);
    procedure CheckBoxTraceLIsteClick(Sender: TObject);
    procedure CheckTrameClick(Sender: TObject);
    procedure ButtonCopClick(Sender: TObject);
    procedure ButtonRazLogClick(Sender: TObject);
    procedure CheckBoxEvtDetAigClick(Sender: TObject);
    procedure CheckBoxAffFDClick(Sender: TObject);
    procedure CheckBoxAffDebDecSigClick(Sender: TObject);
    procedure ButtonSigSuivClick(Sender: TObject);
    procedure ButtonDetSuivClick(Sender: TObject);
    procedure ButtonCanSuivSigClick(Sender: TObject);
    procedure ButtonCPClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Copier2Click(Sender: TObject);
    procedure RichDebugChange(Sender: TObject);
    procedure ButtonSimuDet0Click(Sender: TObject);
    procedure ButtonSimuDet1Click(Sender: TObject);
    procedure ButtonRazToutClick(Sender: TObject);
    procedure MemoEvtDet1Change(Sender: TObject);
    procedure EditDebugSignalChange(Sender: TObject);
    procedure CheckBoxTiersClick(Sender: TObject);
    procedure ButtonSimuAct1Click(Sender: TObject);
    procedure ButtonSimuAct0Click(Sender: TObject);
    procedure ButtonElSuivClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckDebugTCOClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure MemoEvtDetChange(Sender: TObject);
    procedure CheckDetSIgClick(Sender: TObject);
    procedure CheckBoxPrincClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonAigDevieClick(Sender: TObject);
    procedure ButtonSigPrecClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormDebug: TFormDebug;
  NivDebug,signalDebug,compt_erreur,positionErreur,LigneErreur : integer;
  AffSignal,AffAffect,initform,AffFD,debug_dec_sig,debugTCO,DebugAffiche,AFfDetSIg,
  ProcPrinc : boolean;
  N_event_det : integer;   // index du dernier évènement (de 1 à 20)
  N_Event_tick : integer ; // dernier index


procedure AfficheDebug(s : string;lacouleur : TColor);
procedure AfficheDebug_suivi(s : string;lacouleur : TColor);
procedure RE_ColorLine(ARichEdit: TRichEdit; ARow: Integer; AColor: TColor);
procedure affiche_evt(s: string;lacouleur : TColor);
procedure couleurs_debug;

implementation

uses UnitPrinc;

{$R *.dfm}

procedure RE_ColorLine(ARichEdit : TRichEdit;ARow : Integer;AColor : TColor);
begin
  with ARichEdit do
  begin
    SelStart:=SendMessage(Handle,EM_LINEINDEX,ARow,0);
    SelLength:=Length(Lines[ARow]);
    SelAttributes.Color:=AColor;
    SelLength:=0;
  end;
end;

// affiche un texte coloré dans la fenêtre evt
procedure affiche_evt(s: string;lacouleur : TColor);
begin
  if DebugAffiche then
  with FormDebug.MemoEvtDet do
  begin
    Lines.add(s);
    RE_ColorLine(FormDebug.MemoEvtDet,FormDebug.MemoEvtDet.lines.count-1,lacouleur);
  end;
end;

procedure AfficheDebug(s : string;lacouleur : TColor);
begin
  if debugAffiche then
  with FormDebug.RichDebug do
  begin
    Lines.add(s);
    RE_ColorLine(FormDebug.RichDebug,FormDebug.RichDebug.lines.count-1,lacouleur);
  end;
end;

procedure couleurs_debug;
var c : tcomponent;
    i : integer;
begin
  if sombre then with formdebug do
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      if c is tScrollBox then
      begin
        (c as tScrollBox).Color:=color;
      end;
    end;
  end;
end;

procedure AfficheDebug_suivi(s : string;lacouleur : TColor);
var i : integer;
begin
  if DebugAffiche then
  with formDebug.RichDebug do
  begin
    i:=lines.Count-1;
    s:=lines.Strings[i]+s;
    lines.Strings[i]:=s;
    RE_ColorLine(FormDebug.RichDebug,i,lacouleur);
  end;
end;

procedure TFormDebug.FormCreate(Sender: TObject);
var s: string;
begin
  if affevt or (debug=1) then affiche('FormDebug create',clLime);
  EditNivDebug.Text:='0';
  RichDebug.WordWrap:=false;   // interdit la coupure des chaînes en limite du composant
  RichDebug.color:=$33;
  //constraints.MaxHeight:=800;  // taille Y maxi
  ButtonDetSuiv.Hint:='Renvoie le détecteur suivant aux deux éléments (détecteurs ou aiguillages) '+#13+
                      'suivant la position des aiguillages.'+#13+
                      'Les éléments peuvent ne pas être contigus.'+#13+
                      'detecteur_suivant_El';
  initform:=false;
  visible:=false;
  RichDebug.clear;
  s:=DateToStr(date)+' '+TimeToStr(Time)+' ';
  // l'ascenseur de la fenetre dans D12 ------------
  // ne fonctionne que si le style est windows !!! (bug du VCL)
  // obligé d'utiliser une scrollBox

  DebugAffiche:=true;

  RichDebug.Height:=scrollBoxdebug.Height-30;
  RichDebug.Anchors:=[akLeft,akTop,akRight,akBottom];

  with scrollBoxdebug do
  begin
    Anchors:=[akLeft,akTop,akRight,akBottom];
    VertScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si on clique sur la trackbar!!
    VertScrollBar.Tracking:=true;
    HorzScrollBar.Visible:=false;
    autoScroll:=true;
    autoSize:=false;
  end;

  checkTrame.hint:='Affiche les trames de la centrale XpressNet'+#13+'ou les trames CDM-Rail (COM_IP)';
  checkBoxTiers.hint:='Nécessite d''activer les services'+#13+'"signaux" et "position des trains"'+#13+
                      'dans la configuration générale';

  compt_erreur:=0;
  LigneErreur:=0;
  if debug=1 then Affiche('Fin création fenêtre debug',clLime);
  // && débug=====================
  //CheckBoxEvtDetAig.Checked:=true;
  //CheckTrame.checked:=true;
  // fin debug====================
  couleurs_debug;
end;

procedure TFormDebug.FormActivate(Sender: TObject);
begin
  if affevt then affiche('FormDebug activate',clLime);
  formDebug.buttonCP.Caption:='Etat '+intToSTR(Nb_cantons_Sig)+' cantons précédents signal';
end;


procedure TFormDebug.ButtonEcrLogClick(Sender: TObject);
var s : string;
    i : integer;
    fte : textFile;
begin
  s:=GetCurrentDir;
  SaveDialog.InitialDir:=s;
  SaveDialog.DefaultExt:='txt';
  SaveDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
  if SaveDialog.Execute then
  begin
    s:=SaveDialog.FileName;
    assignFile(fte,s);
    rewrite(fte);
    with RichDebug do
    for i:=0 to Lines.Count do
    begin
      writeln(fte,Lines[i]);
    end;
    closefile(fte);
  end;
end;

procedure TFormDebug.EditNivDebugKeyPress(Sender: TObject; var Key: Char);
  var i,e  : integer;
begin
 if ord(Key)=VK_RETURN then
  begin
    Key:=#0; // prevent beeping
    val(EditNivDebug.text,i,e);
    if e=0 then
    begin
      if (i>=0) and (i<=3) then NivDebug:=i
      else EditNivDebug.text:='3';
    end
    else EditNivDebug.text:='0';
  end; 
  RichDebug.Lines.add('Niveau='+intToSTR(NivDebug));
end;


procedure TFormDebug.CheckAffSigClick(Sender: TObject);
begin
  AffSignal:=checkAffSig.Checked;
end;

procedure TFormDebug.ButtonRazTamponClick(Sender: TObject);
begin
   N_event_det:=0;
   Event_det[1].adresse:=0;
   MemoEvtDet.Clear;
   memoEvtDet.Refresh;
end;

procedure TFormDebug.ButtonChercheClick(Sender: TObject);
var i,l,positionErreur : integer;
    s : string;
    trouve : boolean;
begin
  with RichDebug do
  begin
    ligneErreur:=0;
    repeat
      s:=lowercase(Lines[ligneErreur]);
      positionErreur:=pos('erreur',s);
      trouve:=positionErreur<>0;
      inc(LigneErreur);
    until (LigneErreur>=Lines.Count) or trouve;

    if trouve then
    begin
      inc(compt_erreur);
      //Affiche('trouvé en '+Lines[ligneErreur-1],clred);
      l:=0;
      for i:=0 to ligneErreur-1 do
      begin
        l:=l+length(Lines[i])+2;
      end;
      SelStart:= l-length(s)+positionErreur-3;
      SelLength:=6;
      SetFocus;      // afficher la sélection
      Perform(EM_SCROLLCARET,0,0); // et scroller à l'endroit de la sélection
    end
    else
    begin
      LigneErreur:=0;
    end;
  end;
end;

procedure TFormDebug.ButtonAffEvtChronoClick(Sender: TObject);
var i,j,etat : integer;
    s : string;
    typ : Tequipement;
begin
  RichDebug.Clear;
  if N_event_tick=0 then
  begin
    AfficheDebug('Il n''y a aucun évènement détecteur ou aiguillage',clyellow);
    exit;
  end;
  s:='Evts chronologiques det aig du '+DateToStr(date)+' '+TimeToStr(Time)+' '+s;
  AfficheDebug(s,clLime);

  for i:=1 to N_Event_tick do
  begin
    begin
      j:=event_det_tick[i].adresse;
      etat:=event_det_tick[i].etat;
      if j<>-1 then
      begin
        s:=IntToSTR(i)+' Tick='+IntToSTR(event_det_tick[i].tick);
        typ:=event_det_tick[i].modele;
        if typ=det then s:=s+' Det=';
        if typ=aig then s:=s+' Aig=';
        if typ=act then s:=s+' Act=';
        s:=s+IntToSTR(j)+'='+intToSTR(etat);
        AfficheDebug(s,clyellow);
      end;
    end;
  end;
  AfficheDebug('-----------------------------',cllime);
end;


procedure TFormDebug.CheckBoxTraceLIsteClick(Sender: TObject);
begin
  TraceListe:=CheckBoxTraceLIste.checked;
end;

procedure TFormDebug.CheckTrameClick(Sender: TObject);
begin
  traceTrames:=CheckTrame.Checked;
end;

procedure TFormDebug.ButtonCopClick(Sender: TObject);
begin
  RichDebug.Lines:=Formprinc.FenRich.lines;
end;

procedure TFormDebug.ButtonRazLogClick(Sender: TObject);
begin
  RichDebug.Clear;
end;

procedure TFormDebug.CheckBoxEvtDetAigClick(Sender: TObject);
begin
  AffAigDet:=CheckBoxEvtDetAig.checked;
end;

procedure TFormDebug.CheckBoxAffFDClick(Sender: TObject);
begin
  AffFD:=CheckBoxAffFD.checked;
end;

procedure TFormDebug.CheckBoxAffDebDecSigClick(Sender: TObject);
begin
  debug_dec_sig:=CheckBoxAffDebDecSig.checked;
end;


procedure TFormDebug.ButtonSigSuivClick(Sender: TObject);
var adr,erreur,ancdebug,AdrSigSuivant : integer ;
begin
  Val(EditSigSuiv.Text,adr,erreur);
  if (erreur<>0) or (adr<1) then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  etat_signal_suivant(Adr,1,AdrSigSuivant) ;
  NivDebug:=AncDebug;
end;

procedure TFormDebug.ButtonDetSuivClick(Sender: TObject);
var Adr,Prec,Actuel,erreur,ancdebug : integer ;
    type1,type2 : tequipement;
    s1,s2 : string;
begin
  ancdebug:=NivDebug;
  NivDebug:=3;
  s1:=EditPrec.Text;
  s2:=EditActuel.Text;
  if (s1='') or (s2='') then begin NivDebug:=AncDebug;exit;end;
  if s1[1]='A' then begin type1:=aig;delete(s1,1,1);end else type1:=det;
  if s2[1]='A' then begin type2:=aig;delete(s2,1,1);end else type2:=det;
  Val(s1,prec,erreur);
  if prec=0 then type1:=buttoir;
  if (erreur<>0) or (prec<0) then begin NivDebug:=AncDebug;exit;end;
  Val(s2,Actuel,erreur);
  if (erreur<>0) or (actuel<1) then begin NivDebug:=AncDebug;exit;end;
  Adr:=detecteur_suivant_El(prec,type1,actuel,type2,1);
  if Adr<9996 then AfficheDebug('Le détecteur suivant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel)+' est '+IntToSTR(Adr),clyellow)
  else AfficheDebug('Pas trouvé de détecteur suvant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel),clyellow);
  NivDebug:=AncDebug;
end;

procedure TFormDebug.ButtonCanSuivSigClick(Sender: TObject);
var Adr,erreur,ancdebug : integer ;
begin
  Val(EditSigSuiv.Text,Adr,erreur);
  if (erreur<>0) or (adr<1) then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  if test_memoire_zones(Adr) then AfficheDebug('Présence train',clYellow) else
    AfficheDebug('Absence train',clyellow);
  NivDebug:=AncDebug;
end;


procedure TFormDebug.ButtonCPClick(Sender: TObject);
var Adr,erreur,ancdebug,adrtrain,voie : integer ;
begin
  Val(EditSigSuiv.Text,Adr,erreur);
  if (erreur<>0) or (adr<1) then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  if PresTrainPrec(Adr,Nb_cantons_Sig,false,adrtrain,voie) then AfficheDebug('Présence train '+intToSTR(AdrTrain),clYellow) else
    AfficheDebug('Absence train',clyellow);
  NivDebug:=AncDebug;
end;

procedure TFormDebug.Button2Click(Sender: TObject);
var Adr,erreur,ancdebug,train : integer ;
    reservetraintiers : boolean;
begin
  Val(EditSigSuiv.Text,Adr,erreur);
  if (erreur<>0) or (Adr<1) then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  Cond_Carre(Adr);
  carre_signal(adr,0,reservetraintiers,train);
  NivDebug:=AncDebug;
end;

procedure TFormDebug.Copier2Click(Sender: TObject);
begin
  RichDebug.SelectAll;
  RichDebug.CopyToClipboard;
  RichDebug.SetFocus;
end;

// pour déplacer l'ascenseur de l'affichage automatiquement en bas
procedure TFormDebug.RichDebugChange(Sender: TObject);
begin
  SendMessage(RichDebug.handle,WM_VSCROLL,SB_BOTTOM,0);
end;

procedure TFormDebug.ButtonSimuDet0Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if (erreur=0) and (det>0) then Event_Detecteur(det,false,'');
end;

procedure TFormDebug.ButtonSimuDet1Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if (erreur=0) and (det>0) then Event_Detecteur(det,true,'');
end;

procedure TFormDebug.ButtonSimuAct1Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if (erreur=0) and (det>0) then Event_Act(det,0,1,'');
end;

procedure TFormDebug.ButtonSimuAct0Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if (erreur=0) and (det>0)  then Event_Act(det,0,0,'');
end;

procedure TFormDebug.ButtonRazToutClick(Sender: TObject);
begin
  AfficheDebug('Raz tous trains et routes',clLime);
  Raz_tout;
end;

procedure TFormDebug.MemoEvtDet1Change(Sender: TObject);
begin
  SendMessage(MemoEvtDet.handle,WM_VSCROLL,SB_BOTTOM,0);
end;

procedure TFormDebug.EditDebugSignalChange(Sender: TObject);
var erreur : integer;
begin
  val(EditDebugSignal.text,signalDebug,erreur);
end;

procedure TFormDebug.CheckBoxTiersClick(Sender: TObject);
begin
  AffTiers:=checkBoxTiers.checked;
end;

procedure TFormDebug.ButtonElSuivClick(Sender: TObject);
var Adr,Prec,Actuel,erreur,ancdebug : integer ;
    type1,type2 : tequipement;
    s1,s2,s : string;
begin
  ancdebug:=NivDebug;
  NivDebug:=3;
  s1:=EditPrec.Text;
  s2:=EditActuel.Text;
  if (s1='') or (s2='') then begin NivDebug:=AncDebug;exit;end;
  if s1[1]='A' then begin type1:=aig;delete(s1,1,1);end else type1:=det;
  if s2[1]='A' then begin type2:=aig;delete(s2,1,1);end else type2:=det;
  Val(s1,prec,erreur);
  if (erreur<>0) or (prec<0) then begin NivDebug:=AncDebug;exit;end;
  if prec=0 then type1:=buttoir;
  Val(s2,Actuel,erreur);
  if (erreur<>0) or (actuel<1) then begin NivDebug:=AncDebug;exit;end;;
  Adr:=suivant_Alg3(prec,type1,actuel,type2,1);
  if Adr<9995 then
  begin
    s:='L''élément suivant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel)+' est '+IntToSTR(Adr)+' ';
    s:=s+BTypeToChaine(typeGen);
    AfficheDebug(s,clYellow);
  end
  else AfficheDebug('Pas trouvé d''élement suivant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel),clyellow);
  NivDebug:=AncDebug;
end;

procedure TFormDebug.CheckBox1Click(Sender: TObject);
begin
  dupliqueEvt:=CheckBox1.checked;
end;

procedure TFormDebug.CheckDebugTCOClick(Sender: TObject);
begin
  debugTCO:=checkDebugTCO.checked;
end;

procedure TFormDebug.Button1Click(Sender: TObject);
var adr,sortie,erreur,groupe : integer;
    fonction : byte;
    s : string;
begin
  val(EditAdresse.text,adr,erreur);
  if (erreur<>0) or (adr<1) or (adr>2048) then
  begin
    EditAdresse.text:='1';
    exit;
  end;
  val(EditSortie.text,sortie,erreur);
  if (sortie<1) or (sortie>2) then
  begin
    EditSortie.text:='1';
    exit;
  end;

  s:='Accessoire '+IntToSTR(adr)+' ; sortie '+intToSTR(sortie)+' à 1';
  AfficheDebug(s,clyellow);

  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    s:=chaine_CDM_Acc(adr,sortie);
    envoi_CDM(s);
  end;
  
  // pilotage par USB ou par éthernet de la centrale ------------
  if (hors_tension=false) and (portCommOuvert or parSocketLenz) then
  begin
    if protocole=1 then
    begin
      groupe:=(adr-1) div 4;
      fonction:=((adr-1) mod 4)*2 + (sortie-1);
      // pilotage à 1
      s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
      s:=checksum(s);
      envoi(s);     // envoi de la trame et attente Ack
    end;
    if protocole=2 then AfficheDebug('D10: Commande DCC++ pas encore implantée',clred);
  end;

  Self.ActiveControl:=nil;
end;

procedure TFormDebug.Button0Click(Sender: TObject);
var adr,sortie,erreur,groupe : integer;
    fonction : byte;
    s : string;
begin
  val(EditAdresse.text,adr,erreur);
  if (erreur<>0) or (adr<1) or (adr>2048) then
  begin
    EditAdresse.text:='1';
    exit;
  end;
  val(EditSortie.text,sortie,erreur);
  if (sortie<1) or (sortie>2) then
  begin
    EditSortie.text:='1';
    exit;
  end;

  s:='Accessoire '+IntToSTR(adr)+' ; sortie '+intToSTR(sortie)+' à 0';
  AfficheDebug(s,clyellow);

  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    s:=chaine_CDM_Acc(adr,0);
    envoi_CDM(s);
  end;

  // pilotage par USB ou par éthernet de la centrale ------------
  if (hors_tension=false) and (portCommOuvert or parSocketLenz) then
  begin
    if protocole=1 then
    begin
      groupe:=(adr-1) div 4;
      fonction:=((adr-1) mod 4)*2 + (sortie-1);
      // pilotage à 0
      s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
      s:=checksum(s);
      envoi(s);     // envoi de la trame et attente Ack
    end;
    if protocole=2 then AfficheDebug('D11 Commande DCC++ pas encore implantée',clred)
  end;

  Self.ActiveControl:=nil;
end;

procedure TFormDebug.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

procedure TFormDebug.MemoEvtDetChange(Sender: TObject);
begin
  SendMessage(MemoEvtDet.handle,WM_VSCROLL,SB_BOTTOM,0);
end;

procedure TFormDebug.CheckDetSIgClick(Sender: TObject);
begin
  AFfDetSIg:=checkDetSig.checked;
end;


procedure TFormDebug.CheckBoxPrincClick(Sender: TObject);
begin
  ProcPrinc:=checkBoxPrinc.checked;
end;





procedure TFormDebug.Button3Click(Sender: TObject);
begin
  ScrollBoxDebug.VertScrollBar.Position:=0;
end;


procedure TFormDebug.ButtonAigDevieClick(Sender: TObject);
var Adr,erreur,ancDebug : integer;
begin
  Val(EditSigSuiv.Text,Adr,erreur);
  if (erreur<>0) or (Adr<1) then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  Aiguille_deviee(Adr);
  NivDebug:=AncDebug;
end;

procedure TFormDebug.ButtonSigPrecClick(Sender: TObject);
var Adr,erreur,ancDebug : integer;
begin
  Val(EditSigSuiv.Text,Adr,erreur);
  if (erreur<>0) or (Adr<1) then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  erreur:=Signal_Precedent(Adr);
  NivDebug:=AncDebug;
  AfficheDebug('signal précédent='+intToSTR(erreur),clyellow);
end;

end.
