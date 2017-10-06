public
setCharacterTable: anArrayOfCharacters

	| characterClassMirror |
	objectSpace basicCharacterTable: anArrayOfCharacters.
	characterClassMirror := objectSpace classNamed: objectSpace worldConfiguration characterClassName.
	^ characterClassMirror classPool at: #CharacterTable put: anArrayOfCharacters