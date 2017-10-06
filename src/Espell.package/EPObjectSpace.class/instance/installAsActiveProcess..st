execution
installAsActiveProcess: aProcessMirror
	| activeProcess theProcessor |
	theProcessor := (self environment at: #Processor) asSchedulerMirror.
	activeProcess := theProcessor activeProcess.
	"If this is already the active process we have nothing to do"
	(activeProcess pointsToSameObject: aProcessMirror)
		ifTrue: [ ^self ].
	
	"If there is another active process we queue it"
	activeProcess isNilObject ifFalse: [
		activeProcess queue
	].
	
	aProcessMirror asProcessMirror priorityList: self nilObject.
	theProcessor activeProcess: aProcessMirror.