gt-inspector-extension
gtInspectorClassIn: composite
	<gtInspectorPresentationOrder: 5>
	|a|
	a := self basicClass gtInspectorIn: composite.
	a title: 'class'.
	^a