#############################################################################
##
#W  mgmcong.gd                  GAP library                   Andrew Solomon
##
##
#Y  Copyright (C)  1997,  Lehrstuhl D für Mathematik,  RWTH Aachen,  Germany
#Y  (C) 1998 School Math and Comp. Sci., University of St Andrews, Scotland
#Y  Copyright (C) 2002 The GAP Group
##
##  This file contains the declaration of operations for magma congruences.
##
##  Maintenance and further development by:
##  Robert F. Morse
##  Andrew Solomon
##

#############################################################################
##
##               Left Magma Congruences
##
#############################################################################

#############################################################################
##
#C  IsLeftMagmaCongruence( <E> )
##
##  This is true if (a,b) in E implies that (ca,cb) in E.
##
#F  LeftMagmaCongruence(<E>)
##
##  The left magma congruence generated by
##  equivalence relation E.
##
DeclareCategory("IsLeftMagmaCongruence", IsEquivalenceRelation);
DeclareGlobalFunction("LeftMagmaCongruence");


#############################################################################
##
#A  GeneratingPairsOfLeftMagmaCongruence( <I> )
##
##  A set of pairs whose smallest enclosing left compatible equivalence 
##  relation is D
##
DeclareAttribute("GeneratingPairsOfLeftMagmaCongruence", 
    IsLeftMagmaCongruence);
DeclareAttribute("PartialClosureOfCongruence",IsLeftMagmaCongruence,"mutable");


#############################################################################
##
#O  LeftMagmaCongruenceByGeneratingPairs(<D>, <pairs> )
##
##  The left magma ideal generated by pairs
##
DeclareOperation( "LeftMagmaCongruenceByGeneratingPairs", 
    [IsMagma, IsList ] );


#############################################################################
##
##               Right Magma Congruences
##
#############################################################################


#############################################################################
##
#C  IsRightMagmaCongruence( <E> )
##
##  This is true if (a,b) in E implies that (ac,bc) in E.
##
#F  RightMagmaCongruence(<E>)
##
##  The right magma congruence generated by
##  equivalence relation E.
##
DeclareCategory("IsRightMagmaCongruence", IsEquivalenceRelation );
DeclareGlobalFunction("RightMagmaCongruence");


#############################################################################
##
#A  GeneratingPairsOfRightMagmaCongruence( <I> )
##
##  A set of pairs whose smallest enclosing right compatible equivalence 
##  relation is D
##
DeclareAttribute("GeneratingPairsOfRightMagmaCongruence", 
    IsRightMagmaCongruence);
DeclareAttribute("PartialClosureOfCongruence",IsRightMagmaCongruence,"mutable");

#############################################################################
##
#O  RightMagmaCongruenceByGeneratingPairs(<D>, <pairs> )
##
##  The right congruence on <D> generated by <pairs>
##
DeclareOperation( "RightMagmaCongruenceByGeneratingPairs", 
    [IsMagma, IsList ] );


#############################################################################
##
##               (Two Sided) Magma Congruences
##
#############################################################################

#############################################################################
##
#C  IsMagmaCongruence( <E> )
#F  MagmaCongruenceByGeneratingPairs(<magma>, <pairs>)
#C  IsCongruenceClass( <C> )
##
##  IsMagmaCongruence is both a left and a right magma congruence
##
##  MagmaCongruenceByGeneratingPairs: The two sided magma congruence 
##  generated by a set of pairs
##
##  IsCongruenceClass: An equivalence class of a MagmaCongruence.
##
DeclareCategory("IsMagmaCongruence", IsEquivalenceRelation 
    and IsLeftMagmaCongruence and IsRightMagmaCongruence and
    RespectsMultiplication);

DeclareOperation("MagmaCongruenceByGeneratingPairs",
    [IsMagma, IsList ] );

InstallTrueMethod(IsMagmaCongruence,
IsEquivalenceRelation and RespectsMultiplication);

InstallTrueMethod(IsMagmaCongruence,
IsLeftMagmaCongruence and IsRightMagmaCongruence);

DeclareAttribute("GeneratingPairsOfMagmaCongruence", 
    IsMagmaCongruence);
DeclareAttribute("PartialClosureOfCongruence",IsMagmaCongruence,"mutable");

DeclareCategory("IsCongruenceClass", 
IsEquivalenceClass and IsMultiplicativeElement);

#############################################################################
##
#O JoinMagmaCongruences(<cong1>,<cong2>)
##
## Find the transitive closure of the equivalence relations represented by
##    cong1 and cong2
##
DeclareOperation("JoinMagmaCongruences",
    [IsMagmaCongruence, IsMagmaCongruence]);  

#############################################################################
##
#O MeetMagmaCongruences(<cong1>,<cong2>)
##
## Find the meet of the equivalence relations represented by
##    cong1 and cong2
##
DeclareOperation("MeetMagmaCongruences",
    [IsMagmaCongruence, IsMagmaCongruence]);  

#############################################################################
##
##
##               Auxilliary functions
##
DeclareGlobalFunction("LR2MagmaCongruenceByGeneratingPairsCAT");
DeclareGlobalFunction("LR2MagmaCongruenceByPartitionNCCAT");

#############################################################################
##
#E
##