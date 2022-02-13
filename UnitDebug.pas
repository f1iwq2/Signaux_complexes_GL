unit UnitDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , ComCtrls, Menus;

type
  TFormDebug = class(TForm)
    EditNivDebug: TEdit;
    Label1: TLabel;
    MemoEvtDet: TMemo;
    Label2: TLabel;
    SaveDialog: TSaveDialog;
    ButtonEcrLog: TButton;
    ButtonRazTampon: TButton;
    ButtonCherche: TButton;
    ButtonAffEvtChrono: TButton;
    ButtonCop: TButton;
    RichEdit: TRichEdit;
    PopupMenuRE: TPopupMenu;
    copier1: TMenuItem;
    ButtonRazLog: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckAffSig: TCheckBox;
    CheckBoxEvtDetAig: TCheckBox;
    CheckBoxTraceLIste: TCheckBox;
    CheckTrame: TCheckBox;
    CheckBoxAct: TCheckBox;
    CheckBoxAffFD: TCheckBox;
    CheckBoxAffDebDecSig: TCheckBox;
    GroupBox3: TGroupBox;
    ButtonSigSuiv: TButton;
    ButtonCanSuivSig: TButton;
    EditSigSuiv: TEdit;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    ButtonDetSuiv: TButton;
    EditPrec: TEdit;
    EditActuel: TEdit;
    Button1: TButton;
    Button2: TButton;
    RichDebug: TRichEdit;
    PopupMenuRD: TPopupMenu;
    Copier2: TMenuItem;
    GroupBox5: TGroupBox;
    ButtonSimuDet0: TButton;
    ButtonSimuDet1: TButton;
    EditSimuDet: TEdit;
    ButtonRazTout: TButton;
    EditDebugSignal: TEdit;
    CheckBoxTiers: TCheckBox;
    ButtonSimuAct0: TButton;
    ButtonSimuAct1: TButton;
    CheckDebugTrames: TCheckBox;
    ButtonElSuiv: TButton;
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
    procedure copier1Click(Sender: TObject);
    procedure ButtonRazLogClick(Sender: TObject);
    procedure CheckBoxActClick(Sender: TObject);
    procedure CheckBoxEvtDetAigClick(Sender: TObject);
    procedure CheckBoxAffFDClick(Sender: TObject);
    procedure CheckBoxAffDebDecSigClick(Sender: TObject);
    procedure ButtonSigSuivClick(Sender: TObject);
    procedure ButtonDetSuivClick(Sender: TObject);
    procedure ButtonCanSuivSigClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Copier2Click(Sender: TObject);
    procedure RichDebugChange(Sender: TObject);
    procedure ButtonSimuDet0Click(Sender: TObject);
    procedure ButtonSimuDet1Click(Sender: TObject);
    procedure ButtonRazToutClick(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure MemoEvtDetChange(Sender: TObject);
    procedure EditDebugSignalChange(Sender: TObject);
    procedure CheckBoxTiersClick(Sender: TObject);
    procedure ButtonSimuAct1Click(Sender: TObject);
    procedure ButtonSimuAct0Click(Sender: TObject);
    procedure CheckDebugTramesClick(Sender: TObject);
    procedure ButtonElSuivClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

Const
Max_Event_det_tick=30000;
Max_event_det=400;
Max_Trains=50;

var
  FormDebug: TFormDebug;
  NivDebug,signalDebug : integer;
  AffSignal,AffAffect,initform,AffFD,debug_dec_sig : boolean;
  N_event_det : integer; // index du dernier évènement (de 1 à 20)
  event_det : array[1..Max_event_det] of integer;
  event_det_train : array[1..Max_Trains] of record
                    NbEl : integer;
                    Det : array[1..3] of integer; // tableau des evts détecteurs par train
                    end;
  N_Event_tick : integer ; // dernier index

  // tableau des évènements détecteurs et aiguillages
  event_det_tick : array[0..Max_Event_det_tick] of
     record
       tick : longint;
       detecteur : integer ;
       Aiguillage : integer ;
       actionneur : integer;
       objet : integer;  // numéro d'objet dans CDM
       etat : integer ; // état du détecteur de l'aiguillage ou de l'actionneur
       traite : boolean;  // traité lors de a recherche d'une route
     end;

  
procedure AfficheDebug(s : string;lacouleur : TColor);
Procedure Raz_tout;
procedure RE_ColorLine(ARichEdit: TRichEdit; ARow: Integer; AColor: TColor);
  
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

procedure AfficheDebug(s : string;lacouleur : TColor);
begin
  with FormDebug.RichDebug do
  begin
    Lines.add(s);
    RE_ColorLine(FormDebug.RichDebug,FormDebug.RichDebug.lines.count-1,lacouleur);
  end;  
end;

Procedure Raz_tout;
var i : integer;
begin
  N_Event_tick:=0;
  N_event_det:=0;
  N_trains:=0;
  Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);
  for i:=1 to Max_Trains do Event_det_Train[i].NbEl:=0;
  i_simule:=0;
  FormDebug.MemoEvtDet.Clear;
  FormDebug.Richedit.Clear;
