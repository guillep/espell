converting
fromLocalCharacter: aCharacter 
	
	^ self mirrorOnAddress: (self objectMemory characterObjectOf: aCharacter codePoint)