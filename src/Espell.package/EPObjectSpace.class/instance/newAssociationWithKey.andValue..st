builders
newAssociationWithKey: aKey andValue: aValue

	| association |
	association := self backend associationClass basicNew.
	association instanceVariableAtIndex: 1 put: aKey.
	association instanceVariableAtIndex: 2 put: aValue.
	^ association