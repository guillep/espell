dispatching
alternativePrimitivesResult
	^ alternativePrimitivesResult
		ifNil: [ alternativePrimitivesResult := 
			{(#primitiveSnapshot -> true).
			 (#primitiveImageName -> 'imagename').
			 (#primitiveQuit -> true)} asDictionary ]