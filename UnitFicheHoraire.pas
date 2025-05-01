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
    procedure StringGridFOSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  MaxHoraire=200;
  colLigne=0;
  ColTrain=1;
  ColRoute=2;
  ColHDep=3;
  ColVitDem=4;
  ColSens=5;
  ColArret=6;
var
  FormFicheHoraire: TFormFicheHoraire;
  Nombre_horaires : integer;

  GrilleHoraire : Array[1..MaxHoraire] of record
                    NomTrain : string ;
                    route : string;
                    Adresse : integer;  // adresse du train
                    vitesse : integer;
                    sens : boolean;  //Normal=true  inverse=false
                    arretDepart : boolean;  // arret du train au démarrage de l'horloge
                    heure,minute : integer;
                    detecteur,actionneur : integer;
                  end;

Bouton : Tbutton;

implementation

uses verif_version;

{$R *.dfm}

procedure TFormFicheHoraire.ButtonOkClick(Sender: TObject);
var f : textfile;
    ligne,col,n,i,erreur : integer;
    s : string;
begin
  assignFile(f,'FicheHoraire.txt');
  rewrite(f);
  writeln(f,'/ Fichier horaire Version '+VersionSC);
  n:=stringGridFO.RowCount-1;
  if n>MaxHoraire then n:=MaxHoraire;
  for ligne:=1 to n do
  begin
    // nomtrain,Nomroute,départ,vitesse démarre,sens,inverse

    // recopier le composant grille dans le tableau grilleHoraire[]
    grilleHoraire[ligne].NomTrain:=stringGridFO.Cells[1,ligne];

    s:=stringGridFO.Cells[ColHDep,ligne]; // heure de démarrage
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
  {$IF CompilerVersion < 28.0}
  if Modesombre then
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
  {$IFEND}

end;


procedure TFormFicheHoraire.FormCreate(Sender: TObject);
var i,champ,ligne,col,erreur : integer;
    f : textFile ;
    s,ss,v,nomTrain : string;
    ver : single;
begin
  // cells[colonne,ligne]
  with stringGridFO do
  begin
    Anchors:=[];
    Anchors:=[AkTop,AkLeft,akright,akBottom];
    Options:=options
    // édition      pas multiselect  trackbar dynamique   autoriz le dimensionnement des colonnes
    + [goEditing] - [goRangeSelect] + [goThumbTracking]+ [goColSizing]
    + [goAlwaysShowEditor]; // autorise l'édition
    Hint:='Grille horaire';
    ShowHint:=true;
    ColCount:=7;
    RowCount:=MaxHoraire+1;
    Options := stringGridFO.Options + [goEditing];
    ColWidths[ColLigne]:=30;
    ColWidths[ColTrain]:=200;
    ColWidths[ColRoute]:=100;
    ColWidths[ColHDep]:=60;
    ColWidths[ColVitDem]:=60;
    ColWidths[ColSens]:=60;
    ColWidths[ColArret]:=60;

    Cells[ColLigne,0]:='Ligne';
    Cells[ColTrain,0]:='Nom du train';
    Cells[ColRoute,0]:='Nom de la route';
    Cells[ColHDep,0]:='Départ';
    Cells[ColVitDem,0]:='Vitesse'+#13+'démarrage';
    Cells[ColSens,0]:='Sens'+#13+'(N/R)';
    Cells[ColArret,0]:='Forcer arrêt'+#13+'O/N';

    RowHeights[0]:=30;

    // numéroter les lignes et fixer la hauteur des lignes
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

  readln(f,s); // version
  s:=lowercase(s);
  i:=pos('version ',s);
  v:='';
  if i<>0 then
  begin
    delete(s,1,i+7);
    v:=s;
  end;

  val(v,ver,erreur);

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
          if col=ColTrain then   // nom du train
          begin
            if champ=0 then begin affiche('Erreur 17',clred);closefile(f);end;
            NomTrain:=copy(s,1,champ-1);
            stringGridFO.Cells[col,ligne]:=NomTrain;
            grilleHoraire[ligne].NomTrain:=NomTrain;
            if champ<>0 then delete(s,1,champ);
          end;

          if (col=ColRoute) then  // route
          begin
            ss:=s;
            ss:=copy(s,1,champ-1);
            stringGridFO.Cells[colRoute,ligne]:=ss;
            grilleHoraire[ligne].route:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          if col=3 then  // heure
          begin
            ss:=s;
            if champ<>0 then ss:=copy(s,1,champ-1);
            stringGridFO.Cells[ColHDep,ligne]:=ss;
            val(ss,i,erreur);
            grilleHoraire[ligne].heure:=i;
            delete(ss,1,erreur);
            val(ss,i,erreur);
            grilleHoraire[ligne].minute:=i;
            if champ<>0 then delete(s,1,champ);
          end;

          if (col=4) then  // vitesse
          begin
            ss:=copy(s,1,champ-1);
            val(ss,i,erreur);
            grilleHoraire[ligne].vitesse:=i;
            stringGridFO.Cells[colVitDem,ligne]:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          if (col=5) then  // sens
          begin
            ss:=copy(s,1,champ-1);
            grilleHoraire[ligne].sens:=ss='N';
            if grilleHoraire[ligne].sens then ss:='N' else ss:='R';
            stringGridFO.Cells[colSens,ligne]:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          if (col=6) then  // arret du train au démarrage de l'horloge
          begin
            ss:=copy(s,1,champ-1);
            grilleHoraire[ligne].arretDepart:=ss='O';
            if grilleHoraire[ligne].arretDepart then ss:='O' else ss:='N';
            stringGridFO.Cells[colArret,ligne]:=ss;
            if champ<>0 then delete(s,1,champ);
          end;

          inc(col);
        until (col>stringGridFO.ColCount-1) or (pos(',',s)=0);

        inc(ligne);
      end;
    end;
  until eof(f) or (nomTrain='') or (ligne>MaxHoraire);
  Nombre_horaires:=ligne-2;

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
  if (Acol=ColHdep) and (Arow>0) and (s<>'') then
  begin
    if pos('H',sM)=0 then LabelErreur.caption:='Erreur : l''heure doit être au format HHhMM'
    else labelErreur.Caption:='';
  end;

  if (Acol=ColVitDem) and (Arow>0) and (s<>'') then
  begin
    val(s,i,erreur);
    if (i<0) or (i>120) or (erreur<>0) then LabelErreur.caption:='Erreur : la vitesse doit être comprise entre 0 et 120'
    else labelErreur.Caption:='';
  end;

  if (Acol=colSens) and (Arow>0) and (s<>'') then
  begin
    if (sM<>'N') and (sM<>'R') then LabelErreur.caption:='Erreur : le sens doit être N(direct) ou R(recul)'
    else labelErreur.Caption:='';
  end;

  if (Acol=ColArret) and (Arow>0) and (s<>'') then
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
  //Affiche(intToSTR(arow)+' '+intToSTR(aCol),clYellow);
  // couleur de fond
  if Arow=0 then
  begin
    if d12 then couleur:=grid.canvas.Pixels[35,6] else couleur:=$E0E0E0;
    with grid.canvas do
    begin
      Brush.Color := couleur;
      inc(Rect.top); inc(Rect.left); // rend visible les quadrillages
      FillRect(Rect);
    end;

    DRect:=Rect;
    // calcule, ajuste et positionne la ligne de l'espace vertical nécessaire
    DrawText(Grid.Canvas.Handle,Pchar(S),Length(S),DRect,DT_CALCRECT or DT_CENTER);
    // si la hauteur du texte est plus grande que la hauteur de la ligne, augmenter la hauteur de la ligne
    if (DRect.Bottom-DRect.Top)>Grid.RowHeights[ARow] then Grid.RowHeights[ARow]:=DRect.Bottom-DRect.Top
    // changer la hauteur de la cellule provoque son redessinage
    else
    begin
      DRect.Right:=Rect.Right;
      Grid.Canvas.FillRect(DRect);
      DrawText(Grid.Canvas.Handle, Pchar(S), Length(S), DRect, DT_CENTER);
    end;
  end;
