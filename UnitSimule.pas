unit UnitSimule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UnitPrinc;

type
  TFormSimulation = class(TForm)
    ButtonCharge: TButton;
    OpenDialog: TOpenDialog;
    EditIntervalle: TEdit;
    Label1: TLabel;
    CheckAffTick: TCheckBox;
    CheckEvalroutes: TCheckBox;
    procedure ButtonChargeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditIntervalleKeyPress(Sender: TObject; var Key: Char);
    procedure EditIntervalleChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSimulation: TFormSimulation;
  Intervalle    : integer;

procedure ouvre_simulation(nomfichier : string);

implementation

{$R *.dfm}

procedure ouvre_simulation(nomfichier : string);
var s: string;
   fte : text;
   i,k,erreur : integer;
   sortie : boolean;
begin
  assignFile(fte,nomfichier);
  {$I+}
  try
    reset(fte);
  except
    Affiche('Fichier '+nomFichier+' incorrect',clred);
    exit;
  end;
  index_simule:=1;
  sortie:=false;
  while not(eof(fte)) and not(sortie) do
  begin
    readln(fte,s);
    s:=Uppercase(s);
    i:=pos('TICK=',s);
    if i<>0 then
    begin
      Delete(s,1,i+4);
      val(s,k,erreur);
      //if intervalle<>0 then k:=Index_Simule*Intervalle+tick+30 else   // démarre dans 3s
      //  k:=Index_Simule+tick+30 ;
      Tablo_simule[index_simule].tick:=k;
        // détecteur?
      i:=pos('DET',s);
      if i<>0 then
      begin
        Delete(s,1,i+2);
        if s[1]='=' then delete(s,1,1);
        if s[1]=' ' then delete(s,1,1);
        val(s,k,erreur);
        Tablo_simule[index_simule].adresse:=k;
        Tablo_simule[index_simule].modele:=det;
        i:=pos('=',s);
        if i<>0 then
        begin
          Delete(s,1,i);
          val(s,k,erreur);
          Tablo_simule[index_simule].etat:=k;
            {s:=IntToSTR(Index_simule)+' Tick='+intToSTR(Tablo_simule[index_simule].tick)+
             ' Detecteur='+intToSTR(Tablo_simule[index_simule].Adresse)+
             '='+intToSTR(Tablo_simule[index_simule].etat);
            Affiche(s,ClLime); }
            inc(index_simule);
        end;
      end;
        // aiguillage?
      i:=pos('AIG',s);
      if i<>0 then
      begin
        Delete(s,1,i+2);
        if s[1]='=' then delete(s,1,1);
        if s[1]=' ' then delete(s,1,1);
        val(s,k,erreur);
        Tablo_simule[index_simule].adresse:=k;
        Tablo_simule[index_simule].modele:=aig;
        i:=pos('=',s);
        if i<>0 then
        begin
          Delete(s,1,i);
          val(s,k,erreur);
          if (k=1) or (k=2) then Tablo_simule[index_simule].etat:=k
          else Affiche('Erreur 622 : Position aiguillage '+intToSTR(Tablo_simule[index_simule].adresse)+' inconnue dans le fichier de simulation',clred);
            {s:=IntToSTR(Index_simule)+' Tick='+intToSTR(Tablo_simule[index_simule].tick)+
            ' Aiguillage='+intToSTR(Tablo_simule[index_simule].adresse)+
             '='+intToSTR(Tablo_simule[index_simule].etat);
          Affiche(s,ClLime);   }
            inc(index_simule);
        end;
      end;
    end;
    Application.ProcessMessages;
    sortie:=eof(fte) or (index_simule>Max_Simule) or (pos('STOP',s)<>0);
  end ;
  if index_simule>Max_Simule then Affiche('Tableau maximal atteint',clred);
  Affiche('Intervalle='+intToSTR(intervalle),clyellow);
  dec(index_simule);   //maxi
  closeFile(fte);
  formprinc.ButtonArretSimu.Visible:=true;
  i_simule:=1;
  SauvefiltrageDet0:=filtrageDet0;
  filtrageDet0:=0;
  FormSimulation.Close;
  Affiche('Fichier simulation : '+Nomfichier ,clyellow);
end;

procedure TFormSimulation.ButtonChargeClick(Sender: TObject);
var s : string;
begin
  s:=GetCurrentDir;
  s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  OpenDialog.InitialDir:=s;
  OpenDialog.DefaultExt:='txt';
  OpenDialog.Title:='Ouvrir un fichier de simulation';
  OpenDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
  if openDialog.Execute then
  begin
    if checkAffTick.Checked then raz_tout;
    if checkEvalRoutes.Checked then TraceListe:=true;
    s:=openDialog.FileName;
    ouvre_simulation(s);
  end;
end;

procedure TFormSimulation.FormCreate(Sender: TObject);
begin
  Intervalle:=0;
  EditIntervalle.Text:=IntToSTR(Intervalle);
end;


procedure TFormSimulation.EditIntervalleKeyPress(Sender: TObject;var Key: Char);
var erreur : integer;
begin
  Val(EditIntervalle.Text,intervalle,erreur);
  if (intervalle<0) then Intervalle:=1;
end;

procedure TFormSimulation.EditIntervalleChange(Sender: TObject);
var erreur : integer;
begin
  Val(EditIntervalle.Text,intervalle,erreur);
  if (intervalle<0) then Intervalle:=1;
end;

begin
end.
