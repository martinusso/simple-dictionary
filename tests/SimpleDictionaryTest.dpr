program SimpleDictionaryTest;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestFloatDictionary in 'TestFloatDictionary.pas',
  SimpleDictionary in '..\src\SimpleDictionary.pas',
  TestSimpleDictionary in 'TestSimpleDictionary.pas',
  TestSimpleObjectDictionary in 'TestSimpleObjectDictionary.pas';

{$R *.RES}

begin
 
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.

