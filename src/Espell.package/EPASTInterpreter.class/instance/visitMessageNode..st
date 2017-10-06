visiting
visitMessageNode: aMessageNode
	
	| replacement receiver |

	replacement := self tryToReplace: aMessageNode.
	replacement ifNotNil: [ ^ replacement acceptVisitor: self ].
	
	receiver := self interpret: aMessageNode receiver.

	self ifSkip: [^receiver ].
	
	^ self visitMessageNode: aMessageNode receiver: receiver.