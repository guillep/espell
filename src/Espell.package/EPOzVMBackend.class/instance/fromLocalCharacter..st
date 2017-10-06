converting
fromLocalCharacter: aCharacter 
	
	| newCharacterMirror |
	(self characterTable size > aCharacter codePoint)
		ifTrue: [ ^self characterTable at: aCharacter codePoint + 1 ].

	newCharacterMirror := self characterClass asClassMirror basicNew.
	newCharacterMirror instanceVariableAtIndex: 1 put: (aCharacter codePoint asLiteralInObjectSpace: self).
	^newCharacterMirror