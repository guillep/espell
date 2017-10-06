accessing
hasTraitComposition
	
	| compositionNode |
	compositionNode := message statements second arguments first receiver.
	^ compositionNode isArray not or: [ compositionNode children notEmpty ]