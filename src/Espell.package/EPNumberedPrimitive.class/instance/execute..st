execution
execute: anExecution

	| result |
	result := ((ProtoObject>>#tryPrimitive:withArgs:)
		executeOn: anExecution receiver target
		withArguments: { number . anExecution arguments collect: [ :mirror | mirror target ] }).
	^ self objectSpace mirrorOn: result