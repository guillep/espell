"
This mirror contains a special version of at: is specifically for floats, answering the most significant word for index 1 and the least significant word for index 2.  This alows the VM to store floats in whatever order it chooses while it appears to the image that they are always in big-endian/PowerPC order.
"
Class {
	#name : 'EPFloatMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'converting' }
EPFloatMirror >> asFloatMirror [

	^ self
]

{ #category : 'accessing' }
EPFloatMirror >> at: anIndex [

	^ backend floatObject: self at: anIndex
]

{ #category : 'accessing' }
EPFloatMirror >> at: anIndex put: aValue [

	^ backend floatObject: self at: anIndex put: aValue
]
