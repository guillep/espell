Class {
	#name : #EPPrimitivesTest,
	#superclass : #EPBaseTest,
	#category : #'Espell-Tests'
}

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveAdd [

	| result |
	result := (self mirrorOn: 1) executePrimitiveMethod: SmallInteger >> #+ withArguments: { (self mirrorOn: 2) }.
	self deny: result hasFailed.
	self assert: result value asSmallInteger equals: 3
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveBasicNewWithSize [

	| result |
	result := self backend arrayClass executePrimitiveMethod: Behavior >> #basicNew: withArguments: { (self mirrorOn: 2) }.
	self assert: result value size equals: 2.
	self assert: (result value at: 1) isNilObject.
	self assert: (result value at: 2) isNilObject
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveClassOfImmediateObject [

	| result |
	result := (self mirrorOn: 1) executePrimitiveMethod: ProtoObject >> #class withArguments: #(  ).
	self assert: result value target address equals: self backend smallIntegerClass target address
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveFailsWithWrongArgument [

	| result |
	result := (self mirrorOn: 1) executePrimitiveMethod: SmallInteger >> #+ withArguments: { objectSpace nilObject }.
	self assert: result hasFailed
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveGreaterThanAnswersFalse [

	| result |
	result := (self mirrorOn: 1) executePrimitiveMethod: SmallInteger >> #> withArguments: { (self mirrorOn: 2) }.
	self assert: (result value pointsToSameObject: self backend falseObject)
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveLessThanAnswersTrue [

	| result |
	result := (self mirrorOn: 1) executePrimitiveMethod: SmallInteger >> #< withArguments: { (self mirrorOn: 2) }.
	self assert: (result value pointsToSameObject: self backend trueObject)
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveStringAt [

	| result |
	result := ('abc' asLiteralInObjectSpace: objectSpace) executePrimitiveMethod: ByteString >> #at: withArguments: { (self mirrorOn: 2) }.
	self assert: result value asLocalLiteral equals: $b
]

{ #category : #tests }
EPPrimitivesTest >> testPrimitiveStringAtPut [

	| string |
	string := 'abc' asLiteralInObjectSpace: objectSpace.
	string executePrimitiveMethod: ByteString >> #at:put: withArguments: { 
			(self mirrorOn: 1).
			($A asLiteralInObjectSpace: objectSpace) }.
	self assert: string asLocalLiteral equals: 'Abc'
]
