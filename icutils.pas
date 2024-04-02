{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit icutils;

{$warn 5023 off : no warning about unused units}
interface

uses
  filefunc, keyboardfunc, memfunc, strfunc, sysfunc, dictionary, logfunc, 
  collections, dbfunc, dtfunc, execfunc, exttypes, inifunc, mathfunc, netfunc, 
  pyfunc, graphfunc, toolfunc, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('icutils', @Register);
end.
