instance creation
newCompactClassesArray

	| array |
	array := backend arrayClass asClassMirror basicNew: 31.
	1 to: 31 do: [ :index | 
		array at: index put: (backend compactClassAt: index ifNone: [ self nilObject ]) ].
	^ array