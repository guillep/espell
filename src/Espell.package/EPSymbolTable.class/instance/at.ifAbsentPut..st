public
at: aLocalSymbol ifAbsentPut: aBlock

	^ self at: aLocalSymbol ifAbsent: [ self installSymbol: aBlock value ]