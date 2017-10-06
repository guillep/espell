as yet unclassified
fromSton: stonReader

	| binding |
	binding := self new.
	stonReader parseListDo: [ :each |
		binding name: each ].
	^ binding