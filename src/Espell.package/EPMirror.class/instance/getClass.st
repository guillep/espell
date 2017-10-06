public api
getClass
	
	| mirror |
	self deprecated: 'Use #basicClass instead'.
	mirror := self basicClass.
	^ mirror isClassSide
			ifTrue: [ mirror asMetaclassMirror ]
			ifFalse: [ mirror ]