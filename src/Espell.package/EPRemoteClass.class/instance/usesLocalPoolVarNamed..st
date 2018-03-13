shared pools
usesLocalPoolVarNamed: aString 
	
	| sharedPools |
	sharedPools := EPRemoteOrderedCollection on: (self instanceVariableMapping classSharedPoolsIndex).
	^ sharedPools anySatisfy: [ :sharedPool | 
		(EPRemoteClass on: sharedPool environment: environment) allClassVariableNames includes: aString ]