shared pools
sharedPools
	
	| sharedPools maybeSharedPool |
	(mirror instanceVariableMapping classSharedPoolsIndex) ifNil: [ ^ #() ].
	maybeSharedPool := [mirror instanceVariableAtIndex: (mirror instanceVariableMapping classSharedPoolsIndex)] on: AssertionFailure do: [ ^ #() ].
	maybeSharedPool isNilObject ifTrue: [ ^ #() ].
	sharedPools := EPRemoteOrderedCollection on: maybeSharedPool.
	^ sharedPools collect: [ :sharedPool | EPRemoteClass on: sharedPool environment: environment ]