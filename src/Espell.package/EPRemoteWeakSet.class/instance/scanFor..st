private
scanFor: anObject
	"Scan the key array for the first slot containing either flag (indicating an empty slot) or an element that matches anObject. Answer the index of that slot or raise an error if no slot is found. This method will be overridden in various subclasses that have different interpretations for matching elements."

	| index start array |
	array := mirror instanceVariableAtIndex: 2.
	index := start := anObject hash \\ array size + 1.
	[ 
		| element |
		((element := array at: index) isNilObject or: [ 
			"a WeakSet contains ephemeric objects containing the real element in the 1st IV"
			(element instanceVariableAtIndex: 1) asLocalString = anObject ])
				ifTrue: [ ^index ].
		(index := index \\ array size + 1) = start ] whileFalse.
	self errorNoFreeSpace