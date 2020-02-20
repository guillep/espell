gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 2>
	^[composite text
		title: 'mirror';
		display: [ self asString	, Character cr asString, 'hash: ',self identityHash ];
		when: [ true ] ] on: Error do: [ 'NonClass Mirror (error while printing)' ]