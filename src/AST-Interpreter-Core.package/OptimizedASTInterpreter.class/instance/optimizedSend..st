testing
optimizedSend: aNode
	
	"Optimized sends are for block nodes only"
	aNode isBlock ifFalse: [ ^ false ].
	aNode parent isMessage ifFalse: [ ^ false ].
	^ #(#ifTrue:ifFalse: #ifTrue: #ifFalse: #to:do: ifNil: ifNotNil: ifNotNilDo: #ifNil:ifNotNil: whileTrue whileTrue: whileFalse whileFalse )
		includes: aNode parent selector