special objects
characterClass: aClass

	super characterClass: aClass.
	self objectMemory setHashBitsOf: aClass target address to: 2.
	self objectMemory classAtIndex: 2 putUnchecked: aClass target address.
	aClass target: aClass target asClassIndexHandle.