gt-inspector-extension
instSpecDescription
	
	^ { 0 -> '0 sized objects (UndefinedObject True False et al)'.
 	 1 -> 'non-indexable objects with inst vars (Point et al)'.
 	 2 -> 'indexable objects with no inst vars (Array et al)'.
 	 3 -> 'indexable objects with inst vars (MethodContext AdditionalMethodState et al)'.
 	 4 -> 'weak indexable objects with inst vars (WeakArray et al)'.
 	 5 -> 'weak non-indexable objects with inst vars (ephemerons) (Ephemeron)'.
 	 6 -> 'reserved'.
 	 7 -> 'forwarder format (also immediate class format)'.
 	 9 -> '64-bit indexable'.
 	 10-> '32-bit indexable'.
 	 11-> '32-bit indexable'.
  	12-> '16-bit indexable'.
	13-> '16-bit indexable'.
	14-> '16-bit indexable'.
	15-> '16-bit indexable'.
   16-> 'byte indexable'.
	17-> 'byte indexable'.
	18-> 'byte indexable'.
	19-> 'byte indexable'.
	20-> 'byte indexable'.
	21-> 'byte indexable'.
	22-> 'byte indexable'.
	23-> 'byte indexable'.
   24-> 'compiled method'.
   25-> 'compiled method'.
	26-> 'compiled method'.
	27-> 'compiled method'.
	28-> 'compiled method'.
	29-> 'compiled method'.
	30-> 'compiled method'.
	31-> 'compiled method'
	} asDictionary at: self instSpec ifAbsent: [ 'Old ilegal format' ]
