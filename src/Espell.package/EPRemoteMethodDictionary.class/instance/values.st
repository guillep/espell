accessing
values
	| values array |
	values := OrderedCollection new.
	array := mirror instanceVariableAtIndex: 2.
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ values add: (array at: index) ] ].
	^ values