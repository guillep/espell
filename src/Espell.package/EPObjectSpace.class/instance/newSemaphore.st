instance creation
newSemaphore

	| semaphore |
	semaphore := self environment semaphoreClass basicNew.
	semaphore instanceVariableAtIndex: 3 put: 0.
	^ semaphore