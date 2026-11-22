Class {
	#name : 'EPLargeNegativeIntegerMapping',
	#superclass : 'EPByteObjectMapping',
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'accessing' }
EPLargeNegativeIntegerMapping >> localClass [
	
	^LargeNegativeInteger
]

{ #category : 'accessing' }
EPLargeNegativeIntegerMapping >> remoteClass [

	^objectSpace largeNegativeIntegerClass
]

{ #category : 'accessing' }
EPLargeNegativeIntegerMapping >> remoteClassName [

	^objectSpace worldConfiguration largeNegativeIntegerClassName
]
