Class {
	#name : #EPSymbolTableTest,
	#superclass : #EPBaseTest,
	#category : #'Espell-Tests'
}

{ #category : #tests }
EPSymbolTableTest >> testRemoteSymbolIsAByteSymbol [

	| symbol |
	symbol := #foo asLiteralInObjectSpace: objectSpace.
	self assert: (symbol basicClass pointsToSameObject: self backend byteSymbolClass).
	self assert: symbol asLocalLiteral equals: #foo
]

{ #category : #tests }
EPSymbolTableTest >> testSymbolIsCreatedOnce [

	self assert: ((#foo asLiteralInObjectSpace: objectSpace) pointsToSameObject: (#foo asLiteralInObjectSpace: objectSpace))
]

{ #category : #tests }
EPSymbolTableTest >> testSymbolsOfTheKernelAreInTheSymbolTable [

	self assert: (objectSpace symbolTable includesKey: #Object)
]