end;

procedure TFormDebug.FormCreate(Sender: TObject);
var s: string;
begin
  EditNivDebug.Text:='0';
  s:='Cette fenêtre permet d''afficher des informations sur le ';
  s:=s+'comportement du programme. Positionner le niveau du débug de 1 à 3 pour';
  s:=s+' afficher des informations plus ou moins détaillées.';
  RichEdit.Lines.add(s);
  RichDebug.WordWrap:=false;   // interdit la coupure des chaînes en limite du composant
  RichDebug.color:=$33;
  initform:=false;
  RichDebug.clear;
  s:=DateToStr(date)+' '+TimeToStr(Time)+' ';
  if IsWow64Process then s:=s+' OS 64 Bits' else s:=s+' OS 32 Bits';
  RichEdit.color:=$111122;
  RichDebug.Lines.add(s);
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
    writeln(fte,s);
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
 if ord(Key) = VK_RETURN then
  begin
    Key := #0; // prevent beeping
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
   Event_det[1]:=0;
   MemoEvtDet.Clear;
   memoEvtDet.Refresh;
end;

procedure TFormDebug.ButtonChercheClick(Sender: TObject);
var i : integer;
    trouve : boolean;
begin

  with RichDebug do
  begin
    i:=0;
    repeat
      trouve:=pos('erreur',uppercase(Lines[i]))<>0;
      inc(i);
    until (i>=Lines.Count) or trouve;
    if trouve then
    begin
    Affiche('trouvé en '+intToSTR(i),clyellow);
    SelStart := I - 1;
    SelLength := Length('erreur');
    SetFocus;
    end;
  end;
end;

procedure TFormDebug.ButtonAffEvtChronoClick(Sender: TObject);
var i,j,etat : integer;
    s : string;
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
      j:=event_det_tick[i].detecteur;
      etat:=event_det_tick[i].etat;
      if j<>-1 then
      begin
        s:=IntToSTR(i)+' Tick='+IntToSTR(event_det_tick[i].tick)+' Det='+IntToSTR(j)+'='+intToSTR(etat);
        AfficheDebug(s,clyellow);
      end;
    end;

    j:=event_det_tick[i].aiguillage;
    if j<>-1 then
    begin
      s:=IntToSTR(i)+' Tick='+IntToSTR(event_det_tick[i].tick)+' Aig='+IntToSTR(j)+'='+intToSTR(event_det_tick[i].etat);
      AfficheDebug(s,clyellow);
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
var i : integer;
begin
  RichDebug.Lines:=Formprinc.FenRich.lines;
end;

procedure TFormDebug.copier1Click(Sender: TObject);
begin
  RichEdit.SelectAll;
  RichEdit.CopyToClipboard;
  RichEdit.SetFocus;
end;

procedure TFormDebug.ButtonRazLogClick(Sender: TObject);
begin
  RichDebug.Clear;
end;

