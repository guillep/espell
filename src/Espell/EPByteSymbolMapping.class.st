Class {
	#name : 'EPByteSymbolMapping',
	#superclass : 'EPByteStringMapping',
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'transformations' }
EPByteSymbolMapping >> fromRemote: aRemoteByteSymbol [
	| localString |
	localString := super fromRemote: aRemoteByteSymbol.
	^Symbol intern: localString.
]

{ #category : 'accessing' }
EPByteSymbolMapping >> remoteClass [

	^ objectSpace byteSymbolClass
]

{ #category : 'accessing' }
EPByteSymbolMapping >> remoteClass: aRemoteClass [

	remoteClass := aRemoteClass
]

{ #category : 'accessing' }
EPByteSymbolMapping >> remoteClassName [
	^objectSpace worldConfiguration byteSymbolClassName
]

{ #category : 'accessing' }
EPByteSymbolMapping >> symbolTable [
	
	^ objectSpace symbolTable
]
