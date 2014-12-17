program StressTest;

{$APPTYPE CONSOLE}

uses
  Controls,
  SysUtils,
  SimpleDictionary in '..\..\src\SimpleDictionary.pas';

var
  Dictionary: TSimpleDictionary;
  ObjDictionary: TSimpleObjectDictionary;
  I: Integer;
begin
  try
    Writeln('starting charging simple dictionary...');
    Dictionary := TSimpleDictionary.Create;
    try
      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));
      for I := 0 to 10000 do
        Dictionary.Add(I, I * 3.14);
      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));

      Dictionary.Values[10];

      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));
    finally
      Dictionary.Free;
    end;


    Writeln('starting charging object dictionary...');
    ObjDictionary := TSimpleObjectDictionary.Create;
    try
      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));
      for I := 0 to 10000 do
        ObjDictionary.Add(I, TSimpleDictionary.Create);
      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));

      ObjDictionary.Values[10];

      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));
    finally
      Dictionary.Free;
    end;

    Readln;

  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