procedure TFormDebug.CheckBoxActClick(Sender: TObject);
begin
  AffActionneur:=CheckBoxAct.Checked;
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
var adr,erreur,ancdebug : integer ;
begin
  ancdebug:=NivDebug;
  NivDebug:=3;
  Val(EditSigSuiv.Text,adr,erreur);
  if erreur<>0 then exit;
  etat_signal_suivant(Adr,1) ;
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
  if (s1='') or (s2='') then exit;
  if s1[1]='A' then begin type1:=aig;delete(s1,1,1);end else type1:=det;
  if s2[1]='A' then begin type2:=aig;delete(s2,1,1);end else type2:=det;
  Val(s1,prec,erreur); if erreur<>0 then exit;
  Val(s2,Actuel,erreur); if erreur<>0 then exit;
  Adr:=detecteur_suivant_El(prec,type1,actuel,type2,1);
  if Adr<9996 then AfficheDebug('Le détecteur suivant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel)+' est '+IntToSTR(Adr),clyellow)
  else AfficheDebug('Pas trouvé de détecteur suvant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel),clyellow); 
  NivDebug:=AncDebug;
end;

procedure TFormDebug.ButtonCanSuivSigClick(Sender: TObject);
var Adr,erreur,ancdebug : integer ;
begin
  ancdebug:=NivDebug;
  NivDebug:=3;
  Val(EditSigSuiv.Text,Adr,erreur); if erreur<>0 then exit;
  test_memoire_zones(Adr);
  NivDebug:=AncDebug;
end;



procedure TFormDebug.Button1Click(Sender: TObject);
var Adr,erreur,ancdebug : integer ;
begin
  Val(EditSigSuiv.Text,Adr,erreur); if erreur<>0 then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  PresTrainPrec(Adr);
  NivDebug:=AncDebug;
end;

procedure TFormDebug.Button2Click(Sender: TObject);
var Adr,erreur,ancdebug : integer ;
begin
  Val(EditSigSuiv.Text,Adr,erreur); if erreur<>0 then exit;
  ancdebug:=NivDebug;
  NivDebug:=3;
  Cond_Carre(Adr);
  carre_signal(adr);
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
  SendMessage(RichDebug.handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFormDebug.ButtonSimuDet0Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if erreur=0 then
  begin
    Event_Detecteur(det,false,'');
  end;
end;
  

procedure TFormDebug.ButtonSimuDet1Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if erreur=0 then
  begin
    Event_Detecteur(det,true,'');
  end;
end;


procedure TFormDebug.ButtonSimuAct1Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if erreur=0 then
  begin
    Event_Act(det,1,'');
  end;
end;

procedure TFormDebug.ButtonSimuAct0Click(Sender: TObject);
var det,erreur : integer;
begin
  val(EditSimuDet.Text,det,erreur);
  if erreur=0 then
  begin
    Event_Act(det,0,'');
  end;
end;

procedure TFormDebug.ButtonRazToutClick(Sender: TObject);
begin
  Raz_tout;
end;

procedure TFormDebug.RichEditChange(Sender: TObject);
begin
  SendMessage(RichEdit.handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFormDebug.MemoEvtDetChange(Sender: TObject);
begin
  SendMessage(MemoEvtDet.handle, WM_VSCROLL, SB_BOTTOM, 0);
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


procedure TFormDebug.CheckDebugTramesClick(Sender: TObject);
begin
  debugtrames:=checkDebugTrames.checked;
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
  if (s1='') or (s2='') then exit;
  if s1[1]='A' then begin type1:=aig;delete(s1,1,1);end else type1:=det;
  if s2[1]='A' then begin type2:=aig;delete(s2,1,1);end else type2:=det;
  Val(s1,prec,erreur); if erreur<>0 then exit;
  Val(s2,Actuel,erreur); if erreur<>0 then exit;
  Adr:=suivant_Alg3(prec,type1,actuel,type2,1);
  if Adr<9996 then 
  begin
    s:='L''élément suivant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel)+' est '+IntToSTR(Adr)+' ';
    case typeGen of
    aig : s:=s+'aiguillage';
    tjd : s:=s+'tjd';
    tjs : s:=s+'tjs';
    triple : s:=s+'triple';
    det : s:=s+'détecteur';
    buttoir : s:=s+'buttoir';
    end;
    AfficheDebug(s,clYellow);
  end  
  else AfficheDebug('Pas trouvé d''élement suvant aux éléments '+IntToSTR(prec)+'/'+IntToSTR(actuel),clyellow); 
  NivDebug:=AncDebug;

end;

end.
