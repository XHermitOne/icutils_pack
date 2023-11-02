{
Функции взаимодействия с Python

Версия: 0.0.0.1
}
unit pyfunc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Process, FileUtil, StrUtils;

{
Определить версию Python
@param PythonExef комманда запуска Python
}
function GetPythonVersion(PythonExec: AnsiString): AnsiString;

{ Определить версию Python3 }
function GetPython3Version(): AnsiString;

{ Определить версию Python2 }
function GetPython2Version(): AnsiString;

implementation

uses
  strfunc, logfunc;

{ Определить версию Python }
function GetPythonVersion(PythonExec: AnsiString): AnsiString;
var
  str: AnsiString;
begin
  Result := '';
  if RunCommand(PythonExec, ['--version'], str) then
    str := ReplaceStr(Trim(str), 'Python ', '');
    logfunc.DebugMsgFmt('Версия Python <%s>', [str]);
    Result := str;
end;

{ Определить версию Python3 }
function GetPython3Version(): AnsiString;
begin
  Result := GetPythonVersion('python3');
end;

{ Определить версию Python2 }
function GetPython2Version(): AnsiString;
begin
  Result := GetPythonVersion('python2');
end;

end.