end;


procedure TFormFicheHoraire.StringGridFOSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var s : string;
    i,erreur : integer;
begin
  case Acol of
    ColTrain :
    begin
      GrilleHoraire[ARow].NomTrain:=StringGridFO.Cells[Acol,ARow];
      application.CancelHint;
      FormFicheHoraire.Caption:='Nom du train';
    end;
    Colroute :
    begin
      GrilleHoraire[ARow].Route:=StringGridFO.Cells[Acol,ARow];
      application.CancelHint;
      FormFicheHoraire.Caption:='Nom de la route mémorisée du train';
    end;
    ColHDep :
    begin
      FormFicheHoraire.Caption:='Heure au format XXhXX';
      s:=stringGridFO.Cells[Acol,Arow]; // heure de démarrage
      val(s,i,erreur);
      grilleHoraire[Arow].heure:=i;
      if erreur<>0 then
      begin
        delete(s,1,erreur);
        val(s,i,erreur);
        grilleHoraire[Arow].minute:=i;
        LabelErreur.caption:='';
      end
      else
        LabelErreur.caption:='Erreur : l''heure doit être au format HHhMM';
    end;
    ColVitDem :
    begin
      FormFicheHoraire.Caption:='Vitesse entre 0 et 120';
      s:=stringGridFO.Cells[Acol,Arow];
      val(s,i,erreur);
      if (i<0) or (i>120) or (erreur<>0) then LabelErreur.caption:='Erreur : la vitesse doit être comprise entre 0 et 120'
        else labelErreur.Caption:='';
      grilleHoraire[Arow].vitesse:=i;
    end;
    ColSens :
    begin
      FormFicheHoraire.Caption:='Sens N(direct) ou R(recul)';
      s:=stringGridFO.Cells[Acol,Arow];
      if (s<>'N') and (s<>'R') then LabelErreur.caption:='Erreur : le sens doit être N(direct) ou R(recul)'
        else labelErreur.Caption:='';
      grilleHoraire[Arow].sens:=s='N';
    end;
    ColArret :
    begin
      FormFicheHoraire.Caption:='N(non) ou O(oui)';
      s:=stringGridFO.Cells[Acol,Arow];
      grilleHoraire[Arow].arretDepart:=s='O';
      if (s<>'O') and (s<>'N') then LabelErreur.caption:='Erreur : la demande d''arrêt doit être N(non) ou O(oui)'
      else labelErreur.Caption:='';
    end;
  end;
end;

end.

