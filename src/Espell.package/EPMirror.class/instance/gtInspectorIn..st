gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 0>
	^[composite text
		title: 'EPMirror';
		display: [ self asString	, Character cr, Character cr, 'hash: ',self identityHash ];
		when: [ true ] ] on: Error do: [ 'NonClass Mirror (error while printing)' ]