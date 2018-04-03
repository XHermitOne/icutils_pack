{
Функции работы с клавиатурой

Версия: 0.0.1.1
}
unit keyboardfunc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils;

const
  { Коды клавиш }
  ESC_KEY: Integer = 27;    // ESCAPE Key
  ENTER_KEY: Integer = 13;  // ENTER Key
  SPACE_KEY: Integer = 32;  // SPACE Key


{
Проверка соответствия символа коду клавиши
@param cChar Символ
@param iKeyCode Код клавиши
@return True - соответствует / False - не соответствует
}
function SameKey(cChar: Char; iKeyCode: Integer): Boolean;

implementation

{
Проверка соответствия символа коду клавиши.
@param cChar Символ
@param iKeyCode Код клавиши
@return True - соответствует / False - не соответствует
}
function SameKey(cChar: Char; iKeyCode: Integer): Boolean;
begin
  result := Ord(cChar) = iKeyCode;
end;

end.

