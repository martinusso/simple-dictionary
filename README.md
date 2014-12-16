# SimpleDictionary

Using dictionary in Delphi without generics.

## How to use

Just add the unit "SimpleDictionary.pas" to project.
  - ``Project -> Add to Project`` and then locate and choose the file.

## Example

```delphi
    Dictionary := TSimpleDictionary.Create();
    try
      
      // adding value
      Dictionary.Add(0, 'Simple');
      // adding value in another way
      Dictionary.Values[1] := 'Dictionary';
      
      // getting value
      Value := Dictionary.Values[0];
      
    finally
      Dictionary.Free();
    end;
```
