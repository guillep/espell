shared pools
sharedPools
	
	| sharedPools maybeSharedPool |
	maybeSharedPool := mirror instanceVariableAtIndex: (mirror instanceVariableMapping classSharedPoolsIndex).
	maybeSharedPool isNilObject ifTrue: [ ^ #() ].
	sharedPools := EPRemoteOrderedCollection on: maybeSharedPool.
	^ sharedPools collect: [ :sharedPool | EPRemoteClass on: sharedPool environment: environment ]