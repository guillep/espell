"
I am a mirror on a process  scheduler object providing basic scheduling operations such as changing the active process and schedule a process to run at a certain priority.
"
Class {
	#name : 'EPProcessSchedulerMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'accessing' }
EPProcessSchedulerMirror >> activeProcess [
	
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping processSchedulerActiveProcessIndex)
]

{ #category : 'accessing' }
EPProcessSchedulerMirror >> activeProcess: anEPProcessMirror [ 
	
	self instanceVariableAtIndex: (self backend instanceVariableMapping processSchedulerActiveProcessIndex) put: anEPProcessMirror
]
