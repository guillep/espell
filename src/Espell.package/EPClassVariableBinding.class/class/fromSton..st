as yet unclassified
fromSton: stonReader

	| binding |
	binding := self new.
	stonReader parseListDo: [ :each :index |
		index = 1 ifTrue: [binding name: each].
		index = 2 ifTrue: [binding ownerName: each] ].
	^ binding