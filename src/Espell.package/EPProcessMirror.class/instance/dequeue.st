actions
dequeue
	| theList |
	
	self priorityList isNilObject ifTrue:[ ^ self ].
	
	theList := self priorityList.
	self priorityList: self objectSpace nilObject.
	self privateRemoveFromList: theList.