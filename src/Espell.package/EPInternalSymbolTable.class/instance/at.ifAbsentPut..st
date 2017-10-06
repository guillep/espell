public
at: aLocalSymbol ifAbsentPut: aBlock

	^ cache at: aLocalSymbol ifAbsent: [
		super at: aLocalSymbol ifAbsentPut: aBlock ]