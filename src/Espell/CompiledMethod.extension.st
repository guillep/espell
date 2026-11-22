Extension { #name : 'CompiledMethod' }

{ #category : '*Espell' }
CompiledMethod >> executeOn: anObject withArguments: arguments [
	"self halt."
	^(self receiver: anObject withArguments: arguments executeMethod: self)
]

{ #category : '*Espell' }
CompiledMethod >> receiver: anObject withArguments: arguments executeMethod: method [
	<primitive: 188>
	^ anObject  withArgs: arguments executeMethod: method
]
