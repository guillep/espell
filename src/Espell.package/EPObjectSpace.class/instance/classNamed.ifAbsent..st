class access
classNamed: aClassName ifAbsent: aBlock

	| classHandle |
	classHandle := self environment classNamed: aClassName ifAbsent: [ ^ aBlock value ].
	^ self classMirrorOn: classHandle