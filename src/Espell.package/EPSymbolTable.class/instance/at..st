public
at: aLocalSymbol

	^ self at: aLocalSymbol ifAbsent: [ self error: 'key not found: ', aLocalSymbol ]