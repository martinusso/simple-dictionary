# SimpleDictionary

Using dictionary in Delphi without generics.

## How to use

Just add the unit "src/SimpleDictionary.pas" to project.
  - ``Project -> Add to Project`` and then locate and choose the file.

### Example

Simple Delphi data types:

```delphi
Dictionary := TSimpleDictionary.Create();
// It can also be used: Dictionary := TDictionary.Create();
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

Objects:
```delphi
Dictionary := TSimpleObjectDictionary.Create();
// It can also be used: Dictionary := TObjectDictionary.Create();
try

  // adding value
  Dictionary.Add(0, TObject1.Create());
  // adding value in another way
  Dictionary.Values[1] := TObject2.Create();

  // getting value
  Obj := (Dictionary.Values[0] as TObjectTest);

finally
  Dictionary.Free();
end;
```

## License

This software is open source, licensed under the The MIT License (MIT). See [LICENSE.txt](https://github.com/martinusso/simple-dictionary/blob/master/LICENSE.txt) for details.



