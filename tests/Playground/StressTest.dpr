program StressTest;

{$APPTYPE CONSOLE}

uses
  Controls,
  SysUtils,
  SimpleDictionary in '..\..\src\SimpleDictionary.pas';

var
  Dictionary: TSimpleDictionary;
  I: Integer;
begin
  try
    Dictionary := TSimpleDictionary.Create;
    try
      Writeln('starting charging...');
      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));
      for I := 0 to 10000 do
        Dictionary.Add(I, I * 3.14);
      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));

      Dictionary.Values[10];

      Writeln(FormatDateTime('HH:MM:SS.ZZZ', Now));

      Readln;
  finally
      Dictionary.Free;
    end;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
