iterating
collect: aBlockClosure 
	
	| result |
	result := OrderedCollection new.
	self do: [ :each | result add: (aBlockClosure value: each) ].
	^ result