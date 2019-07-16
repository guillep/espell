gt-inspector-extension
gtInspectorLayoutIn: composite with: aMirror
	| ivNames | 
	ivNames := aMirror basicClassFromEnvironment allInstVarNames.
	ivNames doWithIndex: [ :each :i |
		ivNames asString, ' ' , (aMirror instanceVariableAtIndex: i) asString , Character cr ].

	^composite tree
		rootsExpanded;
		title: 'FixedLayout view';
		display: [ :anObject | {anObject} ];
		children: [ :each | (each basicClassFromEnvironment allInstVarNames) collectWithIndex: [ :ivName :i | aMirror instanceVariableAtIndex: i ] ]";
		selectionPopulate: #selectedNode
			on: $o
			entitled: 'Open'
			with: [ :tree | tree selection ];
		format: [ :each | 
					String
						streamContents: [ :stream | 
							stream
								nextPutAll: each class name;
								nextPut: $(;
								nextPutAll: ((each formattedCode truncateTo: 50) copyReplaceAll: String cr with: String space);
								nextPut: $) ] ]"