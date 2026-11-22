Class {
	#name : 'EPRemoteEnvironment',
	#superclass : 'EPRemoteObject',
	#instVars : [
		'sourceFiles',
		'imageFileName'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPRemoteEnvironment >> bindingOf: aString [ 
	
	^ self globalsDictionary bindingOf: aString
]

{ #category : 'mapping' }
EPRemoteEnvironment >> classForClassMirror: anEPClassMirror [ 
	
	(self isMeta: anEPClassMirror)
		ifTrue: [ ^ self metaclassForClassMirror: anEPClassMirror ].
	^ EPRemoteClass on: anEPClassMirror environment: self
]

{ #category : 'accessing' }
EPRemoteEnvironment >> classNamed: aString [ 
	
	^ self globalNamed: aString
]

{ #category : 'source code' }
EPRemoteEnvironment >> getSourceFromFile: anEPRemoteMethod [ 

	| position sourcePointer fileIndex |
	sourcePointer := (EPMethodTrailer new method: anEPRemoteMethod) sourcePointer.
	position := SourceFiles filePositionFromSourcePointer: sourcePointer.
	position = 0 ifTrue: [^ nil].
	fileIndex := SourceFiles fileIndexFromSourcePointer: sourcePointer.
	^ self sourceCodeInFile: fileIndex inPosition: position.
]

{ #category : 'accessing' }
EPRemoteEnvironment >> globalNamed: aString [ 
	
	^ EPRemoteClass
		on: (self globalsDictionary at: aString)
		environment: self
]

{ #category : 'accessing' }
EPRemoteEnvironment >> globalsDictionary [
	
	^ EPRemoteDictionary on: mirror
]

{ #category : 'source code' }
EPRemoteEnvironment >> imageFileName: aName [

	imageFileName := aName asFileReference
]

{ #category : 'testing' }
EPRemoteEnvironment >> includesClassNamed: aString [ 
	
	^ self globalsDictionary includesKey: aString
]

{ #category : 'testing' }
EPRemoteEnvironment >> isMeta: aMirror [
	
	^ (self classNamed: #Metaclass) mirror = aMirror basicClass
]

{ #category : 'mapping' }
EPRemoteEnvironment >> metaclassForClassMirror: anEPClassMirror [ 
	
	^ EPRemoteMetaClass on: anEPClassMirror environment: self
]

{ #category : 'source code' }
EPRemoteEnvironment >> sourceCodeForMethod: anEPRemoteMethod [
	
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
]

{ #category : 'source code' }
EPRemoteEnvironment >> sourceCodeInFile: fileIndex inPosition: position [

	| theFile |
	theFile := (self sourceFilesAtIndex: fileIndex) flush readOnlyCopy.
	^[position > theFile size ifTrue: [
		self error: 'RemoteString past end of file' ].
		theFile position: position.
		theFile nextChunk] ensure: [theFile close]
]

{ #category : 'source code' }
EPRemoteEnvironment >> sourceFiles [

	sourceFiles ifNotNil: [ ^ sourceFiles ].
	sourceFiles := SourceFileArray new.
	sourceFiles at: 1 put: (PharoFilesOpener default
		openSources: 'PharoV30.sources'
	 	"should be the source name of the image, but we don't care so far"
		forImage: imageFileName).
	sourceFiles at: 2 put: (imageFileName withExtension: 'changes') readStream.
	^ sourceFiles
]

{ #category : 'source code' }
EPRemoteEnvironment >> sourceFilesAtIndex: anInteger [ 

	^ self sourceFiles at: anInteger
]
