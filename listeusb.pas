unit listeusb;

//=================================================//
//             Nicolas Paglieri (ni69)             //
//                  www.ni69.info                  //
//                & www.delphifr.com               //
//=================================================//
// Merci à DelphiProg pour son aide précieuse ! ;) //
//=================================================//


interface

uses Registry,ShellAPI, ComCtrls, 
  Windows, Messages, SysUtils, Variants, Classes;// Graphics, Controls,

 
var
  line : array of string;
  NumLine : integer;
  
procedure EnumerateDevices;
  
implementation


//============================================================================//
// Fonction de traduction en français des noms anglais des catégories de périphériques
// On ajoute ici l'index de l'icône de catégorie après un # pour gérer l'affichage
//============================================================================//
function Translate(English: string): string;
begin
 if English = 'CDROM' then result := 'Lecteurs de CD-ROM/DVD-ROM#09'
 else if English = 'Computer' then result := 'Ordinateur#14'
 else if English = 'DiskDrive' then result := 'Lecteurs de disque#10'
 else if English = 'Display' then result := 'Cartes Graphiques#01'
 else if English = 'fdc' then result := 'Contrôleur de lecteur de disquettes#04'
 else if English = 'FloppyDisk' then result := 'Lecteurs de disquettes#11'
 else if English = 'hdc' then result := 'Contrôleurs ATA/ATAPI IDE#05'
 else if English = 'Image' then result := 'Périphériques d''image#15'
 else if English = 'Keyboard' then result := 'Claviers#03'
 else if English = 'LegacyDriver' then result := 'Pilotes non Plug-and-Play#17'
 else if English = 'MEDIA' then result := 'Contrôleurs audio, vidéo et jeu#06'
 else if English = 'Modem' then result := 'Modems#12'
 else if English = 'Monitor' then result := 'Moniteurs#13'
 else if English = 'Mouse' then result := 'Souris et autres périphériques de pointage#20'
 else if English = 'Net' then result := 'Cartes réseau#02'
 else if English = 'NtApm' then result := 'Prise en charge NT APM/hérité#19'
 else if English = 'Ports' then result := 'Ports (COM et LPT)#18'
 else if English = 'Printer' then result := 'Imprimantes#08'
 else if English = 'System' then result := 'Périphériques Système#14'
 else if English = 'USB' then result := 'Contrôleurs de bus USB#07'
 else if English = 'Volume' then result := 'Volumes de stockage#21'
 else result := English+'#22'; // Périphérique inconnu
end;
//============================================================================//




//============================================================================//
//          PROCEDURE D'ENUMERATION DES PERIPHERIQUES SUR WINDOWS XP-7        //
//  ne marche pas avec W10
//============================================================================//
procedure EnumerateDevices;
var
 CategoriesList, SubCatList, SubSubCatList, FinalList : TStringList;
 nb, nb2, nb3 ,num: integer;
 Reg1, Reg2, Reg3 : TRegistry;
 HasBeenFound : boolean;
 listeCles : Tstrings;

