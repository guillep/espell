as yet unclassified
stackIsEmpty
	
	"We have an initial stack of 16"
	^ self simulator stackPointer - self simulator framePointer == (self simulator objectMemory wordSize * 4) negated