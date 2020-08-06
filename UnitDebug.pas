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
    Label3: TLabel;
    MemoDebug: TMemo;
    CheckAffSig: TCheckBox;
    ButtonRazTampon: TButton;
    ButtonCherche: TButton;
    ButtonAffEvtChrono: TButton;
    CheckBoxTraceLIste: TCheckBox;
    CheckTrame: TCheckBox;
    ButtonCop: TButton;
    RichEdit: TRichEdit;
    PopupMenuRE: TPopupMenu;
    copier1: TMenuItem;
    ButtonRazLog: TButton;
    CheckBoxAct: TCheckBox;
    CheckBoxEvtDetAig: TCheckBox;
    CheckBoxAffFD: TCheckBox;
    CheckBoxAffDebDecSig: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

Const 
Max_Event_det_tick=10000;
Max_event_det=400;
Max_Trains=50;

var
  FormDebug: TFormDebug;
  NivDebug : integer;
  AffSignal,AffAffect,initform,AffFD,debug_dec_sig : boolean;
  N_event_det : integer; // index du dernier évènement (de 1 à 20)
  event_det : array[1..Max_event_det] of integer;
  event_det_train : array[1..Max_Trains] of record
                    NbEl : integer;
                    Det : array[1..3] of integer; // tableau des evts détecteurs par train
                    end;
  //                    tick 1/10s,détecteur
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
procedure RE_ColorLine(ARichEdit: TRichEdit; ARow: Integer; AColor: TColor);
  
implementation

uses UnitPrinc;

{$R *.dfm}

procedure AfficheDebug(s : string;lacouleur : TColor);
begin
  FormDebug.MemoDebug.Lines.add(s);
end;

procedure TFormDebug.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := TCloseAction.caNone;
  //DebugOuv:=False;
  //NivDebug:=0;
end;

procedure RE_ColorLine(ARichEdit : TRichEdit;ARow : Integer;AColor : TColor);
begin
  with ARichEdit do
  begin
    SelStart:=SendMessage(Handle,EM_LINEINDEX,ARow-1,0);
    SelLength:=Length(Lines[ARow-1]);
    SelAttributes.Color:=AColor;
    SelLength:=0;
  end;
end;

procedure TFormDebug.FormCreate(Sender: TObject);
var s: string;
    i : integer;
begin
  EditNivDebug.Text:='0';
  s:='Cette fenêtre permet d''afficher des informations sur le ';
  s:=s+'comportement du programme. Positionner le niveau de 1 à 3 pour';
  s:=s+' afficher des informations plus ou moins détaillées.';
  Label3.caption:=s;
  MemoDebug.WordWrap:=false;   // interdit la coupure des chaînes en limite du composant
  MemoDebug.color:=$33;
  initform:=false;
  MemoDebug.clear;
  s:=DateToStr(date)+' '+TimeToStr(Time)+' ';
  if IsWow64Process then s:=s+' OS 64 Bits' else s:=s+' OS 32 Bits';
  RichEdit.color:=$111122;
  MemoDebug.Lines.add(s);
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
    with MemoDebug do
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
  MemoDebug.Lines.add('Niveau='+intToSTR(NivDebug));
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

  with MemoDebug do
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
  MemoDebug.Clear;
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
  trace:=CheckTrame.Checked;
end;

procedure TFormDebug.ButtonCopClick(Sender: TObject);
var i : integer;
begin
  MemoDebug.Lines:=Formprinc.ListBox1.Items
end;



procedure TFormDebug.copier1Click(Sender: TObject);
begin
  RichEdit.SelectAll;
  RichEdit.CopyToClipboard;
  RichEdit.SetFocus;
end;

procedure TFormDebug.ButtonRazLogClick(Sender: TObject);
begin
  MemoDebug.Clear;
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


end.
