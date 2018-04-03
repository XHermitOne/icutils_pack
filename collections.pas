{
Модуль поддержки коллекций объектов.

Версия: 0.0.0.1
}
unit collections;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  { Класс именованного элемента коллекции }
  TICNamedCollectionItem = class(TCollectionItem)
  private
    { Наименование }
    FName: String;

  protected
    { Процедура получения имени менеджера }
    function GetDisplayName: string; override;
    { Процедура установки имени менеджера }
    procedure SetDisplayName(const AValue: string); override;

  public
    constructor Create(ACollection : TCollection); override;
    destructor Destroy; override;
    property DisplayName : string read GetDisplayName write SetDisplayName;

  published

    { Наименование. Свойство }
    property Name : string read FName write SetDisplayName;

  end;
  TICNamedCollectionItemClass = class of TICNamedCollectionItem;

  { Класс коллекции }
  TICCollection = class(TOwnedCollection)
  private

    { Метод получения элемена по индексу }
    function GetItem(Index: Longint): TICNamedCollectionItem;
    { Метод записи элемента по индексу }
    procedure SetItem(Index: Longint; const AValue: TICNamedCollectionItem);

  protected
    { Объект владельца коллекции }
    FOwner: TComponent;

    { Установить наименование элемента коллекции }
    procedure SetItemName(AItem: TCollectionItem); override;

  public
    { Определение индекса внутреннего элемента по имени }
    function IndexOf(const AName: string): Longint;
    { Функция поиска }
    function Find(const AName: string): TICNamedCollectionItem;
    { Процедура заполнения списка имен элементов коллекции }
    procedure GetItemNames(List: TStrings);

    { Элементы коллекции. Свойиство }
    property Items[Index: Longint]: TICNamedCollectionItem read GetItem write SetItem; default;

    { объект владельца-движка SCADA системы. Свойство }
    property Owner: TComponent read FOwner;
  end;
  TICCollectionClass = class of TICCollection;

implementation

uses
  logfunc;

{---------------------- TICNamedCollectionItem  ----------------------------------}
constructor TICNamedCollectionItem.Create(ACollection : TCollection);
begin
  inherited Create(ACollection);
end;

destructor TICNamedCollectionItem.Destroy;
begin
  inherited Destroy;
end;

function TICNamedCollectionItem.GetDisplayName: string;
begin
  Result := FName;
end;

{ Процедура установки имени менеджера }
procedure TICNamedCollectionItem.SetDisplayName(const AValue: string);
var
  TmpInd : Integer;
begin
  if FName = AValue then
    Exit;
  if (AValue <> '') and (Collection is TICCollection) then
  begin
    TmpInd := (TICCollection(Collection).IndexOf(AValue));
    if (TmpInd >= 0) and (TmpInd <> Index) then
      logfunc.ErrorMsgFmt('Дублирование имени <%s> в <%s>', [AValue, Collection.ClassName]);
  end;
  FName := AValue;
  inherited SetDisplayName(AValue);
end;

{---------------------- TICCollection  ----------------------------------}
function TICCollection.GetItem(Index: Longint): TICNamedCollectionItem;
begin
  Result := TICNamedCollectionItem(inherited Items[Index]);
end;

procedure TICCollection.SetItem(Index: Longint; const AValue: TICNamedCollectionItem);
begin
  inherited Items[Index] := AValue;
end;

function TICCollection.IndexOf(const AName: string): Longint;
var
  i: LongInt;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiSameText(TICNamedCollectionItem(Items[i]).Name, AName) then
    begin
      Result := i;
      Break;
    end;
end;

procedure TICCollection.SetItemName(AItem: TCollectionItem);
begin
  with AItem as TICNamedCollectionItem do
    if Name = '' then
    begin
      Name := Copy(ClassName, 2, Length(ClassName) - 1) + IntToStr(ID + 1);
    end
  else
    inherited SetItemName(AItem);
end;

function TICCollection.Find(const AName: string): TICNamedCollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiSameText(TICNamedCollectionItem(Items[i]).Name, AName) then
    begin
      Result := TICNamedCollectionItem(Items[i]);
      Break;
    end;
end;

procedure TICCollection.GetItemNames(List: TStrings);
var
  i: LongInt;
begin
  for i := 0 to Count - 1 do
    List.Add(TICNamedCollectionItem(Items[i]).Name);
end;

end.

