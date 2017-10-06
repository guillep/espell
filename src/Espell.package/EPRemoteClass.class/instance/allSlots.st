instance variables
allSlots
	
	^ self allInstanceVariableNames withIndexCollect: [ :each :index |
		(InstanceVariableSlot named: each asSymbol)
			index: index;
			yourself ]