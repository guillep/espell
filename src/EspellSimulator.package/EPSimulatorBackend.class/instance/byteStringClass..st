special objects
byteStringClass: aMirror 
	
	super byteStringClass: aMirror.
	self objectMemory setHashBitsOf: aMirror target address to: 52.
	self objectMemory classAtIndex: 52 putUnchecked: aMirror target address.
	aMirror target: aMirror target asClassIndexHandle.