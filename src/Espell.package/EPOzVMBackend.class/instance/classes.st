compact classes
classes

	| dictionary internalArray classes |
	dictionary := self systemDictionary.
	internalArray := dictionary instanceVariableAtIndex: 2.
	classes := OrderedCollection new.
	
	1 to: internalArray size do: [ :i | | association |
		association := internalArray at: i.
		association isNilObject ifFalse: [ | maybeClass |
			maybeClass := association instanceVariableAtIndex: 2.
			(self looksLikeClass: maybeClass)
				ifTrue: [ classes add: maybeClass asClassMirror ]]].
		
	^ classes