unit UnitDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , ComCtrls;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonEcrLogClick(Sender: TObject);
    procedure EditNivDebugKeyPress(Sender: TObject; var Key: Char);
    procedure CheckAffSigClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormDebug: TFormDebug;
  NivDebug : integer;
  AffSignal : boolean;

procedure AfficheDebug(s : string;lacouleur : TColor);
  
implementation

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

procedure TFormDebug.FormCreate(Sender: TObject);
var s: string;
begin
  EditNivDebug.Text:='0';
  s:='Cette fenêtre permet d''afficher des informations sur le ';
  s:=s+'comportement du programme. Positionner le niveau de 1 à 3 pour';
  s:=s+' afficher des informations plus ou moins détaillées.';
  Label3.caption:=s;
  MemoDebug.color:=$33;
  MemoDebug.clear;
end;

procedure TFormDebug.ButtonEcrLogClick(Sender: TObject);
var s : string;
    i : integer;
    fte : textFile;
begin
  s:=GetCurrentDir;
  SaveDialog.InitialDir:=s;
  if SaveDialog.Execute then
  begin
    s:=SaveDialog.FileName;
    assignFile(fte,s);
    rewrite(fte);
     writeln(fte,s);
    with MemoDebug do
    for i:=1 to Lines.Count do
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

end.
