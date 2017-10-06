well known objects
arrayWithAll: elements
	
	| array |
	array := self environment arrayClass basicNew: elements size.
	elements withIndexDo: [ :element :index |
		array at: index put: element
	].
	^ array