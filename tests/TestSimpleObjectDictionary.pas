unit TestSimpleObjectDictionary;

interface

uses
  TestFramework, Classes, Variants, SimpleDictionary;

type
  TObjectTest = class
  public
    Id: Integer;
    Name: string;
  end;

  TestTSimpleObjectDictionary = class(TTestCase)
  strict private
    FObjectDictionary: TObjectDictionary;
    procedure UsesInvalidIndex;
    procedure UsesInvalidKey;
    function GetObjectTest(Id: Integer = 0; const Name: string = 'Simple Dictionary'): TObjectTest;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClear;
    procedure TestAdd;
    procedure TestAppend;
    procedure TestDelete;
    procedure TestDelete1;
    procedure TestIndexOf;
    procedure TestValues;
    procedure TestInvalidIndex;
    procedure TestInvalidKey;
  end;

implementation

uses
  Math, Types;

function TestTSimpleObjectDictionary.GetObjectTest(Id: Integer; const Name: string): TObjectTest;
begin
  Result := TObjectTest.Create;
  if not (Id > 0) then
    Id := Random(100);
  Result.Id := Id;
  Result.Name := Name;
end;

procedure TestTSimpleObjectDictionary.SetUp;
begin
  FObjectDictionary := TObjectDictionary.Create();
end;

procedure TestTSimpleObjectDictionary.TearDown;
begin
  FObjectDictionary.Free;
  FObjectDictionary := nil;
end;

procedure TestTSimpleObjectDictionary.TestClear;
var
  Obj1, Obj2: TObjectTest;
begin
  Obj1 := Self.GetObjectTest(1, 'Breno');
  Obj2 := Self.GetObjectTest(2, 'Martinusso');
  FObjectDictionary.Add(1, Obj1);
  FObjectDictionary.Add(2, Obj2);
  CheckEquals(2, FObjectDictionary.Count);
  FObjectDictionary.Clear;
  CheckEquals(0, FObjectDictionary.Count);
end;

procedure TestTSimpleObjectDictionary.TestAdd;
var
  Index: Integer;
begin
  Index := FObjectDictionary.Add(1, Self.GetObjectTest());
  CheckEquals(0, Index, 'Should return 0');
  Index := FObjectDictionary.Add(2, Self.GetObjectTest());
  CheckEquals(1, Index, 'Should return 1');
  Index := FObjectDictionary.Add(1, Self.GetObjectTest());
  CheckEquals(0, Index, 'Should return 0');
  Index := FObjectDictionary.Add(3, Self.GetObjectTest());
  CheckEquals(2, Index, 'Should return 2');
end;

procedure TestTSimpleObjectDictionary.TestAppend;
begin
  FObjectDictionary.Append(0, Self.GetObjectTest());
  CheckEquals(1, FObjectDictionary.Count, 'Should return 1');

  FObjectDictionary.Append(1, Self.GetObjectTest());
  CheckEquals(2, FObjectDictionary.Count, 'Should return 2');

  FObjectDictionary.Append(2, Self.GetObjectTest());
  CheckEquals(3, FObjectDictionary.Count, 'Should return 3');

  FObjectDictionary.Append(1, Self.GetObjectTest());
  CheckEquals(3, FObjectDictionary.Count, 'Should return 3');

  FObjectDictionary.Append(3, Self.GetObjectTest());
  CheckEquals(4, FObjectDictionary.Count, 'Should return 4');
end;

procedure TestTSimpleObjectDictionary.TestDelete;
var
  Index: Integer;
begin
  Index := FObjectDictionary.Add(1, Self.GetObjectTest());
  CheckEquals(0, Index, 'Should return 0');

  Index := FObjectDictionary.Add(2, Self.GetObjectTest());
  CheckEquals(1, Index, 'Should return 1');

  FObjectDictionary.Delete(Index);
  CheckEquals(1, FObjectDictionary.Count, 'Should return 1');

  Index := FObjectDictionary.Add(2, Self.GetObjectTest());
  CheckEquals(1, Index, 'Should return 0');

  Index := FObjectDictionary.Add(3, Self.GetObjectTest());
  CheckEquals(2, Index, 'Should return 2');

  Index := FObjectDictionary.Add(4, Self.GetObjectTest());
  CheckEquals(3, Index, 'Should return 2');

  FObjectDictionary.Delete(2);
  CheckEquals(3, FObjectDictionary.Count, 'Should return 3');
end;

procedure TestTSimpleObjectDictionary.TestDelete1;
begin
  FObjectDictionary.Append(0, Self.GetObjectTest());
  FObjectDictionary.Append(1, Self.GetObjectTest());
  FObjectDictionary.Append(2, Self.GetObjectTest());
  FObjectDictionary.Append(3, Self.GetObjectTest());
  FObjectDictionary.Append(4, Self.GetObjectTest());
  FObjectDictionary.Append(5, Self.GetObjectTest());

  FObjectDictionary.Delete(3);
  CheckEquals(5, FObjectDictionary.Count, 'Should return 5');
end;

procedure TestTSimpleObjectDictionary.TestIndexOf;
begin
  FObjectDictionary.Append(0, Self.GetObjectTest());
  FObjectDictionary.Append(1, Self.GetObjectTest());
  FObjectDictionary.Append(2, Self.GetObjectTest());
  FObjectDictionary.Append(3, Self.GetObjectTest());
  FObjectDictionary.Append(4, Self.GetObjectTest());
  FObjectDictionary.Append(5, Self.GetObjectTest());

  CheckEquals(0, FObjectDictionary.IndexOf(0), 'Should return 0');
  CheckEquals(3, FObjectDictionary.IndexOf(3), 'Should return 3');
end;

procedure TestTSimpleObjectDictionary.TestInvalidIndex;
begin
  CheckException(UsesInvalidIndex, EListError, 'should throw exception');
end;

procedure TestTSimpleObjectDictionary.TestInvalidKey;
begin
  CheckException(UsesInvalidKey, EListError, 'should throw exception');
end;

procedure TestTSimpleObjectDictionary.TestValues;
var
  Obj1, Obj2, Obj3: TObjectTest;
  Return1, Return2, Return3: TObjectTest;
begin
  Obj1 := Self.GetObjectTest(1, 'Breno');
  Obj2 := Self.GetObjectTest(2, 'Borges');
  Obj3 := Self.GetObjectTest(3, 'Martinusso');

  FObjectDictionary.Append(0, Obj1);
  Return1 := (FObjectDictionary.Values[0] as TObjectTest);
  CheckEquals(Obj1.Id, Return1.Id);
  CheckEquals(Obj1.Name, Return1.Name);

  FObjectDictionary.Append(0, Obj2);
  Return2 := (FObjectDictionary.Values[0] as TObjectTest);
  CheckEquals(Obj2.Id, Return2.Id);
  CheckEquals(Obj2.Name, Return2.Name);

  FObjectDictionary.Append(0, Obj3);
  Return3 := (FObjectDictionary.Values[0] as TObjectTest);
  CheckEquals(Obj3.Id, Return3.Id);
  CheckEquals(Obj3.Name, Return3.Name);
end;

procedure TestTSimpleObjectDictionary.UsesInvalidIndex;
begin
  FObjectDictionary.Append(0, nil);
  FObjectDictionary.Keys[1];
end;

procedure TestTSimpleObjectDictionary.UsesInvalidKey;
begin
  FObjectDictionary.Append(0, nil);
  FObjectDictionary.Values[1];
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTSimpleObjectDictionary.Suite);
end.

