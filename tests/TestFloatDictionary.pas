unit TestFloatDictionary;

interface

uses
  TestFramework, Classes, Variants, SimpleDictionary;

type
  TestTFloatDictionary = class(TTestCase)
  strict private
    FFloatDictionary: TFloatDictionary;
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
  end;

implementation

procedure TestTFloatDictionary.SetUp;
begin
  FFloatDictionary := TFloatDictionary.Create();
end;

procedure TestTFloatDictionary.TearDown;
begin
  FFloatDictionary.Free;
  FFloatDictionary := nil;
end;

procedure TestTFloatDictionary.TestClear;
begin
  FFloatDictionary.Add(1, 10);
  FFloatDictionary.Add(2, 20);
  CheckEquals(2, FFloatDictionary.Count);
  FFloatDictionary.Clear;
  CheckEquals(0, FFloatDictionary.Count);
end;

procedure TestTFloatDictionary.TestAdd;
var
  Index: Integer;
begin
  Index := FFloatDictionary.Add(1, 10);
  CheckEquals(0, Index, 'Should return 0');
  Index := FFloatDictionary.Add(2, 20);
  CheckEquals(1, Index, 'Should return 1');
  Index := FFloatDictionary.Add(1, 11);
  CheckEquals(0, Index, 'Should return 0');
  Index := FFloatDictionary.Add(3, 30);
  CheckEquals(2, Index, 'Should return 2');
end;

procedure TestTFloatDictionary.TestAppend;
begin
  FFloatDictionary.Append(0, 0);
  CheckEquals(1, FFloatDictionary.Count, 'Should return 1');

  FFloatDictionary.Append(1, 10);
  CheckEquals(2, FFloatDictionary.Count, 'Should return 2');

  FFloatDictionary.Append(2, 20);
  CheckEquals(3, FFloatDictionary.Count, 'Should return 3');

  FFloatDictionary.Append(1, 11);
  CheckEquals(3, FFloatDictionary.Count, 'Should return 3');

  FFloatDictionary.Append(3, 30);
  CheckEquals(4, FFloatDictionary.Count, 'Should return 4');
end;

procedure TestTFloatDictionary.TestDelete;
var
  Index: Integer;
begin
  Index := FFloatDictionary.Add(1, 10);
  CheckEquals(0, Index, 'Should return 0');

  Index := FFloatDictionary.Add(2, 20);
  CheckEquals(1, Index, 'Should return 1');

  FFloatDictionary.Delete(Index);
  CheckEquals(1, FFloatDictionary.Count, 'Should return 1');

  Index := FFloatDictionary.Add(2, 20);
  CheckEquals(1, Index, 'Should return 0');

  Index := FFloatDictionary.Add(3, 30);
  CheckEquals(2, Index, 'Should return 2');

  Index := FFloatDictionary.Add(4, 40);
  CheckEquals(3, Index, 'Should return 2');

  FFloatDictionary.Delete(2);
  CheckEquals(3, FFloatDictionary.Count, 'Should return 3');
end;

procedure TestTFloatDictionary.TestDelete1;
begin
  FFloatDictionary.Append(0, 0);
  FFloatDictionary.Append(1, 10);
  FFloatDictionary.Append(2, 20);
  FFloatDictionary.Append(3, 30);
  FFloatDictionary.Append(4, 40);
  FFloatDictionary.Append(5, 50);

  FFloatDictionary.Delete(3);
  CheckEquals(5, FFloatDictionary.Count, 'Should return 5');
end;

procedure TestTFloatDictionary.TestIndexOf;
begin
  FFloatDictionary.Append(0, 0);
  FFloatDictionary.Append(1, 10);
  FFloatDictionary.Append(2, 20);
  FFloatDictionary.Append(3, 30);
  FFloatDictionary.Append(4, 40);
  FFloatDictionary.Append(5, 50);

  CheckEquals(0, FFloatDictionary.IndexOf(0), 'Should return 0');
  CheckEquals(3, FFloatDictionary.IndexOf(3), 'Should return 3');
end;

procedure TestTFloatDictionary.TestValues;
begin

  FFloatDictionary.Append(0, 0);
  CheckEquals(1, FFloatDictionary.Count, 'Should return 1');

  FFloatDictionary.Append(0, 0);
  CheckEquals(1, FFloatDictionary.Count, 'Should return 1');

end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTFloatDictionary.Suite);
end.

