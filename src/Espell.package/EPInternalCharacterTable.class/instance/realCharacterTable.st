public
realCharacterTable

	| characterClassMirror |
	characterClassMirror := objectSpace classNamed: objectSpace worldConfiguration characterClassName.
	^ characterClassMirror classPool at: #CharacterTable