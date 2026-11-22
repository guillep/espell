"
I am an abstract class representing a primitive. I have methods to wrap myself to apply some pre and post execution transformations like:

- transform all literals to a remote literal
- transform the results to remote literals 

These transformations are needed because of VM restrictions: some primitives will check the types of receiver/arguments to work properly. So with these transformations we ""fake"" it.
"
Class {
	#name : 'EPPrimitive',
	#superclass : 'Object',
	#instVars : [
		'resolver'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'execution' }
EPPrimitive >> executionWithReceiver: aReceiver andArguments: anArrayOfArguments [
	
	^ EPPrimitiveExecution new
		receiver: aReceiver;
		arguments: anArrayOfArguments;
		primitive: self;
		yourself
]

{ #category : 'installing' }
EPPrimitive >> installOn: aPrimitiveResolver [

	self basicInstall: self inResolver: aPrimitiveResolver
]

{ #category : 'accessing' }
EPPrimitive >> objectSpace [

	^resolver objectSpace
]

{ #category : 'accessing' }
EPPrimitive >> resolver: aPrimitiveResolver [

	resolver := aPrimitiveResolver
]

{ #category : 'decorating' }
EPPrimitive >> transformArgumentsToRemoteLiteral [

	^EPArgumentsToLocalLiteralPrimitiveDecorator decorate: self
]

{ #category : 'decorating' }
EPPrimitive >> transformResultToRemoteClass [

	^EPResultToRemoteClassPrimitiveDecorator decorate: self
]

{ #category : 'decorating' }
EPPrimitive >> transformResultToRemoteLiteral [

	^EPResultToRemoteLiteralPrimitiveDecorator decorate: self
]
