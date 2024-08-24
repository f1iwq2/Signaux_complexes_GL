unit UnitFicheHoraire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids , UnitPrinc ,StrUtils;

type
  TFormFicheHoraire = class(TForm)
    ButtonOk: TButton;
    StringGridFO: TStringGrid;
    Label1: TLabel;
    LabelErreur: TLabel;
    Label2: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGridFODrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  MaxHoraire=200;

var
  FormFicheHoraire: TFormFicheHoraire;
  Nombre_horaires : integer;

  GrilleHoraire : Array[1..MaxHoraire] of record
                    NomTrain : string ;
                    Adresse : integer;
                    vitesse : integer;
                    sens : boolean;
                    arretDepart : boolean;  // arret du train au démarrage de l'horloge
                    heure,minute : integer;
                    detecteur,actionneur : integer;
                  end;

implementation

{$R *.dfm}

procedure TFormFicheHoraire.ButtonOkClick(Sender: TObject);
var f : textfile;
    ligne,col,n,i,erreur : integer;
    s : string;
begin
  assignFile(f,'FicheHoraire.txt');
  rewrite(f);
  writeln(f,'/ Fichier horaire');
  n:=stringGridFO.RowCount-1;
  if n>MaxHoraire then n:=MaxHoraire;
  for ligne:=1 to n do
  begin
    grilleHoraire[ligne].NomTrain:=stringGridFO.Cells[1,ligne];

    s:=stringGridFO.Cells[2,ligne]; // heure de démarrage
    val(s,i,erreur);
    grilleHoraire[ligne].heure:=i;
    delete(s,1,erreur);
    val(s,i,erreur);
    grilleHoraire[ligne].minute:=i;

    s:='';
    for col:=1 to stringGridFO.ColCount-1 do
    begin
      s:=s+stringGridFO.Cells[col,ligne]+',';
    end;
    writeln(f,s);
  end;
  closefile(f);
  close;
end;

procedure couleurs_fiche;
var c : tcomponent;
    i : integer;
    fond,texte : tColor;
begin
  if sombre then
  begin
    fond:=couleurFond;
    texte:=couleurTexte;

    formFichehoraire.Color:=fond;
    for i:=0 to formFichehoraire.ComponentCount-1 do
    begin
      c:=formFichehoraire.Components[i];
      //Affiche(c.Name,clyellow);
      composant(c,fond,texte);
    end;
  end;
end;

procedure TFormFicheHoraire.FormCreate(Sender: TObject);
var i,champ,ligne,col,erreur : integer;
    f : textFile ;
    s,ss : string;
begin
  // cells[colonne,ligne]
  with stringGridFO do
  begin
    Hint:='Grille horaire';
    ShowHint:=true;
    ColCount:=6;
    RowCount:=MaxHoraire+1;
    Options := stringGridFO.Options + [goEditing];
    ColWidths[0]:=30;
    ColWidths[1]:=200;
    ColWidths[2]:=60;
    ColWidths[3]:=60;
    ColWidths[4]:=50;
    ColWidths[5]:=60;

    Cells[0,0]:='Ligne';
    Cells[1,0]:='Nom du train';
    Cells[2,0]:='Départ';
    Cells[3,0]:='Vitesse'+#13+'démarrage';
    Cells[4,0]:='Sens'+#13+'(N/R)';
    Cells[5,0]:='Forcer arrêt'+#13+'O/N';

    RowHeights[0]:=22;

    for i:=1 to RowCount-1 do
    begin
      if i>0 then Cells[0,i]:=intToSTR(i);
      RowHeights[i]:=16;
    end;
    font.Color:=clBlack;
  end;

  try
    assignFile(f,'FicheHoraire.txt');
    reset(f);
  except
    //Affiche('Fichier horaire inexistant',clYellow);
    exit;
  end;

  ligne:=1;
  repeat
    readln(f,s);
    if s<>'' then
    begin
      col:=1;
      if s[1]<>'/' then
      begin
        col:=1;
        repeat        // lecture de la ligne
          champ:=pos(',',s);
          if col=1 then   // nom du train
          begin
            if champ=0 then begin affiche('Erreur 17',clred);closefile(f);end;
            ss:=copy(s,1,champ-1);
            stringGridFO.Cells[col,ligne]:=ss;
            grilleHoraire[ligne].NomTrain:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          if col=2 then  // heure
          begin
            ss:=s;
            if champ<>0 then ss:=copy(s,1,champ-1);
            stringGridFO.Cells[col,ligne]:=ss;
            val(ss,i,erreur);
            grilleHoraire[ligne].heure:=i;
            delete(ss,1,erreur);
            val(ss,i,erreur);
            grilleHoraire[ligne].minute:=i;
            if champ<>0 then delete(s,1,champ);
          end;

          if col=3 then  // vitesse
          begin
            ss:=copy(s,1,champ-1);
            val(ss,i,erreur);
            grilleHoraire[ligne].vitesse:=i;
            stringGridFO.Cells[col,ligne]:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          if col=4 then  // sens
          begin
            ss:=copy(s,1,champ-1);
            grilleHoraire[ligne].sens:=ss='N';
            if grilleHoraire[ligne].sens then ss:='N' else ss:='R';
            stringGridFO.Cells[col,ligne]:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          if col=5 then  // arret du train au démarrage de l'horloge
          begin
            ss:=copy(s,1,champ-1);
            grilleHoraire[ligne].arretDepart:=ss='O';
            if grilleHoraire[ligne].arretDepart then ss:='O' else ss:='N';
            stringGridFO.Cells[col,ligne]:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          inc(col);
        until (col>stringGridFO.ColCount-1) or (pos(',',s)=0);

        inc(ligne);
      end;
    end;
  until eof(f) or (ligne>MaxHoraire);
  Nombre_horaires:=ligne-1;

  closefile(f);
  couleurs_Fiche;
  StringGridFO.Selection:=tGridRect(rect(0,0,0,0));

