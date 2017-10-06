converting
transformLiteral: aLiteral asLiteralInObjectSpace: anObjectSpace 
	
	aLiteral isMethodProperties ifTrue: [
		"For now we convert method properties in selectors. Careful! We are losing pragmas at bootstrap time!"
		^ aLiteral selector asLiteralInObjectSpace: anObjectSpace 
	].
	^ aLiteral asLiteralInObjectSpace: anObjectSpace 