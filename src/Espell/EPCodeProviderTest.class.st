Class {
	#name : 'EPCodeProviderTest',
	#superclass : 'EPBaseTest',
	#instVars : [
		'environment'
	],
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'accessing' }
EPCodeProviderTest class >> resources [

	^{ EPTestResource }
]

{ #category : 'running' }
EPCodeProviderTest >> setUp [

	super setUp.
	objectSpace := EPTestResource current objectSpace.
	environment := (EPRemoteEnvironment
			on: objectSpace backend systemDictionary)
			imageFileName: EPTestResource current imageFileName;
			yourself
]

{ #category : 'running' }
EPCodeProviderTest >> testFindIfNilSourceInFile [
	
	| classDefinition method |
	classDefinition := environment classNamed: #ProtoObject.
	method := classDefinition methodDictionary at: #ifNil:.
	self assert: method sourceCode equals: 'ifNil: nilBlock
	"Return self, or evaluate the block if I''m == nil (q.v.)"

	^ self'
]
