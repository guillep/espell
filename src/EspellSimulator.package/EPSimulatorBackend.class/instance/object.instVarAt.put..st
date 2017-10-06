primitives
object: object instVarAt: index put: aValue
	
	simulator objectMemory storePointer: index - 1 ofObject: object withValue: aValue