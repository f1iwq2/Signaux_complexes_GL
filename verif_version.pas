unit verif_version;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
      Dialogs, StdCtrls , ComCtrls ,WinInet, ExtCtrls , StrUtils;

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

Const  Version='4.2';  // sert à la comparaison de la version publiée
       SousVersion=' '; // en cas d'absence de sous version mettre un espace

implementation

uses UnitPrinc;

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
function DownloadURL_NOCache(aUrl: string;s : string): Boolean;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  Fs:TFileStream;
  lpBuffer: array[0..1024 + 1] of byte;
  dwBytesRead: DWORD;
  dwTimeout : integer;
begin
  Result:=False;
  DeleteFile(s);
  Try Fs:=TFileStream.Create(s,fmCreate,fmShareDenyNone);
    hSession:=InternetOpen('MyApp',INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    try
      if Assigned(hSession) then
      begin
        // fonction longue
        dwTimeout:=2000; //2s
        InternetSetOption(hSession,INTERNET_OPTION_CONNECT_TIMEOUT,@dwTimeOut, SizeOf(dwTimeOut));
        hService:=InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
        if Assigned(hService) then
        try
          while True do
            begin
              dwBytesRead:=1024;
              InternetReadFile(hService,@lpBuffer,1024,dwBytesRead);
              fs.WriteBuffer(lpBuffer,dwBytesRead);
              if dwBytesRead=0 then break;
            end;
            Result:=True;
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

procedure verifie_version;
var s,s2,s3,Version_p,Url,LocalFile : string;
    trouve_version,trouve_zip,zone_comm : boolean;
    fichier : text;
    i,j,erreur,Ncomm,i2,i3,l : integer;
    V_publie,V_utile : real;
    SV_publie : char;
    comm : array[1..10] of string;
begin
    //Affiche('vérifie version',clLime);
    if not(AvecInit)  then exit ;
    if not(verifVersion) then exit;
    Url:='http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906#p50499';
    LocalFile:='page.txt';
    trouve_version:=false;
    trouve_zip:=false;
    zone_comm:=false;
    Ncomm:=0;
    if DownloadURL_NOCache(Url,localFile) then
    begin
      AssignFile(fichier,LocalFile);
      reset(fichier);
      while not(eof(fichier)) and  (not(trouve_version) or not(trouve_zip)) do
      begin
        readln(fichier,s);
        //Affiche(s,clyellow);
        s:=LowerCase(s);
        if not(trouve_version) then
        begin
          i:=pos('version ',s);
          trouve_version:=i<>0;
          if trouve_version then 
          begin 
            s2:=s;zone_comm:=true;
            //Affiche('trouvé version',clOrange);
          end;
        end;
        if not(trouve_zip) then
        begin
          i:=pos('.zip',s);
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
          i:=pos('bold">',s)+6;i2:=posEx('<br />',s,i+1); i3:=posEx('</span>',s,i+1) ;
          if i<>6 then
          begin
            //Affiche(s,clred);
            inc(ncomm);
            if i3<i2 then i2:=i3;
            comm[ncomm]:=UTF8Decode(copy(s,i,i2-i));
            Delete(s,1,i2-1);
            j:=0;
            repeat
              i:=pos('<br />',s)+6;i3:=posEx('</span>',s,i+1);i2:=posEx('<br />',s,i+1);
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
        i:=pos('version ',s2);
        delete(s2,1,i+7);
        j:=pos(' ',s2);
        Version_p:=copy(s2,1,j-1);        // version dans version_p
        // isoler l'url du zip
        i:=pos('href="',s3);
        delete(s3,1,i+5);
        j:=pos('"',s3);
        s3:=copy(s3,1,j-1);
        i:=pos('.',s3);
        if i<>0 then delete(s3,i,1); // supprimer le .
        s3:='http://cdmrail.free.fr/ForumCDR'+s3 ;

        // changer le . en ,
        s:=Version_p;
        // i:=pos('.',s);if i<>0 then s[i]:=',';
        s2:=version;
       // i:=pos('.',s2);if i<>0 then s2[i]:=',';

        s:=AnsiUppercase(s);
        l:=length(s);
        SV_publie:=s[l];
        if Sv_publie in ['0'..'9'] then Sv_Publie:=' ' else s:=copy(s,1,l-1);

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
          //aff(s3);               // url dans s3
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
            s:=GetCurrentProcessEnvVar('USERPROFILE')+'\Downloads\Signaux_Complexes_GL.Zip';
            Aff('Téléchargement de '+s3+' dans ');
            Aff(s);

            if DownloadURL_NOCache(s3,s) then
            //if true then
            begin
              Aff('Téléchargement réussi');
              Aff('Vous pouvez ouvrir le dossier de téléchargement, décomprimer le zip et l''installer');
            end
              else Aff('Echec de téléchargement');
          end
          else formVersion.Free;
        end;

        if (V_utile=V_publie) and notificationVersion then Affiche('Votre version '+Version_p+SousVersion+' est à jour',clLime);

      end;
    end
    else
      begin
        if notificationVersion then Affiche('Pas d''accès au site CDM rail ou échec téléchargement',clorange);
      end;
end;


procedure TFormVersion.FormCreate(Sender: TObject);
begin
  Timerverif.Interval:=1000;    // timer à 1 seconde
  Lance_verif:=2;               // lancer la vérification de version dans 1s
end;

procedure TFormVersion.TimerVerifTimer(Sender: TObject);
begin
  if lance_verif>0 then dec(lance_verif);
  if lance_verif=1 then verifie_version;
end;

end.
