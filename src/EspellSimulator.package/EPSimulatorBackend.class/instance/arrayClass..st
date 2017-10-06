special objects
arrayClass: aMirror 
	
	super arrayClass: aMirror.
	self installClass: aMirror inClassTableIndex: 51.
	
	"Array is a special class that resides in the first page of the class table.
	Array is duplicated in the special class index 16, that can also be obtained by querying the memory manager as follows:
	
		self objectMemory arrayClassIndexPun.
		
	Usually, a class hash must be the same as the class index in the class table. But, since the class is in two different positions, one of them does not hold that invariant.
	To install the class in the table in both positions, we use an Unchecked version of the method that contains no assertions of that invariant."
	self objectMemory classAtIndex: self objectMemory arrayClassIndexPun putUnchecked: aMirror target address.