Class {
	#name : 'EPByteStringMapping',
	#superclass : 'EPByteObjectMapping',
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'accessing' }
EPByteStringMapping >> localClass [
	
	^ByteString
]

{ #category : 'accessing' }
EPByteStringMapping >> remoteClass [

	^ objectSpace byteStringClass
]

{ #category : 'accessing' }
EPByteStringMapping >> remoteClassName [

	^objectSpace worldConfiguration stringClassName
]
