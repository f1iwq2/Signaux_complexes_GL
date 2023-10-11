unit verif_version;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
      Dialogs, StdCtrls , ComCtrls ,WinInet, ExtCtrls , StrUtils, unitPrinc,
      ShellAPI;

type
  TFormVersion = class(TForm)
    TimerVerif: TTimer;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure TimerVerifTimer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormVersion: TFormVersion;
  Lance_verif : integer;
  verifVersion,notificationVersion : boolean;
  date_creation,nombre_tel : string;

Const  Version='8.21';  // sert à la comparaison de la version publiée
       SousVersion=' '; // A B C ... en cas d'absence de sous version mettre un espace

function GetCurrentProcessEnvVar(const VariableName: string): string;
function verifie_version : real;
function DownloadURL_NOCache(aUrl: string;s : string;var taille : longint): Boolean;

implementation

uses unitconfig;

{$R *.dfm}

Procedure Aff(s : string);
begin
  FormVersion.Memo1.lines.add(s);
end;

function GetCurrentProcessEnvVar(const VariableName: string): string;
var
  nSize: DWord;
begin
  nSize:=0;
  nSize:=GetEnvironmentVariable(PChar(VariableName), nil, nSize);
  if nSize=0 then
  begin
    result:='';
  end
  else
  begin
    SetLength(result,nSize-1);
    if GetEnvironmentVariable(PChar(VariableName), PChar(result), nSize) <> nSize - 1 then
      raise Exception.Create(SysErrorMessage(GetlastError))
  end;
end;

// téléchargement d'une page internet sans cache dans un fichier
// aUrl = adresse URL du fichier - S : chemin et nom du fichier à écrire - taille : renvoie la taille lue en octets
function DownloadURL_NOCache(aUrl: string;s : string;var taille : longint): Boolean;
var
  hSession,hService: hinternet;
  Fs : TFileStream;
  lpBuffer: array[0..1024 + 1] of byte;
  dwBytesRead: dword;
  i : integer;
  t : longint;
begin
  Result:=False;
  t:=0;
  Try Fs:=TFileStream.Create(s,fmCreate);
    //hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    hSession:=InternetOpen('MyApp',INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY,nil,nil,0);
    try
      if Assigned(hSession) then
      begin
        hService:=InternetOpenUrl(hSession,PChar(aUrl),nil,0,INTERNET_FLAG_RELOAD,0);
        i:=getLastError;
        if i<>0 then
        case i of
        12037 : Affiche('Erreur validité de certificat',clred);
        12157 : Affiche('Erreur canal sécurisé SSL 2.0',clred);
        else affiche('Erreur '+intToSTR(i),clred);
        end;
        if Assigned(hService) then
        try
          //Affiche('Service assigné',clLime);
          while True do
            begin
              dwBytesRead:=1024;
              InternetReadFile(hService,@lpBuffer,1024,dwBytesRead);
              fs.WriteBuffer(lpBuffer,dwBytesRead);
              t:=t+dwBytesRead;
              if dwBytesRead=0 then break;
            end;
            Result:=True;
            taille:=t;
        finally
          InternetCloseHandle(hService);
        end;
      end;
    finally
      InternetCloseHandle(hSession);
    end;
  finally
    fs.Free;
  end;
end;

