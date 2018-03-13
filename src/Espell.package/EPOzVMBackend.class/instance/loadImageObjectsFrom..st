initialize-release
loadImageObjectsFrom: aFile

	^ self mirrorOn: (self primitiveLoadImage: (File named: aFile fullName) )