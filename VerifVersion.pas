unit VerifVersion;

interface
//procedure verifie_version;

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
      Dialogs, StdCtrls , ComCtrls ,WinInet;

procedure verifie_version;
      
implementation

function GetCurrentProcessEnvVar(const VariableName: string): string;
var
  nSize: DWord;
begin
  nSize:= 0;
  nSize:= GetEnvironmentVariable(PChar(VariableName), nil, nSize);
  if nSize = 0 then
  begin
    result:= '';
  end   
  else
  begin
    SetLength(result, nSize - 1);
    if GetEnvironmentVariable(PChar(VariableName), PChar(result), nSize) <> nSize - 1 then
      raise Exception.Create(SysErrorMessage(GetlastError))
  end;
end;


function DownloadURL_NOCache(aUrl: string;s : string): Boolean;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  Fs:TFileStream;
  lpBuffer: array[0..1024 + 1] of byte;
  dwBytesRead: DWORD;
begin
  Result := False;

  Try Fs := TFileStream.Create(s,fmCreate);
    hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    try
      if Assigned(hSession) then
      begin
        hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
        if Assigned(hService) then
        try
          while True do
            begin
              dwBytesRead := 1024;
              InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
              fs.WriteBuffer(lpBuffer, dwBytesRead);
              if dwBytesRead = 0 then break;
            end;
            Result := True;
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
var s,s2,Url,LocalFile : string;
    trouve : boolean;
    fichier : text;
    i : integer;
    V_publie,V_utile : real;
begin
    Url:='http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906#p50499';
    LocalFile:='page.txt';
    trouve:=false;
    if DownloadURL_NOCache(Url,localFile) then
    begin
      AssignFile(fichier,LocalFile);
      reset(fichier);
      while not(eof(fichier) or trouve) do
      begin
      readln(fichier,s);
      s:=UpperCase(s);
      //Affiche(s,clyellow);
      i:=pos('VERSION ',s);
      trouve:=i<>0;                                      
    end;
    closefile(fichier);
    if trouve then 
    begin
      delete(s,1,i+7);
      i:=pos('VERSION ',s);  
      i:=pos(' ',s);
      s:=copy(s,1,i-1);   
      //Affiche('Version '+s,clgreen);
      // changer le . en ,
      i:=pos('.',s);s[i]:=',';
      s2:=version;
      i:=pos('.',s2);s2[i]:=',';
      
      V_publie:=StrToFloat(s);
      V_utile:=StrToFloat(s2);
        if V_utile<V_publie then 
        begin
          s:='Vous utilisez la version '+version+' mais il existe la version '+s;
          //Affiche(s,clOrange);
          if MessageDlg(s+' Voulez-vous la télécharger?',
             mtConfirmation,[mbYes,mbNo],0)=mrYes then
          begin
            s:=GetCurrentProcessEnvVar('USERPROFILE')+'\Downloads\Signaux_Complexes_GL.Zip';
            //Affiche('A télécharger dans '+s,ClLime);
            if DownloadURL_NOCache('http://cdmrail.free.fr/ForumCDR/download/file.php?id=12070',s) then
            //Affiche('Téléchargement réussi',clLime);
          end;
        end;
       
        //if V_utile=V_publie then Affiche('Version Actuelle=Version publiée : votre version est à jour',clLime);
      
      end;  
    end 
    else
      //Affiche('Pas d''accès au site CDM rail',ClLime);
  end;

end.
