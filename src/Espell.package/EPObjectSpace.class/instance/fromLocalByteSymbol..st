transformations
fromLocalByteSymbol: aByteSymbol

	^ self symbolTable at: aByteSymbol ifAbsentPut: [ 
		backend fromLocalByteSymbol: aByteSymbol ]