// renvoie le numéro de version depuis le site github
function verifie_version : real;
var description,s,s2,s3,Version_p,Url,LocalFile,nomfichier,date_creation_ang
     : string;
    trouve_version,trouve_zip,zone_comm,LocZip : boolean;
    fichier : text;
    i,j,erreur,Ncomm,i2,l : integer;
    V_utile,V_publie : real;
    SV_publie : char;
    taille : longint;
    comm : array[1..10] of string;

    function supprime_anti(s : string) : string;
    var i : integer;
    begin
    // supprimer tous les \ dans la chaine
      i:=0;
      repeat
        i:=posEx('\',s,i+1);
        if i<>0 then delete(s,i,1);
      until i=0;
      result:=s;
    end;

    function extrait_champ(ss : string) : string;
    var i,j : integer;
    begin
      s:='"'+s+'"';
      result:='';
      i:=pos(ss,s);
      if i<>0 then
      begin
        i:=posEx('":',s,i+1);
        //delete(s,1,i+1);i:=0;
        i:=posEx('"',s,i+1);

        j:=i;
        // ne pas tenir compte du \" qui correspond à un " effectif dans la chaîne
        repeat
          j:=posex('"',s,j+1);
        until s[j-1]<>'\' ;

        result:=copy(s,i+1,j-i-1);
      end;
    end;

    function extrait_champ_simple(ss : string) : string;
    var i,j : integer;
    begin
      s:='"'+s+'"';
      result:='';
      i:=pos(ss,s);
      if i<>0 then
      begin
        i:=posEx(':',s,i+1);
        j:=posEx(',',s,i+1);
        result:=copy(s,i+1,j-i-1);
      end;
    end;

begin
    //Affiche('vérifie version',clLime);
    Url:='https://api.github.com/repos/f1iwq2/signaux_complexes_gl/releases/latest';
    LocalFile:='page.txt';
    trouve_version:=false;
    trouve_zip:=false;
    zone_comm:=false;
    Ncomm:=0;
    if DownloadURL_NOCache(Url,localFile,taille) then
    begin
      AssignFile(fichier,LocalFile);
      reset(fichier);

      while not(eof(fichier)) and  (not(trouve_version) or not(trouve_zip)) do
      begin
        readln(fichier,s);
        s:=utf8Decode(s);
        //Affiche(s,clyellow);

        // adresse de téléchargement
        s3:=extrait_champ('browser_download_url');
        if s3<>'' then trouve_zip:=true;

        // nombre de téléchargements
        nombre_tel:=extrait_champ_simple('download_count');

        // date de création
        date_creation_ang:=extrait_champ('created_at');
        if date_creation_ang<>'' then
        begin
          //Affiche(date_creation_ang,clyellow);
          i:=pos('-',date_creation_ang);
          j:=posex('-',date_creation_ang,i+1);
          i2:=pos('T',date_creation_ang);
          date_creation:=copy(date_creation_ang,j+1,i2-j-1);
          date_creation:=date_creation+'/'+copy(date_creation_ang,i+1,j-i-1);
          date_creation:=date_creation+'/'+copy(date_creation_ang,1,i-1);
          date_creation:=date_creation+' '+copy(date_creation_ang,i2+1,length(date_creation_ang)-i2-1);
          //Affiche(date_creation,clyellow);
        end;

        // version publiée
        version_p:=extrait_champ('tag_name');
        if version_p<>'' then
        begin
          trouve_version:=true;
          if not(version_p[1] in ['0'..'9']) then delete(version_p,1,1);
        end;

        description:=extrait_champ('body');
        if description<>'' then
        begin
          //description:=utf8Decode(description);
          i:=1 ; j:=1;
          // couper en chaînes
          while j<>0 do
          begin
            j:=pos('\r',description);
            if j<>0 then
            begin
              comm[i]:=copy(description,1,j-1);
              inc(i);
              delete(description,1,j+1);
            end;

            j:=pos('\n',description);
            if j<>0 then
            begin
              delete(description,j,2);
            end;

          end;
          comm[i]:=supprime_anti(description);
          ncomm:=i;

        end;

      end;
      closefile(fichier);

      if trouve_version and trouve_zip then
      begin
        //----------------------------------------------------
        //isoler le nom du fichier
        i:=length(s3);
        repeat
          dec(i);
          locZip:=s3[i]='/';
        until (i=1) or LocZip;
        nomfichier:=copy(s3,i+1,length(s3)-i);

        //affiche(nombre_tel,cllime);

        //Affiche(s3,clLime);
        //Affiche(nomfichier,clred);

        // changer le . en ,
        s:=Version_p;
        // i:=pos('.',s);if i<>0 then s[i]:=',';
        s2:=version;
        // i:=pos('.',s2);if i<>0 then s2[i]:=',';

        s:=AnsiUppercase(s);
        l:=length(s);
        SV_publie:=s[l];
        if Sv_publie in ['0'..'9'] then Sv_Publie:=' ' else begin s:=copy(s,1,l-1);Version_P:=s;end;

        val(s,V_publie,erreur);
        if erreur<>0 then exit;
        val(s2,V_utile,erreur);
        if erreur<>0 then exit;
        if (V_utile<V_publie) or
           ((V_utile=V_publie) and (SousVersion<SV_publie)) then
        begin
          FormVersion.Top:=10;
          FormVersion.Left:=10;
          FormVersion.show;
          s:='Vous utilisez la version '+version+SousVersion+' mais il existe la version '+Version_p+SV_publie;
          if length(description)>0 then
          begin
            FormVersion.Memo1.lines.Clear;
            Aff('Nouveautés de la V'+version_p+SV_publie+' de Signaux_Complexes_GL du '+date_creation);
            aff(' ');
            for i:=1 to ncomm do aff(comm[i]);
          end;
          if MessageDlg(s+'. Voulez-vous la télécharger?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
          begin
            // récupérer depuis la variable d'environnement windows USERPROFILE le repertoire de la session ouverte
            s:=GetCurrentProcessEnvVar('USERPROFILE')+'\Downloads\'+Nomfichier;
            Aff('Téléchargement de '+s3+' dans ');
            Aff(s);

            if DownloadURL_NOCache(s3,s,taille) then
            begin
              if taille>700000 then
              begin
                Aff('Téléchargement réussi');
                Aff('Vous pouvez ouvrir le dossier de téléchargement, décomprimer le zip et l''installer');
              end
                else Aff('Echec 2 de téléchargement');
            end
              else Aff('Echec 1 de téléchargement');
          end
          else formVersion.close;
        end;
        result:=V_publie;
      end
      else
      affiche('Le dépôt github ne comprend aucune version diffusée.',clOrange);
      
    end
    else
      begin
        result:=0;
        if notificationVersion then Affiche('Pas d''accès au site github.com ou échec téléchargement',clorange);
      end;
end;


procedure TFormVersion.FormCreate(Sender: TObject);
begin
  if debug=1 then Affiche('Création fenêtre version',clLime);
  Timerverif.Interval:=1000;    // timer à 1 seconde
  Lance_verif:=2;               // lancer la vérification de version dans 3s
  if debug=1 then Affiche('Fin création fenêtre version',clLime);
end;

procedure TFormVersion.TimerVerifTimer(Sender: TObject);
var V_utile,V_publie : real;
    erreur: integer;
    s : string;
begin
  if lance_verif>0 then dec(lance_verif);
  if lance_verif=0 then
  begin
    timerVerif.Enabled:=false;
    if not(AvecInit)     then exit;
    if not(verifVersion) then exit;
    if debug=1 then Affiche('Vérification version en ligne',clLime);
    V_publie:=verifie_version;
    if notificationVersion and (v_publie>0) then
    begin
      val(version,V_utile,erreur);
      str(v_publie:2:2,s);
      if V_utile=V_publie then Affiche('Votre version '+Version+SousVersion+' est à jour',clLime);
      if V_utile>V_publie then Affiche('Votre version '+version+SousVersion+' est plus récente que la version publiée '+s,clLime);
    end;
  end;
end;

begin
end.
