dispatching
dispatchFunctionPointer: function
	^ [ self simulator dispatchFunctionPointer: function ]
		on: Error
		do: [ | returnValue |
			returnValue := self interpreter
				evaluateCode: '''' , (self alternativePrimitivesResult at: function) asString , ''''.
			self simulator push: returnValue target address ]