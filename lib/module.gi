#############################################################################
##
#W  module.gi                   GAP library                     Thomas Breuer
##
#H  @(#)$Id$
##
#Y  Copyright (C)  1996,  Lehrstuhl D fuer Mathematik,  RWTH Aachen,  Germany
##
##  This file contains generic methods for modules.
##
Revision.module_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  LeftModuleByGenerators( <R>, <gens> )
#M  LeftModuleByGenerators( <R>, <gens>, <zero> )
##
##  Create the <R>-left module generated by <gens>,
##  with zero element <zero>.
##
InstallMethod( LeftModuleByGenerators,
    "method for ring and collection",
    true,
    [ IsRing, IsCollection ], 0,
    function( R, gens )
    local V;
    V:= Objectify( NewKind( FamilyObj( gens ),
                            IsLeftModule and IsAttributeStoringRep ),
                   rec() );
    SetLeftActingDomain( V, R );
    SetGeneratorsOfLeftModule( V, AsList( gens ) );
    return V;
    end );

InstallOtherMethod( LeftModuleByGenerators,
    "method for ring, collection, and vector",
    true,
    [ IsRing, IsCollection, IsVector ], 0,
    function( R, gens, zero )
    local V;
    V:= Objectify( NewKind( FamilyObj( gens ),
                            IsLeftModule and IsAttributeStoringRep ),
                   rec() );
    SetLeftActingDomain( V, R );
    SetGeneratorsOfLeftModule( V, AsList( gens ) );
    SetZero( V, zero );
    return V;
    end );


#############################################################################
##
#M  AsLeftModule( <R>, <M> )  . . . . . . . . . . .  for ring and left module
##
##  View the collection <M> as a left module over the ring <R>.
##
#T InstallMethod( AsLeftModule, true, [ IsRing, IsCollection ], 0,

InstallMethod( AsLeftModule, true, [ IsRing, IsLeftModule ], 0,
    function( R, M )

    local W,        # the space, result
          base,     # basis vectors of field extension
          gen,      # loop over generators of 'V'
          b,        # loop over 'base'
          gens,     # generators of 'V'
          newgens;  # extended list of generators

    if R = LeftActingDomain( M ) then

      # No change of the left acting domain is necessary.
      return M;

    elif IsSubset( R, LeftActingDomain( M ) ) then

      # Check whether 'M' is really a module over the bigger field,
      # that is, whether the set of elements does not change.
      base:= BasisVectors( Basis( AsField( LeftActingDomain( M ), R ) ) );
#T generalize 'AsField', at least to 'AsAlgebra'!
      for gen in GeneratorsOfLeftModule( M ) do
        for b in base do
          if not b * gen in M then

            # The extension would change the set of elements.
            return fail;

          fi;
        od;
      od;

      # Construct the left module.
      W:= LeftModuleByGenerators( R, GeneratorsOfLeftModule(M), Zero(M) );

    elif IsSubset( LeftActingDomain( M ), R ) then

      # View 'M' as a module over a smaller ring.
      # For that, the list of generators must be extended.
      gens:= GeneratorsOfLeftModule( M );
      if IsEmpty( gens ) then
        W:= LeftModuleByGenerators( R, [], Zero( M ) );
      else

        base:= BasisVectors( Basis( AsField( R, LeftActingDomain( M ) ) ) );
#T generalize 'AsField', at least to 'AsAlgebra'!
        newgens:= [];
        for b in base do
          for gen in gens do
            Add( newgens, b * gen );
          od;
        od;
        W:= LeftModuleByGenerators( R, newgens );

      fi;

    else

      # View 'M' first as module over the intersection of rings,
      # and then over the desired ring.
      return AsLeftModule( R,
                 AsLeftModule( Intersection( R,
                     LeftActingDomain( M ) ), M ) );

    fi;

    RunIsomorphismImplications( M, W );
    RunSubsetImplications( M, W );
    return W;
    end );


#############################################################################
##
#M  SetGeneratorsOfLeftModule( <M>, <gens> )
##
##  If <M> is a free left module and <gens> is a finite list then <M> is
##  finite dimensional.
##
InstallMethod( SetGeneratorsOfLeftModule,
    "method that checks for 'IsFiniteDimensional'",
    IsIdentical,
    [ IsFreeLeftModule and IsAttributeStoringRep, IsList ], SUM_FLAGS + 1,
    function( M, gens )
    SetIsFiniteDimensional( M, IsFinite( gens ) );
    TryNextMethod();
    end );


#############################################################################
##
#M  Representative( <D> ) .  representative of a left operator additive group
##
InstallMethod( Representative,
    "method for left operator additive group with known generators",
    true,
    [ IsLeftOperatorAdditiveGroup
      and HasGeneratorsOfLeftOperatorAdditiveGroup ], 0,
    RepresentativeFromGenerators( GeneratorsOfLeftOperatorAdditiveGroup ) );


