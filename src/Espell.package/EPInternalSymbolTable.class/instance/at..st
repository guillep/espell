public
at: aLocalSymbol

	^ cache at: aLocalSymbol ifAbsentPut: [ super at: aLocalSymbol ]