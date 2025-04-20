unit verif_version;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , ComCtrls ,WinInet, ExtCtrls , StrUtils, unitPrinc,
  ShellAPI , comObj , ShlObj , ActiveX  ;

type
  TFormVersion = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    //procedure TimerVerifTimer(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormVersion: TFormVersion;
  Lance_verif : integer;
  DebugVV,verifVersion,notificationVersion,essai : boolean;
  chemin_Dest,chemin_src,date_creation,nombre_tel : string;
  f : textFile;

Const
VersionSC = '10.5'; // sert � la comparaison de la version publi�e
SousVersion=' ';   // A B C ... en cas d'absence de sous version mettre un espace
// pour unzip
SHCONTCH_NOPROGRESSBOX=4;
SHCONTCH_AUTORENAME=8;
SHCONTCH_RESPONDYESTOALL=16;
SHCONTF_INCLUDEHIDDEN=128;
SHCONTF_FOLDERS=32;
SHCONTF_NONFOLDERS=64;

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
    if GetEnvironmentVariable(PChar(VariableName),PChar(result),nSize) <> nSize-1 then
      raise Exception.Create(SysErrorMessage(GetlastError))
  end;
end;

// t�l�chargement d'une page internet sans cache dans un fichier
// aUrl = adresse URL du fichier - S : chemin et nom du fichier � �crire - taille : renvoie la taille lue en octets
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
  // l'utilisation de TfileStream.Create inplique que le r�pertoire de destination soit libre de droits
  Try Fs:=TFileStream.Create(s,fmCreate);
    //hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    if DebugVV then Affiche('TFileStream.Create ok',clLime);
    hSession:=InternetOpen('MyApp',INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY,nil,nil,0);
    if DebugVV then Affiche('InternetOpen ok',clLime);
    try
      if Assigned(hSession) then
      begin
        if DebugVV then Affiche('Session assign�e',clYellow);
        hService:=InternetOpenUrl(hSession,PChar(aUrl),nil,0,INTERNET_FLAG_RELOAD,0);
        i:=getLastError;
        if i<>0 then
        case i of
        12007 : Affiche('R�seau: Erreur de r�solution DNS',clred);
        12037 : Affiche('R�seau: Erreur validit� de certificat - Mettre windows � jour ou version windows obsol�te',clred);
        12157 : Affiche('R�seau: Erreur canal s�curis� SSL 2.0 - Mettre windows � jour ou version windows obsol�te',clred);
        else affiche('Erreur r�seau '+intToSTR(i),clred);
        end;
        if Assigned(hService) then
        try
          if DebugVV then Affiche('Service assign�',clLime);
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
  except
    begin
      Affiche('Le fichier de v�rification des versions n''a pas pu �tre cr�� car le r�pertoire ',clred);
      Affiche(ExtractFilePath(s)+' n''a pas les droits requis',clred);
    end;
  end;
  fs.Free;
end;

procedure log(s : string;couleur : Tcolor);
begin
  Affiche(s,couleur);
  writeln(f,s);
end;

function Cree_dir(s : string) : boolean;
var erreur : integer;
begin
  result:=true;
  if not(directoryExists(s)) then
  begin
    {$I-}
    MkDir(s);
    erreur:=IoResult;
    {$I+}
    if erreur<>0 then
    begin
      log('Impossible de cr�er r�pertoire '+s+' erreur '+intToSTR(erreur),clred);
      result:=false;
      exit;
    end;
  end;
end;


procedure copie_fichier(s : string);
var fs,fd : string;
    i : integer;
begin
  fd:=chemin_dest+s;
  fs:=chemin_src+s;

  if not(copyfile(pchar(fs),pchar(fd),false)) then   // false force la copie si existant
  begin
    i:=getLastError;
    log('Fichier '+s+' non copi�. Erreur '+intToSTR(i)+': '+SysErrorMessage(i),clred);
  end
  else
  log(s+' copi�',clLime);
end;

// d�zipe un fichier. Si r�ussi : result=true
function Unzip(zipfile : oleVariant): boolean;
var
  shellobj,srcfldr, destfldr, shellfldritems,repertoire: Olevariant;
  filtre: string;
  i : integer;
