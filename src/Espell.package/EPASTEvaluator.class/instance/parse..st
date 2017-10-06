compiling
parse: aString

	| expression |
	expression := RBParser parseExpression: aString.
	(expression isSequence and: [ environment classLoader isClassDefinition: aString ])
		ifTrue: [ expression := EPASTClassDefinition fromMessageNode: expression ].
	(expression isMessage and: [ self isTraitDefinitionSelector: expression selector ])
		ifTrue: [ expression := EPASTTraitDefinition fromMessageNode: expression ].
	^ expression