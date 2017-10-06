initialization
buildCache

	self symbolsDo: [ :each | cache at: each asLocalString asSymbol put: each ]