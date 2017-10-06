converting
asClassIndexHandle

	| hash |
	hash := (backend rawHashOf: address).
	hash > 0 ifFalse: [ ^ self ].
	^ backend handleOnClassIndex: hash.