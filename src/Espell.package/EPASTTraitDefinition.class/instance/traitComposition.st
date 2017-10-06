accessing
traitComposition
	
	| traitCompositionIndex |
	traitCompositionIndex := 0.
	message selectorParts withIndexDo: [ :elem :index | elem value = 'uses:' ifTrue: [ traitCompositionIndex := index ]].

	^ message arguments at: traitCompositionIndex