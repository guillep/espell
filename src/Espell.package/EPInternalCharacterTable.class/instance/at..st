public
at: aLocalCharacter

	| table |
	table := objectSpace basicCharacterTable.
	^ table at: aLocalCharacter asciiValue + 1.