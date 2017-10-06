accessing
methodDictionary

	^ EPRemoteMethodDictionary 
		on: mirror methodDictionary
		environment: environment