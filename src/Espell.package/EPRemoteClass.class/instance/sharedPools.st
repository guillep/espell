shared pools
sharedPools
	
	| sharedPools maybeSharedPool |
	maybeSharedPool := mirror instanceVariableAtIndex: 10.
	maybeSharedPool isNilObject ifTrue: [ ^ #() ].
	sharedPools := EPRemoteOrderedCollection on: maybeSharedPool.
	^ sharedPools collect: [ :sharedPool | EPRemoteClass on: sharedPool environment: environment ]