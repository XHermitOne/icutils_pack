{
Функции взаимодействия с операционной системой

Версия: 0.0.1.1
}
unit sysfunc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils;

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

implementation

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

end.

