#############################################################################
##
#W  field.gd                    GAP library                     Thomas Breuer
##
#H  @(#)$Id$
##
#Y  Copyright (C)  1996,  Lehrstuhl D fuer Mathematik,  RWTH Aachen,  Germany
##
##  This file declares the operations for division rings.
##
Revision.field_gd :=
    "@(#)$Id$";

#T maintained attributes under isomorphisms:
#T     Conductor,
#T     DegreeOverPrimeField,
#T     GaloisStabilizer,
#T     Size,

#############################################################################
##
#P  IsField( <D> )
##
IsField := IsDivisionRing and IsCommutative;
SetIsField := Setter( IsField );
HasIsField := Tester( IsField );

InstallTrueMethod( IsCommutative, IsDivisionRing and IsFinite );


#############################################################################
##
#P  IsNumberField( <F> )
##
##  A number field is a finite extension of a prime field in characteristic
##  zero.
##
IsNumberField := NewProperty( "IsNumberField", IsField );
SetIsNumberField := Setter( IsNumberField );
HasIsNumberField := Tester( IsNumberField );

InstallSubsetTrueMethod( IsNumberField,
    IsField and IsNumberField, IsField );
InstallIsomorphismTrueMethod( IsNumberField,
    IsField and IsNumberField, IsField );


#############################################################################
##
#P  IsAbelianNumberField( <F> )
##
##  An abelian number field is a number field with abelian Galois group.
##
IsAbelianNumberField := NewProperty( "IsAbelianNumberField", IsField );
SetIsAbelianNumberField := Setter( IsAbelianNumberField );
HasIsAbelianNumberField := Tester( IsAbelianNumberField );

InstallTrueMethod( IsNumberField,
    IsAbelianNumberField );

InstallSubsetTrueMethod( IsAbelianNumberField,
    IsField and IsAbelianNumberField, IsField );

InstallIsomorphismTrueMethod( IsAbelianNumberField,
    IsField and IsAbelianNumberField, IsField );


#############################################################################
##
#P  IsCyclotomicField( <F> )
##
##  A cyclotomic field is an abelian number field that is generated by
##  roots of unity.
##
IsCyclotomicField := NewProperty( "IsCyclotomicField", IsField );
SetIsCyclotomicField := Setter( IsCyclotomicField );
HasIsCyclotomicField := Tester( IsCyclotomicField );

InstallTrueMethod( IsAbelianNumberField, IsCyclotomicField );

InstallIsomorphismTrueMethod( IsCyclotomicField,
    IsField and IsCyclotomicField, IsField );


#############################################################################
##
#P  IsPrimeField( <D> )
##
IsPrimeField := NewProperty( "IsPrimeField", IsDivisionRing );
SetIsPrimeField := Setter( IsPrimeField );
HasIsPrimeField := Tester( IsPrimeField );

InstallIsomorphismTrueMethod( IsPrimeField,
    IsField and IsPrimeField, IsField );


#############################################################################
##
#A  Conductor( <F> )
##
##  is the smallest integer $n$ such that the field <F> is contained in the
##  $n$-th cyclotomic field.
##  If <F> is not an abelian extension of the rationals then 'fail' is
##  returned.
##
Conductor := NewAttribute( "Conductor", IsAbelianNumberField );
SetConductor := Setter( Conductor );
HasConductor := Tester( Conductor );


#############################################################################
##
#A  DefiningPolynomial( <F> )
##
##  is the defining polynomial as a field
##  extension over the left acting domain of <F>.
##
DefiningPolynomial := NewAttribute( "DefiningPolynomial", IsField );
SetDefiningPolynomial := Setter( DefiningPolynomial );
HasDefiningPolynomial := Tester( DefiningPolynomial );


#############################################################################
##
#A  DegreeOverPrimeField( <F> )
##
##  is the degree of the field <F> over its prime field.
##
DegreeOverPrimeField := NewAttribute( "DegreeOverPrimeField",
    IsDivisionRing );
SetDegreeOverPrimeField := Setter( DegreeOverPrimeField );
HasDegreeOverPrimeField := Tester( DegreeOverPrimeField );


