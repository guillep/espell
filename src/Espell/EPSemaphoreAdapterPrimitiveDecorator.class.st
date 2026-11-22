"
I am a primitive decorator that transforms the internals of a semaphore to make it work.
"
Class {
	#name : 'EPSemaphoreAdapterPrimitiveDecorator',
	#superclass : 'EPPrimitiveDecorator',
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'as yet unclassified' }
EPSemaphoreAdapterPrimitiveDecorator >> postProcessResult: aResult [
	
	aResult instanceVariableAtIndex: 1 put: self objectSpace nilObject.
	^ aResult
]

{ #category : 'as yet unclassified' }
EPSemaphoreAdapterPrimitiveDecorator >> preProcessExecution: anExecution [
	
	anExecution receiver instanceVariableAtIndex: 1 put: (resolver backend mirrorOn: nil).
	^ anExecution
]
