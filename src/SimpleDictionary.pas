unit SimpleDictionary;

interface

uses
  Classes, Variants;

type
  ISimpleDictionary = interface
  ['{63599D0E-F18C-42A3-930B-5788155C4671}']
  end;

  TVariantRecord = record
    Key: Variant;
    Value: Variant;
  end;
  TVariantArray = array of TVariantRecord;

  TSimpleDictionary = class(TInterfacedObject, ISimpleDictionary)
  private
    FItems: TVariantArray;
    function GetCount: Integer;
    function GetValue(const Key: Variant): Variant;
    procedure SetValue(const Key: Variant; const Value: Variant);
    function GetKey(const Index: Integer): Variant;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Clear();
    function Add(const Key: Variant; const Value: Variant): Integer;
    procedure Append(const Key: Variant; const Value: Variant);
    procedure Delete(const Index: Integer); overload;
    procedure Delete(const Key: Variant); overload;

    function IndexOf(const Key: Variant): Integer;
    property Items: TVariantArray read FItems;
    property Count: Integer read GetCount;
    property Keys[const Index: Integer]: Variant read GetKey;
    property Values[const Key: Variant]: Variant read GetValue write SetValue;
  end;

  TDictionary = class(TSimpleDictionary);
  TFloatDictionary = class(TSimpleDictionary);

  // ObjectDictionary
  TObjectRecord = record
    Key: Variant;
    Value: TObject;
  end;
  TObjectArray = array of TObjectRecord;

  TSimpleObjectDictionary = class(TInterfacedObject, ISimpleDictionary)
  private
    FItems: TObjectArray;
    function GetCount: Integer;
    function GetValue(const Key: Variant): TObject;
    procedure SetValue(const Key: Variant; const Value: TObject);
    function GetKey(const Index: Integer): Variant;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Clear();
    function Add(const Key: Variant; const Value: TObject): Integer;
    procedure Append(const Key: Variant; const Value: TObject);
    procedure Delete(const Index: Integer); overload;
    procedure Delete(const Key: Variant); overload;

    function IndexOf(const Key: Variant): Integer;
    function Contains(const Key: Variant): Boolean;
    property Items: TObjectArray read FItems;
    property Count: Integer read GetCount;
    property Keys[const Index: Integer]: Variant read GetKey;
    property Values[const Key: Variant]: TObject read GetValue write SetValue;
  end;

  TObjectDictionary = class(TSimpleObjectDictionary);

implementation

{ TSimpleDictionary }

function TSimpleDictionary.Add(const Key, Value: Variant): Integer;
var
  Size: Integer;
begin
  if Key = null then
  begin
    Result := -1;
    Exit;
  end;

  Result := Self.IndexOf(Key);
  if Result > -1 then
  begin
    FItems[Result].Value := Value;
  end
  else begin
    Size := Length(FItems) + 1;
    Result := Size - 1;

    SetLength(FItems, Size);
    FItems[Result].Key := Key;
    FItems[Result].Value := Value;
  end;
end;

procedure TSimpleDictionary.Append(const Key, Value: Variant);
begin
  Self.Add(Key, Value);
end;

procedure TSimpleDictionary.Clear;
begin
  FillChar(FItems, SizeOf(FItems), 0);
end;

constructor TSimpleDictionary.Create;
begin
  Self.Clear();
end;

procedure TSimpleDictionary.Delete(const Key: Variant);
var
  Index: Integer;
begin
  Index := Self.IndexOf(Key);
  Self.Delete(Index);
end;

procedure TSimpleDictionary.Delete(const Index: Integer);
var
  Size: Integer;
  TailElements: Cardinal;
begin
  if Index > High(FItems) then Exit;
  if Index < Low(FItems) then Exit;
  if Index = High(FItems) then
  begin
    SetLength(FItems, Length(FItems) - 1);
    Exit;
  end;
  Size := Length(FItems);
  TailElements := Size - Index;

  Finalize(FItems[Index]);
  Move(FItems[Index + 1], FItems[Index], SizeOf(TVariantArray) * TailElements);
  Initialize(FItems[Size - 1]);
  SetLength(FItems, Size - 1);
