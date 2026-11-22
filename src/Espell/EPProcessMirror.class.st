"
I am a mirror on a process object providing basic process operations.
"
Class {
	#name : 'EPProcessMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'instance creation' }
EPProcessMirror class >> createProcessForContext: aContextMirror andPriority: aPriority inObjectSpace: anObjectSpace [
	| newProcess |
	newProcess := anObjectSpace backend processClass asClassMirror basicNew asProcessMirror.
	newProcess priority: aPriority.
	newProcess context: aContextMirror.
	^newProcess
]

{ #category : 'converting' }
EPProcessMirror >> asProcessMirror [

	^self
]

{ #category : 'accessing' }
EPProcessMirror >> context [
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping processContextIndex)) asContextMirror
]

{ #category : 'accessing' }
EPProcessMirror >> context: aContextMirror [
	self 
		instanceVariableAtIndex: (self backend instanceVariableMapping processContextIndex)
		put: aContextMirror
]

{ #category : 'actions' }
EPProcessMirror >> dequeue [
	| theList |
	
	self priorityList isNilObject ifTrue:[ ^ self ].
	
	theList := self priorityList.
	self priorityList: self objectSpace nilObject.
	self privateRemoveFromList: theList.
]

{ #category : 'accessing' }
EPProcessMirror >> name: aString [
	
	self 
		instanceVariableAtIndex: (self backend instanceVariableMapping processNameIndex) 
		put: (aString asLiteralInObjectSpace: self backend)
]

{ #category : 'accessing' }
EPProcessMirror >> priority [
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping processPriorityIndex)) target asSmallInteger
]

{ #category : 'accessing' }
EPProcessMirror >> priority: aPriorityInteger [

	self 
		instanceVariableAtIndex: (self backend instanceVariableMapping processPriorityIndex)
		put: (aPriorityInteger asLiteralInObjectSpace: self backend)
]

{ #category : 'accessing' }
EPProcessMirror >> priorityList [

	^ self instanceVariableAtIndex: (self backend instanceVariableMapping processPriorityListIndex)
]

{ #category : 'accessing' }
EPProcessMirror >> priorityList: aList [

	self instanceVariableAtIndex: (self backend instanceVariableMapping processPriorityListIndex) put: aList
]

{ #category : 'private' }
EPProcessMirror >> privateRemoveFromList: theList [
	(self
		pointsToSameObject: (theList instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex))
		ifTrue: [ theList
				instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex
				put: (self instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex).
			(self
				pointsToSameObject: (theList instanceVariableAtIndex: self backend instanceVariableMapping processContextIndex))
				ifTrue: [ theList
						instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex
						put: self objectSpace nilObject
					]
			]
		ifFalse: [ | tempLink |
			tempLink := theList instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex.
			[ tempLink isNilObject
				ifTrue: [ ^ self ].
			(tempLink instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex)
				pointsToSameObject: self
			]
				whileFalse: [ tempLink := tempLink instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex ].
			tempLink nextLink: (self instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex).
			(self
				pointsToSameObject: (theList instanceVariableAtIndex: self backend instanceVariableMapping processContextIndex))
				ifTrue: [ theList instanceVariableAtIndex: self backend instanceVariableMapping processContextIndex put: tempLink ]
			]
]

{ #category : 'actions' }
EPProcessMirror >> queue [

	self objectSpace processor queueProcess: self
]

{ #category : 'actions' }
EPProcessMirror >> suspend [
	self dequeue.
	self objectSpace processor activeProcess = self ifTrue: [ self objectSpace processor activateNextProcessIfNone: [] ].
]

{ #category : 'actions' }
EPProcessMirror >> terminate [

	self suspend.
]
