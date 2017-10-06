accessing
traitNamed: aTraitName ifAbsent: aBlock

	^ self traitMirrorOn: (self environment globalNamed: aTraitName ifAbsent: [ ^ aBlock value ])