end;

destructor TSimpleDictionary.Destroy;
begin
  Self.Clear();
  inherited;
end;

function TSimpleDictionary.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TSimpleDictionary.GetKey(const Index: Integer): Variant;
begin
  Result := FItems[Index].Key;
end;

function TSimpleDictionary.GetValue(const Key: Variant): Variant;
var
  Index: Integer;
begin
  Index := Self.IndexOf(Key);
  Result := FItems[Index].Value;
end;

function TSimpleDictionary.IndexOf(const Key: Variant): Integer;
var
  I: Integer;
  Size: Integer;
begin
  Result := -1;

  Size := Length(FItems);
  if Size > 0 then
  begin
    for I := 0 to Size - 1 do
    begin
      if FItems[I].Key = Key then
        Result := I;
    end;
  end;
end;

procedure TSimpleDictionary.SetValue(const Key, Value: Variant);
begin
  Self.Append(Key, Value);
end;

{ TSimpleObjectDictionary }

function TSimpleObjectDictionary.Add(const Key: Variant; const Value: TObject): Integer;
var
  Size: Integer;
begin
  if Key = null then
  begin
    Result := -1;
    Exit;
  end;

  Result := Self.IndexOf(Key);
  if Result > -1 then
  begin
    FItems[Result].Value := Value;
  end
  else begin
    Size := Length(FItems) + 1;
    Result := Size - 1;

    SetLength(FItems, Size);
    FItems[Result].Key := Key;
    FItems[Result].Value := Value;
  end;
end;

procedure TSimpleObjectDictionary.Append(const Key: Variant; const Value: TObject);
begin
  Self.Add(Key, Value);
end;

procedure TSimpleObjectDictionary.Clear;
begin
  FillChar(FItems, SizeOf(FItems), 0);
end;

function TSimpleObjectDictionary.Contains(const Key: Variant): Boolean;
begin
  Result := IndexOf(Key) > -1;
end;

constructor TSimpleObjectDictionary.Create;
begin
  Self.Clear();
end;

procedure TSimpleObjectDictionary.Delete(const Key: Variant);
var
  Index: Integer;
begin
  Index := Self.IndexOf(Key);
  Self.Delete(Index);
end;

procedure TSimpleObjectDictionary.Delete(const Index: Integer);
var
  Size: Integer;
  TailElements: Cardinal;
begin
  if Index > High(FItems) then Exit;
  if Index < Low(FItems) then Exit;
  if Index = High(FItems) then
  begin
    SetLength(FItems, Length(FItems) - 1);
    Exit;
  end;
  Size := Length(FItems);
  TailElements := Size - Index;

  Finalize(FItems[Index]);
  Move(FItems[Index + 1], FItems[Index], SizeOf(TObjectArray) * TailElements);
  Initialize(FItems[Size - 1]);
  SetLength(FItems, Size - 1);
end;

destructor TSimpleObjectDictionary.Destroy;
begin
  Self.Clear();
  inherited;
end;

function TSimpleObjectDictionary.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TSimpleObjectDictionary.GetKey(const Index: Integer): Variant;
begin
  Result := FItems[Index].Key;
end;

function TSimpleObjectDictionary.GetValue(const Key: Variant): TObject;
var
  Index: Integer;
begin
  Index := Self.IndexOf(Key);
  Result := FItems[Index].Value;
end;

function TSimpleObjectDictionary.IndexOf(const Key: Variant): Integer;
var
  I: Integer;
  Size: Integer;
begin
  Result := -1;

  Size := Length(FItems);
  if Size > 0 then
  begin
    for I := 0 to Size - 1 do
    begin
      if FItems[I].Key = Key then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

procedure TSimpleObjectDictionary.SetValue(const Key: Variant; const Value: TObject);
begin
  Self.Append(Key, Value);
end;

end.
