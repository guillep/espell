accessing
keys
	| keys |
	keys := OrderedCollection new.
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ keys add: key asLocalString ] ].
	^ keys