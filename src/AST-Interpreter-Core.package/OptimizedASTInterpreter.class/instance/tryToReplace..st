as yet unclassified
tryToReplace: aMessageNode
	
	(aMessageNode selector = #ifTrue:ifFalse:)
		ifTrue: [ ^ OzIfNode replace: aMessageNode ].
	(aMessageNode selector = #ifTrue:)
		ifTrue: [ ^ OzIfTrueNode replace: aMessageNode ].
	(aMessageNode selector = #ifFalse:)
		ifTrue: [ ^ OzIfFalseNode replace: aMessageNode ].
	(aMessageNode selector = #to:do:)
		ifTrue: [ ^ OzToDoNode replace: aMessageNode ].
	(#(ifNil: ifNotNil: ifNotNilDo:)
		includes: aMessageNode selector)
			ifTrue: [ ^ OzIfNilNode replace: aMessageNode ].
	(aMessageNode selector = #ifNil:ifNotNil:)
		ifTrue: [ ^ OzIfNilNode replace: aMessageNode ].
	(#(whileTrue whileTrue: whileFalse whileFalse ) 
		includes: aMessageNode selector)
			ifTrue: [ ^ OzWhileTrueNode replace: aMessageNode ].
	^ nil