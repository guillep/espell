actions
suspend
	self dequeue.
	self objectSpace processor activeProcess = self ifTrue: [ self objectSpace processor activateNextProcessIfNone: [] ].