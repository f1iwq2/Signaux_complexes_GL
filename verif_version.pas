unit verif_version;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , ComCtrls ,WinInet, ExtCtrls , StrUtils, unitPrinc,
  ShellAPI , comObj , ShlObj , ActiveX ;

type
  TFormVersion = class(TForm)
    TimerVerif: TTimer;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure TimerVerifTimer(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormVersion: TFormVersion;
  Lance_verif : integer;
  verifVersion,notificationVersion,essai : boolean;
  chemin_Dest,chemin_src,date_creation,nombre_tel : string;

Const  Version='8.5';  // sert � la comparaison de la version publi�e
       SousVersion=' '; // A B C ... en cas d'absence de sous version mettre un espace
       // pour unzip
       SHCONTCH_NOPROGRESSBOX = 4;
       SHCONTCH_AUTORENAME = 8;
       SHCONTCH_RESPONDYESTOALL = 16;
       SHCONTF_INCLUDEHIDDEN = 128;
       SHCONTF_FOLDERS = 32;
       SHCONTF_NONFOLDERS = 64;

function GetCurrentProcessEnvVar(const VariableName: string): string;
function verifie_version : real;
function DownloadURL_NOCache(aUrl: string;s : string;var taille : longint): Boolean;
function Unzip(zipfile : oleVariant): boolean;

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
        12007 : Affiche('Erreur de r�solution DNS',clred);
        12037 : Affiche('Erreur validit� de certificat - Mettre windows � jour',clred);
        12157 : Affiche('Erreur canal s�curis� SSL 2.0 - Mettre windows � jour',clred);
        else affiche('Erreur '+intToSTR(i),clred);
        end;
        if Assigned(hService) then
        try
          //Affiche('Service assign�',clLime);
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

procedure copie_fichier(s : string);
var fs,fd : string;
    i : integer;
begin
  fd:=chemin_dest+s;
  fs:=chemin_src+s;
  //Affiche(fd,clOrange);
  //Affiche(fs,clOrange);

  if not(copyfile(pchar(fs),pchar(fd),false)) then
  begin
    fs:=' non copi�';    // true �vite de le recopier
    i:=getLastError;
    Affiche('Erreur '+s,clred);
    Affiche('non copi�. Erreur '+intToSTR(i)+': '+SysErrorMessage(i),clred);
  end
  else
  Affiche(s+' copi�',clLime);
end;

procedure cree_raccourci(nom_exe : string);
var
  LinkName : WideString;
  TargetName : String;
  IObject : IUnknown;
  ISLink : IShellLink;
  IPFile : IPersistFile;
  PIDL : PItemIDList;
  InFolder : array[0..MAX_PATH] of Char;
begin
  TargetName:=CheminProgrammes+'\Signaux_complexes\'+nom_exe;
  IObject:=CreateComObject(CLSID_ShellLink);
  ISLink:=IObject as IShellLink;
  IPFile:=IObject as IPersistFile;

  with ISLink do begin
    SetPath(pChar(TargetName));
    SetWorkingDirectory(pChar(ExtractFilePath(TargetName)));
  end;

  // on veut placer le lien sur le bureau
  SHGetSpecialFolderLocation(0,CSIDL_DESKTOPDIRECTORY,PIDL);
  SHGetPathFromIDList(PIDL,InFolder);

  if nom_exe='signaux_complexes_gl.exe' then LinkName:=InFolder + '\Signaux Complexes.lnk';
  if nom_exe='signaux_complexes_gl_d11.exe' then LinkName:=InFolder + '\Signaux Complexes D11.lnk';

  IPFile.Save(PWChar(LinkName),false);
end;


// d�zipe copie les fichiers et lance la nouvelle version
// s : chemin etfichier � d�ziper
procedure dezipe_copie(s : string);
var fichier,nomPDF : string;
    dirList : tStrings;
    SR      : TSearchRec;
    nombre,i,attributes : integer;
    pdf,ok : boolean;
begin
  Aff('T�l�chargement r�ussi, d�compression');
  formVersion.close;

  Affiche('D�compression du zip '+s,clLime);
  if not(unzip(s)) then
  begin
    Affiche('Erreur � la d�compression du zip',clred);
    exit;
  end;

  chemin_src:=s;
  i:=pos('.zip',chemin_src);
  if i=0 then
  begin
    affiche('nom du zip invalide',clred);
    exit;
  end;
  delete(chemin_src,i,4);  // transforme en chemin

  // V�rifier si r�pertoire dest existe
  chemin_Dest:=CheminProgrammes+'\Signaux_complexes';
  if not(directoryExists(chemin_Dest)) then
  begin
    Affiche('Cr�ation du r�pertoire '+chemin_dest,clLime);
    mkDir(chemin_dest);
  end;
  chemin_dest:=chemin_dest+'\';
  chemin_src:=chemin_src+'\';

  // remplit dirlist avec les noms de fichiers du chemin dest
  nombre:=0;
  DirList:=TStringList.Create;
  if FindFirst(chemin_dest+ '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      s:=sr.Name;
      if (s<>'.') and (s<>'..') then
      begin
        DirList.Add(SR.Name); //Fill the list
        inc(nombre);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;

  // supprimer les fichiers *.Exe et versions.txt et pdf
  nomPdf:='';
  for i:=0 to nombre-1 do
  begin
    s:=DirList.Strings[i];
    s:=lowercase(s);
    pdf:=pos('.pdf',s)<>0;
    if pdf then nomPDF:=s;

    //Affiche(s,clyellow);
    // fichiers � supprimer dans r�pertoire destination
    if (pos('.exe',s)<>0) or (s='versions.txt') or pdf then
    begin
      fichier:=chemin_dest+s;
      if sysutils.FileExists((fichier)) then
      begin
        Affiche('Suppression de '+fichier,clorange);
        Attributes:=FileGetAttr(pchar(fichier));
        Attributes := Attributes and not (faReadOnly or faHidden);
        SetFileAttributes(pchar(fichier),Attributes);
        ok:=sysutils.DeleteFile(pchar(fichier));
        if not(OK) then Affiche('Erreur : Pas r�ussi � supprimer '+fichier,clred);
      end;
    end;
  end;

  // copie les fichiers du r�pertoire zip vers le rep install�
  copie_fichier('signaux_complexes_gl.exe');
  copie_fichier('signaux_complexes_gl_d11.exe');
  copie_fichier('versions.txt');

  // trouver du nom du pdf dans le chemin source
  nombre:=0;
  // remplit dirlist avec les noms de fichiers du chemin src
  if FindFirst(chemin_src+ '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      s:=sr.Name;
      if (s<>'.') and (s<>'..') then
      begin
        DirList.Add(SR.Name); //Fill the list
        if pos('.pdf',sr.Name)<>0 then NomPdf:=sr.name;
        inc(nombre);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
  DirList.Destroy;

  if nomPdf<>'' then copie_fichier(nomPdf);

  Affiche('Cr�ation des raccourcis sur le bureau',cllime);
  cree_raccourci('signaux_complexes_gl.exe');
  cree_raccourci('signaux_complexes_gl_d11.exe');

  if essai then exit;

  s:='';
  Affiche('Lancement de la nouvelle version',clyellow);
  Application.processMessages;
  Sleep(3000);
  i:=ShellExecute(Formprinc.Handle,'open',
                    Pchar('signaux_complexes_gl_d11.exe'),
                    Pchar(s),  // param�tre
                    PChar(chemin_dest)  // r�pertoire
                    ,SW_SHOWNORMAL);
  if i>32 then
  begin
    Affiche('lancement ok',cllime);
    Application.Terminate;
  end
  else
  begin
    Affiche('Erreur '+intToSTR(i),clred);
    exit;
  end;

end;

// renvoie le num�ro de version depuis le site github
// si 0
function verifie_version : real;
var description,s,s2,s3,Version_p,Url,LocalFile,nomfichier,date_creation_ang : string;
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

        // adresse de t�l�chargement
        s3:=extrait_champ('browser_download_url');
        if s3<>'' then trouve_zip:=true;

        // nombre de t�l�chargements
        nombre_tel:=extrait_champ_simple('download_count');

        // date de cr�ation
        date_creation_ang:=extrait_champ('published_at');
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

        // version publi�e
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
          // couper en cha�nes
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

          until j=0;
          //
          ncomm:=i;
          comm[i]:=supprime_anti(description);

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
          if nComm>0 then
          begin
            FormVersion.Memo1.lines.Clear;
            Aff('Nouveaut�s de la V'+version_p+SV_publie+' de Signaux_Complexes_GL du '+date_creation);
            aff(' ');
            for i:=1 to ncomm do aff(comm[i]);
          end;
          if MessageDlg(s+#13+'Voulez-vous la t�l�charger, l''installer et l''ex�cuter?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
          begin
            // r�cup�rer depuis la variable d'environnement windows USERPROFILE le repertoire de la session ouverte
            s:=GetCurrentProcessEnvVar('USERPROFILE')+'\Downloads\'+Nomfichier;

            essai:=false;

            if not(essai) then
            begin
              Aff('T�l�chargement de '+s3+' dans ');
              Aff(s);
              Affiche('T�l�chargement de '+s3+' dans '+s,clLime);
            end;

            if essai then
            begin
              Affiche('*** mode essai ***',clOrange);
              dezipe_copie(s);
              exit;
            end;

            if DownloadURL_NOCache(s3,s,taille) then
            begin
              if taille>700000 then
              begin
                dezipe_copie(s);
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
begin
  if debug=1 then Affiche('Cr�ation fen�tre version',clLime);
  Timerverif.Interval:=1000;    // timer � 1 seconde
  Lance_verif:=2;               // lancer la v�rification de version dans 3s
  if debug=1 then Affiche('Fin cr�ation fen�tre version',clLime);
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

//  https://github.com/sx2008/Delphi-Test-Apps/blob/master/ShellZipTest/ShellZipTool.pas
function Unzip(zipfile : oleVariant): boolean;
var
  shellobj,srcfldr, destfldr, shellfldritems,repertoire: Olevariant;
  filtre: string;
  i : integer;
  erreur : integer;
begin
  filtre:='';
  zipfile:=lowercase(zipfile);
  i:=pos('.zip',zipfile);
  if i=0 then exit;
  filtre:=zipfile;
  delete(filtre,i,4);

  if directoryExists(filtre) then DeleteDirectory(filtre);

  {$I-}
  MkDir(filtre);
  erreur:=IoResult;
  {$I+}
  if erreur<>0 then
  begin
    Affiche('Impossible de cr�er r�pertoire',clred);
    exit;
  end;


  repertoire:=filtre;  // mettre dans olevariant

  filtre:='';
  shellobj:=CreateOleObject('Shell.Application');

  srcfldr:=ShellObj.NameSpace(Zipfile);
  if not ((VarType(srcfldr)=varDispatch) and Assigned(TVarData(srcfldr).VDispatch)) then
  begin
    Affiche(zipfile+ ' invalide ou absent',clred);
    result:=false;
    exit;
  end;

  destfldr:=ShellObj.NameSpace(repertoire);
  if not ((VarType(destfldr)=varDispatch) and Assigned(TVarData(destfldr).VDispatch)) then
  begin
    Affiche(' r�pertoire destination invalide : '+ repertoire,clred);
    result:=false;
    exit;
  end;

  shellfldritems:=srcfldr.Items;
  if (filtre<>'') then shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filtre);

  //destfldr.CopyHere(shellfldritems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  destfldr.CopyHere(shellfldritems,  SHCONTCH_RESPONDYESTOALL);
  result:=true;
end;


begin
end.