begin
  result:=false;
  filtre:='';
  zipfile:=lowercase(zipfile);
  i:=pos('.zip',zipfile);
  if i=0 then
  begin
    log('Fichier zip : '+zipfile+' incorrect',clred);
    exit;
  end;
  filtre:=zipfile;
  delete(filtre,i,4);

  // cr�er le r�pertoire destination du zip (obligatoire car la commande de d�zippe ne le cr��e pas)
  if not(Cree_dir(filtre)) then
  begin
    log('Cr�ation r�pertoire '+filtre+' impossible',clred);
    exit;
  end;

  repertoire:=filtre;  // mettre dans olevariant

  filtre:='';
  shellobj:=CreateOleObject('Shell.Application');
  srcfldr:=ShellObj.NameSpace(Zipfile);
  if not((VarType(srcfldr)=varDispatch) and Assigned(TVarData(srcfldr).VDispatch)) then
  begin
    log('Fichier '+zipfile+ ' invalide ou absent',clred);
    exit;
  end;

  destfldr:=ShellObj.NameSpace(repertoire);
  if not ((VarType(destfldr)=varDispatch) and Assigned(TVarData(destfldr).VDispatch)) then
  begin
    log('R�pertoire destination invalide : '+ repertoire,clred);
    exit;
  end;

  shellfldritems:=srcfldr.Items;
  if (filtre<>'') then shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filtre);

  //destfldr.CopyHere(shellfldritems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  destfldr.CopyHere(shellfldritems,  SHCONTCH_RESPONDYESTOALL);
  result:=true;
end;


// d�zipe copie les fichiers et lance la nouvelle version
// s : chemin et fichier � d�ziper
procedure dezipe_copie_lance(s : string);
var i : integer;
begin
  // V�rifier si r�pertoire dest existe
  chemin_Dest:=CheminProgrammes+'\Signaux_complexes';
  if not(directoryExists(chemin_Dest)) then cree_Dir(chemin_dest);

  i:=pos('.zip',s);
  if i=0 then
  begin
    Affiche('Nom du zip invalide',clred);
    exit;
  end;

  chemin_src:=s;
  delete(chemin_src,i,4);  // transforme en chemin

  chemin_dest:=chemin_dest+'\';
  chemin_src:=chemin_src+'\';

  AssignFile(f,chemin_dest+'log-install.txt');
  Rewrite(f);

  log('Mise � jour de signaux complexes V'+versionSC+' le '+DateToStr(date)+' � '+TimeToStr(Time)+' ',clYellow);
  log('T�l�chargement r�ussi, d�compression',clyellow);
  formVersion.close;

  log('D�compression du zip '+s,clLime);
  if not(unzip(s)) then
  begin
    log('Erreur � la d�compression du zip',clred);
    close(f);
    exit;
  end;

  // Lancer le fichier installeur.exe du dossier d�comprim�
  // lancer copie_sc.exe qui copie les exe et cr�e les raccourcis et lance SC
  chdir(chemin_src);
  //s:='"'+chemin_dest+'" "'+chemin_src+'"';
  //log('ex�cution de copie_sc.exe '+s,clyellow);
  Affiche('Installation de la nouvelle version',clyellow);
  Sleep(2000);
  i:=ShellExecute(Formprinc.Handle,pchar('runas'),        // mode admin
                  Pchar('installeur.exe'),
                  Pchar(''),  // param�tre
                  PChar(''),  // r�pertoire
                  SW_SHOWNORMAL);

  if i>32 then
  begin
    fermeSC:=true;
    Application.Terminate;
  end
  else
  begin
    Affiche(SysErrorMessage(GetLastError),clred);
    log('Erreur '+intToSTR(i)+' au lancement de installeur.exe ',clred);
    log('Ex�cutez le manuellement',clred);
  end;
  close(f);
end;

