loading
loadImage: anImageFile
	
	backend loadImage: anImageFile asFileReference.
	self systemDictionary buildCache.
	self interpreter: (EPASTEvaluator new 
		codeProvider: ((EPRemoteEnvironment
			on: self backend systemDictionary)
			imageFileName: anImageFile;
			yourself);
		objectSpace: self)