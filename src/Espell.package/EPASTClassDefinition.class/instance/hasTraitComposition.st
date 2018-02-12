accessing
hasTraitComposition
	
	| compositionNode |
	
	message statements second isMessage ifFalse: [ ^ false ].
	
	compositionNode := message statements second arguments first receiver.
	^ compositionNode isArray not or: [ compositionNode children notEmpty ]