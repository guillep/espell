accessing
selectedCodeRangeForContext: aContext
	
	aContext isDead ifTrue:
		[^1 to: 0].
	^ aContext currentExecutedNode debugHighlightRange