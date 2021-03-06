{
Функции работы с файлами.

Версия: 0.0.2.1
}
unit filefunc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, sysfunc, strfunc;

{ Определить папку домашней директории }
function GetHomeDir(): AnsiString;

{ Домашняя папка в Linux системах }
function GetOSLinuxHomeDir(): AnsiString;
{ Домашняя папка в Windows системах }
function GetOSWindowsHomeDir(): AnsiString;

{ Функция соединяет пути с учётом особенностей операционной системы }
function JoinPath(PathParts: Array Of String): AnsiString;

{ Функция разделяет путь на составляющие }
function SplitPath(sPath: AnsiString): TArrayOfString;

{ Создать весь путь папки }
function CreateDirPath(sPath: AnsiString): Boolean;
{ Создать весь путь папки. Путь должен быть нормализован. }
function CreateDirPathTree(sPath: AnsiString): Boolean;

{ Создать пустой файл }
function CreateEmptyFile(sPath: AnsiString): Boolean;

{ Создать пустой файл если он не существует }
function CreateEmptyFileIfNotExists(sPath: AnsiString): Boolean;

{ Нормализовать путь до файла }
function NormalPathFileName(sPath: AnsiString): AnsiString;

{ Текущая папка }
function GetCurDir(): AnsiString;

implementation

uses
    logfunc;
{
Определить папку домашней директории
}
function GetHomeDir(): AnsiString;
begin
  result := '';
  if IsOSLinux() then
    Result := GetOSLinuxHomeDir()
  else if IsOSWindows() then
    Result := GetOSWindowsHomeDir()
    else
      logfunc.WarningMsg(Format('Не поддерживаемая ОС <%s>', [GetOSType()]));
end;

{
Домашняя папка в Linux системах.
}
function GetOSLinuxHomeDir(): AnsiString;
begin
  Result := '';
  {$IFDEF linux}
  Result := GetEnvironmentVariable('HOME');
  {$ENDIF}
end;

{
Домашняя папка в Windows системах.
}
function GetOSWindowsHomeDir(): AnsiString;
begin
  Result := '';
  {$IFDEF windows}
  Result := GetAppConfigDir(False);
  {$ENDIF}
end;

{
Функция соединяет пути с учётом особенностей операционной системы.
}
function JoinPath(PathParts: Array Of String): AnsiString;
begin
  Result := JoinStr(PathParts, PathDelim);
end;

{
Функция разделяет путь на составляющие.
}
function SplitPath(sPath: AnsiString): TArrayOfString;
begin
  Result := SplitStr(sPath, PathDelim);
end;


{
Создать весь путь папки
}
function CreateDirPath(sPath: AnsiString): Boolean;
begin
  Result := False;

  // Нормализация пути
  sPath := NormalPathFileName(sPath);

  if not DirectoryExists(sPath) then
  begin
    InfoMsg(Format('Создание папки <%s>', [sPath]));
    Result := CreateDirPathTree(sPath);
  end;
end;

{
Создать весь путь папки. Путь должен быть нормализован.
}
function CreateDirPathTree(sPath: AnsiString): Boolean;
var
  parent_path: AnsiString;
begin
  if not DirectoryExists(sPath) then
  begin
    parent_path := ExtractFileDir(sPath);
    if not DirectoryExists(parent_path) then
      Result := CreateDirPathTree(parent_path);
    CreateDir(sPath);
    Result := True;
    Exit;
  end;
  Result := False;
end;

{
Создать пустой файл.
}
function CreateEmptyFile(sPath: AnsiString): Boolean;
var
  file_tmp: Text;
begin
  // Нормализация пути
  sPath := NormalPathFileName(sPath);

  InfoMsg(Format('Создание пустого файла <%s>', [sPath]));
  AssignFile(file_tmp, sPath);
  try
    Rewrite(file_tmp);
    Writeln(file_tmp, '');   //Remember AnsiStrings are case sensitive
    CloseFile(file_tmp);
    Result := True;
  except
    Result := False;
    CloseFile(file_tmp);
  end;
end;

{
Создать пустой файл если он не существует.
}
function CreateEmptyFileIfNotExists(sPath: AnsiString): Boolean;
begin
  Result := False;
  if not FileExists(sPath) then
    Result := CreateEmptyFile(sPath)
end;

{
Нормализовать путь до файла.
}
function NormalPathFileName(sPath: AnsiString): AnsiString;
begin
  // Замена двойных слешей
  sPath := StringReplace(sPath, PathDelim + PathDelim, PathDelim, [rfReplaceAll]);
  Result := ExpandFileName(sPath);
end;

{ Текущая папка }
function GetCurDir(): AnsiString;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

end.

