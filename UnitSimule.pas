unit UnitSimule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UnitPrinc;

type
  TFormSimulation = class(TForm)
    Button1: TButton;
    OpenDialog: TOpenDialog;
    EditIntervalle: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditIntervalleChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSimulation: TFormSimulation;
  Intervalle    : integer;

implementation

{$R *.dfm}

procedure TFormSimulation.Button1Click(Sender: TObject);
var s : string;
   fte : textFile;
   i,k,erreur : integer;
   sortie : boolean;
begin
  s:=GetCurrentDir;
  s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  OpenDialog.InitialDir:=s;
  OpenDialog.DefaultExt:='txt';
  OpenDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
  if openDialog.Execute then
  begin
    s:=openDialog.FileName;
    assignFile(fte,s);
    reset(fte);
    index_simule:=1;
    repeat
      readln(fte,s);
      i:=pos('Tick=',s);
  
      if i<>0 then 
      begin 
        Delete(s,1,i+4);
        val(s,k,erreur);
        k:=Index_Simule*Intervalle*10+tick+80;   // démarre dans 8s
        Tablo_simule[index_simule].tick:=k;
        i:=pos('Det=',s);
        if i<>0 then 
        begin 
          Delete(s,1,i+3);
          val(s,k,erreur);
          Tablo_simule[index_simule].detecteur:=k;
          i:=pos('=',s);
          if i<>0 then 
          begin 
            Delete(s,1,i);
            val(s,k,erreur);
            Tablo_simule[index_simule].etat:=k;

            s:='Tick='+intToSTR(Tablo_simule[index_simule].tick)+
               ' Detecteur='+intToSTR(Tablo_simule[index_simule].detecteur)+
               '='+intToSTR(Tablo_simule[index_simule].etat);
            Affiche(s,ClLime);
            
            inc(index_simule); 
          end;
        end;  
      end;
      sortie:=eof(fte) or (index_simule>199);
    until sortie ;
    Affiche('Intervalle='+intToSTR(intervalle),clyellow);
    dec(index_simule);
    closeFile(fte);
    FormSimulation.Close;
    
  end;
end;


procedure TFormSimulation.FormCreate(Sender: TObject);
begin
  Intervalle:=2;
  EditIntervalle.Text:=IntToSTR(Intervalle);
end;


procedure TFormSimulation.EditIntervalleChange(Sender: TObject);
var i, erreur : integer;
begin
  Val(EditIntervalle.Text,i,erreur);
  if erreur=0 then Intervalle:=i;
end;

end.
