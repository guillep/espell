source code
getSourceFromFile: anEPRemoteMethod 

	| position sourcePointer fileIndex |
	sourcePointer := (EPMethodTrailer new method: anEPRemoteMethod) sourcePointer.
	position := SourceFiles filePositionFromSourcePointer: sourcePointer.
	position = 0 ifTrue: [^ nil].
	fileIndex := SourceFiles fileIndexFromSourcePointer: sourcePointer.
	^ self sourceCodeInFile: fileIndex inPosition: position.