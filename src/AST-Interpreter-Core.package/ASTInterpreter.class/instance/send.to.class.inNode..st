message - sending
send: aMessage to: receiver class: class inNode: aNode
	| method |
	
	method := self lookupSelector: aMessage selector in: class.
	method ifNil: [ ^ self sendDoesNotUnderstandFor: aMessage to: receiver ].
	
	^ method
		accept: self
		on: receiver
		message: aMessage