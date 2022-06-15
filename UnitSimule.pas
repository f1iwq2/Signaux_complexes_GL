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
  AffTickSimu   : boolean;

implementation

{$R *.dfm}

procedure TFormSimulation.ButtonChargeClick(Sender: TObject);
var s,nF : string;
   fte : textFile;
   i,k,erreur : integer;
   sortie : boolean;
begin
  AffTickSimu:= checkAffTick.Checked;
  s:=GetCurrentDir;
  s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  OpenDialog.InitialDir:=s;
  OpenDialog.DefaultExt:='txt';
  OpenDialog.Title:='Ouvrir un fichier de simulation';
  OpenDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
  if openDialog.Execute then
  begin
    nF:=openDialog.FileName;
    assignFile(fte,nF);
    reset(fte);
    index_simule:=1;
    repeat
      readln(fte,s);
      //Affiche(s,clLime);
      i:=pos('Tick=',s);
      if i<>0 then
      begin
        Delete(s,1,i+4);
        val(s,k,erreur);
        if intervalle<>0 then k:=Index_Simule*Intervalle*10+tick+30 else   // démarre dans 3s
          k:=Index_Simule+tick+30 ;
        Tablo_simule[index_simule].tick:=k;

        // détecteur?
        i:=pos('Det',s);
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

            //s:=IntToSTR(Index_simule)+' Tick='+intToSTR(Tablo_simule[index_simule].tick)+
            //   ' Detecteur='+intToSTR(Tablo_simule[index_simule].detecteur)+
            //   '='+intToSTR(Tablo_simule[index_simule].etat);
            //Affiche(s,ClLime);

            inc(index_simule);
          end;
        end;

        // aiguillage?
        i:=pos('Aig',s);
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
      sortie:=eof(fte) or (index_simule>Max_Simule);
    until sortie ;
    if index_simule>Max_Simule then Affiche('Tableau maximal atteint',clred);
    Affiche('Intervalle='+intToSTR(intervalle),clyellow);
    dec(index_simule);
    closeFile(fte);
    formprinc.ButtonArretSimu.Visible:=true;

    FormSimulation.Close;
  end;
  Affiche('Fichier simulation : '+nF ,clyellow);
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

end.
