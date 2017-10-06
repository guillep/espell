special objects
byteSymbolClass
	
	"The most common symbol. Symbol with byte-length characters"
	^ byteSymbolClass ifNil: [ (self arrayClass instanceVariableAtIndex: self simulator classNameIndex) basicClass ]