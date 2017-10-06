methods
methods
	
	^ self methodDictionary values collect: [ :each | EPRemoteMethod on: each environment: environment ]