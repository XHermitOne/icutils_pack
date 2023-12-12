{
Функции математических вычислений.

Версия: 0.0.1.2
}
unit mathfunc;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils;

{ Вычислить сумму }
function SumRangeAsInteger(AIntegerListAsStr: TStringList; AStartIdx, AStopIdx: Integer): LongInt;
function SumRangeAsInteger(AIntegerListAsStr: TStrings; AStartIdx, AStopIdx: Integer): LongInt;


implementation

uses
    logfunc;

{ Вычислить сумму }
function SumRangeAsInteger(AIntegerListAsStr: TStringList; AStartIdx, AStopIdx: Integer): LongInt;
var
  i: Integer;
begin
  Result := 0;

  for i := AStartIdx to AStopIdx - 1 do
    Result := Result + StrToInt(AIntegerListAsStr.Strings[i]);
end;

function SumRangeAsInteger(AIntegerListAsStr: TStrings; AStartIdx, AStopIdx: Integer): LongInt;
var
  i: Integer;
begin
  Result := 0;

  for i := AStartIdx to AStopIdx - 1 do
    Result := Result + StrToInt(AIntegerListAsStr.Strings[i]);
end;

end.
