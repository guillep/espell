"
I am a class mirror object providing basic operations to work on class objects inside an object space.
"
Class {
	#name : 'EPClassMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'converting' }
EPClassMirror >> asClassMirror [

	"no need to convert"
	^ self
]

{ #category : 'accessing' }
EPClassMirror >> basicIdentityHash [

	^ target basicIdentityHashOnClass
]

{ #category : 'accessing' }
EPClassMirror >> basicNew [
	
	^ backend basicNewOn: self
]

{ #category : 'accessing' }
EPClassMirror >> basicNew: aSize [

	^ backend basicNewOn: self withSize: (backend smallIntegerMirrorOn: aSize)
]

{ #category : 'accessing' }
EPClassMirror >> basicSetClassName: aClassNameMirror [ 
	
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classNameIndex) put: aClassNameMirror
]

{ #category : 'accessing' }
EPClassMirror >> className [
	
	^ backend fromRemoteByteSymbol: (self instanceVariableAtIndex: (self backend instanceVariableMapping classNameIndex))
]

{ #category : 'accessing' }
EPClassMirror >> className: aString [ 
	
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classNameIndex) put: (aString asLiteralInObjectSpace: self backend)
]

{ #category : 'accessing' }
EPClassMirror >> classPool [
	
	"We wish this is a classpool dictionary"
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classPoolIndex)
]

{ #category : 'accessing' }
EPClassMirror >> classPool: aClassPool [
	
	"We wish this is a class where this fits"
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classPoolIndex) put: aClassPool
]

{ #category : 'accessing' }
EPClassMirror >> classSide [
	
	^ self basicClass
]

{ #category : 'testing' }
EPClassMirror >> compactClassIndex [

	^ backend compactClassIndexOf: self.
	
]

{ #category : 'accessing' }
EPClassMirror >> format [
	^(self instanceVariableAtIndex: (self backend instanceVariableMapping classFormatIndex)) asSmallInteger
]

{ #category : 'accessing' }
EPClassMirror >> format: aFormat [
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classFormatIndex) put: (backend smallIntegerMirrorOn: aFormat)
]

{ #category : 'accessing' }
EPClassMirror >> instanceFixedSize [
	
	^ backend instanceFixedSizeOf: self.
]

{ #category : 'testing' }
EPClassMirror >> isBitsClass [

	^ backend isBitsClass: self
	
]

{ #category : 'testing' }
EPClassMirror >> isBytesClass [

	^ self instanceSpecification >= 8
]

{ #category : 'testing' }
EPClassMirror >> isCompact [

	^ self compactClassIndex ~= 0
]

{ #category : 'accessing' }
EPClassMirror >> methodDictionary [
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classMethodDictionaryIndex)
]

{ #category : 'accessing' }
EPClassMirror >> methodDictionary: aDictionary [
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classMethodDictionaryIndex) put: aDictionary
]

{ #category : 'accessing' }
EPClassMirror >> superclass [
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping classSuperclassIndex)) asClassMirror
]