#############################################################################
##
#M  Representative( <D> ) . representative of a right operator additive group
##
InstallMethod( Representative,
    "method for right operator additive group with known generators",
    true,
    [ IsRightOperatorAdditiveGroup
      and HasGeneratorsOfRightOperatorAdditiveGroup ], 0,
    RepresentativeFromGenerators( GeneratorsOfRightOperatorAdditiveGroup ) );


#############################################################################
##
#M  ClosureLeftModule( <V>, <a> ) . . . . . . . . .  closure of a left module
##
InstallMethod( ClosureLeftModule, IsCollsElms, [ IsLeftModule, IsVector ], 0,
    function( V, w )

    # if possible test if the element lies in the module already
    if w in GeneratorsOfLeftModule( V ) or
       ( HasAsList( V ) and w in AsList( V ) ) then
      return V;
    fi;

    # Otherwise make a new module.
    return LeftModuleByGenerators( LeftActingDomain( V ),
                           Concatenation( GeneratorsOfLeftModule( V ),
                                          [ w ] ) );
    end );


#############################################################################
##
#M  ClosureLeftModule( <V>, <W> ) . . . . . . . . .  closure of a left module
##
InstallOtherMethod( ClosureLeftModule, IsIdentical,
    [ IsLeftModule, IsLeftModule ], 0,
    function( V, W )
    local C, v;
    if LeftActingDomain( V ) = LeftActingDomain( W ) then
      C:= V;
      for v in GeneratorsOfLeftModule( W ) do
        C:= ClosureLeftModule( C, v );
      od;
      return C;
    else
      return ClosureLeftModule( V, AsLeftModule( LeftActingDomain(V), W ) );
    fi;
    end );


#############################################################################
##
#M  \+( <U1>, <U2> )  . . . . . . . . . . . . . . . . sum of two left modules
##
InstallOtherMethod( \+,
    "method for two left modules",
    IsIdentical,
    [ IsLeftModule, IsLeftModule ], 0,
    function( V, W )

    local S;          # sum of <V> and <W>, result

    if LeftActingDomain( V ) <> LeftActingDomain( W ) then
      S:= Intersection2( LeftActingDomain( V ), LeftActingDomain( W ) );
      S:= \+( AsLeftModule( S, V ), AsLeftModule( S, W ) );
    elif IsEmpty( GeneratorsOfLeftModule( V ) ) then
      S:= W;
    else
      S:= LeftModuleByGenerators( LeftActingDomain( V ),
                           Concatenation( GeneratorsOfLeftModule( V ),
                                          GeneratorsOfLeftModule( W ) ) );
    fi;

    return S;
    end );


#############################################################################
##
#F  Submodule( <M>, <gens> )  . . . . .  submodule of <M> generated by <gens>
#F  SubmoduleNC( <M>, <gens> )
#F  Submodule( <M>, <gens>, "basis" )
#F  SubmoduleNC( <M>, <gens>, "basis" )
##
Submodule := function( arg )
    local S;
    if Length( arg ) < 2
       or not IsLeftModule( arg[1] )
       or not IsList( arg[2] ) then
      Error( "first argument must be a left module, second a list\n" );
    elif IsEmpty( arg[2] ) then
      return SubmoduleNC( arg[1], arg[2] );
    elif     IsIdentical( FamilyObj( arg[1] ), FamilyObj( arg[2] ) )
         and IsSubset( arg[1], arg[2] ) then
      S:= LeftModuleByGenerators( LeftActingDomain( arg[1] ), arg[2] );
      SetParent( S, arg[1] );
      if Length( arg ) = 3 and arg[3] = "basis" then
        UseBasis( S, arg[2] );
      fi;
      return S;
    fi;
    Error( "usage: Submodule( <V>, <gens> [, \"basis\"] )" );
end;

SubmoduleNC := function( arg )
    local S;
    if IsEmpty( arg[2] ) then
      S:= Objectify( NewKind( FamilyObj( arg[1] ),
                                  IsFreeLeftModule
                              and IsTrivial
                              and IsAttributeStoringRep ),
                     rec() );
      SetLeftActingDomain( S, LeftActingDomain( arg[1] ) );
      SetGeneratorsOfLeftModule( S, AsList( arg[2] ) );
    else
      S:= LeftModuleByGenerators( LeftActingDomain( arg[1] ), arg[2] );
    fi;
    if Length( arg ) = 3 and arg[3] = "basis" then
      UseBasis( S, arg[2] );
    fi;
    SetParent( S, arg[1] );
    return S;
end;


#############################################################################
##
#M  TrivialSubmodule( <M> ) . . . . . . .  trivial submodule of a left module
##
InstallMethod( TrivialSubmodule,
    "generic method for left modules",
    true, [ IsLeftModule ], 0,
    M -> SubmoduleNC( M, [] ) );


#############################################################################
##
#E  module.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here



