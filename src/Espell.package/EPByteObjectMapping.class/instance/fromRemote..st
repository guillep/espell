transformations
fromRemote: aRemoteByteObject
	| remoteByteObjectMirror newString |
	remoteByteObjectMirror := aRemoteByteObject.
	newString := self localClass new: remoteByteObjectMirror size.
	1 to: remoteByteObjectMirror size do: [ :index |
		self
			inLocal: newString
			at: index
			putRemote: (remoteByteObjectMirror at: index)
	].
	^newString