lookup by name
traitNamed: aTraitName 
	
	^self traitMirrorOn: (self environment globalNamed: aTraitName)