source code
sourceCodeInFile: fileIndex inPosition: position

	| theFile |
	theFile := (self sourceFilesAtIndex: fileIndex) flush readOnlyCopy.
	^[position > theFile size ifTrue: [
		self error: 'RemoteString past end of file' ].
		theFile position: position.
		theFile nextChunk] ensure: [theFile close]