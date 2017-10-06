public
at: aLocalSymbol ifAbsent: aBlock

	^ cache at: aLocalSymbol ifAbsent: [ self like: aLocalSymbol ifAbsent: aBlock ].