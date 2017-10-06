special objects
smallFloatClass: aClass

	"SmallFloat is a special class that resides in the first page of the class table.
	
	Usually, a class hash must be the same as the class index in the class table. 
	To install the class in the table in both positions, we use an Unchecked version of the method that contains no assertions of that invariant.
	
	Also the hash of the class is set to 4, following the current behavior of the system:
	
	SmallFloat64 basicIdentityHash."

	self objectMemory setHashBitsOf: aClass target address to: 4.
	self objectMemory classAtIndex: 4 putUnchecked: aClass target address.
	aClass target: aClass target asClassIndexHandle.