Class {
	#name : 'EPDebugSession',
	#superclass : 'Object',
	#instVars : [
		'interruptedContext'
	],
	#category : 'Espell-Debug',
	#package : 'Espell',
	#tag : 'Debug'
}

{ #category : 'as yet unclassified' }
EPDebugSession class >> debuggingActionsForPragmas: aCollection for: aSpecDebugger [ 
	
	^ #()
]

{ #category : 'instance creation' }
EPDebugSession class >> process: aProcess context: aContext [
	^ self new
		process: aProcess context: aContext
]

{ #category : 'accessing' }
EPDebugSession >> interruptedContext [
	^ interruptedContext
]

{ #category : 'testing' }
EPDebugSession >> isContextPostMortem: anAIMethodContext [ 
	
	^ false
]

{ #category : 'initialize-release' }
EPDebugSession >> process: aProcess context: aContext [

	"aProcess stepToSendOrReturn ."
	"aProcess isSuspended ifTrue: [ aProcess stepToSendOrReturn ]."
	interruptedProcess := aProcess.
	interruptedContext := aContext.
	

]

{ #category : 'accessing' }
EPDebugSession >> selectedCodeRangeForContext: aContext [
	
	aContext isDead ifTrue:
		[^1 to: 0].
	^ aContext currentExecutedNode debugHighlightRange
]

{ #category : 'stack' }
EPDebugSession >> stackOfSize: limit [
	| stack context |
	stack := OrderedCollection new.
	stack addLast: (context := interruptedContext).
	[ (context := context sender) notNil and: [ stack size < limit ] ] whileTrue: [ stack addLast: context ].
	^ stack
]

{ #category : 'changing process state' }
EPDebugSession >> terminate [
	"Nothing for the moment"
]
