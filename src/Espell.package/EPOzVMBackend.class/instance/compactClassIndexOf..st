compact classes
compactClassIndexOf: aClassMirror
	
	^ (aClassMirror format bitShift: -11) bitAnd: 16r1F