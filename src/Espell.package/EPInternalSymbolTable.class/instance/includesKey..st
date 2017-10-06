public
includesKey: aLocalSymbol

	^ (cache includesKey: aLocalSymbol) or: [ super includesKey: aLocalSymbol ]