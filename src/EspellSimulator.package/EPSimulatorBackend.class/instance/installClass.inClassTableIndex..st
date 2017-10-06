as yet unclassified
installClass: aMirror inClassTableIndex: anInteger 
	
	self objectMemory setHashBitsOf: aMirror target address to: anInteger.
	self objectMemory classAtIndex: anInteger putUnchecked: aMirror target address.
	aMirror target: aMirror target asClassIndexHandle.