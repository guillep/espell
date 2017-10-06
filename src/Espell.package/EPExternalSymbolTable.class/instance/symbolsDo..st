public
symbolsDo: aBlock

	symbols copy keysAndValuesDo: [ :key :value |
		aBlock value: value.
	]