// renvoie le num�ro de version depuis le site github, et t�l�charge... etc
function verifie_version : real;
var description,s,s2,s3,Version_p,Url,LocalFile,nomfichier,date_creation_ang : string;
    faire,trouve_version,trouve_zip,zone_comm,LocZip : boolean;
    fichier : text;
    i,j,Ncomm,i2,l : integer;
    V_utile,V_publie : real;
    SV_publie : char;
    taille : longint;
    comm : array[1..20] of string;

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
        // ne pas tenir compte du \" qui correspond � un " effectif dans la cha�ne
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
  //Affiche('v�rifie version',clLime);
  // URL de l'API github des derni�res releases
  Url:='https://api.github.com/repos/f1iwq2/signaux_complexes_gl/releases/latest';

  // l'utilisation de TfileStream.Create inplique que le r�pertoire de destination soit libre de droits,
  // ce qui ne marche pas pour c:\program files (x64)\signaux_complexes.
  // Le fichier page.txt est donc mis dans C:\Users\moi\AppData\Roaming\signaux_complexes qui lui a tous les droits
  // fabrication du nom de fichier destinataire et son chemin
  LocalFile:=SysUtils.GetEnvironmentVariable('APPDATA');
  if LocalFile<>'' then LocalFile:=IncludeTrailingPathDelimiter(LocalFile)+'Signaux_complexes';
  cree_dir(LocalFile);
  LocalFile:=LocalFile+'\page.txt';
  if Debug=1 then Affiche('fichier page: '+LocalFile,clOrange);

  //
  trouve_version:=false;
  DebugVV:=false;
  trouve_zip:=false;
  zone_comm:=false;
  essai:=false;
  Ncomm:=0;
  if DebugVV then Affiche('Lancement DownloadURL_NOCache',clYellow);
  faire:=essai;
  if not(essai) then
  begin
    faire:=DownloadURL_NOCache(Url,localFile,taille);
  end;
  if faire then
  begin
    if not(FileExists(localfile)) then
    begin
      Affiche('Erreur fichier d�pot absent. V�rifiez les droits du r�pertoire ',clred);
      Affiche(GetCurrentDir,clred);
      Affiche('Voir la notice page 9 : Refus de modification des fichiers du dossier par Windows',clred);
      result:=0;
      exit;
    end;
    if DebugVV then Affiche('DownloadURL_NOCache pass�',clYellow);

    AssignFile(fichier,LocalFile);
    reset(fichier);

    while not(eof(fichier)) and  (not(trouve_version) or not(trouve_zip)) do
    begin
      readln(fichier,s);
      if DebugVV then Affiche(s,clYellow);

      s:=utf8Decode(s);
      //Affiche(s,clyellow);
      // adresse de t�l�chargement
      s3:=extrait_champ('browser_download_url');
      if s3<>'' then
      begin
        if DebugVV then affiche('ZIP trouv�',clYellow);
        trouve_zip:=true;
      end;

      // nombre de t�l�chargements
      nombre_tel:=extrait_champ_simple('download_count');

      // date de cr�ation
      date_creation_ang:=extrait_champ('published_at');
      if date_creation_ang<>'' then
      begin
        //Affiche(date_creation_ang,clyellow);
        if DebugVV then affiche('Date cr�ation trouv�',clYellow);
        i:=pos('-',date_creation_ang);
        j:=posex('-',date_creation_ang,i+1);
        i2:=pos('T',date_creation_ang);
        date_creation:=copy(date_creation_ang,j+1,i2-j-1);
        date_creation:=date_creation+'/'+copy(date_creation_ang,i+1,j-i-1);
        date_creation:=date_creation+'/'+copy(date_creation_ang,1,i-1);
        date_creation:=date_creation+' '+copy(date_creation_ang,i2+1,length(date_creation_ang)-i2-1);
        //Affiche(date_creation,clyellow);
      end;
      // version publi�e
      version_p:=extrait_champ('tag_name');
      if version_p<>'' then
      begin
        trouve_version:=true;
        if DebugVV then affiche('Version trouv�e',clYellow);
        if not(version_p[1] in ['0'..'9']) then delete(version_p,1,1);
      end;

      description:=extrait_champ('body');
      if description<>'' then
      begin
        if DebugVV then affiche('Description trouv�e',clYellow);
        //description:=utf8Decode(description);
        i:=1 ; j:=1;
        // couper en cha�nes et mettre dans comm[]
        repeat
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
        until (j=0) or (i>=20);
        //
        ncomm:=i;
        comm[i]:=supprime_anti(description);
      end;
    end;
    closefile(fichier);
    if DebugVV then affiche('Fermeture du fichier d''�change',clYellow);

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
      s2:=versionSC;
      // i:=pos('.',s2);if i<>0 then s2[i]:=',';

      s:=AnsiUppercase(s);
      l:=length(s);
      SV_publie:=s[l];
      if Sv_publie in ['0'..'9'] then Sv_Publie:=' ' else begin s:=copy(s,1,l-1);Version_P:=s;end;
      V_Publie:=StrToFloat(s,FormatSettings);
      V_utile:=StrToFloat(s2,FormatSettings);

      if essai or (V_utile<V_publie) or ((V_utile=V_publie) and (SousVersion<SV_publie)) then
      begin
        FormVersion.Top:=10;
        FormVersion.Left:=10;
        FormVersion.show;
        s:='Vous utilisez la version '+versionSC+SousVersion+' mais il existe la version '+Version_p+SV_publie;
        if nComm>0 then
        begin
          FormVersion.Memo1.lines.Clear;
          Aff('Nouveaut�s de la V'+version_p+SV_publie+' de Signaux_Complexes_GL du '+date_creation);
          Aff(' ');
          for i:=1 to ncomm do aff(comm[i]);
        end;
        if MessageDlg(s+#13+'Voulez-vous la t�l�charger, l''installer et l''ex�cuter?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
        begin
          // r�cup�rer depuis la variable d'environnement windows USERPROFILE le repertoire de la session ouverte
          s:=GetCurrentProcessEnvVar('USERPROFILE')+'\Downloads\'+Nomfichier;

          // s3=url complete avecnom de fichier      ex : 'https://github.com/f1iwq2/Signaux_complexes_GL/releases/download/V8.51/signaux_complexes_V8.51.zip'
          // s=r�pertoire+fichier de t�l�chargement  ex : 'C:\Users\moi\Downloads\signaux_complexes_V8.51.zip'
          if not(essai) then
          begin
            Aff('T�l�chargement de '+s3+' dans ');
            Aff(s);
            Affiche('T�l�chargement de '+s3+' dans '+s,clLime);
          end;
          if essai then
          begin
            Affiche('*** mode essai ***',clOrange);
            dezipe_copie_lance(s);
            exit;
          end;

          // t�l�charge l'url (s3) dans le fichier s
          if DownloadURL_NOCache(s3,s,taille) then
          begin
            if taille>700000 then
            begin
              dezipe_copie_lance(s); // d�zipe et lance et termine le programme.
            end
            else Aff('Echec 2 de t�l�chargement - taille invalide');
          end
          else Aff('Echec 1 de t�l�chargement');
        end
        else formVersion.close;
      end;
      result:=V_publie;
    end
    else
    begin
      result:=-1;
      affiche('Le d�p�t ',clOrange);
      formprinc.FenRich.SelStart:=length(formprinc.FenRich.Text);
      formprinc.FenRich.SelAttributes.Style:=[fsUnderline];
      Affiche('https://github.com/f1iwq2/Signaux_complexes_GL/releases',clAqua);
      Affiche('ne comprend aucune version diffus�e.',clOrange);
    end;
  end
  else
  begin
    result:=0;
    Affiche('Pas d''acc�s au site github.com ou �chec t�l�chargement',clorange);
  end;
end;


procedure TFormVersion.FormCreate(Sender: TObject);
var V_utile,V_publie : real;
    erreur: integer;
    s : string;
begin
  if debug=1 then Affiche('Cr�ation fen�tre version',clLime);
  if debug=1 then Affiche('Fin cr�ation fen�tre version',clLime);

  if not(verifVersion) then exit;
  if debug=1 then Affiche('V�rification version en ligne',clLime);
  V_publie:=verifie_version;
  if notificationVersion and (v_publie>0) then
  begin
    val(version,V_utile,erreur);
    str(v_publie:2:2,s);
    if V_utile=V_publie then Affiche('Votre version '+Version+SousVersion+' est � jour',clLime);
    if V_utile>V_publie then Affiche('Votre version '+version+SousVersion+' est plus r�cente que la version publi�e '+s,clLime);
  end;
  
end;

{
procedure TFormVersion.TimerVerifTimer(Sender: TObject);
var V_utile,V_publie : real;
    erreur: integer;
    s : string;
begin
  if lance_verif>0 then dec(lance_verif);
  if lance_verif=0 then
  begin
    if not(verifVersion) then exit;
    if debug=1 then Affiche('V�rification version en ligne',clLime);
    V_publie:=verifie_version;
    if notificationVersion and (v_publie>0) then
    begin
      val(version,V_utile,erreur);
      str(v_publie:2:2,s);
      if V_utile=V_publie then Affiche('Votre version '+Version+SousVersion+' est � jour',clLime);
      if V_utile>V_publie then Affiche('Votre version '+version+SousVersion+' est plus r�cente que la version publi�e '+s,clLime);
    end;
  end;
end;
}

// ne parche pas pour les r�pertoires non vides
procedure DeleteDirectory(const DirName: string);
var
  FileFolderOperation: TSHFileOpStruct;
begin
  FillChar(FileFolderOperation, SizeOf(FileFolderOperation), 0);
  FileFolderOperation.wFunc := FO_DELETE;
  FileFolderOperation.pFrom := PChar(ExcludeTrailingPathDelimiter(DirName) + #0);
  FileFolderOperation.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
  SHFileOperation(FileFolderOperation);
end;

function DelDir(Dir: String): Boolean;
var fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos,SizeOf(fos));
  with fos do
  begin
    wFunc:=FO_DELETE;
    fFlags:=FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom:=PChar(Dir + #0);
  end;
  Result:=(0=ShFileOperation(fos));
end;



begin
end.
