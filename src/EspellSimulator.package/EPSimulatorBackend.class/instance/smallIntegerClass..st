special objects
smallIntegerClass: aClass

	super smallIntegerClass: aClass.
	
	"SmallInteger is a special class that resides in the first page of the class table.
	For some reason that we ignore so far, this class is in two different indexes of the table: 1 and 3.
	
	Usually, a class hash must be the same as the class index in the class table. But, since the class is in two different positions, one of them does not hold that invariant.
	To install the class in the table in both positions, we use an Unchecked version of the method that contains no assertions of that invariant.
	
	Also the hash of the class is set to 1, following the current behavior of the system:
	
	SmallInteger basicIdentityHash."
	self objectMemory setHashBitsOf: aClass target address to: 1.
	self objectMemory classAtIndex: 1 putUnchecked: aClass target address.
	self objectMemory classAtIndex: 3 putUnchecked: aClass target address.
	aClass target: aClass target asClassIndexHandle.