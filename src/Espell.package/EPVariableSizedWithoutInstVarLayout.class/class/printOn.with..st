gt-inspector-extension
printOn: aStream with: aMirror
	aStream nextPutAll: '#('.
	(1 to: aMirror basicSize) do: [ :i | (aMirror at: i) printOn: aStream . aStream nextPutAll: ' ' ].
	aStream nextPutAll: ')'