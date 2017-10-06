public api
variableSize

	self deprecated: 'Use #basicSize'.
	^ (self basicClass = self objectSpace contextClass
		ifTrue: [ self asContextMirror ]
		ifFalse: [ self ]) basicSize.