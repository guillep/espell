Class {
	#name : 'EPMethodTrailer',
	#superclass : 'CompiledMethodTrailer',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'decoding' }
EPMethodTrailer >> decodeNativeCodeTrailer [
	| bytes platformId msz pos shift srcPtr |
	
	msz := method size.
	platformId := (method byteAt: msz - 1) + ((method byteAt: msz - 2)<<8).
	size := 	(method byteAt: msz - 3) + ((method byteAt: msz - 4)<<8).
		
	pos := method size-5.
	shift := srcPtr := 0.
	
	[ | value | 
		value := method byteAt: pos.
		srcPtr := (value bitAnd: 16r7F) << shift + srcPtr.
		pos := pos - 1.
		shift := shift + 7.
		value > 127 ] whileTrue.

	bytes := ByteArray new: size - (msz - pos).
	
	1 to: bytes size do: [:i | bytes at: i put: (method byteAt: msz-size+i) ].
	
	data := Array with: platformId with: bytes with: srcPtr.
	
]

{ #category : 'decoding' }
EPMethodTrailer >> decodeSourcePointer [

	"Trailer is a source pointer"
	| msz |
	
	size := 4.
	msz := method size.
	data := (method byteAt: msz) - 251 << 8 + (method byteAt: msz-1) << 8
	 + (method byteAt: msz-2) << 8 + (method byteAt: msz-3).
	

]

{ #category : 'initialize-release' }
EPMethodTrailer >> method: aMethod [

	| flagByte |

	data := size := nil.
	method := aMethod.
	flagByte := method byteAt: (method size).

	"trailer kind encoded in 6 high bits of last byte"
	kind := self class trailerKinds at: 1+(flagByte>>2).

	"decode the trailer bytes, inline some common types to speed up decoding"
	kind = 'SourcePointer'
		ifTrue: [ self decodeSourcePointer ]
	ifFalse: [ kind = 'VarLengthSourcePointer'
		ifTrue: [ self decodeVarLengthSourcePointer ]
	ifFalse: [ kind = 'NoTrailer'
			ifTrue: [ self decodeNoTrailer ]
	ifFalse: [ 
		"slow but general decoding using perform"
		self perform: ('decode' , kind) asSymbol ]]].
	
	"after decoding the trailer, size must be set"
	[size notNil] assert.
	

]
