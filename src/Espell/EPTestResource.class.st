Class {
	#name : 'EPTestResource',
	#superclass : 'TestResource',
	#instVars : [
		'imagesDirectory',
		'objectSpace'
	],
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'running' }
EPTestResource >> imageFileName [

	^ self imagesDirectory / 'Pharo-30864.image'
]

{ #category : 'running' }
EPTestResource >> imagesDirectory [

	^ FileSystem workingDirectory / 'images'
]

{ #category : 'accessing' }
EPTestResource >> objectSpace [

	^ objectSpace
]

{ #category : 'running' }
EPTestResource >> setUp [ 

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
]

{ #category : 'running' }
EPTestResource >> tearDown [

	objectSpace := nil.
	imagesDirectory exists ifTrue: [ imagesDirectory deleteAll ].
	'PharoV30.sources' asFileReference ensureDelete
]
