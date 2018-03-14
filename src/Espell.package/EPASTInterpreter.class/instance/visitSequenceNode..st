visiting
visitSequenceNode: aSequenceNode
	| lastResult |
	lastResult := evaluator objectSpace nilObject.
	aSequenceNode statements do: [ :statement|
		lastResult := self interpret: statement.
		self ifSkip: [ ^ lastResult ]].
	
	self updateGotoContext.
		
	^ lastResult