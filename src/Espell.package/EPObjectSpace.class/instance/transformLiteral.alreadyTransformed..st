converting
transformLiteral: aLiteral alreadyTransformed: aDictionary
	
	aDictionary at: aLiteral ifPresent: [ :x | ^ x ].
	
	aLiteral isMethodProperties ifTrue: [
		"For now we convert method properties in selectors. Careful! We are losing pragmas at bootstrap time!"
		^ aLiteral selector asLiteralInObjectSpace: self alreadyTransformed: aDictionary
	].
	^ aLiteral asLiteralInObjectSpace: self alreadyTransformed: aDictionary