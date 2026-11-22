Class {
	#name : 'EPLargePositiveIntegerMapping',
	#superclass : 'EPByteObjectMapping',
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'accessing' }
EPLargePositiveIntegerMapping >> localClass [
	
	^LargePositiveInteger
]

{ #category : 'accessing' }
EPLargePositiveIntegerMapping >> remoteClass [

	^objectSpace largePositiveIntegerClass
]

{ #category : 'accessing' }
EPLargePositiveIntegerMapping >> remoteClassName [

	^objectSpace worldConfiguration largePositiveIntegerClassName
]
