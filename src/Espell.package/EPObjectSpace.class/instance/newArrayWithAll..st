builders
newArrayWithAll: elements

	| array |
	array := self backend arrayClass asClassMirror basicNew: elements size.
	1 to: elements size do: [ :index | array at: index put: (elements at: index) ].
	^ array