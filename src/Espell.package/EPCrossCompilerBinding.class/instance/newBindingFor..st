bindings
newBindingFor: aRFiClass 
	
	^ EPCrossCompilerBinding new
		class: aRFiClass;
		environment: environment