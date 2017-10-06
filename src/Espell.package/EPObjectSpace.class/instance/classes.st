accessing
classes
	^self environment classes collect: [ :c | self classMirrorOn: c ] 