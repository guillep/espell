transformations
fromLocal: aByteObject
	| remoteByteClass remoteByteObject |
	remoteByteClass := self remoteClass.
	remoteByteObject := (objectSpace mirrorOn: aByteObject) copy.
	remoteByteObject setClass: remoteByteClass.
	^remoteByteObject