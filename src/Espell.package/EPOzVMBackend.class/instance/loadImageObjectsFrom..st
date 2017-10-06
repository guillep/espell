initialize-release
loadImageObjectsFrom: aFile

	^ self mirrorOn: (self primitiveLoadImage: aFile readStream fileHandle)