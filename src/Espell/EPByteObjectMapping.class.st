Class {
	#name : 'EPByteObjectMapping',
	#superclass : 'Object',
	#instVars : [
		'objectSpace'
	],
	#category : 'Espell-LowLevel-Mappings',
	#package : 'Espell',
	#tag : 'LowLevel-Mappings'
}

{ #category : 'transformations' }
EPByteObjectMapping >> fromLocal: aByteObject [
	| remoteByteClass remoteByteObject |
	remoteByteClass := self remoteClass.
	remoteByteObject := (objectSpace mirrorOn: aByteObject) copy.
	remoteByteObject setClass: remoteByteClass.
	^remoteByteObject
]

{ #category : 'transformations' }
EPByteObjectMapping >> fromRemote: aRemoteByteObject [
	| remoteByteObjectMirror newString |
	remoteByteObjectMirror := aRemoteByteObject.
	newString := self localClass new: remoteByteObjectMirror size.
	1 to: remoteByteObjectMirror size do: [ :index |
		self
			inLocal: newString
			at: index
			putRemote: (remoteByteObjectMirror at: index)
	].
	^newString
]

{ #category : 'transformations' }
EPByteObjectMapping >> inLocal: localByteObject at: index putRemote: aMirror [

	localByteObject basicAt: index put: aMirror target asSmallInteger.
]

{ #category : 'accessing' }
EPByteObjectMapping >> localClass [

	self subclassResponsibility
]

{ #category : 'accessing' }
EPByteObjectMapping >> objectSpace [
	^objectSpace
]

{ #category : 'accessing' }
EPByteObjectMapping >> objectSpace: anObjectSpace [
	objectSpace := anObjectSpace
]

{ #category : 'accessing' }
EPByteObjectMapping >> remoteClassName [
	self subclassResponsibility
]
