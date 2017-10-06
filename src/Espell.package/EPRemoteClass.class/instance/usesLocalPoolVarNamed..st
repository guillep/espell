shared pools
usesLocalPoolVarNamed: aString 
	
	| sharedPools |
	sharedPools := EPRemoteOrderedCollection on: (mirror instanceVariableAtIndex: 10).
	^ sharedPools anySatisfy: [ :sharedPool | 
		(EPRemoteClass on: sharedPool environment: environment) allClassVariableNames includes: aString ]