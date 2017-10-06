accessing
hasTraitComposition
	
	| compositionNode |
	compositionNode := message arguments second.
	^ compositionNode isArray not or: [ compositionNode children notEmpty ]