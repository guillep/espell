accessing
at: aString 
	
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ key asLocalString = aString ifTrue: [ 
				^ EPRemoteMethod on: ((self array) at: index) environment: environment ] ] ].
	
	KeyNotFound signalFor: aString in: self