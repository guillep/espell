"
I am a Dictionary class that avoids printing my elements. This is because I can contain remote references that cannot be printed as others: they do not understand regular messages and crash the system if we send them one.
"
Class {
	#name : 'EPDictionary',
	#superclass : 'Dictionary',
	#category : 'Espell-Support',
	#package : 'Espell',
	#tag : 'Support'
}

{ #category : 'printing' }
EPDictionary >> longPrintOn: aStream limitedTo: sizeLimit indent: indent [
	aStream cr
]

{ #category : 'printing' }
EPDictionary >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that  
	identifies the receiver."

	| title |
	title := self class name.
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title
]