begin


 CategoriesList := TStringList.Create; // Liste des catégories principales du registre
 SubCatList := TStringList.Create; // Liste intermédiaire
 SubSubCatList := TStringList.Create; // Liste intermédiaire
 FinalList := TStringList.Create; // Liste finale comprenant les périphériques

 // On crée les objets TRegistry qui serviront à parcourir l'arborescence
 Reg1 := TRegistry.Create;
 Reg2 := TRegistry.Create;
 Reg3 := TRegistry.Create;

 try
  // Définition de la clé racine
  Reg1.RootKey := HKEY_LOCAL_MACHINE;
  Reg2.RootKey := HKEY_LOCAL_MACHINE;
  Reg3.RootKey := HKEY_LOCAL_MACHINE;

  //----------------------------------------------------------------------------------------
  // 1ère ETAPE : ENUMARTION DES CATEGORIES DU REGISTRE (différentes des catégories finales)
  with TRegistry.Create do try
   RootKey := HKEY_LOCAL_MACHINE;

   //! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
   // IMPORTANT : DROITS D'ACCES
   // On ouvre les clés en lecture seule avec OpenKeyReadOnly
   // car on dispose de la valeur de sécurité d'accès KEY_READ.
   // En effet, seul SYSTEM a le droit d'ouvrir cette clé en écriture en temps normal.
   //! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !

   OpenKeyReadOnly('SYSTEM\CurrentControlSet\Enum');
   GetKeyNames(CategoriesList); // Récupération des catégories
   CloseKey;
  finally
   free;
  end;

   num:=1;Setlength(line,num+1);
   //-----------------------------------------------------------------------------------------------------------------------------------
   // 2eme ETAPE : PARCOURS DE L'ARBORESCENCE DU REGISTRE (les clés contenant les informations utiles sont contenues dans d'autres clés)
   for nb := 0 to CategoriesList.Count-1 do begin
    Reg1.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Enum\'+CategoriesList[nb]);
     Reg1.GetKeyNames(SubCatList);
     Reg1.CloseKey;
     for nb2 := 0 to SubCatList.Count-1 do begin
       Reg2.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Enum\'+CategoriesList[nb]+'\'+SubCatList[nb2]);
       Reg2.GetKeyNames(SubSubCatList);
       Reg2.CloseKey;
       for nb3 := 0 to SubSubCatList.Count-1 do begin
        Reg3.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Enum\'+CategoriesList[nb]+'\'+SubCatList[nb2]+'\'+SubSubCatList[nb3]);

        // Si on ne dispose ni du type de périphérique, ni de son nom,
        // Ou alors si le périphérique n'est plus disponible (si la clé "Control" n'est pas présente), on ne l'ajoute pas
        if ((Reg3.ReadString('Class')='') and (Reg3.ReadString('DeviceDesc')='')) or (not Reg3.KeyExists('Control'))  then begin
         Reg3.CloseKey;
         continue;
        // Si il s'agit d'un lecteur CD, d'un disque dur ou d'un port (COM ou LPT), on remplace la description du périphérique par un nom plus parlant
        end else if (Reg3.ReadString('Class')='CDROM') or (Reg3.ReadString('Class')='DiskDrive') or (Reg3.ReadString('Class')='Ports') then
         line[num] := Translate(Reg3.ReadString('Class'))+'|'+Reg3.ReadString('FriendlyName')
        else line[num] := Translate(Reg3.ReadString('Class'))+'|'+Reg3.ReadString('DeviceDesc');
        // Ajout des informations si elles sont présentes dans le registre
         if Reg3.ValueExists('DeviceDesc') then Line[num] := Line[num] + '§Description@'+Reg3.ReadString('DeviceDesc');
         if Reg3.ValueExists('FriendlyName') then Line[num] := Line[num] + '§FriendlyName@'+Reg3.ReadString('FriendlyName');
         if Reg3.ValueExists('Mfg') then Line[num] := Line[num] + '§Fabriquant@'+Reg3.ReadString('Mfg');
         if Reg3.ValueExists('Service') then Line[num] := Line[num] + '§Service@'+Reg3.ReadString('Service');
         if Reg3.ValueExists('LocationInformation') then Line[num] := Line[num] + '§Emplacement@'+Reg3.ReadString('LocationInformation');
         if Reg3.ValueExists('Class') then Line[num] := Line[num] + '§Enumérateur@'+Reg3.ReadString('Class');
        FinalList.Add(line[num]);
        inc(num);
        //Affiche(line,clyellow);
        Reg3.CloseKey;Setlength(line,num+1);
       end;
     end;
   end;

  NumLine:=num-1;

 finally
  // On libère les éléments créés au départ
  Reg3.Free;
  Reg2.Free;
  Reg1.Free;
  FinalList.Free;
  SubSubCatList.Free;
  SubCatList.Free;
  CategoriesList.Free;
 end;
end;

end.


 
 