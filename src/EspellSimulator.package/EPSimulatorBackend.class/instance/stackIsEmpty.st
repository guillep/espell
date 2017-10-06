as yet unclassified
stackIsEmpty
	
	"We have an initial stack of 20"
	^ self simulator stackPointer - self simulator framePointer == (self simulator objectMemory wordSize * 5) negated