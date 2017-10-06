accessing
bytecodes
	^ ByteArray streamContents: [ :s |
		self initialPC to: self endPC do: [:i | 
			s nextPut: (self byteAt: i) ] ].