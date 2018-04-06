{
Функции взаимодействия с операционной системой

Версия: 0.0.2.1
}
unit sysfunc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Process, FileUtil;

{$IFDEF linux}
{ some linux-specific code }
const OS: AnsiString = 'linux';
{$ENDIF}

{$IFDEF windows}
{ some M$-specific code }
const OS: AnsiString = 'windows';
{$ENDIF}

{ Тип операционной системы: linux/windows}
function GetOSType(): AnsiString;

{ Проверка является ли ОС Linux }
function IsOSLinux(): Boolean;

{ Проверка является ли ОС Windows }
function IsOSWindows(): Boolean;

{
Запуск внешней программы
@param Command комманда запуска
}
procedure ExecuteSystem(Command: AnsiString);

implementation

uses
  strfunc, logfunc;

{
Тип операционной системы: linux/windows
}
function GetOSType(): AnsiString;
begin
  Result := OS;
end;

{ Проверка является ли ОС Linux }
function IsOSLinux(): Boolean;
begin
  Result := OS = 'linux';
end;

{ Проверка является ли ОС Windows }
function IsOSWindows(): Boolean;
begin
  Result := OS = 'windows';
end;

{ Запуск внешней программы }
procedure ExecuteSystem(Command: AnsiString);
var
  cmd: TArrayOfString;
  i: Integer;
begin
  cmd := strfunc.SplitStr(Command, ' ');
  with TProcess.Create(nil) do
  try
    Executable := FindDefaultExecutablePath(cmd[0]);
    logfunc.DebugMsgFmt('Выполняющая программа <%s>', [Executable]);
    for i := 1 to Length(cmd) - 1 do
    begin
      Parameters.Add(Trim(cmd[i]));
      logfunc.DebugMsgFmt('%d. Параметр коммандной строки <%s>', [i, Trim(cmd[i])]);
    end;
    Execute;
  finally
    Free;
  end;
end;

end.

