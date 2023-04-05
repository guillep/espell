running
setUp 

	imagesDirectory := self imagesDirectory.
	imagesDirectory exists ifTrue: [ imagesDirectory deleteAll ].
	imagesDirectory ensureCreateDirectory.
	
	ZnClient new
		url: 'http://files.pharo.org/image/30/latest.zip';
		downloadTo: imagesDirectory.
	
	'PharoV30.sources' asFileReference exists ifFalse: [
		ZnClient new
			url: 'http://files.pharo.org/sources/PharoV30.sources';
			downloadTo: FileSystem workingDirectory ].
		
	ZipArchive new
		readFrom: (imagesDirectory / 'latest' , 'zip');
		extractAllTo: imagesDirectory.
		
	objectSpace := EPObjectSpace onSimulatedBackend.
	objectSpace loadImage: self imageFileName