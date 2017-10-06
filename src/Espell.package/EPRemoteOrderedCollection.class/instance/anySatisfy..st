iterating
anySatisfy: aBlockClosure 
	
	self do: [ :each | (aBlockClosure value: each) ifTrue: [ ^ true ] ].
	^ false