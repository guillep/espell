accessing
initialPC
	"Answer the program counter for the receiver's first bytecode."
	^ (self numberOfLiterals + 1) * self backend wordSize + 1