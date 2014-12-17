unit TestSimpleDictionary;

interface

uses
  TestFramework, Classes, Variants, SimpleDictionary;

type
  TestTSimpleDictionary = class(TTestCase)
  strict private
    FSimpleDictionary: TSimpleDictionary;
    procedure UsesInvalidIndex;
    procedure UsesInvalidKey;
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
    procedure TestStress;
  end;

implementation

uses
  Math, Types;

procedure TestTSimpleDictionary.SetUp;
begin
  FSimpleDictionary := TSimpleDictionary.Create();
end;

procedure TestTSimpleDictionary.TearDown;
begin
  FSimpleDictionary.Free;
  FSimpleDictionary := nil;
end;

procedure TestTSimpleDictionary.TestClear;
begin
  FSimpleDictionary.Add(1, 10.123);
  FSimpleDictionary.Add(2, 'Simple Dictionary');
  CheckEquals(2, FSimpleDictionary.Count);
  FSimpleDictionary.Clear;
  CheckEquals(0, FSimpleDictionary.Count);
end;

procedure TestTSimpleDictionary.TestAdd;
var
  Index: Integer;
begin
  Index := FSimpleDictionary.Add(1, 10.123);
  CheckEquals(0, Index, 'Should return 0');
  Index := FSimpleDictionary.Add(2, False);
  CheckEquals(1, Index, 'Should return 1');
  Index := FSimpleDictionary.Add(1, 'Martinusso');
  CheckEquals(0, Index, 'Should return 0');
  Index := FSimpleDictionary.Add(3, 30);
  CheckEquals(2, Index, 'Should return 2');
end;

procedure TestTSimpleDictionary.TestAppend;
begin
  FSimpleDictionary.Append(0, 0);
  CheckEquals(1, FSimpleDictionary.Count, 'Should return 1');

  FSimpleDictionary.Append(1, 10);
  CheckEquals(2, FSimpleDictionary.Count, 'Should return 2');

  FSimpleDictionary.Append(2, 20);
  CheckEquals(3, FSimpleDictionary.Count, 'Should return 3');

  FSimpleDictionary.Append(1, 11);
  CheckEquals(3, FSimpleDictionary.Count, 'Should return 3');

  FSimpleDictionary.Append(3, 30);
  CheckEquals(4, FSimpleDictionary.Count, 'Should return 4');
end;

procedure TestTSimpleDictionary.TestDelete;
var
  Index: Integer;
begin
  Index := FSimpleDictionary.Add(1, 10);
  CheckEquals(0, Index, 'Should return 0');

  Index := FSimpleDictionary.Add(2, 20);
  CheckEquals(1, Index, 'Should return 1');

  FSimpleDictionary.Delete(Index);
  CheckEquals(1, FSimpleDictionary.Count, 'Should return 1');

  Index := FSimpleDictionary.Add(2, 20);
  CheckEquals(1, Index, 'Should return 0');

  Index := FSimpleDictionary.Add(3, 30);
  CheckEquals(2, Index, 'Should return 2');

  Index := FSimpleDictionary.Add(4, 'Simple Dictionary');
  CheckEquals(3, Index, 'Should return 2');

  FSimpleDictionary.Delete(2);
  CheckEquals(3, FSimpleDictionary.Count, 'Should return 3');
end;

procedure TestTSimpleDictionary.TestDelete1;
begin
  FSimpleDictionary.Append(0, 0);
  FSimpleDictionary.Append(1, 10);
  FSimpleDictionary.Append(2, 20);
  FSimpleDictionary.Append(3, 30);
  FSimpleDictionary.Append(4, 40);
  FSimpleDictionary.Append(5, 'Delphi');

  FSimpleDictionary.Delete(3);
  CheckEquals(5, FSimpleDictionary.Count, 'Should return 5');
end;

procedure TestTSimpleDictionary.TestIndexOf;
begin
  FSimpleDictionary.Append(0, 0);
  FSimpleDictionary.Append(1, 10);
  FSimpleDictionary.Append(2, 20);
  FSimpleDictionary.Append(3, 30);
  FSimpleDictionary.Append(4, 40);
  FSimpleDictionary.Append(5, 50);

  CheckEquals(0, FSimpleDictionary.IndexOf(0), 'Should return 0');
  CheckEquals(3, FSimpleDictionary.IndexOf(3), 'Should return 3');
end;

procedure TestTSimpleDictionary.TestInvalidIndex;
begin
  CheckException(UsesInvalidIndex, EListError, 'should throw exception');
end;

procedure TestTSimpleDictionary.TestInvalidKey;
begin
  CheckException(UsesInvalidKey, EListError, 'should throw exception');
end;

procedure TestTSimpleDictionary.TestStress;
var
  I: Integer;
begin
  for I := 0 to 10000 do
    FSimpleDictionary.Add(I, I * 1.23456);
end;

procedure TestTSimpleDictionary.TestValues;
begin
  FSimpleDictionary.Append(0, 1.23);
  CheckTrue(CompareValue(1.23, FSimpleDictionary.Values[0]) = EqualsValue);

  FSimpleDictionary.Add(1, 'Simple Dictionary');
  CheckEquals('Simple Dictionary', FSimpleDictionary.Values[1]);

  FSimpleDictionary.Add(2, True);
  CheckEquals(True, FSimpleDictionary.Values[2]);

  FSimpleDictionary.Add(3, False);
  CheckEquals(False, FSimpleDictionary.Values[3]);
end;


procedure TestTSimpleDictionary.UsesInvalidIndex;
begin
  FSimpleDictionary.Append(0, 1);

  FSimpleDictionary.Keys[1];
end;

procedure TestTSimpleDictionary.UsesInvalidKey;
begin
  FSimpleDictionary.Append(0, 1);

  FSimpleDictionary.Values[1];
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTSimpleDictionary.Suite);
end.

