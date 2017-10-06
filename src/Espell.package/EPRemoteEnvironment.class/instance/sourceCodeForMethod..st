source code
sourceCodeForMethod: anEPRemoteMethod
	
	| trailer source |
	trailer := EPMethodTrailer new method: anEPRemoteMethod.

	trailer sourceCode ifNotNil: [:code | ^ code ].
	
	trailer hasSourcePointer ifFalse: [
		"No source pointer -- decompile without temp names"
		^ Error signal: 'no source pointer available' ].

	"Situation normal;  read the sourceCode from the file"
	source := self getSourceFromFile: anEPRemoteMethod.
		
	source isEmptyOrNil ifTrue: [
			"Something really wrong -- decompile blind (no temps)"
			^ Error signal: 'Source not available in source/changes file' ].
		
	^source