end;



procedure TFormFicheHoraire.FormActivate(Sender: TObject);
begin
  if FormFicheHoraire=nil then exit;
end;

// apellée sur dessin d'une cellule.
procedure TFormFicheHoraire.StringGridFODrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  s,sM: string;
  i,erreur : integer;
  DRect: TRect;
  couleur : tColor;
  Grid: TStringGrid;
  d12 : boolean;
begin
  Grid:=Sender as TStringGrid;

  s:=Grid.Cells[ACol,ARow];
  sM:=uppercase(s);
  if (Acol=2) and (Arow>0) and (s<>'') then
  begin
    if pos('H',sM)=0 then LabelErreur.caption:='Erreur : l''heure doit être au format HHhMM'
    else labelErreur.Caption:='';
  end;

  if (Acol=3) and (Arow>0) and (s<>'') then
  begin
    val(s,i,erreur);
    if (i<0) or (i>120) or (erreur<>0) then LabelErreur.caption:='Erreur : la vitesse doit être comprise entre 0 et 120'
    else labelErreur.Caption:='';
  end;


  if (Acol=4) and (Arow>0) and (s<>'') then
  begin
    if (sM<>'N') and (sM<>'R') then LabelErreur.caption:='Erreur : le sens doit être N(direct) ou R(recul)'
    else labelErreur.Caption:='';
  end;

  if (Acol=5) and (Arow>0) and (s<>'') then
  begin
    if (sM<>'O') and (sM<>'N') then LabelErreur.caption:='Erreur : la demande d''arrêt doit être N(non) ou O(oui)'
    else labelErreur.Caption:='';
  end;


  // pour écrire sur 2 lignes dans une stringGrid
 {
  if Length(s)>0 then
  begin
    if Arow=0 then
    begin
      Grid.Canvas.Font.Color:=clBlue;
 //     Grid.Font.style:=[fsBold];
    end
    else
    begin
      Grid.Canvas.Font.Color:=clBlack;
//      Grid.Font.style:=[];     si on valide sans style, créée evts continus!!
    end;
  end;  }


  d12:=false;
  {$IF CompilerVersion >= 28.0}
    d12:=true;
  {$IFEND}

  couleur:=$E0E0E0;
  if d12 then couleur:=$505050;
  with grid.canvas do
  begin
    Brush.Color := couleur;
    FillRect(Rect);
  end;

    DRect:=Rect;
    // calcule, ajuste et positionne la ligne de l'espace vertical nécessaire
    DrawText(Grid.Canvas.Handle,Pchar(S),Length(S),DRect,DT_CALCRECT or DT_CENTER);
    // if the text height is greater than the row height, increase the row height
    if (DRect.Bottom - DRect.Top) > Grid.RowHeights[ARow] then Grid.RowHeights[ARow]:=DRect.Bottom - DRect.Top
    // changer la hauteur de la cellule provoque son redessinage
    else
    begin
      DRect.Right:=Rect.Right;
      Grid.Canvas.FillRect(DRect);
      DrawText(Grid.Canvas.Handle, Pchar(S), Length(S), DRect, DT_CENTER);
    end;
end;

end.

