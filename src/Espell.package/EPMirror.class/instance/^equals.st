comparing
= anotherMirror
	
	([anotherMirror isOzMirror] on:Exception do: [ false ]) ifFalse: [ ^ false ].
	
	^ self pointsToSameObject: anotherMirror