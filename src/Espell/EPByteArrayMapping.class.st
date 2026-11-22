Class {
	#name : 'EPByteArrayMapping',
	#superclass : 'EPByteObjectMapping',
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'accessing' }
EPByteArrayMapping >> localClass [
	
	^ByteArray
]

{ #category : 'accessing' }
EPByteArrayMapping >> remoteClass [

	^objectSpace byteArrayClass
]

{ #category : 'accessing' }
EPByteArrayMapping >> remoteClassName [

	^objectSpace worldConfiguration byteArrayClassName
]
