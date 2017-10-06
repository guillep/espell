s
classHandle: aClass setTo: anObject
	
	self objectMemory changeClassOf: anObject address to: aClass address