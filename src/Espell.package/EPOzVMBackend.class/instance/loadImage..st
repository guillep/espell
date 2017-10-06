initialize-release
loadImage: aFile
	| file |
	file := aFile asFileReference.
	file exists ifFalse: [ self error: 'File ', aFile asString ,' does not exist' ].
	
	self specialObjectsArray: (self loadImageObjectsFrom: aFile).
	self createCompactClassesArray.
	self symbolTable buildCache.