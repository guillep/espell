"
I am a primitive decorator that transforms all arguments to literals of the local object space so the VM will accept them for the primitive. I am needed for those primitives where the VM checks for the specific types of objects.
"
Class {
	#name : 'EPArgumentsToLocalLiteralPrimitiveDecorator',
	#superclass : 'EPPrimitiveDecorator',
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'execution' }
EPArgumentsToLocalLiteralPrimitiveDecorator >> preProcessExecution: anExecution [

	^ anExecution withArgumentsAs: [ :each | [ self objectSpace mirrorOn: each asLocalLiteral] on: Error do: [ each ] ]
]