#############################################################################
##
#A  GeneratorsOfDivisionRing( <D> )
##
##  generators w.r.t. addition, mutliplication, and taking inverses
##  (the identity cannot be omitted ...)
##
GeneratorsOfDivisionRing := NewAttribute( "GeneratorsOfDivisionRing",
    IsDivisionRing );
SetGeneratorsOfDivisionRing := Setter( GeneratorsOfDivisionRing );
HasGeneratorsOfDivisionRing := Tester( GeneratorsOfDivisionRing );


#############################################################################
##
#A  GeneratorsOfField( <D> )
##
GeneratorsOfField := GeneratorsOfDivisionRing;
SetGeneratorsOfField := SetGeneratorsOfDivisionRing;
HasGeneratorsOfField := HasGeneratorsOfDivisionRing;


#############################################################################
##
#A  GaloisGroup( <F> )
##
GaloisGroup := NewAttribute( "GaloisGroup", IsField );
#T and of polynomial?
SetGaloisGroup := Setter( GaloisGroup );
HasGaloisGroup := Tester( GaloisGroup );


#############################################################################
##
#A  GaloisStabilizer( <F> )
##
##  is the set of all integers $k$ in the range from $1$ to the conductor of
##  <F> such that the field automorphism induced by raising roots of unity
##  in <F> to the $k$-th power acts trivially on <F>.
##
GaloisStabilizer := NewAttribute( "GaloisStabilizer", IsAbelianNumberField );
SetGaloisStabilizer := Setter( GaloisStabilizer );
HasGaloisStabilizer := Tester( GaloisStabilizer );


#############################################################################
##
#A  NormalBase( <F> )
##
##  is a list of basis vectors of <F> that consists of conjugate elements.
##
NormalBase := NewAttribute( "NormalBase", IsField );
SetNormalBase := Setter( NormalBase );
HasNormalBase := Tester( NormalBase );


#############################################################################
##
#A  PrimeField( <D> )
##
PrimeField := NewAttribute( "PrimeField", IsDivisionRing );
SetPrimeField := Setter( PrimeField );
HasPrimeField := Tester( PrimeField );


#############################################################################
##
#A  PrimitiveElement( <D> )
##
##  is an element of <D> that generates <D> as a division ring together with
##  the left acting domain
##
PrimitiveElement := NewAttribute( "PrimitiveElement", IsDivisionRing );
SetPrimitiveElement := Setter( PrimitiveElement );
HasPrimitiveElement := Tester( PrimitiveElement );


#############################################################################
##
#A  PrimitiveRoot( <F> )
##
##  A primitive root of a finite field is a generator of its multiplicative
##  group.
##
PrimitiveRoot := NewAttribute( "PrimitiveRoot", IsField and IsFinite );
SetPrimitiveRoot := Setter( PrimitiveRoot );
HasPrimitiveRoot := Tester( PrimitiveRoot );


#############################################################################
##
#A  RootOfDefiningPolynomial( <F> )
##
##  is a root in the field <F> of its defining polynomial as a field
##  extension over the left acting domain of <F>.
##
RootOfDefiningPolynomial := NewAttribute(
    "RootOfDefiningPolynomial", IsField );
SetRootOfDefiningPolynomial := Setter( RootOfDefiningPolynomial );
HasRootOfDefiningPolynomial := Tester( RootOfDefiningPolynomial );


#############################################################################
##
#A  Subfields( <F> )
##
##  is the set of all subfields of the field <F>.
#T or shall we allow to ask, e.g., for subfields of quaternion algebras?
##
Subfields := NewAttribute( "Subfields", IsField );
SetSubfields := Setter( Subfields );
HasSubfields := Tester( Subfields );


#############################################################################
##
#O  AsDivisionRing( <F>, <D> )
##
##  view <D> as division ring over <F>
##
AsDivisionRing := NewOperation( "AsDivisionRing",
    [ IsDivisionRing, IsDivisionRing ] );

AsField := AsDivisionRing;


#############################################################################
##
#O  FieldExtension( <F>, <poly> )
##
##  is the field obtained on adjoining a root of the irreducible polynomial
##  <poly> to the field <F>.
##
FieldExtension := NewOperation( "FieldExtension",
    [ IsField, IsUnivariatePolynomial ] );


