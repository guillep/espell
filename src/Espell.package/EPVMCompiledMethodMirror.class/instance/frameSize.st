accessing
frameSize
	(self header noMask: 16r20000)
		ifTrue: [^ 16 "SmallFrame"]
		ifFalse: [^ 56 "LargeFrame"]