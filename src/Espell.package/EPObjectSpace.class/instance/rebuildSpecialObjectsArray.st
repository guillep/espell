special objects array
rebuildSpecialObjectsArray

	mustRebuildSpecialObjectsArray ifFalse: [ ^ self ].
	mustRebuildSpecialObjectsArray := false.
	"self environment createCompactClassesArray."
	self createSpecialObjectsArray in: [ :array |
		self specialObjectsArray: array.
		^array
		]