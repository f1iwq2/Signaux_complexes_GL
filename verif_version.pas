unit verif_version;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
      Dialogs, StdCtrls , ComCtrls ,WinInet, ExtCtrls , StrUtils, unitPrinc,
      ShellAPI ;

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

Const  Version='7.2';  // sert à la comparaison de la version publiée
       SousVersion=' '; // A B C ... en cas d'absence de sous version mettre un espace

function GetCurrentProcessEnvVar(const VariableName: string): string;
function verifie_version : real;
function DownloadURL_NOCache(aUrl: string;s : string;var taille : longint): Boolean;
function url_github(var url: string) : boolean;

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

// récupère l'url de téléchargement du github avec curl
// curl -s https://api.github.com/repos/f1iwq2/signaux_complexes_gl/releases/latest \
function url_github(var url: string) : boolean;
var s : string;
    retour,i : integer;
    trouve : boolean;
    fichier : text;
begin
  result:=false;
  url:='';
  s:='-s -o url.txt https://api.github.com/repos/f1iwq2/signaux_complexes_gl/releases/latest';  // résultat dans url.txt
  //s:='';
  retour:=ShellExecute(Formprinc.Handle,'open',
                       Pchar('curl.exe'),
                       //Pchar('cmd.exe'),
                       Pchar(s),  // paramètre
                       Pchar('')  // répertoire
                       ,SW_HIDE);               // pas d'affichage
  if retour>32 then
  begin
    result:=true;
    assign(fichier,'url.txt');
    reset(fichier);
    trouve:=false;
    while not(eof(fichier)) or not trouve do
    begin
      readln(fichier,s);
      if pos('browser_download_url',s)<>0 then
      begin
        trouve:=true;
        i:=pos('https',s);
        delete(s,1,i-1);
        i:=pos('"',s);
        s:=copy(s,1,i-1);
        url:=s;
      end;
    end;
  end
end;


// téléchargement d'une page internet sans cache dans un fichier
// aUrl = adresse URL du fichier - S : chemin et nom du fichier à écrire - taille : renvoie la taille lue en octets
function DownloadURL_NOCache(aUrl: string;s : string;var taille : longint): Boolean;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  Fs:TFileStream;
  lpBuffer: array[0..1024 + 1] of byte;
  dwBytesRead: DWORD;
  i : integer;
  t : longint;
begin
  Result := False;
  t:=0;
  Try Fs := TFileStream.Create(s,fmCreate);
    //hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY, nil, nil, 0);
    try
      if Assigned(hSession) then
      begin
        //Affiche('Session assignée',clLime);
        hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
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
              dwBytesRead := 1024;
              InternetReadFile(hService,@lpBuffer,1024,dwBytesRead);
              fs.WriteBuffer(lpBuffer,dwBytesRead);
              t:=t+dwBytesRead;
              if dwBytesRead=0 then break;
            end;
            Result := True;
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

// renvoie le numéro de version depuis le forum CDM
function verifie_version : real;
var s,s2,s3,Version_p,Url,LocalFile,nomfichier : string;
    trouve_version,trouve_zip,zone_comm,LocZip : boolean;
    fichier : text;
    i,j,erreur,Ncomm,i2,i3,l : integer;
    V_utile,V_publie : real;
    SV_publie : char;
    taille : longint;
    comm : array[1..10] of string;
begin
    //Affiche('vérifie version',clLime);
    // tester si on peut extraire l'url par curl
    //if url_github(UrlGIT) then affiche('curl ok',clyellow);

    Url:='http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906#p50499';
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
        //Affiche(s,clyellow);
        //s:=LowerCase(s);
        if not(trouve_version) then
        begin
          i:=pos('version ',LowerCase(s));
          trouve_version:=i<>0;
          if trouve_version then
          begin
            s2:=s;zone_comm:=true;
            //Affiche('trouvé version',clOrange);
          end;
        end;
        if not(trouve_zip) then
        begin
          i:=pos('.zip',LowerCase(s));
          trouve_zip:=i<>0;
          //if trouve_zip then Affiche(s,clyellow);
          if trouve_zip then
          begin
            s3:=s;
            //zone_comm:=false;
          end;
        end;
        // commentaire en gras
          if zone_comm then
          begin
            i:=pos('bold">',LowerCase(s))+6;i2:=posEx('<br />',LowerCase(s),i+1); i3:=posEx('</span>',LowerCase(s),i+1) ;
            if i<>6 then
            begin
              //Affiche(s,clred);
              inc(ncomm);
              if i3<i2 then i2:=i3;
            comm[ncomm]:=UTF8Decode(copy(s,i,i2-i));
            Delete(s,1,i2-1);
            j:=0;
            repeat
              i:=pos('<br />',LowerCase(s))+6;i3:=posEx('</span>',LowerCase(s),i+1);i2:=posEx('<br />',LowerCase(s),i+1);
              inc(ncomm);
              if i2<i3 then
              begin
                comm[ncomm]:=UTF8Decode(copy(s,i,i2-i));Delete(s,1,i2-1);
              end
              else
              begin
                comm[ncomm]:=UTF8Decode(copy(s,i,i3-i));Delete(s,1,i3-1);
              end;
              inc(j);
            until (i3<i2) or (ncomm=10) or (j=20);
            zone_comm:=false;
          end;
        end;
      end;
      closefile(fichier);

      if trouve_version and trouve_zip then
      begin
        // isoler le champ version
        i:=pos('version ',LowerCase(s2));
        delete(s2,1,i+7);
        j:=pos(' ',s2);
        Version_p:=copy(s2,1,j-1);        // version dans version_p Exemple V4.73b
        // isoler l'url du zip
        i:=pos('.zip',LowerCase(s3));
        repeat
          dec(i);
          locZip:=s3[i]='=';
        until (i=1) or LocZip;
        if locZip then 
        begin
          delete(s3,1,i+1);
        end;
        i:=pos('zip"',LowerCase(s3));     // s3 contient l'url du zip
        s3:=copy(s3,1,i+2);
        //----------------------------------------------------
        //isoler le nom du fichier
        i:=length(s3);
        repeat
          dec(i);
          locZip:=s3[i]='/';
        until (i=1) or LocZip;
        nomfichier:=copy(s3,i+1,length(s3)-i);

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
          if ncomm>0 then
          begin
            Aff('Nouveautés de la V'+version_p+SV_publie+' de Signaux_Complexes_GL :');
            aff(' ');
            for i:=1 to ncomm-1 do aff(comm[i]);
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
          else formVersion.Free;
        end;
        result:=V_publie;
      end;
    end
    else
      begin
        result:=0;
        if notificationVersion then Affiche('Pas d''accès au site ou échec téléchargement',clorange);
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
