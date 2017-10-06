source code
sourceFiles

	sourceFiles ifNotNil: [ ^ sourceFiles ].
	sourceFiles := SourceFileArray new.
	sourceFiles at: 1 put: (PharoFilesOpener default
		openSources: 'PharoV30.sources'
	 	"should be the source name of the image, but we don't care so far"
		forImage: imageFileName).
	sourceFiles at: 2 put: (imageFileName withExtension: 'changes') readStream.
	^ sourceFiles