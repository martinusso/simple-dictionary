unit SimpleDictionary;

interface

uses
  Classes, Variants;

type
  ISimpleDictionary = interface
  ['{63599D0E-F18C-42A3-930B-5788155C4671}']
  end;

  TFloatRecord = record
    Key: Variant;
    Value: Extended;
  end;

  TFloatArray = array of TFloatRecord;

  TFloatDictionary = class(TInterfacedObject, ISimpleDictionary)
  private
    FValues: TFloatArray;
    function GetCount: Integer;
    function GetValue(const Key: Variant): Extended;
    procedure SetValue(const Key: Variant; const Value: Extended);
    function GetKey(const Index: Integer): Variant;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Clear();
    function Add(const Key: Variant; const Value: Extended): Integer;
    procedure Append(const Key: Variant; const Value: Extended);
    procedure Delete(const Index: Integer); overload;
    procedure Delete(const Key: Variant); overload;

    function IndexOf(const Key: Variant): Integer;
    property Count: Integer read GetCount;
    property Keys[const Index: Integer]: Variant read GetKey;
    property Values[const Key: Variant]: Extended read GetValue write SetValue;
  end;

implementation

{ TFloatDictionary }

function TFloatDictionary.Add(const Key: Variant; const Value: Extended): Integer;
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
    FValues[Result].Value := Value;
  end
  else begin
    Size := Length(FValues) + 1;
    Result := Size - 1;

    SetLength(FValues, Size);
    FValues[Result].Key := Key;
    FValues[Result].Value := Value;
  end;
end;

procedure TFloatDictionary.Append(const Key: Variant; const Value: Extended);
begin
  Self.Add(Key, Value);
end;

procedure TFloatDictionary.Clear;
begin
  FillChar(FValues, SizeOf(FValues), 0);
end;

constructor TFloatDictionary.Create;
begin
  Self.Clear();
end;

procedure TFloatDictionary.Delete(const Key: Variant);
var
  Index: Integer;
begin
  Index := Self.IndexOf(Key);
  Self.Delete(Index);
end;

procedure TFloatDictionary.Delete(const Index: Integer);
var
  Size: Integer;
  TailElements: Cardinal;
begin
  if Index > High(FValues) then Exit;
  if Index < Low(FValues) then Exit;
  if Index = High(FValues) then
  begin
    SetLength(FValues, Length(FValues) - 1);
    Exit;
  end;
  Size := Length(FValues);
  TailElements := Size - Index;

  Finalize(FValues[Index]);
  Move(FValues[Index + 1], FValues[Index], SizeOf(TFloatArray) * TailElements);
  Initialize(FValues[Size - 1]);
  SetLength(FValues, Size - 1);
end;

destructor TFloatDictionary.Destroy;
begin
  Self.Clear();
  inherited;
end;

function TFloatDictionary.GetCount: Integer;
begin
  Result := Length(FValues);
end;

function TFloatDictionary.GetKey(const Index: Integer): Variant;
begin
  Result := FValues[Index].Key;
end;

function TFloatDictionary.GetValue(const Key: Variant): Extended;
var
  Index: Integer;
begin
  Index := Self.IndexOf(Key);
  Result := FValues[Index].Value;
end;

function TFloatDictionary.IndexOf(const Key: Variant): Integer;
var
  I: Integer;
  Size: Integer;
begin
  Result := -1;

  Size := Length(FValues);
  if Size > 0 then
  begin
    for I := 0 to Size - 1 do
    begin
      if FValues[I].Key = Key then
        Result := I;
    end;
  end;
end;

procedure TFloatDictionary.SetValue(const Key: Variant; const Value: Extended);
begin
  Self.Append(Key, Value);
end;

end.