#############################################################################
##
#O  Conjugates( <F>, <z> )  . . . . . . . . . . conjugates of a field element
#O  Conjugates( <z> )
##
Conjugates := NewOperation( "Conjugates", [ IsField, IsScalar ] );


#############################################################################
##
#O  Norm( <F>, <z> ) . . . . . . . . . . . . . . .  trace of a field element
#O  Norm( <z> )
##
Norm := NewOperation( "Norm", [ IsField, IsScalar ] );


#############################################################################
##
#O  Trace( <F>, <z> ) . . . . . . . . . . . . . . .  trace of a field element
#O  Trace( <z> )
#O  Trace( <mat> )  . . . . . . . . . . . . . . . . . . . . trace of a matrix
##
Trace := NewOperation( "Trace", [ IsField, IsScalar ] );


#############################################################################
##
#O  CharacteristicPolynomial( <F>, <z> )
##
##  is the characteristic polynomial of the field element <z> in the field
##  <F>, that is, the product of $(X - c)$ where $c$ runs over the
##  conjugates of <z> w.r.t. the field <F>, viewed as extension of its
##  left acting domain.
##
#O  MinimalPolynomial( <F>, <z> )
##
##  is the minimal polynomial of the field element <z> in the field
##  <F>, that is, the product of $(X - c)$ where $c$ runs over the different
##  conjugates of <z> w.r.t. the field <F>, viewed as extension of its
##  left acting domain.
##
#O  DivisionRingByGenerators( [ <z>, ... ] )  . . . . div. ring by generators
#O  DivisionRingByGenerators( <F>, [ <z>, ... ] ) . . div. ring by generators
#O                                       collection, as vector space over <F>
##
##  The first version returns a division ring as vector space over
##  'FieldOverItselfByGenerators( <gens> )'.
##
DivisionRingByGenerators :=
    NewOperation( "DivisionRingByGenerators",
        [ IsDivisionRing, IsCollection ] );
#T 1997/01/16 fceller was old 'NewConstructor'

FieldByGenerators := DivisionRingByGenerators;


#############################################################################
##
#O  FieldOverItselfByGenerators( [ <z>, ... ] )
##
##  This  operation is  needed for  the  call of 'Field' or
##  'FieldByGenerators'
##  without  explicitly given subfield, in  order to construct  a left acting
##  domain for such a field.
##
FieldOverItselfByGenerators :=
    NewOperation( "FieldOverItselfByGenerators",
        [ IsCollection ] );
#T 1997/01/16 fceller was old 'NewConstructor'


#############################################################################
##
#O  DefaultFieldByGenerators( [ <z>, ... ] )  . . default field by generators 
##
DefaultFieldByGenerators :=
    NewOperation( "DefaultFieldByGenerators",
        [ IsCollection ] );


#############################################################################
##
#F  Field( <z>, ... ) . . . . . . . . . field generated by a list of elements
#F  Field( [ <z>, ... ] )
#F  Field( <F>, [ <z>, ... ] )
##
Field := NewOperationArgs( "Field" );


#############################################################################
##
#F  DefaultField( <z>, ... )  . . . . . default field containing a collection
#F  DefaultField( [ <z>, ... ] )
##
DefaultField := NewOperationArgs( "DefaultField" );


#############################################################################
##
#F  Subfield( <F>, <gens> ) . . . . . . . subfield of <F> generated by <gens>
#F  SubfieldNC( <F>, <gens> )
##
Subfield := NewOperationArgs( "Subfield" );
SubfieldNC := NewOperationArgs( "SubfieldNC" );


#############################################################################
##
#P  IsFieldHomomorphism( <map> )
##
##  A mapping is a field homomorphism if and only if it is
##  a ring homomorphism with source a field.
##
IsFieldHomomorphism :=
    NewProperty( "IsFieldHomomorphism",
        IsGeneralMapping );

InstallTrueMethod( IsRingHomomorphism, IsFieldHomomorphism );


#############################################################################
##
#E  field.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here



