public
includesKey: aLocalCharacter

	| table |
	table := objectSpace basicCharacterTable.
	^ table size > aLocalCharacter asciiValue and: [(table at: aLocalCharacter asciiValue + 1) isNilObject not].