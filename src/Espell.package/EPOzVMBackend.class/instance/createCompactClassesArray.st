compact classes
createCompactClassesArray

	compactClasses := Dictionary new.
	self classes do: [ :class |
		class isCompact ifTrue: [ 
			compactClasses at: class compactClassIndex put: class.
		]
	]