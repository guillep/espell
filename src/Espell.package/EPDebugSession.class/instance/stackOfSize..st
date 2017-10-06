stack
stackOfSize: limit
	| stack context |
	stack := OrderedCollection new.
	stack addLast: (context := interruptedContext).
	[ (context := context sender) notNil and: [ stack size < limit ] ] whileTrue: [ stack addLast: context ].
	^ stack