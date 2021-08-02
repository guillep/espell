as yet unclassified
send: aMessage to: receiver class: class inNode: aMessageNode
	| method replacedMethod |
	
	method := aMessageNode polymorphicInlineCache
		at: class
		ifAbsentPut: [ self lookupSelector: aMessage selector in: class. ].
	method ifNil: [ ^ self sendDoesNotUnderstandFor: aMessage to: receiver ].
	
	replacedMethod := (self tryToReplaceMethod: method) ifNil: [ method ].
	
	^ replacedMethod
		accept: self
		on: receiver
		message: aMessage