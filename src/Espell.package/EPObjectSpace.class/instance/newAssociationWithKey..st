builders
newAssociationWithKey: aKey

	| association |
	association := backend associationClass basicNew.
	association instanceVariableAtIndex: 1 put: aKey.
	^ association